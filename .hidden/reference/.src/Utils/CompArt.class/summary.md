# CompArt — Synthèse

> Source : `.src/Utils/CompArt.class` · Synthèse des autres documents.

## Rôle

Compare un fichier `code;libellé` à `Fiches_Art` et liste les codes absents dans `~/tmp/Diff.txt`.

## Points clés

- Programme de maintenance lancé par `Prgm` ; lecture seule.
- Jumeau à 92 % d'`ImportStk`.

## Dépendances principales

- `Prgm` (non vu par deps.py) ; `Utils.db`, `Visualiseur.Prog`, `Start.Son`/`Musique`.

## Risques

- Erreurs d'exécution sur fichier absent ou ligne mal formée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 53 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (COMPART-T01 à T03) comparant `Diff.txt`.

## Rework

3 étapes (séparation, factorisation avec `ImportStk`, `Cbase.Table`) et 1 anomalie (A01).
