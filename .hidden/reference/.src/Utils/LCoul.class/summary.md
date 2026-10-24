# LCoul — Synthèse

> Source : `.src/Utils/LCoul.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Couleurs de fond des listes (articles, écritures comptables, documents de vente) et génération des
fragments SQL `CASE WHEN … END as bgcolor` utilisés par les écrans de tri pour colorer les lignes.

## Points clés

- Couleurs d'articles lues dans `Laurux.conf` (`/Coul/Stk`, `Nstk`, `Eps`, `Spd`) ; couleurs
  d'écritures et de documents en dur.
- Signature de `_New` copiée de `LPrix` (paramètres inutilisés).
- 14 champs `Public` utilisés seulement en interne.

## Dépendances principales

- Utilise : `Start.LocalSettings`, `Utils.Fcolr` (et `LPrix.Arr_001` sans raison).
- Utilisé par : `TriArticles`, `TriFacture`, `Articles` (instance) et `Listextcpt` (statique).

## Risques

- Ligne 56 : affectation d'une chaîne à une structure (LCOUL-A01).
- Paramétrage des couleurs de documents ignoré (LCOUL-A03) ; proformas non colorés (A02).
- Valeurs de configuration concaténées dans le SQL (risque faible, configuration locale).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 92 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 5 (`_New`) |
| Variables globales | 0 |
| Variables Public | 14 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (LCOUL-T01 à T04) : fragments avec configuration complète, absente ou mal formée,
et exécution des fragments sur MySQL et SQLite.

## Rework

5 étapes (LCOUL-001 à 005) : documentation, signature de `_New`, helpers de lecture et de
construction du `CASE`, réduction de portée. 3 anomalies (LCOUL-A01 à A03).
