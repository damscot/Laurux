# FAbout — Synthèse

> Source : `.src/Communs/FAbout.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « A propos de Laurux » (menu « ? > Concernant Laurux ») : version, SHA1 court et branche
de compilation, panneau défilant de remerciements.

## Points clés

- Version lue dans `Application.Version` ; SHA1 et branche dans `Start.version_sha1` /
  `Start.version_branch`.
- Deux boucles de dégradé quasi identiques ; un handler vide `Grad1_MouseDown` (conservé).

## Dépendances principales

- Appelé par `Fmenu.Menu23`. Utilise `Start`, `Utils.Observers`.

## Risques

- Faibles. Minuteur de défilement actif dès l'ouverture avec un délai nul (A01, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 43 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 3 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `replay` (FABOUT-T01, T02) : contenu à l'ouverture, bascule des remerciements.

## Rework

2 étapes (FABOUT-001, 002) : documentation et factorisation des dégradés. 1 anomalie (FABOUT-A01).
