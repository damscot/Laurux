# EdStk — Synthèse

> Source : `.src/Gestion/Impressions/EdStk.class` · Synthèse des autres documents.

## Rôle

Écran d'impression du **stock chiffré ou non** (`Fmenu.Menu102_Click`). Articles stockés filtrés
par plages article/famille/fournisseur, 4 tris, choix du code imprimé ; PDF `~/tmp/rStock.pdf`
(`Carticles`) avec totaux au prix d'achat et au PMP.

## Points clés

- Imprime `art_qte` tel quel (stock théorique) : aucune source de mouvement relue, pas de stock par
  dépôt ; dépend des calculs `Lockstock`/`Cstock`/`Validinv` (tableau de Stockmvt).
- Copie partielle d'`EdArt1` (64 %) ; `Button2_Click` CC 27 avec `Catch` global.
- 12 membres de classe ne servent que de variables locales à l'impression.

## Dépendances principales

- Appelé par `Fmenu.class:1129`. `Carticles` (`Level1..5`), `TriArticles`, `Utils` (`CDec`,
  `cpoint`, `ObsGotf`), `Visualiseur`. Tables `Fiches_Art`, `Fiches_Fam`, `Fiches_Four` en dur.

## Risques

- Total arrondi à chaque ligne (écart possible avec la somme des lignes).
- Pas de pied de page ; `Print` de débogage sur stdout.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 435 |
| Lignes de commentaire | 65 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 101 |
| Complexité max (fonction) | 27 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 `replay` (EDSTK-T01 à T07 : chiffré, non chiffré, codes, tris, pagination, décimales, vide et
listes) et 1 `gbtest` (T08) après extraction de la valorisation ; jeu `editions_articles`.

## Rework

6 étapes (EDSTK-001 à 006) : documentation, code mort, variables locales, séparation de la
valorisation, socle `EdSelection`, réduction de portée. 4 anomalies (EDSTK-A01 à A04).
