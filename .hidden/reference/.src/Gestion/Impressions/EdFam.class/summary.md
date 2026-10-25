# EdFam — Synthèse

> Source : `.src/Gestion/Impressions/EdFam.class` · Synthèse des autres documents.

## Rôle

Écran d'impression de la **liste des familles d'articles** sur une plage de codes
(`~/tmp/Famille.pdf`, `Cdocuments`), avec deux listes de sélection des bornes.

## Points clés

- Gabarit commun avec `EdFour` (104 lignes communes) et `EdClient`.
- `Button2` est groupé dans `Btn` : `Button2_Click` n'est qu'un pseudo-handler ; `Case 1` de
  `Btn_Click` inatteignable.
- `Colfam_Click`/`Colfam2_Click` appelés dynamiquement au rejeu : restent `Public`.

## Dépendances principales

- Appelé par `Fmenu` (`Menu54`). Utilise `Cdocuments`, `Visualiseur`, `Doc`, `Utils`.
- Lit `Fiches_Fam`.

## Risques

- Faibles : écran en lecture seule, aucune anomalie relevée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 217 |
| Lignes de commentaire | 31 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 7 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (EDFAM-T01 à T05) : plage par défaut, sélection par liste, plage vide, saut de
page, clavier.

## Rework

6 étapes (EDFAM-001 à 006) : documentation, code mort, portée, helpers de liste, socle commun
« plage de codes » avec `EdFour`/`EdClient`/`EdDocs`, séparation. Aucune anomalie.
