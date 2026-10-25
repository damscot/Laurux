# Edart4 — Synthèse

> Source : `.src/Gestion/Impressions/Edart4.class` · Synthèse des autres documents.

## Rôle

Écran actuel d'impression du **tarif client** (Tarif > Client, `Fmenu.class:863` `EdArt4.Show`),
qui remplace `EdArt2`. Rapport gb.report (`~/tmp/tarif.pdf`) par famille et sous-famille, prix
calculés par `TarArt` pour un client ou un type client.

## Points clés

- Seule édition du lot construite avec gb.report (`Report` + `Printer`) au lieu de `PdfWriter`.
- Familles choisies dans un `TreeView` alimenté par `Trifam` ; options photo, négociés, saut de
  page, logo ; colonnes droits/S.S en option boisson.
- Tables en dur : `Fiches_Cli`, `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Typec`, `Fiches_Societes`.
- Procédure privée `TriArticles` homonyme de la classe `TriArticles`.

## Dépendances principales

- `TarArt` (une fenêtre cachée par article), `Trifam`, `TriCpt`, `TriArticles`, `Calculdroit`
  (via `TarArt.cdr`), `Utils` (`Option`, `totobs`, `ObsGotf`), `Visualiseur`.

## Risques

- Saisie clavier probablement bloquée dans 5 champs (`Stop Event` inconditionnel).
- Ordre des articles non garanti (pas d'`ORDER BY`) ; société lue sans filtre `cd_sc`.
- `Image.Load` sans `Try` ; accumulation de fenêtres `TarArt`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 392 |
| Lignes de commentaire | 6 |
| Fonctions | 20 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 66 |
| Complexité max (fonction) | 19 (`Butimp_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 `replay` (EDART4-T01 à T08) : client, type, liste des types, options, boisson, sélection,
saisie clavier, client puis type ; à lire avec TARART-T12. Jeu `editions_articles`.

## Rework

8 étapes (EDART4-001 à 008) : documentation, code mort, renommage de l'homonyme `TriArticles`,
helper de cellule, séparation SQL/calcul, lecture société et liste des types communes,
observateurs conservés. 6 anomalies (EDART4-A01 à A06).
