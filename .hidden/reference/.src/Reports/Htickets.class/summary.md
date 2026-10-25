# Htickets — Synthèse

> Source : `.src/Reports/Htickets.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) de réimpression d'un ticket de caisse archivé, sur A4,
utilisé par `ArchivesTck` : page (`Entete`), lignes d'en-tête société (`Entete2`), lignes du
ticket et totaux (`Level4`).

## Points clés

- 6 méthodes `Public`, complexité 1.
- `Footer` jamais appelé (code mort), ce qui rend aussi `_new`/`R`/`G`/`B` inutiles.
- `Entete2` ignore son paramètre `PosX`.
- Aucune pagination.

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md).
- Appelant unique : `ArchivesTck.Button4_Click`.

## Risques

- **HTICKETS-A01** : un ticket long produit une page par ligne au-delà du bas de la première
  page (saut automatique de `PdfWriter.Cell`, à confirmer).
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, accents, PDFWRITER-A01) et largeur de
  texte (alignements à droite décalés, PDFWRITER-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 3 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests : 2 `gbtest` (ticket court, ticket long en caractérisation de A01) et 1 `replay` par la
réimpression d'`ArchivesTck`.

## Rework

3 étapes (HTICKETS-001 à 003) : documentation, suppression du code mort (`Footer` et ce qu'il
utilise), retrait du paramètre `PosX`. 1 anomalie (A01, pagination).
