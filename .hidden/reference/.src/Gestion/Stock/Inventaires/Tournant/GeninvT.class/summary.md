# GeninvT — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Génération d'un inventaire tournant : recrée `Fiches_InvT` avec les articles stockés d'une plage
de familles, de fournisseurs ou de casiers, puis imprime la feuille de comptage en renumérotant les
lignes selon le tri choisi. Premier maillon de la chaîne tournante (`SaisieInvT` → `EcartsT`/
`EdnsaisisT`/`Edinv("T")` → `ValidinvT`).

## Points clés

- 22 fonctions dont 18 handlers ; forte duplication interne (4 listes de choix × 2 handlers,
  3 handlers de critère).
- `gen_Inv` : 6 `SELECT` ne différant que par la clause de critère et l'`ORDER BY`.
- `Button3_Click` **modifie les données** (renumérotation `inv_nlig`) à chaque impression.
- 156 lignes communes avec `Geninv` → module commun `Inventaire` (voir Geninv).
- 4 handlers `Col*_Click` appelés dynamiquement par le rejeu : restent `Public`.

## Dépendances principales

- `Utils.db` (`AutoIncrement`, `Engine`), `Cstocks`, `Visualiseur`, `Doc`, `Utils.SetEditColor`.
- Appelé par `Fmenu.Menu95_Click` (modal).
- Tables : `Fiches_InvT` (créée), `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`.

## Risques

- Renumérotation à l'impression (GENINVT-A01) ; flux par exception (A02) ; tri ignoré à la
  génération (A03) ; cumul d'observateurs (A04) ; focus vers « Quitter » (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 531 |
| Lignes de commentaire | 61 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 110 |
| Complexité max (fonction) | 20 (`button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 scénarios `replay` (GENINVT-T01 à T14) : 3 critères × tris, bornes manquantes, régénération,
première génération, plage vide, renumérotation, listes de choix, cumul d'observateurs, SQLite.
**Liste à valider par l'utilisateur avant la phase 2** (module complexe).

## Rework

8 étapes (GENINVT-001 à 008) : documentation, code mort, helpers des listes et des critères,
requête unique, séparation traitement/GUI, module `Inventaire`, `Cbase.Table`, portée de
`gen_Inv`. 5 anomalies (GENINVT-A01 à A05).
