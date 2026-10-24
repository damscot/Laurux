# RecupN — Synthèse

> Source : `.src/Utils/RecupN.class` · Synthèse des autres documents.

## Rôle

Réparation ponctuelle après une clôture intempestive : recopie les écritures 1 à 424 de
`Fiches_Mvt1` dans `Fiches_Mvt`.

## Points clés

- Constante 424 en dur, propre à une base de production (2017).
- Aucune confirmation, aucune transaction, non idempotent.
- `numcol` jamais renseigné ; sommes de contrôle non recalculées.

## Dépendances principales

- `Prgm` ; `Utils.db` ; tables `Fiches_Mvt`, `Fiches_Mvt1` en dur.

## Risques

- **Élevé** : une saisie de « RecupN » dans « Appel programme » duplique des écritures comptables.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 23 |
| Lignes de commentaire | 2 |
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

3 replays (RECUPN-T01 à T03), diff de `Fiches_Mvt`.

## Rework

3 étapes (documentation, code mort, message) et 3 anomalies, dont la suppression proposée du script
(A01).
