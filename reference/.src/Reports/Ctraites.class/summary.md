# Ctraites — Synthèse

> Source : `.src/Reports/Ctraites.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF de traites (`Inherits PdfWriter`) **mort** : une seule méthode (`EnteteN`), jamais
instancié ni cité, sans `.form`, sans appelant dans l'historique git. Les traites sont imprimées par
`Ccompta` (niveaux `T`) et `CLcr`.

## Points clés

- `_new` et `EnteteN` sont des copies exactes d'autres gabarits (`Creleve`, `Cdocuments*`).

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`. Utilisé par : aucun fichier.

## Risques

- Aucun à l'exécution.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 19 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (`CTRAITES-T01`) : compilation et suite verte après suppression.

## Rework

1 étape (CTRAITES-001) : suppression du fichier (code mort). Aucune anomalie.
