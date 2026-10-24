# Jourcent — Synthèse

> Source : `.src/Compta/Impressions/Jourcent.class` · Synthèse des autres documents.

## Rôle

Écran « Impression des journaux centralisateurs » (menu Compta). Pour chaque journal de
l'intervalle, cumule par compte les écritures validées de la période dans la table de travail
`centralisation`, puis imprime une page de centralisation (débit, crédit, solde cumulé) dans
`~/tmp/jourcent.pdf`.

## Points clés

- Saisie (exercice, période, journaux, clavier) copiée de `Journaux` : 487 lignes communes.
- Règles de cumul propres, différentes de la centralisation imprimée par `JournauxM` : journaux
  OD inclus, comptes 401/411 détaillés exclus, collectifs 401/411 libellés « Clients ».
- `Button2_Click` (export `<Row …/>`), `Centralisation` et `Donnees0..3` : code mort
  inaccessible (aucune commande `Tag` 2) et incohérent (nombre d'arguments, fichier PDF écrasé).
- Période filtrée en Gambas après lecture de tout l'exercice.

## Dépendances principales

- Ouvert par `Fmenu.Menu109_Click` ; aucun autre appelant.
- `Ccompta` (PDF), `Visualiseur`, `Utils` (dates, `db`, `Coulfd`), tables `Fiches_Parametres`,
  `Fiches_Journaux`, `Fiches_Comptes`, `Fiches_Societes`, `Fiches_Mvt*` (en dur), table de
  travail `centralisation` (écrite).

## Risques

- Collectif hors 401/411 cumulé avec les montants de la ligne précédente (A01).
- Libellé « Clients » pour les fournisseurs et `UPDATE` concaténé qui échoue sur une apostrophe
  (A02).
- Curseur final `Mouse.Custom` (A03).
- Deux éditions de centralisation aux règles divergentes (A04, arbitrage utilisateur).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 780 |
| Lignes de commentaire | 45 |
| Fonctions | 44 |
| Fonctions Public | 44 |
| Complexité cyclomatique totale | 137 |
| Complexité max (fonction) | 22 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (JOURCENT-T01 à T10) : centralisation complète, collectifs, collectif 453,
journal OD, édition provisoire, saut de page, aucune écriture, apostrophe, curseur, exercice et
dates. Critères : texte du PDF normalisé et dump de la base. Jeu de données dérivé nécessaire.

## Rework

7 étapes sans changement de comportement (JOURCENT-001 à 007) : documentation, suppression du
code mort (dont `Button2_Click`), adoption du socle `ImpCompta` (saisie et centralisation),
extraction du cumul, séparation traitement/GUI, réduction de portée. 4 anomalies (JOURCENT-A01 à
A04) soumises à validation utilisateur.
