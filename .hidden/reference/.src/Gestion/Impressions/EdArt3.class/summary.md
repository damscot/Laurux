# EdArt3 — Synthèse

> Source : `.src/Gestion/Impressions/EdArt3.class` · Synthèse des autres documents.

## Rôle

Écran modal d'impression du **tarif par type client** (Gestion > Impression des tables > Tarif >
Type client, `Fmenu.Menu297_Click`). Copie d'`EdArt1` (91 % de lignes communes) avec saisie d'un
type client (`Cdt`, liste `Coltype`) et coefficient par famille lu dans `Fiches_CoeffTypec`.

## Points clés

- Lecture seule : `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Typec`, `Fiches_CoeffTypec`.
- `Button2_Click` (CC 30) : une requête `Fiches_CoeffTypec` par article ; PDF `~/tmp/Tarif1.pdf`
  (même nom qu'`EdArt1`), mode photo actif.
- Le PV HT recalculé avec le coefficient du type est écrasé par `art_pvht` : seul le coefficient
  change à l'impression.

## Dépendances principales

- Appelé par `Fmenu.class:2304` (`EdArt3.ShowModal`).
- `Carticles`, `TriArticles` (`Bsel`/`Bval`), `Utils`, `Cbase` (`TabArt`, `TabTypec`, `TabCtcli`),
  `Visualiseur`.

## Risques

- **EDART3-A01** : tarif par type client imprimé avec le prix de vente de base (impact métier).
- Pages suivantes titrées « tarif interne » ; type client non contrôlé sans Entrée.
- Défauts hérités d'`EdArt1` (contrôle du 2ᵉ article, `Bsel`, impression sur toute touche).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 583 |
| Lignes de commentaire | 68 |
| Fonctions | 27 |
| Fonctions Public | 27 |
| Complexité cyclomatique totale | 135 |
| Complexité max (fonction) | 30 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 `replay` (EDART3-T01 à T08) : tarif avec et sans coefficients, saut de page, photo, tris et
prix consommateur, contrôles du type client, liste des types, type non validé, scénarios communs
avec `EdArt1`. Jeu `editions_articles` (EdArt1/test.md) avec coefficients partiels.

## Rework

8 étapes (EDART3-001 à 008) : documentation, code mort, socle `EdSelection`, coefficients chargés
une fois (SQL modifié, PDF identique), séparation SQL/GUI, `ImprimeTarif` commun avec `EdArt1`,
`CoefTypeClient` partagé avec `TarArt`/`Edart4`, réduction de portée de 4 membres.
6 anomalies (EDART3-A01 à A06).
