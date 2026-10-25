# TriMo — Rework

> Source : `.src/Affichages/TriMo.class` · Message de commit (phase 4) : `reference/.src/Affichages/TriMo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 2 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 8 |
| Complexité max (fonction) | 2 (`Colmo_Data`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 48 | 8 | 2 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRIMO-001 — [documentation] En-tête signalant la classe comme morte (aucune ouverture, remplacée
  par `TriArticles` en mode `"mo_code"`) en attendant la décision sur TRIMO-A01 · appelants :
  aucun · tests : T01 · sources : [TriMo.class:_new](../../../../.src/Affichages/TriMo.class#L8-L18)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRIMO-A01 — [anomalie] Supprimer le couple mort `TriMo.class` + `TriMo.form` (jamais
  instancié, signal `jamais_reference` vérifié), puis `Variables.$Codemo` (VARIABLES-002) ;
  suppression d'un `.form` = validation utilisateur · tests : T01 · sources : [TriMo.class:_new](../../../../.src/Affichages/TriMo.class#L8-L18), [TriMo.class:63](../../../../.src/Affichages/TriMo.class#L63)
