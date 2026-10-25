# EditStkDepart — Synthèse

> Source : `.src/Gestion/option/EditStkDepart.class` · Synthèse des autres documents.

## Rôle

État `gb.report` de l'option boissons : stock d'alcool par code régie et par degré (volumes
effectif, alcool pur, sécurité sociale) pour quatre sources : inventaire de fin d'année,
inventaire tournant, stock de départ, stock de fin. Appelé par `Caleditcmat.editinv`.

## Points clés

- Énumération `Public` (`inventaire`, `tournant`, `depart`, `fin`) utilisée par `Caleditcmat`.
- Ruptures : sous-total par degré, total et saut de page par régie.
- Volumes calculés ligne par ligne par `Calculdroit` (qui fait ses propres requêtes).
- Lecture seule ; aucune table `*M` du matériel.

## Dépendances principales

- Utilise : `Calculdroit`, `LDate`, `Start.R/G/B`, `Utils.db` ; tables `Fiches_Art`,
  `Fiches_Inv`, `Fiches_InvT`, `Fiches_regie`.
- Utilisé par : `Caleditcmat` uniquement.

## Risques

- Articles à code régie vide imprimés (filtre `IS NOT NULL` au lieu de `<> ''`, A01).
- Police mal orthographiée (A02, cosmétique).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 136 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 9 (`_new`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (EDITSTKDEPART-T01 à T06) : comparaison du texte du PDF produit, horloge figée, jeu
`cmat_base`.

## Rework

6 étapes (EDITSTKDEPART-001 à 006) : documentation, code mort, requête par table, `nomInv` en
`Private`, fabrique de `ReportLabel` commune avec Caleditcmat, séparation des cumuls. 2 anomalies
(A01, A02).
