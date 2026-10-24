# ComMail — Synthèse

> Source : `.src/Gestion/Tables/ComMail.class` · Synthèse des autres documents.

## Rôle

Écran des textes prédéfinis pour les courriels (`Fiches_ComMail`), en mode gestion (menu) ou en
mode choix (`FClient`, `ObjFacB`), le texte choisi étant transmis par `Variables.sTexte`.

## Points clés

- Copie de Comment (similarité 0,89) avec un argument de constructeur `Org` et un mode « Choisir »
  déduit du libellé du bouton.
- Nom de table en dur (aucune clé `Cbase`).
- Code mort : `Button3_Click` (handler inactif), variable `Public stexte`, branche `Case 2` de
  `Lib_KeyPress`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.ReplaceLb`, `Utils.SetEditColor`, `Variables.sTexte`, `Doc`.
- Utilisé par : `Fmenu` (`Menu326_Click`), `FClient`, `ObjFacB` (`New Commail(…)`).
- `colcol_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : suppression de la ligne sélectionnée, sans test ; A02 : erreur après UPDATE sans
  sélection ; A03 : page d'aide de Comment, `ReplaceLb` asymétrique.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 130 |
| Lignes de commentaire | 28 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 7 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, modification, suppression, choix depuis la fiche client, touche sur le bouton
Choisir).

## Rework

6 étapes (001 à 006) : documentation, code mort, mode explicite et UPDATE simplifié, module
partagé avec Comment, séparation traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
