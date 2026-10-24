# FJournaux — Synthèse

> Source : `.src/Compta/Tables/FJournaux.class` · Synthèse des autres documents.

## Rôle

Écran de la table des journaux comptables (`Fiches_Journaux`) : création, modification,
suppression, choix du compte de trésorerie des journaux `TR`.

## Points clés

- Codes numériques, compte obligatoire pour `TR` et interdit sinon.
- SQL par concaténation exécuté sous `Try` : échec silencieux.
- UPDATE et DELETE portent sur la ligne sélectionnée, pas sur le code saisi.
- Contrôle numérique dupliqué trois fois ; `Cleanchamps` morte.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.SetEditColor`, `Doc` ; tables `Fiches_Journaux`, `Fiches_Comptes` (en dur).
- Utilisé par : `Fmenu` (deux menus), `Parametre` (création d'un journal manquant).

## Risques

- A01 : apostrophe → enregistrement perdu sans message.
- A02 : modification appliquée à la ligne sélectionnée ; A03 : suppression d'un journal utilisé.
- A04 : enregistrement sur toute touche, avertissement trésorerie non bloquant.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 275 |
| Lignes de commentaire | 50 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 13 (`Jo_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, trésorerie, modification, apostrophe, suppression et contrôles) avec diff de
`Fiches_Journaux`.

## Rework

6 étapes (001 à 006) : documentation, code mort, contrôle numérique factorisé, `Cbase.Table`,
séparation traitement/GUI, réduction de portée. 4 anomalies (A01 à A04).
