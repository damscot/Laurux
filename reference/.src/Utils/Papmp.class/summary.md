# Papmp — Synthèse

> Source : `.src/Utils/Papmp.class` · Synthèse des autres documents.

## Rôle

Script de maintenance : PMP de tous les articles = prix de revient.

## Points clés

- Méthode statique `run` appelée par `Prgm` ; boucle d'un `UPDATE` par article.
- Doublon exact de la case `Chk2` de `RazArt`.
- Message trompeur (« prix d'achat »).

## Dépendances principales

- `Prgm` (dans les deux sens : `Prgm.Mouse`) ; `Utils.db`, `Cbase.Table("TabArt")`.

## Risques

- Écrasement irréversible du PMP de tous les articles.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 18 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 4 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 replays (PAPMP-T01, T02), diff de `Fiches_Art`.

## Rework

3 étapes (code mort, mise en commun avec `RazArt`, regroupement optionnel des scripts) et 1 anomalie.
