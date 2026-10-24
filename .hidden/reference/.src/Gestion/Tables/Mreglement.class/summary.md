# Mreglement — Synthèse

> Source : `.src/Gestion/Tables/Mreglement.class` · Synthèse des autres documents.

## Rôle

Écran de la table des modes de règlement (`Fiches_Reglements` : journal, compte interne, LCR,
liaison avec un mode de règlement de caisse) et référentiel des modes de caisse (énumérations,
`RegCais`, `CodeCais`, conversions) utilisé par le moulinage.

## Points clés

- Saisie par la barre `Barselection` (création, modification, suppression) avec transaction
  ouverte jusqu'à la validation ; écriture par `Result` éditable (`Create9`, `Edit`, `Delete`).
- Référentiel en membres d'instance : `Moulinage` crée l'auto-instance cachée du formulaire.
- Code mort : `CodeCaisse2RegMode` (jamais appelée), `bar1_recherche` (bouton non affiché).
- `Bsel`/`Bval` écrits par `TriCpt` via `Object.SetProperty`.

## Dépendances principales

- Utilise : `Utils.db`, `Barselection`, `Chainage`, `TriCpt`, `Start.LocalSettings`.
- Utilisé par : `Fmenu`, `Moulinage`, `SaiReg`, `EcrAuto`, `LauruxMaj` (énumérations).
- `GridView1_Click`, `recherche_Click` rejoués par `ReplayObserver` : restent `Public`.

## Risques

- A01 : transaction laissée ouverte si la fenêtre est fermée pendant une saisie.
- A02 : modification sans sélection ; A03 : suppression sans contrôle d'usage ; A04 : absence de
  tests `Available`/bornes.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 318 |
| Lignes de commentaire | 6 |
| Fonctions | 24 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 77 |
| Complexité max (fonction) | 11 (`bar1_valide`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 `gbtest` sur le référentiel et 6 replays (création, modification, contrôles, liaison caisse,
suppression, modification sans sélection).

## Rework

6 étapes (001 à 006) : documentation, référentiel statique, code mort, séparation des contrôles,
`Cbase.Table`, cycle de barre commun. 4 anomalies (A01 à A04).
