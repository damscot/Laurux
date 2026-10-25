# Edbr — Synthèse

> Source : `.src/Gestion/Impressions/Edbr.module` · Synthèse des autres documents.

## Rôle

Impression des **bons de réception fournisseur** (`~/tmp/BonReception.pdf`, `Cdocuments`) pour
`Edbl` (réimpression) et `ValidBR` (validation, avec pied de TVA), puis copie dans `~/Impressions`
et archivage GED si le fournisseur le demande (`fo_copie`).

## Points clés

- État de module partagé entre appels (`pdf`, `PosY`, `TotEuros`…) ; `Init` appelé par `ValidBR`.
- `Calc_tva` lit la table de travail `Totalisation` préparée par `ValidBR`.
- Code mort : variable `Cdocuments` homonyme de la classe, `son`, branche `Valcom`, `~/BR`.
- Séquence GED identique à `ObjFac`/`commande1`/`EcrAuto` → `LGed.Archive` (LGED-007).
- Requête `tag_def` par concaténation (correcte car `fo_code` est entier).

## Dépendances principales

- Appelé par `Edbl` (3 appels) et `ValidBR` (`Init`, `Ed`).
- Utilise `Cdocuments`, `Copie.Dupli` (→ `Copie.spiece`, COPIE-A02), `LGed`, `LPrix`, `LDate`,
  `Visualiseur`, `Cbase`.

## Risques

- EDBR-A01 : en validation multiple, la GED ne référence que le dernier BR.
- EDBR-A02 : date différente dans l'en-tête des pages suivantes.
- EDBR-A03/A04 : son jamais joué, page vide pour un BR sans ligne.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 228 |
| Lignes de commentaire | 14 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 19 (`Ed`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (EDBR-T01 à T07) via `Edbl` et `ValidBR` : BR simple, GED, validation multiple,
saut de page, auto-entrepreneur, prix sans décimale, BR vide. Le jeu partagé `editions_gestion`
des éditions de gestion est décrit dans `test.md`.

## Rework

7 étapes (EDBR-001 à 007) : documentation, code mort, portée, `LGed.Archive`, SQL paramétré et
`Cbase`, séparation du calcul de TVA, découpage d'`Ed`. 4 anomalies (EDBR-A01 à A04).
