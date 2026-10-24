# RazArt — Synthèse

> Source : `.src/Utils/RazArt.class` · Synthèse des autres documents.

## Rôle

Réinitialisation en masse de zones des articles : drapeaux de stock, quantités de commande/départ,
PMP, codes-barres (`Fiches_Art`, `Fiches_CdBarre`).

## Points clés

- Traitements irréversibles sur toute la table, sans transaction.
- Libellés et code divergent (`art_stocke` au lieu du stock réel, `art_prvt` au lieu du Paht,
  « contient » au lieu de « commence par »).
- `Chk2` duplique `Papmp.run`.

## Dépendances principales

- `Fmenu.Menu279_Click` (non vu par deps.py) ; `Utils.db`, `Cbase.Table`.

## Risques

- Effacement de données plus large qu'annoncé (codes-barres) ; SQL concaténé ; échec sous SQLite.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 67 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 13 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 replays (RAZART-T01 à T07) avec diff de `Fiches_Art` et `Fiches_CdBarre`.

## Rework

5 étapes (documentation, code mort, séparation traitement/GUI, mise en commun avec `Papmp`,
`Cbase.Table` et `LIKE` paramétré) et 5 anomalies (A01 à A05).
