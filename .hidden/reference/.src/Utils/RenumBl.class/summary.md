# RenumBl — Synthèse

> Source : `.src/Utils/RenumBl.class` · Synthèse des autres documents.

## Rôle

Script de réparation ponctuelle (doublons de numéros de facture dans les BL) lancé par « Appel
programme ».

## Points clés

- Trois mises à jour massives sans confirmation ni transaction : types de lignes de factures forcés à
  `A`, renumérotation de tous les BL facturés, taux et montants de toutes les lignes de BL réécrits.
- Une ligne de BL reçoit les montants d'une autre (clause `WHERE` incomplète).

## Dépendances principales

- `Prgm` ; `Utils.db`, `Utils.cpoint` ; `Fiches_HistoLigfac`, `Fiches_Bl`, `Fiches_Ligbl`.

## Risques

- **Très élevé** : corruption des documents commerciaux sur simple saisie de « RenumBl ».

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 29 |
| Lignes de commentaire | 18 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 8 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 `gbtest` (RENUMBL-T01 à T03) avec base Docker, dont la vérification de compilation après suppression.

## Rework

2 étapes (documentation, code mort) et 3 anomalies, dont la suppression proposée du script (A01).
