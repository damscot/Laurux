# Stockmvt — Synthèse

> Source : `.src/Gestion/Stockmvt.class` · Synthèse des autres documents.

## Rôle

Écran d'**analyse des mouvements de stock par critères** (menu `Fmenu.mvst`) : période, marque,
centrale, client, fournisseur, article ou familles, sens, sources (stock de départ/théorique,
BL/factures en cours et archivées, réceptions, mouvements exceptionnels, produits composés,
tickets), regroupement (détail/jour/mois/année) ; affichage, édition PDF et export CSV.

## Points clés

- `Buttrait_Click` (CC 75, ~410 lignes) construit dynamiquement une union de 10 sous-requêtes à
  partir de 40 variables de fragments SQL.
- Lecture seule sur la base ; tables en dur.
- La définition des mouvements diffère de `Cstock.Calc_stock` (types de BL, conversion des
  réceptions, tickets, dépôts, inventaire tournant).
- Méthode privée `TriArticles` homonyme de la classe `TriArticles`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.fam`, `Utils.totobs`, `LDate`, `Trifam`, `TriCpt`, `TriArticles`,
  `ObjFacB`, `Commande1`, gb.report, `Visualiseur`, `Editeur`.
- Utilisé par : `Fmenu` (1 appel).

## Risques

- A01 : jointure marque/centrale erronée sur les factures archivées.
- A02 : SQL invalide (fournisseur + stock de départ/théorique).
- A04 : export CSV en erreur hors mode détail.
- A05 : chiffres incohérents avec le stock calculé par `Cstock`.
- A06 / UTILS-A02 : familles sans sélection → SQL invalide.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 843 |
| Lignes de commentaire | 23 |
| Fonctions | 18 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 163 |
| Complexité max (fonction) | 75 (`Buttrait_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 replays (STOCKMVT-T01 à T09, T11) comparant le SQL émis et l'affichage (écran en lecture seule)
et 1 gbtest (T10) sur la construction de la requête après séparation. Liste à valider par
l'utilisateur (écran complexe).

## Rework

8 étapes (STOCKMVT-001 à 008) : documentation, code mort, renommage, extraction de
`ConstruitRequete`, réduction de complexité par descripteurs de sources (SQL identique), totaux et
CSV, `Cbase.Table`, description commune avec `Cstock`. 6 anomalies (STOCKMVT-A01 à A06).
