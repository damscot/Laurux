# FRelance — Synthèse

> Source : `.src/Compta/Relances/FRelance.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de saisie des textes de relance : pour chaque niveau (1, 2, 3…), un texte d'introduction
(`libell1`) et un texte de conclusion (`libell2`), stockés dans `Fiches_Txt_Relances` et imprimés
par `FEditrel` / `Ligcli` dans les lettres de relance.

## Points clés

- Écran GUI simple, SQL direct dans les handlers, table en dur (pas de clé `Cbase`).
- Création ou mise à jour selon l'existence du niveau (`SELECT` puis `INSERT`/`UPdate`).
- Lancé par `Fmenu.Menu27_Click`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.Observers`, `Doc.Open`, `Start.Son`/`Musique`.
- Données lues par `FEditrel.Impressionr`, `Ligcli._new` et `Ligcli.Buttonedit_Click`.

## Risques

- Suppression : zones vidées même si l'utilisateur refuse (FRELANCE-A01).
- `Catch` vide à l'ouverture ; aucun contrôle de saisie numérique du niveau.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 74 |
| Lignes de commentaire | 22 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 4 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 tests `replay` (FRELANCE-T01 à T05) : navigation, modification, création, suppression,
saisie invalide ; comparaison du dump de `Fiches_Txt_Relances`.

## Rework

3 étapes (documentation, constante de table, séparation traitement/GUI) ; 3 anomalies soumises
à validation (FRELANCE-A01 à A03).
