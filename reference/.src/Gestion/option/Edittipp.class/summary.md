# Edittipp — Synthèse

> Source : `.src/Gestion/option/Edittipp.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

État mensuel TICPE « Annexe IX » (liste des destinataires finals d'un distributeur de carburant
en acquitté) : classe d'un `Report` (`Edittipp.report`) listant les lignes de BL et de factures
portant un code TIPP.

## Points clés

- Une requête `UNION ALL` (BL de type B/F + factures historisées) sur le mois choisi ;
  colonnes `tipp_ligbl`, `tipp_ligfac`, `cli_dfin` ajoutées par `modfichier` (absentes de
  `db_control.csv`).
- Les 7 handlers `*_Data` sont des événements du `.report` : faux `unused` de `deps.py`, à garder
  `Public`.
- Raison sociale et adresse d'une société précise en dur dans le `.report`.

## Dépendances principales

- Utilise : `Utils.db`, `LDate`, gb.report.
- Utilisé par : `menuopt` (impression PDF, `Visualiseur`).

## Risques

- Jointure régionale sur l'article seul (lignes dupliquées par région, à confirmer).
- Double comptage possible BL facturé / historique (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 38 |
| Lignes de commentaire | 1 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 2 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests (EDITTIPP-T01 à T03) : 2 replays (texte du PDF) et 1 `gbtest` du jeu de lignes.

## Rework

4 étapes (EDITTIPP-001 à 004) : documentation, requête isolée, helper des `*_Data`,
`Cbase.Table`. 3 anomalies (A01 à A03).
