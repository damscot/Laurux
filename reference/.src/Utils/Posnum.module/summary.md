# Posnum — Synthèse

> Source : `.src/Utils/Posnum.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Convertit un rang 1-20 en ordinal français (« premier »… « vingtième »).

## Points clés

- Aucun appelant dans le projet : module mort.
- `Select Case` de 20 cas (CC 21).

## Dépendances principales

- Aucune.

## Risques

- Aucun.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 45 |
| Lignes de commentaire | 4 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 21 (`Pos`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `gbtest` de caractérisation (POSNUM-T01), retiré avec le module.

## Rework

1 étape (POSNUM-001) : suppression du module. Aucune anomalie.
