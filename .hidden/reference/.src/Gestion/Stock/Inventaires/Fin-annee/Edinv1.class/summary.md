# Edinv1 — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne édition de l'inventaire de fin d’exercice par famille, **jamais appelée** : remplacée par
`Edinv("F")`.

## Points clés

- Couple `.class` + `.form` mort (aucune référence dans `.src`).
- 87 % identique à `Edinv`.

## Dépendances principales

- Aucun appelant ; dépendances statiques vers `Utils`, `Cstocks`, `Visualiseur`.

## Risques

- Aucun à l'exécution ; coût de maintenance et confusion (tables et libellés dupliqués).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 126 |
| Lignes de commentaire | 28 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 27 |
| Complexité max (fonction) | 15 (`TriArticles`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (`EDINV1-T01`) de non-régression de la suppression ; le comportement équivalent est couvert
par EDINV.

## Rework

1 étape de documentation ; 1 anomalie (EDINV1-A01 : suppression du couple, validation requise).
