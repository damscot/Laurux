# VisPmp — Synthèse

> Source : `.src/Utils/VisPmp.class` · Synthèse des autres documents.

## Rôle

Liste dans `~/Pmp.txt` les articles dont le PMP est négatif et ouvre le fichier dans l'éditeur.

## Points clés

- Programme de maintenance lancé par `Prgm` (nom `Pmp`).
- Même squelette que `Dcfour`.

## Dépendances principales

- `Prgm` (non vu par deps.py) ; `Utils.db`, `Cbase.Table("TabArt")`, `Editeur.Prog_Editeur`.

## Risques

- Faibles (lecture seule).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 5 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 replays (VISPMP-T01, T02) comparant `Pmp.txt`.

## Rework

3 étapes (documentation, séparation, helper commun avec `Dcfour`) et 1 anomalie (A01).
