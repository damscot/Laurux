# Edmo — Synthèse

> Source : `.src/Gestion/Impressions/Edmo.class` · Synthèse des autres documents.

## Rôle

Écran d'impression de la **liste des mains d'oeuvre** (`Fmenu.Menu59_Click`) : plages main
d'oeuvre et famille, tri par code ou famille ; PDF `~/tmp/MO.pdf` (`Carticles.Level1MO/2MO`).

## Points clés

- HT = `mo_valeurht`, ou `mo_txht × mo_montant` si `mo_tempmont = 1` ; TTC recalculé par
  `Valeur2TTC_Calcul` (une requête `Fiches_Tvaav` par ligne).
- Structure de saisie copiée des éditions d'articles (4 listes `ColumnView`).

## Dépendances principales

- `Fmenu.class:823` ; `Carticles` ; `Utils`, `Cbase("TabTvav")` ; tables `Fiches_Mo`, `Fiches_Fam`
  en dur.

## Risques

- Valeur invalide : arrêt sans PDF, curseur bloqué.
- `Draw.End` sans `Draw.Begin` quand la sélection est vide.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 370 |
| Lignes de commentaire | 64 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 83 |
| Complexité max (fonction) | 11 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 `replay` (EDMO-T01 à T06) et 1 `gbtest` (T07) sur le calcul TTC après extraction ; jeu
`editions_articles`.

## Rework

6 étapes (EDMO-001 à 006) : documentation, code mort, calcul TTC pur, cache des taux, socle de
listes, réduction de portée. 3 anomalies (EDMO-A01 à A03).
