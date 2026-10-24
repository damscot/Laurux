# Condition — Synthèse

> Source : `.src/Utils/Condition.class` · Synthèse des autres documents.

## Rôle

Structure (champ, opérateur, valeur) d'une condition de `Conditions`.

## Points clés

- 4 membres publics, aucune méthode ; `{Table}` jamais utilisé.
- Fonctionnellement morte avec `Conditions` (jamais exécutée).

## Dépendances principales

- Utilisée uniquement par `Conditions`.

## Risques

- Aucun.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 4 |
| Lignes de commentaire | 5 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test de compilation (CONDITION-T01).

## Rework

Suppression coordonnée avec `Conditions` (001) ou suppression de `{Table}` (002). Aucune anomalie.
