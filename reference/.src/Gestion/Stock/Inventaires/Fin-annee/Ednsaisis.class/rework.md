# Ednsaisis — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 154 |
| Lignes de commentaire | 27 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 7 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 154 | 18 | 7 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDNSAISIS-001 — [documentation] En-tête en français (lignes non comptées, lien avec l'option de la
  validation) · appelants : aucun · tests : T01-T06 · sources : [Ednsaisis.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L64-L138)
- [ ] EDNSAISIS-002 — [code mort] Supprimer `Level1`, `Level2`, `Level3`, `Coulfond`, `Nbpage`,
  `Nlig`, le `Shell "cd ~"` · appelants : aucun · tests : T01 · sources : [Ednsaisis.class:Level1](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L141-L160), [Ednsaisis.class:Level2](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L163-L175), [Ednsaisis.class:Level3](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L178-L196), [Ednsaisis.class:85](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L85)
- [ ] EDNSAISIS-003 — [réarchitecture] `Cbase.Table("TabInv")` / `("TabArt")` au lieu des littéraux ; SQL
  identique · appelants : aucun · tests : T01 · sources : [Ednsaisis.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L35-L62), [Ednsaisis.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L64-L138)
- [ ] EDNSAISIS-004 — [séparation traitement/GUI] `LignesNonSaisies()` sans contrôle · appelants : aucun ·
  tests : T01, T04, T05 · sources : [Ednsaisis.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L64-L138)
- [ ] EDNSAISIS-005 — [commonalisation] Module `Inventaire` et édition paramétrée par le type, partagée
  avec `EdnsaisisT` ; squelette d'édition commun avec `Ecarts*` · appelants : aucun · tests : T01-T04 ·
  sources : [Ednsaisis.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L64-L138), [EdnsaisisT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L59-L135)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDNSAISIS-A01 — [anomalie] `Fiches_Art` lu sans `Available` (article supprimé → erreur non
  gérée) ; lignes sans `ORDER BY` · tests : T01, T06 · sources : [Ednsaisis.class:96](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L96), [Ednsaisis.class:101](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L101)
