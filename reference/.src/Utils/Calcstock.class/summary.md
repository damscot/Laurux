# Calcstock — Synthèse

> Source : `.src/Utils/Calcstock.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran (menu Gestion) de recalcul des stocks : un produit, une plage de casiers, tous les produits,
ou remise à zéro des produits non stockés. Vérifie d'abord qu'aucune caisse n'est connectée, que
les tickets Z sont tirés et que le moulinage est fait, puis délègue à `Cstock.Calc_stock`.

## Points clés

- Les boutons radio `Cbx`..`Cbx4` sont publics et **relus par `Cstock`** : dépendance circulaire.
- `Art_man` est du code mort.
- Pré-conditions de caisse codées dans le handler (`Fiches_Caisses`, `Fiches_EntTickets1..9`,
  `Fiches_EntTicketz`).

## Dépendances principales

- Appelé par `Fmenu` (`ShowModal`) ; instancié en cachette par `Cstock` lors de l'appel depuis
  `Validinv`.
- Utilise `Cstock`, `TriArticles`, `Cbase.Table("TabArt")`.

## Risques

- Le couplage avec `Cstock` rend le recalcul après validation d'inventaire inopérant (voir
  CSTOCK-A01).
- Messages « Traitement terminé » trompeurs.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 133 |
| Lignes de commentaire | 43 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 31 |
| Complexité max (fonction) | 15 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays (CALCSTOCK-T01 à T08) sur MariaDB : chaque mode, chaque pré-condition bloquante, produit
vide. Le calcul est couvert par les 12 tests de `Cstock`.

## Rework

5 étapes (CALCSTOCK-001 à 005) : documentation, code mort, extraction des pré-conditions et de la
remise à zéro, passage d'un mode explicite à `Cstock`, réduction de portée. 2 anomalies
(CALCSTOCK-A01, A02).
