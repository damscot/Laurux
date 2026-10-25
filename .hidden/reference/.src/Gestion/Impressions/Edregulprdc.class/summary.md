# Edregulprdc — Synthèse

> Source : `.src/Gestion/Impressions/Edregulprdc.class` · Synthèse des autres documents.

## Rôle

Écran d'impression des **entrées de produits composés** (`Fiches_Mvtexpdc`, fabrications
`mind` saisies par `MvtProdcomp`) d'une période, en PDF (`~/tmp/Regul.pdf`), avec purge
facultative.

## Points clés

- Copie d'`Edregul` (142 lignes communes) : table, titre, tri, séparateur entre fabrications,
  couleur de champ.
- `Level1`/`Level2` et `date2_GotFocus` : code mort ; `date*_LostFocus` : pseudo-handlers.
- Un handler `Button2_Click` (CC 13) : lecture, N+1 articles, PDF, purge.

## Dépendances principales

- Appelé par `Fmenu` (`Menu264`). Utilise `Carticles`, `Visualiseur`, `Utils`.
- Table `Fiches_Mvtexpdc` écrite par `MvtProdcomp`.

## Risques

- **EDREGULPRDC-A01 (critique)** : la purge efface les mouvements des composants dans toutes les
  fabrications, hors période comprise.
- A02 (purge sur période vide), A03 (suppression d'un fichier inexistant).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 186 |
| Lignes de commentaire | 33 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 39 |
| Complexité max (fonction) | 13 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (EDREGULPRDC-T01 à T05) : impression avec séparateurs, purge (A01 figée),
période vide, saisie des dates, saut de page.

## Rework

5 étapes (EDREGULPRDC-001 à 005) : documentation, code mort, portée, module commun avec `Edregul`,
séparation traitement/GUI. 3 anomalies (EDREGULPRDC-A01 à A03).
