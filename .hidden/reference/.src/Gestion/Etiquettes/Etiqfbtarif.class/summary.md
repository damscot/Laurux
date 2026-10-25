# Etiqfbtarif — Synthèse

> Source : `.src/Gestion/Etiquettes/Etiqfbtarif.class` · Synthèse des autres documents.

## Rôle

Impression d'étiquettes de gondole aux prix recalculés d'après la fiche barème (articles dont `art_datefbt` vaut la date saisie).

## Points clés

- Copie locale du calcul de prix de `MajFbtarif2`/`MajTarifP`/`Impart`/`Articles` sur 20 membres `String` partagés.
- `Calc_Marge`, `Calc_Percent`, `Calc_coeff` sans effet observable.
- `i2` remis à 0 à chaque article : pas de saut de page sur une planche multi-rangées.

## Dépendances principales

- Appelants : `Fmenu.Menu242/247_Click` (modal).
- Tables `Fiches_Art`, `Fiches_Tvaav`, `Fiches_Etiquettes` (lecture seule).

## Risques

- Pages non découpées (A01, à confirmer) ; Zebra → « Null object », aucun message si aucun article (A02) ; divergence possible avec le calcul de `MajFbtarif2`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 365 |
| Lignes de commentaire | 35 |
| Fonctions | 20 |
| Fonctions Public | 20 |
| Complexité cyclomatique totale | 92 |
| Complexité max (fonction) | 18 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests (6 `replay`, 1 `gbtest` sur le calcul de prix après séparation).

## Rework

6 reworks (documentation, code mort, calcul de prix pur, commonalisation avec le lot Tarifs, portée, `PlancheEtiquettes`). 2 anomalies.
