# gridvi — Synthèse

> Source : `.src/Utils/gridvi.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Composant d'écran qui ajoute un onglet « Statistiques » à une fiche et y affiche un **tableau
comparatif annuel** (12 mois + TOTAL × 4 exercices × C.A / Quantité / Marge), calculé à partir des
factures et BL (archives comprises). Cinq variantes selon le type passé au constructeur : article
(`A`), main d'œuvre (`M`), famille/sous-famille (`F`/`S`), client (`C`, avec fenêtre de détail par
article sur une sélection de mois) et tournée (`T`).

## Points clés

- Construction entièrement dynamique (Panel, Label, Buttons, GridView) ; pas de `.form`.
- Lecture seule en base ; 192 requêtes `SUM` par calcul (4 exercices × 12 mois × 4 sources).
- `bouton_Click` (CC 25) est à la fois un handler et une méthode appelée par les fiches.
- Tables en dur (11), pas de `Cbase.Table` ; SQL paramétré pour les valeurs.
- Fenêtre de détail client : 4 requêtes `UNION ALL` copiées-collées et 2 requêtes par article
  pour les désignations (N+1).
- Variantes mortes : `gridvi2` (86 lignes strictement identiques) et `gridv` (35 lignes
  identiques) ; `Tregie.affent` reproduit le même dessin d'en-têtes.

## Dépendances principales

- Utilisé par `Articles`, `FClient`, `Famille`, `Movr`, `Ttourne` (`New Gridvi`, `razcol`,
  `bouton_Click`, `code`, `dec`).
- Utilise `Utils.db`, `Utils.mois`, `Utils.lastday`, `Utils.totobs`, `LDate`.
- Tables : `Fiches_HistoFac(M)`, `Fiches_HistoLigfac(M)`, `Fiches_Bl(M)`, `Fiches_Ligbl(M)`,
  `Fiches_Parametres`, `Fiches_Art`, `Fiches_Mo`.

## Risques

- **SQLite** : `LOCATE` non traduit → statistiques par sous-famille en erreur (A01).
- Marge des lignes de main d'œuvre dans le détail client probablement fausse (A03, à confirmer).
- Curseur d'attente non rétabli si `Fiches_Parametres` est vide (A02) ; lecture sans `Available`
  dans le détail (A04).
- Sommes dépendantes de la locale (`Utils.totobs`) ; conversion implicite Date → String de
  `dteclec`.
- Performance du détail client sur un gros historique.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 493 |
| Lignes de commentaire | 12 |
| Fonctions | 13 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 80 |
| Complexité max (fonction) | 25 (`bouton_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests prévus : 8 `replay` (un par type, détail client, bornes d'exercice, SQLite), 1 `gbtest`
sur le calcul des bornes après extraction, 1 test de performance. Le résultat comparé est le dump
des cellules de la grille, généré dans le clone Laurux non modifié.

## Rework

9 étapes sans changement de comportement (GRIDVI-001 à 009) : documentation, code mort,
réduction de complexité de `bouton_Click`, factorisation des requêtes de détail, `Cbase.Table`,
séparation des calculs de dates et du SQL, suppression du N+1, helper commun avec `Tregie`.
4 anomalies (GRIDVI-A01 à A04) soumises à validation utilisateur.
