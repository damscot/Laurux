# RazHistoFbl — Synthèse

> Source : `.src/Archivages/RazHistoFbl.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Epuration des BL fournisseurs » (`Fmenu.Menu261`, `Prgm` nom `efb`) : supprime les bons de
réception fournisseurs (`Fiches_Entrecpt` + `Fiches_Ligrecpt`) antérieurs à la date choisie, après
confirmation et sauvegarde `mysqldump`.

## Points clés

- **Suppression par `numrecpt` seul** alors que la clé est `(four, numrecpt)` : une réception d'un
  autre fournisseur de même numéro est supprimée, quelle que soit sa date.
- Pas de filtre sur `validee` ; pas de garde-fou par rapport au dernier inventaire.
- Boucle avec `ProgBar` interruptible, sans transaction ; écran non instrumenté.

## Dépendances principales

- Appelé par `Fmenu.Menu261_Click` et `Prgm` ; utilise `Utils.db`, `Cbase.Table`, `ProgBar`,
  `Syntheses.Message`, `Shell mysqldump`.
- Données lues par `Cstock`, `ValidBR`/`ValidBR1`, `Articles`, `Stockmvt`, `StatFour`, options boissons.

## Risques

- **A01** perte de réceptions hors période (autre fournisseur) ; A03 stock recalculé faux et BL non
  validés perdus (à confirmer) ; A02 sauvegarde non contrôlée ; A04 SQLite sans effet.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 33 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests `replay` (RAZHISTOFBL-T01 à T06) dont le cas « même numéro, deux fournisseurs » et l'effet
sur le recalcul de stock ; dump avant/après, horloge figée, **à valider par l'utilisateur**.

## Rework

3 étapes (RAZHISTOFBL-001 à 003) : documentation, séparation `Purge`, commonalisation. 4 anomalies
(A01 à A04).
