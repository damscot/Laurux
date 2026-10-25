# CLcr — Synthèse

> Source : `.src/Gestion/Lcr/CLcr.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) des états LCR : en-tête, pied de page, listes de LCR (avec ou
sans banque) et bordereau de remise à la banque.

## Points clés

- Trois familles de niveaux : `Level1/2` (écran `Lcr`), `Level1A/2A` (`Attribution`, `Glcr`,
  `Preparation`), `Level1B…4B` (`Bordrx`) ; `Entete`, `BasPage`, `Lines` communs.
- Aucun SQL ; seule logique : formatage des montants, incohérent entre niveaux.
- `Level0`, `Level5A`, `_free` : code mort. `Level1`/`Level2` sont bien utilisés (faux positif de
  `deps.py`).
- `BasPage` identique à `Ccompta.BasPage`, `Level0` identique à `Cbalances.Level0`.

## Dépendances principales

- Utilisé par `Lcr`, `Attribution`, `Glcr`, `Preparation`, `Bordrx`.
- Utilise `PdfWriter`, `Start.R/G/B`, `Utils.cpoint`.

## Risques

- Montant stocké avec un point mal imprimé en locale française (`Level2`/`Level2A`, A01).
- Date de remise du bordereau = date du jour (A02).
- Faible risque de régression du rework : rendu vérifiable par `pdftotext`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 179 |
| Lignes de commentaire | 11 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 10 (`Level2A`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `gbtest` (CLCR-T01 à T06) produisant des PDF comparés par `pdftotext`, date et utilisateur
figés ; T05 caractérise la dépendance à la locale.

## Rework

5 étapes (CLCR-001 à 005) : documentation, code mort, factorisation des niveaux, typage de
`Lines`, base commune des gabarits PDF (lot Reports). 2 anomalies (CLCR-A01, A02).
