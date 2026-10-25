# EdFour — Synthèse

> Source : `.src/Gestion/Impressions/EdFour.class` · Synthèse des autres documents.

## Rôle

Écran d'impression de la **liste des fournisseurs** sur une plage de codes, triée par code ou par
nom (`~/tmp/Fours.pdf`, `Cclients`, paysage), avec listes de sélection des bornes (F2 ou bouton).

## Points clés

- Gabarit commun avec `EdClient` (141 lignes communes) et `EdFam` (104).
- `Button2_Click` pseudo-handler d'un bouton groupé ; `Case 1` de `Btn_Click` inatteignable.
- Boucles `Do … Loop Until` (idiome isolé).

## Dépendances principales

- Appelé par `Fmenu` (`Menu104`, `Menu108`). Utilise `Cclients`, `Visualiseur`, `Doc`.
- Lit `Fiches_Four`.

## Risques

- EDFOUR-A01 : pied de la dernière page décentré (pied portrait sur page paysage).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 234 |
| Lignes de commentaire | 31 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 10 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (EDFOUR-T01 à T05) : tri par code et par nom, sélection, plage vide, saut de page.

## Rework

6 étapes (EDFOUR-001 à 006) : documentation, code mort, portée, helpers de liste, socle commun
avec `EdFam`/`EdClient`/`EdDocs`, séparation. 1 anomalie (EDFOUR-A01).
