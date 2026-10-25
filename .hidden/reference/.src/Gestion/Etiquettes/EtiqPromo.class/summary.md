# EtiqPromo — Synthèse

> Source : `.src/Gestion/Etiquettes/EtiqPromo.class` · Synthèse des autres documents.

## Rôle

Impression des étiquettes de gondole d'une promotion (`Fiches_Promo`/`Fiches_ArtPromo`) au prix promotionnel ou normal, en PDF A4 (3 exemplaires par article) ou Dymo.

## Points clés

- `Init` et `Connect` morts ; branche Zebra morte qui passerait le TextBox `Code` comme code article.
- Jointure `ArtPromo` sans filtre sur la promotion.
- `pos_Etiq` V5 (seuil `>` : une rangée de trop).

## Dépendances principales

- Appelant : `Fmenu.Menu225_Click` (modal).
- Tables `Fiches_Promo`, `Fiches_ArtPromo`, `Fiches_Art`, `Fiches_Etiquettes` (lecture seule).

## Risques

- Zebra → « Null object » (A01) ; prix d'une autre promotion (A02) ; rangée hors page, espacement (A03) ; orphelin (A04) ; argument Zebra erroné (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 306 |
| Lignes de commentaire | 13 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 69 |
| Complexité max (fonction) | 20 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests `replay` (PDF normalisé).

## Rework

5 reworks (documentation, code mort, séparation, portée, `PlancheEtiquettes`). 5 anomalies.
