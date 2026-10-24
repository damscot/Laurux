# Cstock — Synthèse

> Source : `.src/Utils/Cstock.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Moteur de recalcul du stock théorique (`Fiches_Art.art_qte`) des articles stockés : stock de départ
(dernier inventaire ou inventaire tournant) − ventes (BL, BLM, factures, factures M) + réceptions
× taux de conversion ± mouvements exceptionnels et de dépôt, depuis la date du dernier inventaire.

## Points clés

- Une fonction publique `Calc_stock(Art, art2)` (CC 13) et `date_ex` (date de départ).
- 1 + 2 requêtes par article (inventaire tournant, `UNION ALL` de 8 sources), sous `LOCK TABLES`
  de 17 tables, sans transaction.
- **Couplage GUI caché** : le choix des articles lit les boutons radio du formulaire `Calcstock`.
- Variables de module partagées entre articles (`dte2`).

## Dépendances principales

- Appelé par `Calcstock` (écran de recalcul) et `Validinv` (validation d'inventaire de fin d'année).
- Lit `Calcstock.Cbx`/`Cbx2` (dépendance circulaire non détectée par `deps.py`).
- 18 tables lues, `Fiches_Art` écrite.

## Risques

- **Validation d'inventaire** : l'appel depuis `Validinv` ne recalcule aucun article (bouton
  `Cbx` coché par défaut sur l'instance cachée du formulaire).
- **Fuite de `dte2`** : un inventaire tournant d'un article décale la date de recherche de
  l'article suivant (stock faux possible).
- **SQLite** : la requête est refusée (`UNION ALL(`) et les comparaisons de dates sont fausses.
- Verrous laissés en place en cas d'erreur.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 108 |
| Lignes de commentaire | 30 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 16 |
| Complexité max (fonction) | 13 (`Calc_stock`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests (CSTOCK-T01 à T12) sur MariaDB : modes de sélection, contribution isolée de chaque source,
inventaires tournants, fuite de date, date de départ, valeurs limites, appel depuis Validinv
(replay), SQLite, performance. Diff du dump de `Fiches_Art` et du log SQL ; valeurs attendues
produites par le clone non modifié, avec un contrôle indépendant de la formule à titre indicatif.

## Rework

7 étapes (CSTOCK-001 à 007) : documentation, code mort, paramètre de mode à la place de la lecture
des contrôles (appelants `Calcstock` et `Validinv` mis à jour), extraction du calcul par article,
`date_ex` sans GUI, `Cbase.Table`, réduction de portée. 5 anomalies (CSTOCK-A01 à A05).
