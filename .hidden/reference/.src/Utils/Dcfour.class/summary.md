# Dcfour — Synthèse

> Source : `.src/Utils/Dcfour.class` · Synthèse des autres documents.

## Rôle

Liste dans `~/Doublon.txt` les articles partageant la même référence fournisseur et ouvre le
fichier dans l'éditeur.

## Points clés

- Programme de maintenance lancé par `Prgm`.
- *n* + 1 requêtes ; groupes répétés ; seconde passe sans effet.
- Même squelette que `VisPmp`.

## Dépendances principales

- `Prgm` (non vu par deps.py) ; `Utils.db`, `Cbase.Table("TabArt")`, `Editeur.Prog_Editeur`.

## Risques

- Faibles (lecture seule) ; résultats redondants ou incomplets.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 60 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 14 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (DCFOUR-T01 à T03) comparant `Doublon.txt`.

## Rework

3 étapes (documentation, séparation, helper commun avec `VisPmp`) et 3 anomalies (A01 à A03).
