# Expart — Synthèse

> Source : `.src/Utils/Exports-Imports/Expart.class` · Synthèse des autres documents.

## Rôle

Export des articles (`Fiches_Art`) en CSV `;` (`Liste_articles.csv`), avec en-tête et prix formatés
selon le nombre de décimales de l'article.

## Points clés

- Traitement complet dans `Button2_Click`, 21 variables intermédiaires.
- Tri par `lpad(art_code,15,' ')` (traduit pour SQLite).
- `art_stocke` exporté `O`/`N` via la conversion Booléen → `"T"`.

## Dépendances principales

- Ouverte par `Fmenu.Menu281_Click` (non vu par deps.py).
- `Utils.Find_nbdec`, `Utils.db`, `Start.Son`/`Musique`.

## Risques

- Prix `Null` → erreur d'export ; `;` dans les libellés casse le CSV.
- Comportement de `art_stocke` sous SQLite à confirmer.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 79 |
| Lignes de commentaire | 22 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 8 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (EXPART-T01 à T05) comparant le CSV produit, dont un sous SQLite.

## Rework

5 étapes (documentation, simplification, séparation traitement/GUI, socle commun avec
`Expclient`, `Cbase.Table`) et 3 anomalies (A01 à A03).
