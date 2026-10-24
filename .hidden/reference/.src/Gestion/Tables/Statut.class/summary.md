# Statut — Synthèse

> Source : `.src/Gestion/Tables/Statut.class` · Synthèse des autres documents.

## Rôle

Écran de la table des statuts clients (`Fiches_Statut`), lue par `FClient`, `Emailing`,
`EdClient` et `Expcontact`.

## Points clés

- Copie quasi exacte de Centrales (similarité 0,94), avec `Cbase.Table("TabStatut")`.
- Affiché/masqué par `EmailingCarte.bstatut_Click` via la propriété `Visible` de l'auto-instance.
- Code mort : `$bForceKey`, `Quitte_*` vides, aide commentée.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Cbase`, `Start.LocalSettings`.
- Utilisé par : `Fmenu` (`Show`), `EmailingCarte` (`Visible`).
- `Coltype_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : `SELECT` concaténé ; A02 : suppression de la ligne sélectionnée, sans contrôle d'usage.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 136 |
| Lignes de commentaire | 27 |
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

4 replays (création, modification, suppression, ouverture depuis l'emailing).

## Rework

6 étapes (001 à 006) : documentation, code mort, UPDATE simplifié, socle commun, séparation
traitement/GUI, réduction de portée. 2 anomalies (A01, A02).
