# PdfWriterFont — Synthèse

> Source : `.src/Reports/PdfWriterFont.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Tables de largeurs des caractères (millièmes d'em, 256 codes CP1252) des polices standard PDF,
pour [PdfWriter](../PdfWriter.class/summary.md). Issu du même portage de FPDF 1.53 (Luigi Carlotto,
2007, GPL2). Point d'entrée unique : `Font(name)`, appelé par `PdfWriter.SetFont`.

## Points clés

- 18 noms dans le `Select Case` de `Font`, 17 fonctions : courier ×4, helvetica ×4, times ×4,
  serif ×3, symbol, zapfdingbats.
- Comparées aux AFM Adobe (script `afm_compare.py`) : courier, helvetica B/I/BI, times, zapfdingbats
  **exacts** ; les tables sont régénérables automatiquement depuis les AFM.
- Polices « Serif » non standard, remplies des largeurs de Courier.
- Le projet n'utilise que helvetica (et arial → helvetica) et courier.

## Dépendances principales

- Utilisé par : `PdfWriter` (`SetFont`, `AddFont` mort). N'utilise rien.

## Risques

- `serifBI()` appelée mais inexistante : erreur d'exécution pour `SetFont("serif", "BI")`.
- `helvetica[0xD8]` = 39778 (faute de frappe) ; table `symbol` corrompue (254 valeurs, décalage).
- Risque actuel faible (polices ou caractères inutilisés), mais 0xD8 deviendra visible si la mesure
  du texte de `PdfWriter` est corrigée (PDFWRITER-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 400 |
| Lignes de commentaire | 8 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 19 (`Font`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (PDFWRITERFONT-T01, T02) : contenu de toutes les tables, contrôlé contre les AFM,
et noms invalides.

## Rework

3 étapes (PDFWRITERFONT-001 à 003) : documentation, factorisation des polices à chasse fixe (et
cache facultatif), réduction de portée des 17 fonctions. 3 anomalies (A01 à A03) : `serifBI`
absente, Ø de helvetica, table symbol.
