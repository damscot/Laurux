# RazEcr — Synthèse

> Source : `.src/Compta/Utils/RazEcr.class` · Synthèse des autres documents.

## Rôle

Formulaire « Lancer / Quitter » ouvert par `Prgm` (`RazEcr`) dont l'action `Raz` est entièrement
commentée (ancienne purge des écritures de 2011). Il ne fait rien.

## Points clés

- Couple `.class` + `.form` mort fonctionnellement.
- Aucune table, aucun état global.

## Dépendances principales

- Utilisé par : `Prgm.class:78` uniquement.

## Risques

- Aucun (sans effet) ; confusion pour l'utilisateur.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 10 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 4 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `replay` (RAZECR-T01) prouvant l'absence d'effet.

## Rework

1 étape de documentation (RAZECR-001). 1 anomalie (A01) : suppression du couple et de l'entrée
`Prgm`, soumise à validation.
