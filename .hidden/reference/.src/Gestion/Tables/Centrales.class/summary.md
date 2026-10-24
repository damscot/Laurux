# Centrales — Synthèse

> Source : `.src/Gestion/Tables/Centrales.class` · Synthèse des autres documents.

## Rôle

Écran de la table des centrales d'achat (`Fiches_Centrales`, code/libellé), utilisées par les
fiches articles et fournisseurs.

## Points clés

- Squelette « table code/libellé à observateurs » copié à l'identique dans Identite, Statut et
  Typec (~130 lignes communes par fichier).
- Seul des quatre à utiliser `Cbase.Table` partout.
- `Button3_KeyPress` : toute touche sur le bouton Enregistrer enregistre.
- Code mort : `$bForceKey`, `Quitte_Cdtype`/`Quitte_Libeltype` vides, `Button1_Click` (aide commentée).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Cbase`, `Start.LocalSettings`.
- Utilisé par : `Fmenu` (`Show`) ; table lue par `Articles`, `FFournisseur`, `TriArticles`…
- `Coltype_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : `SELECT` concaténé (apostrophe → erreur SQL).
- A02 : suppression de la ligne sélectionnée et non du code saisi ; erreur sans sélection.
- A03 : suppression sans contrôle d'usage.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
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

5 replays (création, modification, suppression, apostrophe, touche sur bouton) avec diff de
`Fiches_Centrales` ; scénarios réutilisables pour Identite, Statut et Typec.

## Rework

6 étapes (001 à 006) : documentation, code mort, UPDATE simplifié, séparation traitement/GUI,
socle commun « table code/libellé », réduction de portée. 3 anomalies (A01 à A03).
