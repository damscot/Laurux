# Expclient — Synthèse

> Source : `.src/Utils/Exports-Imports/Expclient.class` · Synthèse des autres documents.

## Rôle

Export des clients (`Fiches_Cli`) en CSV `;` à 10 colonnes, sans en-tête, dans `Liste_clients.csv`.

## Points clés

- Squelette identique à `Expart` (même `_New`, `Svs_Click`, fin de traitement).
- Pas de tri : ordre de sortie dépendant du SGBD.

## Dépendances principales

- Ouverte par `Fmenu.Menu170_Click` (non vu par deps.py).
- `Utils.db`, `Utils.Observers`, `Start.Son`/`Musique`.

## Risques

- Faibles : export en lecture seule ; CSV cassé si un champ contient `;`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 59 |
| Lignes de commentaire | 22 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 5 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (EXPCLIENT-T01 à T03), comparaison du CSV après tri des lignes.

## Rework

5 étapes (documentation, code mort, séparation traitement/GUI, socle commun, `Cbase.Table`) et
2 anomalies (A01, A02).
