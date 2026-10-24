# Edsdepots — Synthèse

> Source : `.src/Gestion/Depots/Edsdepots.class` · Synthèse des autres documents.

## Rôle

Impression PDF des entrées et sorties de dépôts (`Fiches_Sdepots`) sur une période, avec purge
optionnelle des mouvements.

## Points clés

- `Button2_Click` (CC 15) mêle requêtes et mise en page `Cstocks`.
- Purge inopérante : colonne `datesortie` inexistante.
- Code mort : `Level1`, `Level2` (ancienne mise en page), `date2_GotFocus` (handler inactif,
  contrôle groupé), `Kill "~/Regul.ps"`.

## Dépendances principales

- Utilise : `Cstocks`, `Visualiseur`, `Utils.Cdate_*`, `Utils.db`, `Cbase`.
- Utilisé par : `Fmenu`, `Prgm` (`Edsdep`).
- `Fiches_Sdepots` sert aussi au recalcul du stock du dépôt `01` (`Cstock`).

## Risques

- A01 : erreur si la période ne contient que des sorties ; A02 : purge jamais effectuée mais
  annoncée ; A03 : mouvements d'articles supprimés ignorés.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 253 |
| Lignes de commentaire | 33 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 15 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (entrées et sorties, sorties seules, aucun mouvement, purge, dates inversées), PDF
comparé par extraction de texte, horloge fixée.

## Rework

6 étapes (001 à 006) : documentation, code mort, découpage de l'impression, séparation
traitement/GUI, saisie de période commune, réduction de portée. 3 anomalies (A01 à A03).
