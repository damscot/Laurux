# EdnsaisisT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 151 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 151 | 18 | 7 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDNSAISIST-001 — [documentation] En-tête en français (lignes non comptées, lien avec l'option de la
  validation) · appelants : aucun · tests : T01-T06 · sources : [EdnsaisisT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L59-L135)
- [ ] EDNSAISIST-002 — [code mort] Supprimer `Level1`, `Level2`, `Level3`, `Coulfond`, `Nbpage`,
  `Nlig`, le `Shell "cd ~"` · appelants : aucun · tests : T01 · sources : [EdnsaisisT.class:Level1](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L138-L157), [EdnsaisisT.class:Level2](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L160-L172), [EdnsaisisT.class:Level3](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L175-L193), [EdnsaisisT.class:82](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L82)
- [ ] EDNSAISIST-003 — [réarchitecture] `Cbase.Table("TabInvT")` / `("TabArt")` au lieu des littéraux ; SQL
  identique · appelants : aucun · tests : T01 · sources : [EdnsaisisT.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L35-L57), [EdnsaisisT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L59-L135)
- [ ] EDNSAISIST-004 — [séparation traitement/GUI] `LignesNonSaisies()` sans contrôle · appelants : aucun ·
  tests : T01, T04, T05 · sources : [EdnsaisisT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L59-L135)
- [ ] EDNSAISIST-005 — [commonalisation] Module `Inventaire` et édition paramétrée par le type, partagée
  avec `Ednsaisis` ; squelette d'édition commun avec `Ecarts*` · appelants : aucun · tests : T01-T04 ·
  sources : [Ednsaisis.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class#L64-L138), [EdnsaisisT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L59-L135)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDNSAISIST-A01 — [anomalie] `If Not Error And rResult.Available` sans court-circuit : table
  absente (après `ValidinvT`) → erreur non gérée à l'ouverture · tests : T03 · sources : [EdnsaisisT.class:46](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L46)
- [ ] EDNSAISIST-A02 — [anomalie] `Fiches_Art` lu sans `Available` (article supprimé → erreur non
  gérée) ; lignes sans `ORDER BY` · tests : T01, T06 · sources : [EdnsaisisT.class:93](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L93), [EdnsaisisT.class:98](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class#L98)
