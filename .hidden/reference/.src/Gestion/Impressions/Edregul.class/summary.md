# Edregul — Synthèse

> Source : `.src/Gestion/Impressions/Edregul.class` · Synthèse des autres documents.

## Rôle

Écran d'impression des **régularisations de stock** (`Fiches_Mvtexp`) d'une période, en PDF
(`~/tmp/Regul.pdf`, `Carticles`), avec purge facultative des mouvements imprimés.

## Points clés

- Jumeau d'`Edregulprdc` (≈ 93 % des lignes d'`Edregul` communes) et parent d'`Edsdepots`.
- Un handler `Button2_Click` (CC 13) : lecture, N+1 lectures d'articles, PDF, purge.
- Saisie de dates par le groupe `Cmpt` : `date*_LostFocus` ne sont que des pseudo-handlers,
  `date2_GotFocus` est un handler inactif (code mort).
- Boutons `Button1` (aide) et `Button6` sans handler.

## Dépendances principales

- Appelé par `Fmenu` (`Menu91`). Utilise `Carticles`, `Visualiseur`, `Utils` (dates, `db`).
- Table `Fiches_Mvtexp` partagée avec `Mvtex`, `Epurmvtexp`, `Cstock`, `Stockmvt`.

## Risques

- **EDREGUL-A01 (critique)** : la purge supprime toutes les régularisations des articles
  concernés, hors période comprise.
- A02 (purge sans mouvement), A03 (date non normalisée à la souris, à confirmer), A04 (PDF
  temporaire jamais supprimé).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 31 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 13 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (EDREGUL-T01 à T07) : impression, purge (A01 figée), refus, période vide, saisie
des dates, date à la souris, saut de page ; comparaison `pdftotext` + dump `Fiches_Mvtexp`.

## Rework

6 étapes (EDREGUL-001 à 006) : documentation, code mort, réduction de portée, module commun avec
`Edregulprdc`, séparation traitement/GUI (jointure), saisie de période commune. 4 anomalies
(EDREGUL-A01 à A04).
