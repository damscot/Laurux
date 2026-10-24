# HistoCom — Synthèse

> Source : `.src/Utils/HistoCom.class` · Synthèse des autres documents.

## Rôle

Réparation ponctuelle (bogue 3.16) : déplace le libellé des lignes de commentaire de l'historique des
factures vers `com_ligfac`.

## Points clés

- Méthode statique `run` appelée par `Prgm` ; sans GUI propre.
- Idempotent, mais écrase un commentaire existant.

## Dépendances principales

- `Prgm` ; `Utils.db`, `Cbase.Table("TabHisLigFac")`.

## Risques

- Perte du contenu de `com_ligfac` si des lignes `C` ont à la fois libellé et commentaire.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 11 |
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

2 `gbtest` (HISTOCOM-T01, T02) avec base Docker.

## Rework

2 étapes (documentation, idiome `Repeat`) et 1 anomalie (A01).
