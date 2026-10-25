# RazInv — Synthèse

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de suppression de l'inventaire de fin d'exercice : après confirmation, `DROP TABLE IF EXISTS
Fiches_Inv` (table de travail créée par `Geninv`). Ouvert par `Fmenu.Menu232_Click`.

## Points clés

- 3 fonctions (constructeur + 2 handlers), aucune variable membre.
- Aucun contrôle d'état de l'inventaire (comptages en cours, validé) ; le `.form` le signale.
- Jumeau de `RazInvT` à 85 % (seule la clé `Cbase` `TabInv`/`TabInvT` et le texte diffèrent).

## Dépendances principales

- Utilise : `Utils.db.Exec`, `Cbase.Table("TabInv")`, `Utils.Observers`.
- Utilisé par : `Fmenu` (menu 232).
- Rend inopérants jusqu'à la prochaine génération : `SaisieInv`, `Validinv`, `Ecarts`,
  `Ednsaisis`, `Edinv("F")`, `EditStkDepart`.

## Risques

- `Try` + message de succès inconditionnel : un `DROP` en échec est annoncé comme réussi
  (RAZINV-A01).
- Destruction des comptages sans avertissement spécifique.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 13 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 scénarios `replay` (RAZINV-T01 à T03) : suppression confirmée, refusée, table absente ; le dump
normalisé inclut la liste des tables.

## Rework

3 étapes (RAZINV-001 à 003) : documentation, extraction du `DROP`, socle commun `Inventaire`
partagé avec `RazInvT`/`Geninv`/`GeninvT`. 1 anomalie (RAZINV-A01).
