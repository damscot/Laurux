# fourconsdroi — Rework

> Source : `.src/Gestion/option/fourconsdroi.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/fourconsdroi.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 213 |
| Lignes de commentaire | 2 |
| Fonctions | 17 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 49 |
| Complexité max (fonction) | 8 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 213 | 49 | 8 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FOURCONSDROI-001 — [code mort] Supprimer le fichier `fourconsdroi.class` (sans `.form`,
  jamais instancié) : fonctions `unused` `addligne`, `enrligne`, `renligne`, `recuppalette`,
  `recupcoli`, `creadra`, `unused_transitive` `supligne`, `enregistre`, constructeur et structures
  `consigne`/`ligne` · appelants : aucun · tests : T01, T02 · sources : [fourconsdroi.class:_new](../../../../../.src/Gestion/option/fourconsdroi.class#L40-L77), [fourconsdroi.class:addligne](../../../../../.src/Gestion/option/fourconsdroi.class#L79-L114), [fourconsdroi.class:supligne](../../../../../.src/Gestion/option/fourconsdroi.class#L131-L140), [fourconsdroi.class:enrligne](../../../../../.src/Gestion/option/fourconsdroi.class#L142-L155), [fourconsdroi.class:enregistre](../../../../../.src/Gestion/option/fourconsdroi.class#L203-L220), [fourconsdroi.class:renligne](../../../../../.src/Gestion/option/fourconsdroi.class#L157-L169), [fourconsdroi.class:recuppalette](../../../../../.src/Gestion/option/fourconsdroi.class#L171-L185), [fourconsdroi.class:recupcoli](../../../../../.src/Gestion/option/fourconsdroi.class#L187-L201), [fourconsdroi.class:creadra](../../../../../.src/Gestion/option/fourconsdroi.class#L222-L243)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

Aucune : les défauts relevés (variable `cdt` jamais affectée dans `addligne`, `DELETE` hors
transaction dans `enrligne`) sont dans du code jamais exécuté et disparaissent avec
FOURCONSDROI-001.
