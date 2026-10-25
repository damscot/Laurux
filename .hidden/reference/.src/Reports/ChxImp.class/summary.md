# ChxImp — Synthèse

> Source : `.src/Reports/ChxImp.class` (+ `ChxImp.form`) · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Choix imprimante » : liste les imprimantes CUPS (`lpstat -p`) dans une liste
déroulante et écrit le choix dans `Variables.impr`.

## Points clés

- **Jamais ouverte** : aucune référence dans le code ni ouverture dans l'historique git depuis
  son ajout (`e1b2d2b8`, 2016) ; signal `jamais_reference` confirmé.
- `Variables.impr`, qu'elle écrit, n'est lue nulle part (VARIABLES-002).
- Lecture de `lpstat` fragile (filtre `Not InStr` toujours vrai, indice hors bornes possible).

## Dépendances principales

- `Variables.impr` (écriture), commande `lpstat`, `User.Home`.
- Aucun appelant.

## Risques

- Aucun en production (code inaccessible) ; risque de confusion avec l'ancienne case à cocher
  homonyme des écrans de facturation (commentaire `Facturergbl:455`).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 20 |
| Lignes de commentaire | 1 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 5 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `gbtest` conditionnel (si l'écran est conservé et sa lecture de `lpstat` extraite) ;
l'écran n'est pas rejouable.

## Rework

1 étape de documentation (CHXIMP-001). 2 anomalies : suppression du couple `.class` + `.form`
(A01, avec VARIABLES-002) ou, à défaut, correction de la lecture de `lpstat` (A02).
