# RecupDech — Synthèse

> Source : `.src/Compta/Utils/RecupDech.class` · Synthèse des autres documents.

## Rôle

Script statique lancé par `Prgm` (`RecupDech`) : exporte dans `~/tmp/Dtech.txt` les dates
d'échéance des écritures des comptes 401/411 non collectifs (`numdoc;compte;date;`), pour réimport
par `Renech`.

## Points clés

- Seule la méthode statique `run` est utilisée ; le `.form` n'est jamais affiché (code mort).
- Trace `Print` sur la sortie standard ; date convertie implicitement en chaîne.
- Chemin d'export différent du chemin lu par `Renech`.

## Dépendances principales

- Utilise : `Utils.db`, `Cbase.Table("TabMvt")`, `User.Home`.
- Utilisé par : `Prgm.class:83` ; produit le fichier lu par `Renech`.

## Risques

- Faibles (lecture seule de la base) ; erreur d'exécution si `~/tmp` n'existe pas.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 17 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 4 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `gbtest` (export nominal, répertoire absent, SQLite) et 1 `replay` via `Prgm`
(RECUPDECH-T01 à T04).

## Rework

2 étapes (RECUPDECH-001, 002) : documentation, nettoyage. 2 anomalies (A01 : suppression du
`.form` mort ; A02 : format de date et chemins).
