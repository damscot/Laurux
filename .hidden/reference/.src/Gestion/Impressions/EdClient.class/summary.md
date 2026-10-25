# EdClient — Synthèse

> Source : `.src/Gestion/Impressions/EdClient.class` · Synthèse des autres documents.

## Rôle

Écran d'impression de la **liste des clients** filtrée par plage de codes, statuts, types et mode
de règlement, triée par code ou nom (`~/tmp/Clients.pdf`, `Cclients`).

## Points clés

- Une seule liste `Colcli` pour six champs (variable `Org`) ; trois fonctions `Aff_*` quasi
  identiques.
- Clause `WHERE` construite dynamiquement ; codes comparés en chaîne (`CAST … AS CHAR`).
- Gabarit commun avec `EdFour` (141 lignes communes) et `EdFam`.

## Dépendances principales

- Appelé par `Fmenu` (`Menu101`). Utilise `Cclients`, `Visualiseur`, `Doc`, `Cbase`.
- Lit `Fiches_Cli`, `Fiches_Statut`, `Fiches_Typec`.

## Risques

- EDCLIENT-A01 : le filtre « mode de règlement » écrase tous les autres filtres.
- EDCLIENT-A02 : erreur SQL si tous les champs sont vides.
- EDCLIENT-A03 : titre incomplet sur les pages suivantes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 338 |
| Lignes de commentaire | 18 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 78 |
| Complexité max (fonction) | 15 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (EDCLIENT-T01 à T06) : filtres, mode de règlement (A01 figée), champs vides (A02),
listes, saut de page (A03) ; le SQL du log fige la clause construite.

## Rework

6 étapes (EDCLIENT-001 à 006) : documentation, code mort, portée, fusion des `Aff_*`, filtre SQL
pur, socle commun. 3 anomalies (EDCLIENT-A01 à A03).
