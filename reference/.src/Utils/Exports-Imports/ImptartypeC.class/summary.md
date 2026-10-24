# ImptartypeC — Synthèse

> Source : `.src/Utils/Exports-Imports/ImptartypeC.class` · Synthèse des autres documents.

## Rôle

Import des coefficients tarifaires par type de client (`Fiches_TarTypcli`) depuis un fichier `;`
(code article en colonne 0, coefficient en colonne 12).

## Points clés

- Programme de maintenance lancé par « Appel programme » (`Prgm`).
- Upsert manuel (SELECT puis INSERT ou UPDATE) par ligne.
- Code type = 2 premiers caractères de la ComboBox.

## Dépendances principales

- `Prgm` (non vu par deps.py) ; `Utils.db`, `Utils.cpoint` ; tables `Fiches_Typec`,
  `Fiches_TarTypcli` en dur.

## Risques

- Ligne courte → erreur et import partiel ; type vide accepté.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 52 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 6 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (IMPTARTYPEC-T01 à T04), diff de `Fiches_TarTypcli`.

## Rework

5 étapes (documentation, code mort, séparation traitement/GUI, socle commun, `Cbase.Table`) et
3 anomalies (A01 à A03).
