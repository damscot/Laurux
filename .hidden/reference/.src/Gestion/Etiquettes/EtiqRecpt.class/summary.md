# EtiqRecpt — Synthèse

> Source : `.src/Gestion/Etiquettes/EtiqRecpt.class` · Synthèse des autres documents.

## Rôle

Impression des étiquettes « préparées » : files `Fiches_EtiProd` (produit, casier) et `Fiches_EtiGond` (gondole) alimentées par les réceptions et mises à jour de tarifs, puis effacement de la file.

## Points clés

- Reprend les dessins d'Etiqart, Etigond et Etiqcasier (le code le reconnaît) ; `pos_Etiq` V2 identique à Etigond.
- `Button2_Click` CC 36 ; effacement ligne par ligne.
- Produit et casier partagent la même file.

## Dépendances principales

- Appelants (`Show`) : Fmenu, GesTar, Impart, MajTarifM, MajTarifP ; écrivains des files : GesTar, MajTarifM/P, MajFbtarif2, Impart.
- Tables `Fiches_EtiProd`, `Fiches_EtiGond`, `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Etiquettes`.

## Risques

- Saut de positions avant création du PDF (A01) ; lignes orphelines (ARTICLES-A05) → erreur (A02) ; Zebra non géré, page ignorée (A03) ; effacement de la file commune produit/casier (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 322 |
| Lignes de commentaire | 31 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 68 |
| Complexité max (fonction) | 36 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests `replay` (diff des files et du PDF).

## Rework

7 reworks (documentation, code mort, DELETE unique « SQL modifié, dump identique », découpage, portée, `PlancheEtiquettes`, séparation/`Cbase`). 4 anomalies.
