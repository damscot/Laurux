# rechtipp — Rework

> Source : `.src/Gestion/option/rechtipp.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/rechtipp.class/rework.md <REWORK_ID>`

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

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 58 | 13 | 5 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECHTIPP-001 — [documentation] En-tête : rôle (régions TICPE), modes `"N"`/`"T"`, sentinelle
  `cart = '0'`, événement `trouve`, appelants · appelants : aucun · tests : T01-T03 · sources : [rechtipp.class:_new](../../../../../.src/Gestion/option/rechtipp.class#L8-L38)
- [ ] RECHTIPP-002 — [séparation traitement/GUI] Requête de la colonne 3 de `GridView1_Data`
  déplacée dans une fonction privée `DesignationArticle(code)` (SQL identique) ·
  appelants : aucun · tests : T02 · sources : [rechtipp.class:GridView1_Data](../../../../../.src/Gestion/option/rechtipp.class#L40-L57)
- [ ] RECHTIPP-003 — [complexité] Mode `"T"` : jointure avec `Fiches_Art` dans `_new` au lieu d'une
  requête par cellule (SQL modifié, aucune écriture, affichage identique) · appelants : aucun ·
  tests : T02 · sources : [rechtipp.class:_new](../../../../../.src/Gestion/option/rechtipp.class#L8-L38), [rechtipp.class:GridView1_Data](../../../../../.src/Gestion/option/rechtipp.class#L40-L57)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RECHTIPP-A01 — [anomalie] Fenêtre non journalisée (`Utils.Observers(Me)` absent) · tests :
  T04 · sources : [rechtipp.class:_new](../../../../../.src/Gestion/option/rechtipp.class#L8-L38)
- [ ] RECHTIPP-A02 — [anomalie] `GridView1_Data` lit `res!art_design` sans test `Available` (article
  supprimé → erreur, mode `"T"` inutilisé à ce jour) · tests : T02 · sources : [rechtipp.class:54](../../../../../.src/Gestion/option/rechtipp.class#L54)
