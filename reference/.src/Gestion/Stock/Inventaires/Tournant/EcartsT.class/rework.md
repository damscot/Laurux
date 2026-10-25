# EcartsT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 164 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 164 | 17 | 5 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECARTST-001 — [documentation] En-tête en français (contenu de l'édition, valorisation aux prix
  actuels, lignes comptées seulement) · appelants : aucun · tests : T01-T06 · sources : [EcartsT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L61-L139)
- [ ] ECARTST-002 — [code mort] Supprimer `Level1`, `Level2`, `Level3` (jamais appelées), `Nbpage`, `p`, `Frmt`, `Coulfond`,
  le `Shell "cd ~"` et le `With Utils` · appelants : aucun · tests : T01 · sources : [EcartsT.class:Level1](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L142-L165), [EcartsT.class:Level2](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L168-L182), [EcartsT.class:Level3](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L185-L203), [EcartsT.class:86](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L86)
- [ ] ECARTST-003 — [réarchitecture] `Cbase.Table("TabInvT")` / `("TabArt")` au lieu des littéraux ; SQL
  identique · appelants : aucun · tests : T01 · sources : [EcartsT.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L34-L59), [EcartsT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L61-L139)
- [ ] ECARTST-004 — [séparation traitement/GUI] `LignesEcarts()` (lecture + calculs) sans contrôle,
  mise en page dans le handler · appelants : aucun · tests : T01, T04, T06 · sources : [EcartsT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L61-L139)
- [ ] ECARTST-005 — [commonalisation] Module `Inventaire` (`DateInv`, `Lignes`, `Libelle`) et
  édition des écarts paramétrée par le type, partagée avec `Ecarts` ; squelette d'édition paginée
  commun avec `Ednsaisis*` · appelants : aucun · tests : T01-T04, ECARTS-T01..T04 · sources : [Ecarts.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class#L63-L138), [EcartsT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L61-L139)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECARTST-A01 — [anomalie] `If Not Error And rResult.Available` (sans court-circuit) : table
  `Fiches_InvT` absente — état normal après `ValidinvT` — → erreur non gérée à l'ouverture de
  l'écran au lieu du message « aucun inventaire » · tests : T03 · sources : [EcartsT.class:47](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L47)
- [ ] ECARTST-A02 — [anomalie] `Fiches_Art` lu sans `Available` : article supprimé → erreur non
  gérée ; lignes sans `ORDER BY` (ordre de génération `lind`, alors que les n° ont pu être
  renumérotés par l'impression de `GeninvT`) · tests : T01, T05 · sources : [EcartsT.class:97](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L97), [EcartsT.class:102](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class#L102)
