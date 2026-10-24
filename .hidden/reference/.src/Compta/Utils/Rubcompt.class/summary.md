# Rubcompt — Synthèse

> Source : `.src/Compta/Utils/Rubcompt.class` · Synthèse des autres documents.

## Rôle

Écran de saisie des **plages de comptes** (`Fiches_RubCompt` : `numrub`, `compte1`, `compte2`,
`amortissement`) qui alimentent les rubriques du bilan, du compte de résultat et des SIG. Ouvert
par Comptabilité > Compte de résultat > Gestion des comptes (`Fmenu.Menu123_Click`).

## Points clés

- Formulaire GUI, SQL écrit directement dans les handlers ; noms de tables en dur (pas de clé
  `Cbase` pour `Fiches_RubCompt` ni `Fiches_Rubriques`).
- Fin de plage proposée automatiquement (`601` → `60199999`).
- Liste des rubriques de type `L` (F2) ; contrôle d'existence de la rubrique.
- `Form_Open` fait une requête par plage pour lire l'intitulé (N+1).
- Squelette quasi identique à `Rubresult`.
- `Button3_Click` est un handler nominal inactif (groupe `Btn`) : code mort confirmé.

## Dépendances principales

- Appelé par : `Fmenu` (menu 123) uniquement.
- Utilise : `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Doc.Open`, `Start.Son`.
- Données partagées avec `Rubresult`, `Exprub`, `Imp_Bilan`, `Imp_Sig`, `RubImp` : toute plage
  saisie ici change les éditions comptables.

## Risques

- Case « Amortissement » lue sur le curseur interne de la grille (`Item` au lieu de `Current`) :
  risque d'écraser le drapeau d'une plage (RUBCOMPT-A01, à confirmer).
- Suppression qui mélange ligne sélectionnée et champ saisi (A02) ; enregistrement sur toute
  touche du bouton (A05).
- Représentation du drapeau sous SQLite (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 270 |
| Lignes de commentaire | 42 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 14 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (RUBCOMPT-T01 à T08) : 7 replays (liste, ajout, modification, suppression, rubrique
inconnue et liste F2, état de la case au clic, saisie incomplète) comparant le dump de
`Fiches_RubCompt`, et 1 gbtest sur la fin de plage après extraction.

## Rework

6 étapes (RUBCOMPT-001 à 006) : documentation, code mort (`Button3_Click`), réduction de portée,
séparation traitement/GUI, suppression du N+1 de `Form_Open`, helper et clés `Cbase` communs avec
`Rubresult`. 5 anomalies (A01 à A05) soumises à validation.
