# Cecheancier — Synthèse

> Source : `.src/Reports/Cecheancier.class` · Synthèse des autres documents.

## Rôle

Gabarit PDF d'échéancier (`Inherits PdfWriter`) **mort** : jamais instancié ni cité, sans `.form`,
sans appelant dans tout l'historique git. L'échéancier comptable utilise `Ccompta`.

## Points clés

- 6 méthodes (`_new`, `_free`, `Entete`, `BasPage`, `Level0`, `Level2`), toutes sans appelant.
- `Entete`, `BasPage`, `_new` sont des copies exactes d'autres gabarits.
- Commentaire parasite `' Gambas module file` en tête.

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`. Utilisé par : aucun fichier.

## Risques

- Aucun à l'exécution. Seul effet : fausser le décompte des doublons des gabarits.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 39 |
| Lignes de commentaire | 4 |
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

1 test (`CECHEANCIER-T01`) : compilation et suite verte après suppression.

## Rework

1 étape (CECHEANCIER-001) : suppression du fichier (code mort). Aucune anomalie.
