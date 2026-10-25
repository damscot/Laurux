# Ecarts — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Édition PDF des écarts de l'inventaire de fin d’exercice : lignes comptées de `Fiches_Inv`,
stock théorique, comptage, écart valorisé au PA et au PMP actuels, totaux.

## Points clés

- Lecture seule ; une requête `Fiches_Art` par ligne, sans `ORDER BY` ni `Available`.
- `Level1/2/3` : ancien dessin `Draw` jamais appelé (code mort).
- 91 % identique à `EcartsT`, 62 % avec l'édition des non saisis.

## Dépendances principales

- `Utils.db`, `Utils.PointBase`, `Cstocks`, `Visualiseur`, `Doc` ; appelé par `Fmenu`.

## Risques


- Article supprimé / ordre des lignes (ECARTS-A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 162 |
| Lignes de commentaire | 24 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 5 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 scénarios `replay` (ECARTS-T01 à T06), comparaison du texte du PDF.

## Rework

5 étapes (ECARTS-001 à 005) : documentation, code mort, `Cbase.Table`, séparation traitement/GUI,
édition commune paramétrée. 1 anomalie.
