# ImportStk — Synthèse

> Source : `.src/Utils/Exports-Imports/ImportStk.class` · Synthèse des autres documents.

## Rôle

Import d'un fichier `code;quantité` qui écrase `art_qte` et `art_stkdep` de `Fiches_Art` ; les codes
inconnus sont listés dans `~/tmp/Diff.txt`.

## Points clés

- Programme de maintenance appelé par « Appel programme » (`Prgm`), pas par un menu.
- Copie à 90 % de `CompArt` (même squelette, même fichier de rapport).
- En-tête de commentaire erroné (copié de `CompArt`).

## Dépendances principales

- `Prgm` (non vu par deps.py), `Utils.db`, `Visualiseur.Prog`, `Start.Son`/`Musique`.
- Table `Fiches_Art` (en dur).

## Risques

- Écrase le stock sans mouvement ni transaction.
- Codes avec espaces : mise à jour perdue sans signalement.
- Erreurs d'exécution sur fichier absent ou ligne mal formée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (IMPORTSTK-T01 à T04) : fichier d'entrée + diff de `Fiches_Art` et de `Diff.txt`.

## Rework

4 étapes (documentation, séparation traitement/GUI, factorisation avec `CompArt`, `Cbase.Table`)
et 3 anomalies (A01 à A03).
