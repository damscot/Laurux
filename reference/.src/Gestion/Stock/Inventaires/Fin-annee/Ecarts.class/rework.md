# Ecarts — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 162 |
| Lignes de commentaire | 24 |
| Fonctions | 7 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 5 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 162 | 17 | 5 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECARTS-001 — [documentation] En-tête en français (contenu de l'édition, valorisation aux prix
  actuels, lignes comptées seulement) · appelants : aucun · tests : T01-T06 · sources : [Ecarts.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L63-L138)
- [ ] ECARTS-002 — [code mort] Supprimer `Level1`, `Level2`, `Level3` (jamais appelées), `Nbpage`,
  le `Shell "cd ~"` et le `With Utils` · appelants : aucun · tests : T01 · sources : [Ecarts.class:Level1](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L141-L164), [Ecarts.class:Level2](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L167-L181), [Ecarts.class:Level3](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L184-L202), [Ecarts.class:86](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L86)
- [ ] ECARTS-003 — [réarchitecture] `Cbase.Table("TabInv")` / `("TabArt")` au lieu des littéraux ; SQL
  identique · appelants : aucun · tests : T01 · sources : [Ecarts.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L33-L61), [Ecarts.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L63-L138)
- [ ] ECARTS-004 — [séparation traitement/GUI] `LignesEcarts()` (lecture + calculs) sans contrôle,
  mise en page dans le handler · appelants : aucun · tests : T01, T04, T06 · sources : [Ecarts.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L63-L138)
- [ ] ECARTS-005 — [commonalisation] Module `Inventaire` (`DateInv`, `Lignes`, `Libelle`) et
  édition des écarts paramétrée par le type, partagée avec `EcartsT` ; squelette d'édition paginée
  commun avec `Ednsaisis*` · appelants : aucun · tests : T01-T04, ECARTST-T01..T04 · sources : [Ecarts.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L63-L138), [EcartsT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L61-L139)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECARTS-A01 — [anomalie] `Fiches_Art` lu sans `Available` : article supprimé → erreur non
  gérée ; lignes sans `ORDER BY` (ordre lexicographique de `inv_nlig char(9)` sur MySQL, voir
  GENINV-A01) · tests : T01, T05 · sources : [Ecarts.class:97](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L97), [Ecarts.class:102](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L102)
