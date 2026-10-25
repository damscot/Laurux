# EdinvT — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancienne édition de l'inventaire tournant (sans familles), **jamais appelée** : remplacée par
`Edinv("T")`.

## Points clés

- Couple `.class` + `.form` mort (aucune référence dans `.src`).
- Contient aussi `Level1/2/3` (dessin `Draw`) jamais appelées.

## Dépendances principales

- Aucun appelant ; dépendances statiques vers `Utils`, `Cstocks`, `Visualiseur`.

## Risques

- Aucun à l'exécution ; coût de maintenance et confusion (tables et libellés dupliqués).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 161 |
| Lignes de commentaire | 25 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 10 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (`EDINVT-T01`) de non-régression de la suppression ; le comportement équivalent est couvert
par EDINV.

## Rework

1 étape de documentation ; 1 anomalie (EDINVT-A01 : suppression du couple, validation requise).
