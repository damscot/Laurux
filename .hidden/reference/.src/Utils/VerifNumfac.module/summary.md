# VerifNumfac — Synthèse

> Source : `.src/Utils/VerifNumfac.module` · Synthèse des autres documents.

## Rôle

Recherche du prochain numéro de facture à 6 chiffres absent des factures et BL (et de leurs
variantes Matériel).

## Points clés

- **Code mort** : `Dnfac` n'a aucun appelant.
- Calculs inutilisés (`N5`, `bfacture`, `b3facture`) et booléens écrasés en mode Matériel.

## Dépendances principales

- `Utils.db`, `Start.LocalSettings` ; tables `Fiches_HistoFac`, `Fiches_Bl`, `Fiches_HistoFacM`,
  `Fiches_BlM`.

## Risques

- Aucun à la suppression ; si conservé, résultat faux en mode Matériel.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 86 |
| Lignes de commentaire | 3 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 26 (`Dnfac`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

1 test de compilation après suppression (T01) ; T02 seulement si le module est conservé.

## Rework

2 étapes (suppression, ou à défaut nettoyage) et 1 anomalie (A01).
