# EdDocs — Synthèse

> Source : `.src/Gestion/Impressions/EdDocs.class` · Synthèse des autres documents.

## Rôle

Écran d'impression de la **liste des documents clients en cours** (devis, commandes, BL,
factures), filtrée par type, clients et période, avec détail facultatif des lignes et totaux
(`~/tmp/ListeDocs.pdf`, `Cdocuments`).

## Points clés

- `Button1_Click` (CC 39) : clause SQL, mise en page, totaux par client et général.
- Type mémorisé par les handlers `RadioButton*_Click` (`TypeD`).
- `Frmt`/`Coulfond` morts ; ≈ 118 lignes communes avec `EdPrep`.

## Dépendances principales

- Appelé par `Fmenu` (`Menu254`). Utilise `Cdocuments`, `Visualiseur`, `Cbase`.
- Lit `Fiches_Bl`, `Fiches_Cli`, `Fiches_Ligbl`.

## Risques

- EDDOCS-A01 : titres « devis »/« commandes » inversés.
- EDDOCS-A02 : tri « Par commentaire » en erreur SQL.
- EDDOCS-A03 : total du dernier client absent ; A04 (à confirmer) : filtre de dates fragile,
  faux sous SQLite.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 328 |
| Lignes de commentaire | 26 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 84 |
| Complexité max (fonction) | 39 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (EDDOCS-T01 à T07) : types, tri par commentaire, totaux par client, période et
clients (MySQL et SQLite), détail, factures imprimées.

## Rework

6 étapes (EDDOCS-001 à 006) : documentation, code mort, portée, découpage, séparation, liste
commune avec `EdPrep`. 4 anomalies (EDDOCS-A01 à A04).
