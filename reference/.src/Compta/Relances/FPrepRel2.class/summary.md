# FPrepRel2 — Synthèse

> Source : `.src/Compta/Relances/FPrepRel2.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Ancien écran de préparation des relances, remplacé par `FEditrel`. **Aucun appelant** : le couple
`.class`/`.form` est du code mort.

## Points clés

- Générait `Fiches_relances` avec une clé `(compte, numdoc, lind)` différente de celle de `FEditrel`.
- SQL par concaténation et requêtes répétées dans les suppressions ; colonne d'index 8 hors des
  8 colonnes déclarées.

## Dépendances principales

- Utilise : `Utils.db`, `Cbase`, `Doc`, `Start` ; tables `Fiches_relances`, `Fiches_Mvt`,
  `Fiches_Cli`, `Fiches_Parametres`.
- Utilisé par : personne (vérifié par grep).

## Risques

- Aucun en exploitation (inaccessible). Risque de confusion pour la maintenance et de
  modification de la table de travail s'il était rebranché.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 346 |
| Lignes de commentaire | 23 |
| Fonctions | 21 |
| Fonctions Public | 21 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 10 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test (FPREPREL2-T01) de non-régression après suppression (compilation + replays `FEditrel`).

## Rework

1 étape de documentation ; 1 anomalie (FPREPREL2-A01) : suppression du couple `.class`/`.form`.
