# Prodcomposes — Synthèse

> Source : `.src/Gestion/Tables/Prodcomposes.class` · Synthèse des autres documents.

## Rôle

Gestion de la **nomenclature des produits composés** (`Fiches_PrdComp`) : un article
`art_prdcomp = 1` est décrit par des composants articles ou main-d'œuvre avec leur quantité.
L'écran recalcule le coût du produit composé (PMP, prix de revient, marge) et l'**écrit dans
`Fiches_Art`**. Ouvert en modal depuis le menu Gestion.

## Points clés

- Chaque affichage d'un produit composé (`Cprdcomp`) émet un `UPdate` de `Fiches_Art`
  (`art_pmp`, `art_pbht`, `art_pauaht`, `art_prvt`, `art_coef`).
- Calculs de coût mêlés aux contrôles et au SQL (`Calc_Pmp`, `Calc_Prvt`, `Calc_Marge`), avec
  requêtes N+1 et noms de tables en dur.
- Sélection des composants par `TriArticles`, qui écrit `Bsel`/`Bval` par `Object.SetProperty`.
- Code mort : `Code_KeyPress` (handler inactif), `CalcTTC`, `CalcHt`, `Recup_Tva`, `Calc_coeff`.
- Fonction la plus complexe : `Cmpt_Keypress` (CC 20).

## Dépendances principales

- Utilise : `Utils` (`db`, `rs1`, `cpoint`, `Find_nbdec`), `Cbase.Table`, `TriArticles`,
  `Articles` (F4), `Doc.Open`.
- Tables : `Fiches_PrdComp` (gérée), `Fiches_Art` (lue et **modifiée**), `Fiches_Mo`,
  `Fiches_Ligbl` (contrôle de retrait).
- Appelée par `Fmenu` uniquement ; `Fiches_PrdComp` est aussi utilisée par `Facture`,
  `Articles`, `MvtProdcomp`, `Changefam`.

## Risques

- Coût faux écrit dans `Fiches_Art` : quantité de la zone de saisie appliquée à tous les
  composants (A01), coefficient remis à 0 et prix de revient décalé d'un calcul (A02), calcul
  interrompu en silence si un composant a été supprimé (A03).
- Tri inopérant (A04), ajout par simple Tab sur le bouton (A05), F4 incohérent (A06), prix de
  revient MO incohérent (A07), dépendance à la conversion booléenne du pilote (A08).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 534 |
| Lignes de commentaire | 64 |
| Fonctions | 34 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 130 |
| Complexité max (fonction) | 20 (`Cmpt_Keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests prévus : 7 replays (affichage, ajout article, ajout MO et modification, contrôles et
retrait, clavier/F4, composant supprimé, base SQLite) sur un jeu dérivé de `Laurux01.sql`
(produits composés et composants), et 1 `gbtest` du coût après séparation traitement/GUI.

## Rework

7 étapes sans changement de comportement (PRODCOMPOSES-001 à 007) : documentation, code mort,
`Cbase.Table`, calculs de coût et SQL extraits des handlers, découpage de `Cmpt_Keypress`,
réduction de portée de 13 fonctions. 8 anomalies (PRODCOMPOSES-A01 à A08) soumises à validation.
