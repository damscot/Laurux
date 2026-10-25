# Consigne — Synthèse

> Source : `.src/Gestion/option/Consigne.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet de calcul des **consignes d'emballages** (palettes, colis, bouteilles) de l'option
« boissons » (`Utils.Option()` = `B` ou `T`). Classe sans formulaire héritant de `calculdroit1`
(droits sur les alcools) et donc de `LPrix` : un même objet porte le prix de la ligne, ses droits
et ses consignes.

## Points clés

- Montant consigné = prix(palette) × nb palettes + prix(colis) × nb colis + prix(unité) × quantité
  (`consigne`), chaque prix lu dans `Fiches_consigne`.
- Mouvements stockés dans `Fiches_ligcons` (clé `bloc` = date `dd.mm.yyyy` & n° réception &
  fournisseur, `numlig` sur 3 chiffres) ; `recuppalette`/`recupcol` relisent palettes et colis.
- Constructeur à 13 arguments dans `Achat` : 4 pour `LPrix`, 4 pour `calculdroit1`, 5 pour
  `Consigne` (classes mères d'abord).
- Objet porté par `Sailig.AutresObj[Achat.Consignes].ccd` dans l'écran de réception (accès
  `Variant` non vus par `deps.py`).
- Tables créées à l'exécution par `modfichier.fichierboisson` : absentes de `db_control.csv` et de
  `Laurux01.sql`.

## Dépendances principales

- Utilise : `calculdroit1` (héritage), `LPrix`, `LTaxe` (`LTaxe.Consigne`), `Utils.db`.
- Utilisé par : `Achat` (création, `consigne_montant`), `ValidBR1` (`recuppalette`, `recupcol`,
  `consigne` → écriture comptable sur `consfou`).

## Risques

- Quantité convertie en `Integer` dans `consigne_montant` (quantités fractionnaires, à confirmer).
- Hérite de l'anomalie CALCULDROIT1-A01 : en option `B` seule, les droits et la ligne de régie
  d'`Achat` sont neutralisés.
- Six requêtes par lecture double de la propriété `consigne` dans `ValidBR1`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 61 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 3 (`recuppalette`) |
| Variables globales | 0 |
| Variables Public | 5 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests (CONSIGNE-T01 à T06) : 5 `gbtest` (montant, quantité fractionnaire, relecture
palettes/colis, total, constructeur à 13 arguments) et 1 replay de réception + validation. Jeu de
données dérivé `option_boisson` (tables de l'option créées par `modfichier`).

## Rework

6 étapes (CONSIGNE-001 à 006) : documentation, suppression de `LecCons`, paramètre `&1`,
factorisation `recuppalette`/`recupcol` et `consigne_Read`, fonction commune de prix de consigne
avec `Saisiedecons`. 2 anomalies (CONSIGNE-A01 quantité entière, A02 héritée de calculdroit1).
