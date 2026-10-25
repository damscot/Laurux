# Dymo — Synthèse

> Source : `.src/Gestion/Etiquettes/Dymo.module` · Synthèse des autres documents.

## Rôle

Module mort : `Gondole1` écrit une étiquette de gondole en ZPL sur une socket ; copie exacte de `Zebra.Gondole1`, jamais appelée.

## Points clés

- Aucun appelant : `Dymo.Value` dans les écrans d'étiquettes désigne le RadioButton `Dymo`, prioritaire sur le module.
- Une imprimante Dymo ne parle pas ZPL : le mode Dymo produit un PDF `dymog`/`dymoc` via `CEtiquettes`.

## Dépendances principales

- Utilise `Utils.Remplace`. Utilisé par : personne.

## Risques

- Aucun, hormis la confusion de nom avec le contrôle `Dymo`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 19 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 1 |
| Complexité max (fonction) | 1 (`Gondole1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `gbtest` (DYMO-T01) d'équivalence avec Zebra avant suppression.

## Rework

1 rework (DYMO-001 : suppression du module). Aucune anomalie propre.
