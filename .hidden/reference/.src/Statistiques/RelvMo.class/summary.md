# RelvMo — Synthèse

> Source : `.src/Statistiques/RelvMo.class` · Synthèse des autres documents.

## Rôle

Relevé des prestations de main-d'oeuvre par client sur une période (menu `Fmenu`). Le traitement
cumule, pour chaque MO, les quantités facturées par client (BL facturés non historisés, factures
historisées, factures matériel historisées) dans la table de travail `Fiches_Stat`, les affiche dans
`RlCli`, puis imprime un relevé PDF par client (`Cdocuments`).

## Points clés

- Filtre de période appliqué côté Gambas (`Cdate_Comp`) après des requêtes unitaires par MO, par
  ligne et par document : coût élevé sur une grosse base.
- Table de travail `Fiches_Stat` recréée à chaque traitement avec une structure propre, alors que
  `RelMoprod` et `TriHistos` la recréent avec d'autres structures.
- `Button1_Click` (CC 37) recopie trois fois le même bloc ; `Button2_Click` recompose les mentions
  société comme d'autres relevés.
- Les méthodes `dteN*_GotFocus/LostFocus` ne sont pas des handlers levés (groupe `Cmpt`).

## Dépendances principales

- Appelé par `Fmenu` (ligne 1823).
- Utilise `Cdocuments` (impression), `Utils` (dates, `Observers`, `db`), `Cbase.Table` (10 clés).
- `RlCli_Click` appelé dynamiquement par le rejeu (`Object.Call`) : reste `Public`.

## Risques

- **Impression plantée au saut de page** : `Cdocuments.Entete` appelé avec 18 arguments sur 19
  (A01, vérifié : aucun paramètre optionnel).
- Montant TTC non cumulé (A02) ; table `Fiches_Stat` partagée à structures multiples (A03) ;
  quantité héritée d'une ligne précédente et lignes matériel non historisées ignorées (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 382 |
| Lignes de commentaire | 26 |
| Fonctions | 16 |
| Fonctions Public | 16 |
| Complexité cyclomatique totale | 97 |
| Complexité max (fonction) | 37 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests prévus (RELVMO-T01 à T08) : 7 replays (traitement, bornes, date invalide, suppression,
impression de la sélection, saut de page, sans sélection) comparant le dump de `Fiches_Stat`, les
lignes `Exec_SQL` et le texte du PDF, puis 1 gbtest du remplissage après extraction.

## Rework

8 étapes (RELVMO-001 à 008) : documentation, code mort, `DELETE` unique (SQL modifié, dump
identique), factorisation des trois blocs, séparation calcul/GUI et mentions société, dates
communes, réduction de portée de 6 méthodes. 6 anomalies (RELVMO-A01 à A06).
