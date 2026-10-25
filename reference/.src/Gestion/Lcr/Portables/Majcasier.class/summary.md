# Majcasier — Synthèse

> Source : `.src/Gestion/Lcr/Portables/Majcasier.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Mise à jour code casier » : affecte un code casier (emplacement de stockage,
`Fiches_Art.art_casier`) à tous les articles scannés par le **terminal portable d'inventaire**
(fichier `~/Portable/inventaire.txt`, code-barres en 3ᵉ champ). Aucun lien avec les LCR.

## Points clés

- Toute la logique est dans `Import_Portable` (CC 17) : lecture du fichier, résolution du
  code-barres, `UPDATE` par article, rapport des rejets.
- Appel inutile à `Portable.Import("Casier")`.
- Couleurs calculées et inutilisées ; écran instrumenté (`Utils.Observers`).

## Dépendances principales

- Ouvert par `Fmenu.Menu275_Click`. Utilise `Portable`, `Utils.Find_cbarre`, `Cbase.Table("TabArt")`,
  `Editeur.Prog_Editeur`.

## Risques

- Article précédent remis à jour sur une ligne sans code-barres (A01) ; rapport sans le code-barres
  rejeté (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 88 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 17 (`Import_Portable`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (MAJCASIER-T01 à T05) : nominal, rejets, casier vide, fichier absent, lignes courtes ;
dump de `Fiches_Art.art_casier` et rapport.

## Rework

4 étapes (MAJCASIER-001 à 004) : documentation, code mort, réduction de portée, extraction du
traitement et lecture commune du fichier. 3 anomalies (MAJCASIER-A01 à A03).
