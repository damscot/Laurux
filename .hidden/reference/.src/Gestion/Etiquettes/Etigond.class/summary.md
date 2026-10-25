# Etigond — Synthèse

> Source : `.src/Gestion/Etiquettes/Etigond.class` · Synthèse des autres documents.

## Rôle

Impression des étiquettes de gondole (code, intitulé, références fournisseur, EAN13, TVA, prix au kg/l, PV HT/TTC) en PDF A4 ou Dymo, par plage ou par liste.

## Points clés

- Variante d'Etiqart (85 % commun) ; table de travail temporaire ; `pos_Etiq` V2 identique à EtiqRecpt.
- `Imprime` (CC 51, maximum du lot) choisit la mise en page d'après le **libellé** du modèle (« Gondole » / « Article »).
- `Init` saute les positions avant la création du PDF ; membre `Nb` jamais remis à faux.

## Dépendances principales

- Appelants : `Fmenu.Menu158/162_Click`, `Articles.Btn_click`.
- Tables `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Tvaav`, `Fiches_Etiquettes`, `Etiquettes` (temporaire).

## Risques

- Zebra → « Null object » (A01) ; Dymo avec `Posetiq` ≥ 2 → « Null object » (A02) ; modèle sans mot-clé → PDF vide (A03) ; 1re étiquette en (0,0) après une impression avec saut (A04) ; lectures sans `Available` (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 915 |
| Lignes de commentaire | 80 |
| Fonctions | 39 |
| Fonctions Public | 39 |
| Complexité cyclomatique totale | 235 |
| Complexité max (fonction) | 51 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 tests (12 `replay`, 1 `gbtest` sur la variante V2).

## Rework

10 reworks (documentation, code mort, `EtiqArticles` ×3, découpage d'`Imprime`, séparation, portée de 12 membres, `PlancheEtiquettes`, `Cbase`/observateurs). 5 anomalies.
