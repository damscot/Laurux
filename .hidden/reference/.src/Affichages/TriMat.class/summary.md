# TriMat — Synthèse

> Source : `.src/Affichages/TriMat.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de **sélection d'un matériel** (`Fiches_Materiels`) avec filtres par code,
désignation, propriétaire/série/marque/type et état vendu/en stock. Appelant unique : `EdMat`.

## Points clés

- `_new(Barticle, B2article, $Tri, Org)` : les deux premiers paramètres sont ignorés ; le tri
  initial devient `mat_design`.
- Retour en dur sur l'auto-instance `EdMat.Bsel`/`EdMat.CodeMat` (correct, `EdMat` étant ouvert
  par son auto-instance), **sans remise à zéro**.
- Pagination manuelle sur `Utils.rs2` avec navigation clavier inversée.
- Huit textes SQL quasi identiques (`Deb1`/`Deb2`), valeurs concaténées.

## Dépendances principales

- Utilise : `Utils` (`Base2`, `rs2`, `Observers`, `Obstch`…), `Cbase.Table("TabMat")`, `EdMat`.
- Utilisé par : `EdMat.SelectionMat`.

## Risques

- Touches de pagination inversées (A01) ; annulation qui réapplique l'ancien choix (A02) ; page
  conservée après changement de filtre (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 329 |
| Lignes de commentaire | 5 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 117 |
| Complexité max (fonction) | 11 (`ColMat_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests prévus (TRIMAT-T01 à T06) : 5 `replay` depuis `EdMat` (sélection, filtres et tri,
vendus/en stock, pagination, annulation) et 1 `gbtest` sur la requête extraite.

## Rework

6 étapes sans changement de comportement (TRIMAT-001 à 006) : documentation, requête unique,
simplification de l'affichage et des filtres, requête pure, réduction de portée de 6 membres,
pagination partagée (sens actuel conservé). 3 anomalies (TRIMAT-A01 à A03).
