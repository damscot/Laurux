# Edbl — Synthèse

> Source : `.src/Gestion/Impressions/Edbl.class` · Synthèse des autres documents.

## Rôle

Écran de **réimpression d'un bon de réception fournisseur**, choisi par numéro ou dans une liste
triable des réceptions ; l'impression est déléguée à `Edbr.Ed`.

## Points clés

- Fournisseur et date du BR mémorisés en membres entre deux impressions.
- Cinq handlers de tri (`*_GotFocus`) identiques ; recherche par numéro dupliquée.
- Aucune écriture propre ; les effets de bord (copie, GED) viennent d'`Edbr`.

## Dépendances principales

- Appelé par `Fmenu` (`Menu90`). Utilise `Edbr.Ed`, `Utils`.
- Lit `Fiches_Ligrecpt`, `Fiches_Entrecpt`, `Fiches_Four`.

## Risques

- EDBL-A01 : un nouveau numéro est imprimé avec le fournisseur mémorisé.
- EDBL-A02 : numéro de BR partagé entre fournisseurs ; A03 : en-tête `Mt` non masqué ; A04 (à
  confirmer) : date transmise sous deux formes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 212 |
| Lignes de commentaire | 39 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 39 |
| Complexité max (fonction) | 6 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (EDBL-T01 à T07) : saisie, inexistant, liste, réimpression (A01), tris, clavier
(A03), numéro partagé (A02) ; ils couvrent aussi `Edbr`.

## Rework

5 étapes (EDBL-001 à 005) : documentation, code mort, portée, helpers de tri et d'impression,
séparation. 4 anomalies (EDBL-A01 à A04).
