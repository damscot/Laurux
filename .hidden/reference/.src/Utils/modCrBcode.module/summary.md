# modCrBcode — Synthèse

> Source : `.src/Utils/modCrBcode.module` · Synthèse des autres documents.

## Rôle

Dessin d'un code-barres EAN-13 avec l'API `Draw` de Gambas 2.

## Points clés

- **Code mort** : aucun appelant dans le projet.
- Remplacé par `Cdocuments.EAN13` (génération PDF).

## Dépendances principales

- Aucune entrante ; classe `Draw` en sortie.

## Risques

- Aucun à la suppression (vérifiée par compilation).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 79 |
| Lignes de commentaire | 14 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 17 (`PrintBarcode`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (MODCRBCODE-T01) : compilation après suppression.

## Rework

1 étape : suppression du module (MODCRBCODE-001). Aucune anomalie.
