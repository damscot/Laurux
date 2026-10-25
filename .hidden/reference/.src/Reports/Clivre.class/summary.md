# Clivre — Synthèse

> Source : `.src/Reports/Clivre.class` · Synthèse des autres documents.

## Rôle

Ancien gabarit PDF de **tickets et factures de caisse** (`Inherits PdfWriter`), malgré son nom.
Classe **morte** : jamais instanciée ni citée, sans `.form` ; son dernier appelant
(`Caisse/Moulinage`) a été retiré en 2018 (commit `f442d721`).

## Points clés

- 19 méthodes, toutes sans appelant (`jamais_reference` confirmé par grep, aucun chargement
  dynamique).
- `Logo` est identique à `Creleve.Logo`, `Logo2` à `Cdocuments2.Logo2`, `BasPage` à
  `Cclients.BasPage`, `newPage` à `Cfacture.newPage`.

## Dépendances principales

- Utilise : `PdfWriter`, `Start.R/G/B`, `Start.LocalSettings` (logo). Utilisé par : aucun fichier.

## Risques

- Aucun à l'exécution. Ses copies faussent le décompte des doublons pour la base commune
  `PdfLaurux` : à supprimer d'abord.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 142 |
| Lignes de commentaire | 14 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 32 |
| Complexité max (fonction) | 7 (`Logo`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (`CLIVRE-T01`) : compilation et suite verte après suppression.

## Rework

1 étape (CLIVRE-001) : suppression du fichier (code mort). Aucune anomalie.
