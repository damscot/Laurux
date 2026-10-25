# Cmat — Synthèse

> Source : `.src/Reports/Cmat.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Gabarit PDF (`Inherits PdfWriter`) de la liste des matériels imprimée par `EdMat` : titre,
en-tête de colonnes, lignes (code, intitulé, marque, type, série, propriétaire, PV HT, PV TTC) et
pied de page.

## Points clés

- 8 méthodes `Public`, complexité 1 ; copie réduite de `Carticles` (`_new`, `Footer`, `Ligne`,
  `Ligne2` identiques).
- `Ligne`, `Ligne2` et `_free` sont du code mort.

## Dépendances principales

- Hérite de [PdfWriter](../PdfWriter.class/summary.md) ; lit `Start.R/G/B`.
- Appelant unique : `EdMat`.

## Risques

- Faible (rendu pur, un seul appelant). Une fusion avec `Carticles` changerait la position du
  titre tant que CARTICLES-A02 n'est pas tranchée.
- Défauts hérités de `PdfWriter` : encodage (€ → ¤, accents, PDFWRITER-A01) et largeur de
  texte (alignements à droite décalés, PDFWRITER-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 54 |
| Lignes de commentaire | 4 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests : 1 `gbtest` (texte `pdftotext` et flux non compressé), 1 `replay` par `EdMat`.

## Rework

3 étapes (CMAT-001 à 003) : documentation, suppression du code mort, passage à la base commune
`PdfLaurux` et aux helpers de colonnes. Aucune anomalie.
