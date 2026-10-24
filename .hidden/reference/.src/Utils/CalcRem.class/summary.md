# CalcRem — Synthèse

> Source : `.src/Utils/CalcRem.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Utilitaire d'administration (lancé par le nom `CalcRem` dans `Prgm`) qui recalcule les remises
main-d'œuvre (`remmofac`) et articles (`remartfac`) de chaque facture de `Fiches_HistoFac` à partir
de ses lignes `Fiches_HistoLigfac` (Σ brut − net HT par type `M`/`A`).

## Points clés

- Toute la logique est dans `Button2_Click` (CC 7), avec rupture sur le numéro de facture.
- `Cbase.Table` utilisé pour les deux tables.
- Factures de rétrocession (`*M`) non traitées.

## Dépendances principales

- Appelé uniquement par `Prgm` (appel par nom saisi, invisible pour `deps.py`).
- Utilise `Utils.db`, `Cbase`, `Utils.PointBase`, `Utils.cpoint`.

## Risques

- **La dernière facture n'est jamais recalculée.**
- Cumuls Float non arrondis écrits dans des `varchar(10)` (troncature ou erreur SQL).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 39 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 7 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests (CALCREM-T01 à T04) : 3 replays sur MariaDB (nominal, décimales, base vide) et un gb.test
après extraction du calcul.

## Rework

2 étapes (CALCREM-001, 002) : documentation et séparation traitement/GUI. 3 anomalies
(CALCREM-A01 à A03).
