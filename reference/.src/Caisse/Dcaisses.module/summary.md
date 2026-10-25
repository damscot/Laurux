# Dcaisses — Synthèse

> Source : `.src/Caisse/Dcaisses.module` · Synthèse des autres documents.

## Rôle

Ancienne lecture du verrou `~/Caisse<N>.lock` (vendeur connecté sur une caisse), remplacée par
`TestCaisses.TestCai`.

## Points clés

- Module **jamais référencé** (signal `jamais_reference` confirmé par `grep`), sans `.form`.
- Homonyme de `TestCaisses.TestCai` (signature différente, appels qualifiés : pas d'ambiguïté).

## Dépendances principales

- Utilise `User.home` ; aucun appelant, aucune table.

## Risques

- Aucun.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`TestCai`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Aucun test : suppression validée par `gbc3 -agt` et `./Laurux -T all`.

## Rework

1 étape (DCAISSES-001) : suppression du module [code mort]. Aucune anomalie.
