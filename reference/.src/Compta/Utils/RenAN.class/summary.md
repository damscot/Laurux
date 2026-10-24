# RenAN — Synthèse

> Source : `.src/Compta/Utils/RenAN.class` · Synthèse des autres documents.

## Rôle

Script statique lancé par `Prgm` (`RenAN`) : renumérote à 1 les écritures « Report a nouveau » de
la table `Fiches_Mvtoc`.

## Points clés

- `Fiches_Mvtoc` n'existe plus (absente de `db_control.csv`, `Cbase`, `LauruxMaj`) : le script
  échoue toujours avec une erreur SQL.
- Aucune confirmation ni transaction.

## Dépendances principales

- Utilise : `Utils.db`.
- Utilisé par : `Prgm.class:74`.

## Risques

- Aucun effet sur les données (échec immédiat) ; message d'erreur SQL pour l'utilisateur.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 12 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test `replay` (RENAN-T01) : lancement par `Prgm`, erreur SQL figée, dump inchangé.

## Rework

1 étape de documentation (RENAN-001). 1 anomalie (A01) : retrait de la classe et de l'entrée
`Prgm`, avec PRGM-A06.
