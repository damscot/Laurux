# Positions — Synthèse

> Source : `.src/Caisse/Positions.class` · Synthèse des autres documents.

## Rôle

Énumération `{Left}, {Right}, Top, Bottom, Background` importée avec Laurux-Pos, jamais utilisée.

## Points clés

- Classe **jamais référencée** (signal `jamais_reference` confirmé par `grep`), sans `.form`.

## Dépendances principales

- Aucune, dans un sens comme dans l'autre.

## Risques

- Aucun.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1 |
| Lignes de commentaire | 1 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Aucun test : suppression validée par `gbc3 -agt` et `./Laurux -T all`.

## Rework

1 étape (POSITIONS-001) : suppression du fichier [code mort]. Aucune anomalie.
