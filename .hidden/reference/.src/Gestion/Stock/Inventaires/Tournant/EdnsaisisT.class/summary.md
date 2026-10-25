# EdnsaisisT — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Édition PDF des produits non saisis de l'inventaire tournant (`Fiches_InvT`,
`inv_comptee = 0`) avec stock théorique valorisé au PA et au PMP actuels : liste de ce que la
validation mettra à zéro ou conservera.

## Points clés

- Lecture seule ; `Fiches_Art` relu par ligne sans `Available`.
- `Level1/2/3` : code mort.
- 93 % identique à `Ednsaisis`.

## Dépendances principales

- `Utils.db`, `Utils.CDec`/`cpoint`/`PointBase`, `Cstocks`, `Visualiseur`, `Doc` ; appelé par
  `Fmenu`.

## Risques

- Erreur à l’ouverture sans inventaire tournant (EDNSAISIST-A01).
- Article supprimé, ordre des lignes, valorisation sur quantité complétée d'espaces (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 151 |
| Lignes de commentaire | 27 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 scénarios `replay` (EDNSAISIST-T01 à T06), comparaison du texte du PDF.

## Rework

5 étapes (EDNSAISIST-001 à 005). 2 anomalies.
