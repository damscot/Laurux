# RichDataGrid — Synthèse

> Source : `.src/Utils/RichDataGrid.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Enrichit un `GridView` existant en grille liée à une table : chargement `SELECT *`, formats de
colonnes (`CFormat`), formats conditionnels, tri par en-tête, recherche « commence par » au clic
droit, valeur du champ clé exposée par `Value` et les événements `Select`/`Activate`.

## Points clés

- Un seul utilisateur : `Remisec` (table `Fiches_RemTypec`).
- SQL exécuté par `db.Exec` (classe `DB` de gb.db), hors `Utils.db`.
- `Grid_Data` (CC 24) mélange formats de colonne et conditions ; cas `datebl` codé en dur.
- Code mort : `$oFormatDefaut`, `sFind`, blocs commentés Gambas 2.

## Dépendances principales

- Utilisé par `Remisec` (propriétés, `Refresh`, `Value`).
- Utilise `CFormat`, `Conditions`, `Utils.Cdate_Aff`, `DB`.

## Risques

- Recherche concaténée dans le SQL (A01) ; connexion hors `Utils.db` (A02).
- Propriétés `BackColor`/`ForeColor` inexistantes et `Tag_Write` erroné (A03, latents).
- Précédence `Or`/`And` dans le formatage (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 225 |
| Lignes de commentaire | 32 |
| Fonctions | 32 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 73 |
| Complexité max (fonction) | 24 (`Grid_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 `replay` sur `Remisec` (affichage, tri, recherche, sélection, suppression, SQLite) et 1 `gbtest`
sur la construction de la requête après extraction.

## Rework

4 étapes (RICHDATAGRID-001 à 004) : documentation, code mort, réduction de complexité de
`Grid_Data`, extraction de la requête. 4 anomalies (A01 à A04) soumises à validation.
