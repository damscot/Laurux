# EdImpayes — Synthèse

> Source : `.src/Compta/Impressions/EdImpayes.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Impression des impayés » : liste, par compte client, des écritures validées non lettrées
de l'exercice en cours entre deux dates. **Aucun code ne l'ouvre** : c'est l'ancêtre
d'`EdNlettrees` (même en-tête, même PDF `~/tmp/Enlettrees.pdf`, même aide).

## Points clés

- Couple `.class` + `.form` mort à l'échelle du projet.
- Filtre de période appliqué en Gambas, une seule table `Fiches_Mvt`, table de travail `Ctrln`
  recréée sans usage (nom partagé avec d'autres éditions, EDITCOMPTE-A06).
- Handlers sans contrôle (`E0_Click`, `Bclient_Click`, `Cbl_GotFocus`).

## Dépendances principales

- Aucun appelant.
- Utilise `Utils.db`, `Utils.Cdate_*`, `TriCpt`, `Ccompta`, `Visualiseur`, `Doc`.
- Tables : `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Parametres`, `Fiches_Societes`, `Ctrln` (DDL).

## Risques

- Aucun risque d'exécution (inatteignable) ; risque de confusion à la maintenance.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 314 |
| Lignes de commentaire | 65 |
| Fonctions | 15 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 49 |
| Complexité max (fonction) | 15 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

2 tests : vérification de l'absence de référence et compilation après suppression (EDIMPAYES-T01),
caractérisation par ouverture directe seulement si la suppression est refusée (EDIMPAYES-T02).

## Rework

3 étapes conditionnelles (EDIMPAYES-001 à 003, si l'écran est conservé). 2 anomalies : suppression
du couple `.class` + `.form` (EDIMPAYES-A01, proposition principale) et défauts fonctionnels en cas
de réactivation (A02).
