# EntreeItem — Synthèse

> Source : `.src/Gestion/Lcr/EntreeItem.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Traduit un code entrée LCR (1 à 5 : escompte, escompte en valeur, encaissement forfaitaire,
encaissement après échéance, cession Dailly) en libellé affiché, identique aux listes déroulantes
de `Preparation.form` et `Glcr.form`.

## Points clés

- Une seule fonction, `item`, calcul pur ; renvoie `""` hors plage.
- Libellés dupliqués en dur dans les `.form` (intouchables).

## Dépendances principales

- Utilisé par `Preparation.Maj_Zones` uniquement ; n'utilise rien.

## Risques

- Faibles. Une valeur non numérique pourrait lever une erreur de conversion (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 6 (`item`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests `gbtest` (ENTREEITEM-T01, T02) : libellés 1 à 5, valeurs hors plage.

## Rework

2 étapes (ENTREEITEM-001, 002) : documentation, tableau constant à la place du `Select Case`.
Aucune anomalie.
