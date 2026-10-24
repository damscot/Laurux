# RenMvt — Synthèse

> Source : `.src/Compta/Utils/RenMvt.module` · Synthèse des autres documents.

## Rôle

Script de reprise ponctuel lancé par `Prgm` (`RenMvt`) : déplace les écritures du journal 80 de
`Fiches_Mvt` vers `Fiches_Mvt1` en retirant le premier chiffre de leur numéro. Contient aussi `Ren`,
renumérotation globale des écritures, jamais appelée.

## Points clés

- Aucune confirmation, aucune transaction, tables en dur.
- `Run` supprime l'écriture de numéro **tronqué** au lieu de celle copiée.
- Copie partielle : la clé `control`, `numerodef`, `dateech`… sont perdues.
- `Ren` est du code mort.

## Dépendances principales

- Utilise : `Utils.db` ; tables `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Parametres`.
- Utilisé par : `Prgm.class:82`.

## Risques

- **Destruction de données** et rupture de l'inaltérabilité si lancé sur une base courante
  (A01-A03) ; erreur d'exécution sans journal 80.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 20 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 4 (`Ren`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (RENMVT-T01, T02) et 1 `replay` (T03, via `Prgm`) de caractérisation, dump
normalisé.

## Rework

2 étapes (RENMVT-001, 002) : documentation, suppression de `Ren`. 3 anomalies (A01 à A03) dont le
retrait du script avec `Prgm`.
