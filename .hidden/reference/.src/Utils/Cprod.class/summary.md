# Cprod — Synthèse

> Source : `.src/Utils/Cprod.class` · Synthèse des autres documents.

## Rôle

Réglage des couleurs des produits (stocké, non stocké, épuisé, suspendu) dans `/Coul/...`.

## Points clés

- Fenêtre GUI pure, copie de `Cprod`/`Cmo`/`Carch` (même modèle à 1-4 couleurs).
- Remplacée par `SetColors`, qui gère les mêmes clés `/Coul/...`.
- Aucun appelant.

## Dépendances principales

- `Start.LocalSettings` uniquement.

## Risques

- Aucun à la suppression, hormis la règle « `.form` intouchable » (validation utilisateur).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 86 |
| Lignes de commentaire | 25 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 6 (`Coul_Dblclick`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests : compilation après suppression (T01) et équivalence fonctionnelle via `SetColors` (T02).

## Rework

Suppression proposée du couple `.class`/`.form` (001, à valider), nettoyage minimal sinon (002) ;
1 anomalie (A01, `Val(Facture)` inatteignable).
