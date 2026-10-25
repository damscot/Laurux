# rechtipp — Synthèse

> Source : `.src/Gestion/option/rechtipp.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre de choix d'une région TICPE/TIPP (option carburants, `Fiches_region`) : régions générales
(`cart = '0'`, mode `"N"`) ou taux par article (mode `"T"`, inutilisé) ; lève `trouve(code)`.

## Points clés

- Appelants : `FClient` (code TIPP du client et de l'adresse de livraison), `Facture` (code TIPP de
  ligne). Colonnes `cli_tipp`, `tipp_ligbl` ajoutées à l'exécution par `modfichier` (absentes de
  `db_control.csv`).
- Mode `"T"` : une requête `Fiches_Art` par cellule, sans test `Available`.

## Dépendances principales

- Utilise : `Utils.db` ; tables `Fiches_region`, `Fiches_Art`.
- Utilisé par : `FClient`, `Facture`.

## Risques

- Non journalisée, sans `GridView1_Click` : non rejouable directement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 58 |
| Lignes de commentaire | 1 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 5 (`GridView1_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests (RECHTIPP-T01 à T04) : 3 `gbtest` sous Xvfb (modes N et T, sélection), 1 replay via
`FClient`.

## Rework

3 étapes (RECHTIPP-001 à 003) : documentation, requête de désignation isolée, jointure en mode T.
2 anomalies (A01 journalisation, A02 article absent).
