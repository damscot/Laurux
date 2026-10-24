# FTips — Synthèse

> Source : `.src/Communs/FTips.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Astuce du jour » : affiche une section HTML de `tips/tips.fr` (24 astuces), parcourue de
façon circulaire, au démarrage (si `/Tips`) et depuis le menu « ? > Astuces ».

## Points clés

- Index des sections construit une fois par `_init` statique ; position mémorisée dans `/LastTip`.
- Fichier relu en entier à chaque astuce ; un calcul de couleur inutilisé dans `_new`.
- Membres statiques partagés entre l'instance du démarrage et celle du menu.

## Dépendances principales

- Appelé par `Start.Lancement` et `Fmenu.Menu125`.
- Utilise `Start.LocalSettings`, `Utils.FColr`, `Utils.Observers` et le fichier `tips/tips.fr`.

## Risques

- Fichier d'astuces absent : erreur au démarrage (A01).
- `/LastTip` hors bornes : message d'erreur en reculant (A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 87 |
| Lignes de commentaire | 5 |
| Fonctions | 11 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 22 |
| Complexité max (fonction) | 8 (`GetNextTip`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests (FTIPS-T01 à T05) : 4 `replay` (démarrage, parcours circulaire, case d'affichage, indice
hors bornes) et un `gbtest` sur les fonctions extraites.

## Rework

4 étapes (FTIPS-001 à 004) : documentation, code mort, extraction de fonctions pures, lecture unique
du fichier. 2 anomalies (FTIPS-A01, A02).
