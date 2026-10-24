# gridv — Synthèse

> Source : `.src/Utils/gridv.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module à fonction unique (`ajoustat`) qui dessinait un onglet « Statistiques » vide ; remplacé par
la classe `gridvi` et **jamais appelé** : code mort.

## Points clés

- Aucun appelant (vérifié par `grep`), seule une mention en commentaire dans `Tregie`.
- 35 lignes identiques à `gridvi` (en-têtes d'exercice, libellés de mois).

## Dépendances principales

- Utilise `Utils.db` (`Fiches_Parametres`) et `Utils.mois`.

## Risques

- Aucun à l'exécution.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 56 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 10 (`ajoustat`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 contrôle de build (GRIDV-T01) ; non-régression assurée par les replays de `gridvi`.

## Rework

1 étape : suppression du module (GRIDV-001). Aucune anomalie.
