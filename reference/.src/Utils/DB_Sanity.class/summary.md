# DB_Sanity — Synthèse

> Source : `.src/Utils/DB_Sanity.class` · Synthèse des autres documents.

## Rôle

Fenêtre Admin de contrôle de structure : compare la base réelle à `db_control.csv` (lu dans le
répertoire courant), colore les écarts, exporte en CSV, corrige la base (types, défauts, `NULL`,
collations, champs et tables manquants, clés primaires, `AUTO_INCREMENT`, index secondaires) et
supprime les champs ou tables en trop.

## Points clés

- `Refresh_Data` (CC 50) : lecture `DESCRIBE`/`SHOW INDEXES` (MySQL) ou `PRAGMA table_info` (SQLite),
  comparaison colonne par colonne avec jokers `?`, filtres d'affichage par boutons radio.
- `Corriger_Click` (CC 30) et `SyncKeys` (CC 29) génèrent du DDL MySQL à partir du CSV ; `RenumAI`
  renumérote des identifiants (modification de données).
- Corriger et Nettoyer sont **spécifiques à MySQL**.
- Codes de validité : 0 écart, 1 conforme, 2 absent, 3 en trop, -1 non comparé.

## Dépendances principales

- Utilise : `DB_Connection` (`Tables`, `Exec`, `IsType`, `Commit`), `ProgBar`, `Start.Societe`.
- Utilisé par : `Fmenu.Menu142_Click` uniquement. `.form` : `DB_Sanity.form` (13 handlers).

## Risques

- Opérations destructrices (`DROP TABLE`, `DROP COLUMN`, renumérotation) pilotées par un CSV non
  validé ; sauvegarde préalable indispensable (seulement conseillée par le message).
- Anomalies : `ENGINE=` sans espace (A01), schéma reconstruit sans le préfixe (A02), export CSV
  dépendant du défilement (A03), type de `Valid` incohérent (A04), état `Datain` périmé (A05),
  boutons MySQL actifs sous SQLite (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 575 |
| Lignes de commentaire | 40 |
| Fonctions | 25 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 171 |
| Complexité max (fonction) | 50 (`Refresh_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus (DB_SANITY-T01 à T09) : 7 `replay` (contrôle conforme et dégradé, filtres, correction,
clés, nettoyage, SQLite) avec dump de structure normalisé et CSV exporté, et 2 `gbtest` sur les
fonctions pures extraites (clés, comparaison).

## Rework

7 étapes sans changement de comportement (DB_SANITY-001 à 007) : documentation, code mort,
découpage de `Refresh_Data`, séparation de la génération du DDL, factorisation de l'affichage,
réduction de portée, simplification de `GridView1_Data`. 6 anomalies (DB_SANITY-A01 à A06).
