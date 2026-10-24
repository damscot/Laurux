# Lettrage — Synthèse

> Source : `.src/Compta/Lettrages/Lettrage.class` · Synthèse des autres documents.

## Rôle

Écran de lettrage manuel d'un compte lettrable (client, fournisseur ou bilan) : affichage des
écritures de l'exercice courant et suivant via `Listextcpt`, sélection de lignes, lettrage si le
total sélectionné est nul (lot saisi ou aléatoire), délettrage.

## Points clés

- Ouvert depuis le menu (`Fmenu.Menu51`) ou depuis l'extrait de compte (F4).
- Toutes les écritures passent par `Listextcpt.letcpt` (UPDATE `numlot`/`lettree` par `lind`
  dans `Fiches_Mvt…Mvt5`).
- `affichage` (CC 20) mélange navigation dans la liste des comptes, bornes d'exercice et
  remplissage de la grille.
- Copies locales `cpoint` et `convBool` remplaçables ; plusieurs variables mortes (`Desg`,
  `Lettrable`, `num`).

## Dépendances principales

- Utilise : `Listextcpt`, `TriCpt`, `LDate`, `Utils` (`db`, `cpoint`, `Cdate_Aff`, `Observers`,
  `SetEditColor`), `Doc`.
- Utilisé par : `Fmenu`, `Extrait` (instanciation seulement) ; `TriCpt` écrit `Bsel`/`Bval`.

## Risques

- **A01** : un lettrage refusé délettre quand même en base les lignes sélectionnées.
- Lots aléatoires sans unicité (A02), délettrage qui conserve un lot (A03).
- Erreur sur liste de comptes vide (A04) ; contrôle d'équilibre dépendant de la locale (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 447 |
| Lignes de commentaire | 35 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 104 |
| Complexité max (fonction) | 20 (`affichage`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (affichage, lettrage équilibré, lettrage refusé, délettrage, navigation, ouverture
depuis l'extrait) et 1 gbtest sur le calcul du total de sélection après extraction. Le lot
aléatoire est neutralisé par la normalisation du dump.

## Rework

8 étapes (LETTRAGE-001 à 008) : documentation, code mort, `Utils.cpoint`, requête des comptes
factorisée, `Cbase.Table`, découpage de `affichage`, séparation calcul/lettrage, réduction de
portée. 5 anomalies (A01 à A05) soumises à validation.
