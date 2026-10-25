# Saisiedecons — Synthèse

> Source : `.src/Gestion/option/Saisiedecons.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de **saisie des déconsignations fournisseur** (emballages rendus) sur une réception non
validée : chaque ligne (`Fiches_ligcons`, `numlig = 'D'`, montants négatifs) diminue le HT et le TTC
de la réception (`Fiches_Entrecpt`).

## Points clés

- Clé `bloc` = date & n° de réception & fournisseur (commune avec `Achat` et `ValidBR1`).
- Proposition automatique colis = palettes × `art_nbcol`, bouteilles = colis × `art_nbbou`.
- Cumul d'accise affiché (`calculdroit`), calculette `FCalc` sur F5.
- Listes flottantes (réceptions, consignes) créées par code, non journalisées.

## Dépendances principales

- Utilise : `calculdroit`, `FCalc`, `TriCpt`, `TriArticles`, `Utils.db` ; tables `Fiches_ligcons`,
  `Fiches_consigne`, `Fiches_Entrecpt`, `Fiches_Ligrecpt`, `Fiches_Four`, `Fiches_Art`.
- Utilisé par : `menuopt` (auto-instance, sans paramètre).

## Risques

- Suppression d'une ligne sans correction des totaux de la réception.
- Accise recumulée à chaque sélection ; code fournisseur cherché par `Val()`.
- Lecture du prix de consigne sans test ; division par un nombre nul.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 497 |
| Lignes de commentaire | 11 |
| Fonctions | 34 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 117 |
| Complexité max (fonction) | 9 (`saisie_keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (SAISIEDECONS-T01 à T07) : 6 replays (sélection, déconsignation, modification,
suppression, cumul d'accise, calculette) et 1 `gbtest` du montant de ligne.

## Rework

8 étapes (SAISIEDECONS-001 à 008) : documentation, séparation des calculs, fenêtre flottante
commune, relectures, prix de consigne commun, code mort, `Cbase.Table`. 5 anomalies (A01 à A05).
