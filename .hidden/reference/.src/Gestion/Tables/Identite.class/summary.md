# Identite — Synthèse

> Source : `.src/Gestion/Tables/Identite.class` · Synthèse des autres documents.

## Rôle

Écran de la table des formes juridiques et civilités (`Fiches_Identite`), dont les libellés
alimentent les listes de civilité (`Fsoc`, `Utils`).

## Points clés

- Variante du squelette « table code/libellé à observateurs » de Centrales (Statut, Typec).
- Nom de table en dur (`Fiches_Identite`) alors que la clé `TabIdentite` existe.
- Suppression par le code saisi (corrigée par rapport à Centrales/Typec) ; `Quitte_Cdtype` relit
  le libellé.
- L'aide ouvre la page `Familles`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Start.LocalSettings`.
- Utilisé par : `Fmenu` (`ShowModal`) ; table lue par `Fsoc` et `Utils`.
- `Coltype_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : deux `SELECT` concaténés (apostrophe → erreur SQL).
- A02 : page d'aide erronée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 156 |
| Lignes de commentaire | 28 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 48 |
| Complexité max (fonction) | 6 (`OBS_GotFocus`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, modification, relecture du code, suppression, apostrophe) avec diff de
`Fiches_Identite`.

## Rework

7 étapes (001 à 007) : documentation, code mort, `Cbase.Table`, UPDATE simplifié, socle commun,
séparation traitement/GUI, réduction de portée. 2 anomalies (A01, A02).
