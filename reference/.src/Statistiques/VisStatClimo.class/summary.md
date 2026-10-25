# VisStatClimo — Synthèse

> Source : `.src/Statistiques/VisStatClimo.class` · Synthèse des autres documents.

## Rôle

Visualisation et impression du CA pièces / main d'oeuvre par client calculé par `StatClimo` :
grille `Liste` (pièces, remises, M.O., remises M.O., total net) et PDF `~/tmp/Statpmc.pdf`.

## Points clés

- Lecture seule de `Total`, tris par RadioButton (`Click`), pas de totaux à l'écran.
- Impression : requête `Fiches_Societes` inutile ; lignes passées en `Float` à `level2P`.
- Famille `VisStat*` : socle commun proposé (voir VisStatComm).

## Dépendances principales

- Ouvert par `StatClimo.Traitement` ; `Chistoriques` (`Level1P`, `level2P`, `Level4P`,
  `Level5P`), `Visualiseur`, `Utils`.

## Risques

- **A01** : montants des lignes du PDF non localisés et non formatés.
- Anomalies amont de `StatClimo` (BL hors période, `union`) ; table `Total` partagée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 185 |
| Lignes de commentaire | 23 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 19 |
| Complexité max (fonction) | 4 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests : 4 `replay` (affichage, tris, impression, fermeture), 1 `gbtest`. Ne pas cliquer dans
`Liste`.

## Rework

5 étapes (VISSTATCLIMO-001 à 005) : documentation, code mort (dont requête inutile), portée,
socle `VisStat*`, séparation. 1 anomalie (A01).
