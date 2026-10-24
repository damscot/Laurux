# Crupt — Synthèse

> Source : `.src/Utils/Crupt.module` · Synthèse des autres documents.

## Rôle

Calcul des produits en rupture de stock et des quantités à commander pour l'impression `EdRup`. La
procédure unique `Rupture` remplit deux tables de travail partagées, `Rupture` (par article et
fournisseur) et `RuptureC` (détail par client), ensuite lues par `EdRup` pour produire le PDF.

## Points clés

- Une seule fonction de 319 lignes, CC 106 (maximum de la couche Utils), jusqu'à 8 niveaux
  d'imbrication.
- Cinq phases : création des tables, cumul des commandes fournisseurs, cumul des commandes clients,
  stock théorique et quantité à commander, ajustement final.
- Un seul appelant (`EdRup`, `Org = "EdRup"`) : toutes les branches `Org <> "EdRup"` sont du code mort.
- Requêtes unitaires par ligne lue (coût élevé sur gros volumes).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.cpoint`, `Cbase.Table` (`Fiches_Ligcom`, `Fiches_Art`, `Fiches_Entcom`,
  `Fiches_Ligbl`, `Fiches_Bl`).
- Utilisé par : `EdRup` ; tables `Rupture`/`RuptureC` aussi touchées par `Changefam`.

## Risques

- Colonne inexistante `qtecli` dans `RuptureC` (A01), mise à jour sans filtre fournisseur (A02),
  test d'erreur périmé (A03), division par `art_txconv` nul (A04).
- Tables de travail communes à tous les postes (A05).
- Fichier critique pour les commandes : rework uniquement derrière des tests de caractérisation
  couvrant les combinaisons de cases et les articles divers `.DEP`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 319 |
| Lignes de commentaire | 8 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 106 |
| Complexité max (fonction) | 106 (`Rupture`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus (CRUPT-T01 à T09) : 8 `gbtest` qui appellent `Crupt.Rupture` et comparent les dumps
de `Rupture`/`RuptureC` (nominal, non stockés, par client, bornes, `.DEP`, multi-fournisseurs, cas
limites, performance) et 1 `replay` de l'impression `EdRup`.

## Rework

7 étapes sans changement de comportement (CRUPT-001 à 007) : documentation, suppression du code mort
`Org <> "EdRup"` et des variables inutilisées, constantes de tables partagées, helpers, découpage en
5 procédures (CC 106 → ≤ 25), extraction des calculs purs. 5 anomalies (CRUPT-A01 à A05).
