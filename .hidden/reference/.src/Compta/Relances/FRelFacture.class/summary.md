# FRelFacture — Synthèse

> Source : `.src/Compta/Relances/FRelFacture.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Édition des relevés de factures (écritures non lettrées des journaux de ventes ou d'achats) sur
une période, avec solde en toutes lettres. Jumeau de `FRelCompte`.

## Points clés

- Table de travail `Fiches_RelFacture` (clé `(compte, numdoc, numero)`).
- Deux requêtes supplémentaires par écriture (journal, fiche tiers).
- Solde en lettres par `Numtostring.Convertir` ; la fonction locale `Solde` est morte.
- Date de ligne calculée par `CStr` : résultat faux (A01).

## Dépendances principales

- Utilise : `Utils.db`, `Creleve`, `Visualiseur`, `Numtostring`, `Doc`.
- Tables : `Fiches_Mvt`, `Fiches_Journaux`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Societes`,
  `Fiches_Parametres`, `Fiches_RelFacture`.
- Utilisé par : `Fmenu.Menu52_Click`.

## Risques

- Dates de ligne erronées dans le PDF (FRELFACTURE-A01, à confirmer sur données réelles).
- Écritures perdues ou erreur sur doublon de clé (A02).
- Défauts hérités de `FRelCompte` (contrôle de période, `Available` manquants).
- Modules homonymes `Numtostring`/`numtostring` : un seul est compilé (impact sur la caisse).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 425 |
| Lignes de commentaire | 23 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 89 |
| Complexité max (fonction) | 24 (`Releves`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` et 1 `gbtest` (FRELFACTURE-T01 à T06) : listes, éditions, solde négatif, période,
caractérisation de la conversion de date.

## Rework

6 étapes : documentation, code mort (`Solde`, `Compdate`…), réduction de portée, base commune avec
`FRelCompte`, suppression des requêtes par écriture, `Cbase.Table`. 3 anomalies (A01 à A03).
