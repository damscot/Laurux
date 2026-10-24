# Changefour — Synthèse

> Source : `.src/Utils/Changefour.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran (menu Gestion) de changement du fournisseur principal (`Fiches_Art.art_four`) : pour un
article, une liste d'articles (table temporaire `CFour`), tous les articles d'un fournisseur, ou à
partir d'un fichier CSV `code;fournisseur`.

## Points clés

- Seule `Fiches_Art` est modifiée ; aucun verrou, aucune transaction.
- Copie de `Changefam` (en-tête compris) : 247 lignes de code identiques, formulaire d'import CSV
  dynamique dupliqué.
- Le fournisseur saisi au clavier n'est jamais contrôlé (contrôles commentés).
- Traitements mixtes (lecture directe des contrôles).

## Dépendances principales

- Appelé par `Fmenu` (`Changefour.ShowModal()`).
- Utilise `TriArticles`, `TriCpt` (retour par `Object.SetProperty` sur `Bsel`/`Bval`),
  `Cbase.Table("TabFour")`, `Utils.Find_cbarre`.

## Risques

- Doublon dans la liste → erreur SQL (colonne `code` inexistante dans `CFour`).
- Messages inversés dans `Change2`, reprise d'une ancienne sélection après annulation de `TriCpt`.
- Code fournisseur inexistant accepté.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 411 |
| Lignes de commentaire | 52 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 90 |
| Complexité max (fonction) | 12 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 replays prévus (CHANGEFOUR-T01 à T08) sur MariaDB, dump de `Fiches_Art` et diff du log :
article, champs vides, fournisseur global, liste, doublon, import fichier, annulation de sélection,
code-barres.

## Rework

8 étapes (CHANGEFOUR-001 à 008) : documentation, code mort, simplification de `Change`,
factorisation des sélections, commonalisation avec `Changefam`, séparation traitement/GUI,
`Cbase.Table`, réduction de portée. 5 anomalies (CHANGEFOUR-A01 à A05).
