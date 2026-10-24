# Movr — Synthèse

> Source : `.src/Gestion/Tables/Movr.class` · Synthèse des autres documents.

## Rôle

Fiche des **codes de main-d'œuvre** (`Fiches_Mo`) : MO au temps (temps × taux horaire, valorisée
à la facturation) ou au forfait (valeur HT/TTC avec règle d'arrondi), rattachée à une famille
(TVA), un fournisseur et un taux de MO (`Fiches_Txtmo`). Calcule la marge. Ouverte en modal depuis
le menu Gestion et par F4 dans la saisie de MO de la facturation.

## Points clés

- Grille triable/filtrable (`Colmo`, `Utils.Base` → `Utils.rs1`) et onglet de statistiques
  (`Gridvi`, mode `"M"`).
- Validation de zone dupliquée entre `Cmpt_KeyPress` (CC 35, max) et `Cmpt_Lostfocus` (CC 29).
- Arrondi du TTC au pas de 0,05/0,10/0,50/1,00 **par chaîne** (`arrondi`), identique à
  `Materiel.arrondi` ; marge identique à `Txmo.Calc_MargeMo`.
- Erreur de lecture de champ utilisée comme contrôle de flux (`FamMan`, `fourMan`, `TxMoMan`).
- Code mort : `Txht_LostFocus`, `Valeur2TTC_LF`, branche `Case 10`.

## Dépendances principales

- Utilise : `Utils` (`db`, `rs1`, `cpoint`, `PointBase`, `Remplace`, `FColr`, observateurs),
  `Cbase.Table("TabMo")`, `Gridvi`, `Start.LocalSettings` (couleurs, taxe), `Doc.Open`.
- Tables : `Fiches_Mo` (seule modifiée), lecture de `Fiches_Fam`, `Fiches_Four`, `Fiches_Txtmo`,
  `Fiches_Tvaav`, `Fiches_Ligbl`.
- Appelée par `Fmenu` et `Facture` (auto-instance) ; `Fiches_Mo` est aussi écrite par `Txmo` et
  `FTvav`.

## Risques

- Saisie manuelle d'un code existant puis enregistrement : écrasement de colonnes non chargées,
  forfait repassé au temps (A01).
- Suppression non contrôlée hors `Fiches_Ligbl` (A02) ; code TVA inexistant non signalé (A03).
- SQL par concaténation de la saisie (A04) ; F2 sur famille → erreur SQL (colonne `code`
  inexistante, A05) ; listes incohérentes clavier/souris (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1271 |
| Lignes de commentaire | 91 |
| Fonctions | 70 |
| Fonctions Public | 70 |
| Complexité cyclomatique totale | 323 |
| Complexité max (fonction) | 35 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus : 8 replays (création temps/forfait avec arrondis, modification, saisie manuelle
d'un code, suppression, listes, tri/filtre, ouverture depuis la facturation) et 1 `gbtest` des
calculs (arrondi, marge) après séparation traitement/GUI. Données : `Laurux01.sql` + un BL
dérivé.

## Rework

9 étapes sans changement de comportement (MOVR-001 à 009) : documentation, code mort,
`Cbase.Table`, factorisation des en-têtes et de la validation, calculs purs communs avec `Txmo`
(marge) et `Materiel` (arrondi), extraction SQL, réduction de portée de 21 fonctions.
6 anomalies (MOVR-A01 à A06) soumises à validation.
