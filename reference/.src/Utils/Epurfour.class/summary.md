# Epurfour — Synthèse

> Source : `.src/Utils/Epurfour.class` · Synthèse des autres documents.

## Rôle

Script de maintenance : vide `art_cfour` (référence fournisseur) de tous les articles.

## Points clés

- Méthode statique `run` appelée par `Prgm` ; aucune confirmation.
- Un `UPDATE` par article.

## Dépendances principales

- `Prgm` ; `Utils.db`, `Cbase.Table("TabArt")`.

## Risques

- Perte irréversible de toutes les références fournisseurs sur simple saisie du nom du programme.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 12 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 replays (EPURFOUR-T01, T02).

## Rework

3 étapes (documentation, `UPDATE` unique, séparation) et 1 anomalie (A01, absence de confirmation).
