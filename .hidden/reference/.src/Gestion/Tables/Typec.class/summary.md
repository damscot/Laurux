# Typec — Synthèse

> Source : `.src/Gestion/Tables/Typec.class` · Synthèse des autres documents.

## Rôle

Écran de la table des types clients (`Fiches_Typec`), base des tarifs et remises par type ; la
table est lue par 21 fichiers (tarifs, facturation, statistiques, éditions).

## Points clés

- Copie du squelette de Centrales (similarité 0,92), nom de table en dur, en-tête « Typeco.class ».
- Suppression de la ligne sélectionnée (et non du code saisi), sans contrôle d'usage.
- `deps.py` attribue à tort à ce formulaire des usages du contrôle `TypeC` de `TarTypeCli`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Start.LocalSettings`.
- Utilisé par : `Fmenu` (`show`).
- `Coltype_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : `SELECT` concaténé ; A02 : suppression d'un type utilisé → remises/coefficients orphelins.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 143 |
| Lignes de commentaire | 26 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 47 |
| Complexité max (fonction) | 6 (`OBS_GotFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (création, modification, suppression d'un type utilisé, apostrophe).

## Rework

7 étapes (001 à 007) : documentation, code mort, `Cbase.Table`, UPDATE simplifié, socle commun,
séparation traitement/GUI, réduction de portée. 2 anomalies (A01, A02).
