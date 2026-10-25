# EditStkDepart — Rework

> Source : `.src/Gestion/option/EditStkDepart.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/EditStkDepart.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 136 |
| Lignes de commentaire | 1 |
| Fonctions | 6 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 9 (`_new`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 136 | 17 | 9 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDITSTKDEPART-001 — [documentation] En-tête en français : quatre variantes, sources des
  quantités, ruptures régie/degré, rôle de `Calculdroit`, réaffectation du contrôle `ligne` ·
  appelants : aucun · tests : T01-T04 · sources : [EditStkDepart.class:_new](../../../../../.src/Gestion/option/EditStkDepart.class#L21-L69)
- [ ] EDITSTKDEPART-002 — [code mort] Supprimer la constante `champs` et la variable `$tab`,
  inutilisées · appelants : aucun · tests : T01 · sources : [EditStkDepart.class:19](../../../../../.src/Gestion/option/EditStkDepart.class#L19), [EditStkDepart.class:16](../../../../../.src/Gestion/option/EditStkDepart.class#L16)
- [ ] EDITSTKDEPART-003 — [complexité] `_new` : requête choisie dans une table (source, colonne de
  quantité) au lieu des quatre `Case` ; SQL identique au caractère près (CC 9 → ≤ 5 visé) ·
  appelants : aucun · tests : T01-T04 · sources : [EditStkDepart.class:_new](../../../../../.src/Gestion/option/EditStkDepart.class#L21-L69)
- [ ] EDITSTKDEPART-004 — [réduction de portée] `nomInv` → `Private` (aucun usage externe,
  vérifié) · appelants : aucun · tests : T01 · sources : [EditStkDepart.class:4](../../../../../.src/Gestion/option/EditStkDepart.class#L4)
- [ ] EDITSTKDEPART-005 — [commonalisation] Fabrique de `ReportLabel` (`dimention`) partagée avec
  `Caleditcmat` (`entete`, `soustot`, `ligne`) ; rendu identique · appelants : `Caleditcmat`
  (même commit, voir CALEDITCMAT-006) · tests : T01-T04 ; tests de Caleditcmat · sources :
  [EditStkDepart.class:dimention](../../../../../.src/Gestion/option/EditStkDepart.class#L170-L183), [Caleditcmat.class:ligne](../../../../../.src/Gestion/option/Caleditcmat.class#L783-L893)
- [ ] EDITSTKDEPART-006 — [séparation traitement/GUI] `LignesStock(ind) As Result` et cumul des
  totaux séparé de la construction des `ReportLabel` · appelants : aucun · tests : T01-T04 ·
  sources : [EditStkDepart.class:_new](../../../../../.src/Gestion/option/EditStkDepart.class#L21-L69), [EditStkDepart.class:edligne](../../../../../.src/Gestion/option/EditStkDepart.class#L134-L168)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDITSTKDEPART-A01 — [anomalie] Filtre `art_dra IS NOT NULL` : les articles à code régie
  vide (`''`) sont imprimés sous une régie sans libellé, alors que `Caleditcmat.ctrl` les exclut
  (`art_dra <> ''`) · tests : T05 · sources : [EditStkDepart.class:30](../../../../../.src/Gestion/option/EditStkDepart.class#L30), [EditStkDepart.class:36](../../../../../.src/Gestion/option/EditStkDepart.class#L36)
- [ ] EDITSTKDEPART-A02 — [anomalie] Police `"Serif,Blod,11"` (faute de frappe) : le libellé de la
  régie n'est probablement pas en gras (à confirmer visuellement) · tests : T01 (visuel) ·
  sources : [EditStkDepart.class:77](../../../../../.src/Gestion/option/EditStkDepart.class#L77)
