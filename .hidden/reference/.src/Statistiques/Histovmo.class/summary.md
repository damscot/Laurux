# Histovmo — Synthèse

> Source : `.src/Statistiques/Histovmo.class` · Synthèse des autres documents.

## Rôle

Édition PDF de l'historique des ventes de main-d'oeuvre sur une période (menu `Fmenu`) : pour chaque
MO des plages code/famille/fournisseur, quantité et total HT vendus d'après les factures historisées
et les documents en cours (BL et factures), normaux, matériel ou les deux.

## Points clés

- Lecture seule ; PDF `~/tmp/HistoArt.pdf` via `Chistoriques`.
- `Button2_Click` (CC 39) : requêtes unitaires par MO, par ligne et par document, filtre de date
  côté Gambas ; tables en dur (`Tab` à `Tab9`).
- Six listes de choix recopiées (`ToggleButton1..6`, `Col*_KeyPress`, `Col*_Click`), identiques à
  celles des éditions d'articles (`EdArt1`, `Edmo`…).
- Code mort : `Level1`/`Level2` (ancienne API `Draw`, les appels visent `Chistoriques`), `Case 1` de
  `Btn_Click`.

## Dépendances principales

- Appelé par `Fmenu` (ligne 1370).
- Utilise `Chistoriques`, `Visualiseur`, `Doc`, `Utils` (dates, couleurs, `Observers`, `db`).
- `Col*_Click` appelés dynamiquement par le rejeu : restent `Public`.

## Risques

- Condition `AND`/`OR` mal parenthésée avec `Bl` (A01) ; filtre inversé sur `Fiches_LigblM` en mode
  « tous » (A02) ; plage fournisseur ignorée hors tri par code (A03).
- Impression déclenchée par toute touche sur le bouton (A04) ; focus incohérent et aide inadaptée
  (A05) ; règles de sélection différentes de `RelvMo`/`TBord` (A06, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 674 |
| Lignes de commentaire | 92 |
| Fonctions | 31 |
| Fonctions Public | 31 |
| Complexité cyclomatique totale | 163 |
| Complexité max (fonction) | 39 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus (HISTOVMO-T01 à T09) : 8 replays (défaut, tris, sources matériel, case `Bl`, listes,
aucune MO, dates, touche sur Imprimer) comparant le texte du PDF et les lignes `Exec_SQL`, puis 1
gbtest du cumul après extraction.

## Rework

9 étapes (HISTOVMO-001 à 009) : documentation, code mort, listes communes (`EdSelection.ListeCodes`),
helpers de fermeture de liste, dates communes, `Cbase.Table`, séparation calcul/impression, choix
des sources hors boucle, réduction de portée de 3 méthodes. 6 anomalies (HISTOVMO-A01 à A06).
