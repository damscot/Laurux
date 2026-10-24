# JournauxM — Synthèse

> Source : `.src/Compta/Impressions/JournauxM.module` · Synthèse des autres documents.

## Rôle

Moteur d'impression PDF des journaux comptables, appelé par l'écran `Journaux` (bouton
« Imprimer »). Pour chaque journal de l'intervalle choisi, imprime les écritures validées de la
période (solde progressif, séparation par pièce), puis une page de centralisation par compte
(sauf journaux `OD`) et, en option, les totaux. Produit `~/tmp/Journaux.pdf` via `Ccompta`.

## Points clés

- Une seule fonction utile, `Imprime` (289 lignes, CC 55) : SQL, rendu PDF, messages et curseur
  mêlés.
- Centralisation par une **table physique de travail** `centralisation`, détruite et recréée à
  chaque journal (DDL + `UPDATE`/`INSERT`), partagée entre postes.
- Édition « provisoire » (numéros `numero`) si la date de fin dépasse `dtepc`, sinon numéros
  définitifs `numerodef`.
- Les lignes de comptes collectifs ne sont pas imprimées mais cumulées sous le collectif.
- Code mort notable : paramètre `Cloture` (toujours `False`), `Shell "cd"`, cumuls jamais
  imprimés, requête `Fiches_Comptes` exécutée deux fois par ligne.

## Dépendances principales

- Appelé uniquement par `Journaux.Button1_Click` ; lit/écrit `Journaux.Mouse` (dépendance
  circulaire).
- Utilise `Ccompta` (PDF), `Visualiseur`, `Utils.db`, `Utils.Cdate_Dbase`/`CDate_Aff`,
  `Start.Societe`.
- Tables : `Fiches_Journaux`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Comptes`, table
  d'exercice `Fiches_Mvt*` (paramètre), `centralisation` (écrite).
- Copie quasi intégrale dans `EcrM.class` (55 % des lignes communes).

## Risques

- Compte absent du plan comptable : arrêt sans PDF, curseur bloqué, totaux faussés au tirage
  suivant (A01).
- Filtre de dates `yyyymmdd` sur `datetime` : dernier jour tronqué si heure non nulle ; résultat
  vraisemblablement faux sous SQLite (A02, à confirmer).
- Table `centralisation` partagée : impressions simultanées incohérentes (A03).
- Libellé de collectif hérité de la ligne précédente pour un préfixe inattendu (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 338 |
| Lignes de commentaire | 21 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 55 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests `replay` (JOURNAUXM-T01 à T12) via l'écran `Journaux` : journaux VE/BQ/OD, édition
provisoire/définitive, totaux, sauts de page, compte absent, aucun journal, heure non nulle,
SQLite, collectif atypique, performance. Critères : texte du PDF normalisé (date et utilisateur
du pied de page) et dump de la base (table `centralisation`). `Laurux01.sql` ne contient aucune
écriture : un jeu dérivé commun aux éditions comptables (voir [Balance](../Balance.class/test.md)) est nécessaire.

## Rework

10 étapes sans changement de comportement (JOURNAUXM-001 à 010) : documentation, code mort
(dont le paramètre `Cloture`), requête doublon, création du socle `ImpCompta` (centralisation :
création, cumul, impression) repris par `JournauxA`, `Jourcent` et `EcrM`, découpage d'`Imprime`,
`Cbase.Table`, séparation traitement/GUI, réduction de portée. 4 anomalies (JOURNAUXM-A01 à A04)
soumises à validation utilisateur.
