# ImpDepots — Synthèse

> Source : `.src/Gestion/Depots/ImpDepots.class` · Synthèse des autres documents.

## Rôle

Impression PDF du stock d'un dépôt (`Fiches_StkDepots`), chiffrée ou non.

## Points clés

- Une requête par article (N+1) ; PDF créé avant de savoir s'il y a des lignes.
- Liste des dépôts hors `01`, code dépôt non vérifié.
- Pas d'appel à `Utils.Observers` : écran non instrumenté pour le log/replay.
- `aff_Depot`/`Cman`/`Coldep_Click` dupliqués dans MvtDepots et Sdepots.

## Dépendances principales

- Utilise : `Cstocks`, `Visualiseur`, `Utils.Find_nbdec`, `Utils.db`, `Cbase`.
- Utilisé par : `Fmenu`, `Prgm` (`Impdep`).
- `Coldep_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : `Draw.End` sans `Draw.Begin` pour un dépôt vide ; A02 : absence d'instrumentation.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 2 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 30 |
| Complexité max (fonction) | 11 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (impression chiffrée, non chiffrée, dépôt vide, saut de page), PDF comparé par
extraction de texte.

## Rework

6 étapes (001 à 006) : documentation, code mort, requête jointe, séparation traitement/GUI,
module `Depot`, réduction de portée. 2 anomalies (A01, A02).
