# Crupt — Rework

> Source : `.src/Utils/Crupt.module` · Message de commit (phase 4) : `reference/.src/Utils/Crupt.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 319 |
| Lignes de commentaire | 8 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 106 |
| Complexité max (fonction) | 106 (`Rupture`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 319 | 106 | 106 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CRUPT-001 — [documentation] Réécrire l'en-tête (un seul appelant `EdRup`), décrire les
  paramètres, les 5 phases et le contrat des tables `Rupture`/`RuptureC` · appelants : aucun ·
  tests : aucun · sources : [Crupt.module:Rupture](../../../../.src/Utils/Crupt.module#L6-L332)
- [ ] CRUPT-002 — [code mort] Supprimer les branches `Org <> "EdRup"` (aucun autre appelant, vérifié
  par grep) ; paramètre `Org` conservé · appelants : `EdRup` (inchangé) · tests : T01 à T07, T09 · sources : [Crupt.module:Rupture](../../../../.src/Utils/Crupt.module#L6-L332), [Crupt.module:63-75](../../../../.src/Utils/Crupt.module#L63-L75), [Crupt.module:82-84](../../../../.src/Utils/Crupt.module#L82-L84)
- [ ] CRUPT-003 — [code mort] Variables inutilisées (`Tabl`, `rupt`, `rupt2`, `Nbpage`, `nmclient`),
  `UCase$(".DEP")` → `".DEP"` · appelants : aucun · tests : T01 à T05 · sources : [Crupt.module:Rupture](../../../../.src/Utils/Crupt.module#L6-L332), [Crupt.module:20-24](../../../../.src/Utils/Crupt.module#L20-L24)
- [ ] CRUPT-004 — [commonalisation] Constantes `TabRupture`/`TabRuptureC` partagées avec `EdRup` et
  `Changefam` · appelants : `EdRup`, `Changefam` · tests : T01, T09 · sources : [Crupt.module:21-22](../../../../.src/Utils/Crupt.module#L21-L22), [EdRup.class:319-320](../../../../.src/Gestion/Impressions/EdRup.class#L319-L320), [Changefam.class:541-542](../../../../.src/Utils/Changefam.class#L541-L542)
- [ ] CRUPT-005 — [commonalisation] Helpers privés `EstDivers(codea)`, `IntituleSansPrefixe(s)`,
  `ChercheRupture(codea, intitulea, four)` (mêmes requêtes) · appelants : aucun · tests : T01 à T06 · sources : [Crupt.module:Rupture](../../../../.src/Utils/Crupt.module#L6-L332)
- [ ] CRUPT-006 — [complexité] Découper `Rupture` en 5 procédures privées par phase (CC 106 → ≤ 25 par
  procédure) en conservant l'ordre exact des requêtes · appelants : aucun · tests : T01 à T08 · sources : [Crupt.module:Rupture](../../../../.src/Utils/Crupt.module#L6-L332)
- [ ] CRUPT-007 — [séparation traitement/GUI] Extraire les calculs purs `StockTheorique` et
  `QuantiteACommander` (testables en gb.test) · appelants : aucun · tests : T01, T07 · sources : [Crupt.module:257-283](../../../../.src/Utils/Crupt.module#L257-L283)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CRUPT-A01 — [anomalie] L. 181 : `UPdate RuptureC SET … qtecli = …` sur une colonne inexistante
  (erreur SQL propagée dans le cas `chk2`, à confirmer) · tests : T07 · sources : [Crupt.module:181](../../../../.src/Utils/Crupt.module#L181)
- [ ] CRUPT-A02 — [anomalie] L. 117 : cumul `qtefour` mis à jour sans filtre `four` (lignes des autres
  fournisseurs écrasées) · tests : T06 · sources : [Crupt.module:117](../../../../.src/Utils/Crupt.module#L117)
- [ ] CRUPT-A03 — [anomalie] L. 101 : `If Not Error` teste un `Try` précédent (état périmé) · tests : T06 · sources : [Crupt.module:101](../../../../.src/Utils/Crupt.module#L101)
- [ ] CRUPT-A04 — [anomalie] L. 282 : division par `art_txconv` sans contrôle (0 → erreur) · tests : T07 · sources : [Crupt.module:282](../../../../.src/Utils/Crupt.module#L282)
- [ ] CRUPT-A05 — [anomalie] Tables `Rupture`/`RuptureC` partagées entre postes : deux éditions
  simultanées s'écrasent (correction = changement de schéma, voir architecture.md) · tests : T09 · sources : [Crupt.module:25-26](../../../../.src/Utils/Crupt.module#L25-L26), [Crupt.module:29](../../../../.src/Utils/Crupt.module#L29)
- [ ] CRUPT-A06 — [anomalie, à confirmer] (signal `sql_params`, ajouté après le lot Gestion-2) l. 83 :
  hors `EdRup`, la lecture des lignes de commande passe `four1` sans marqueur `&1` : toutes les
  commandes de tous les fournisseurs sont lues ; le filtre fournisseur ne vient qu'ensuite
  (`rarts!art_four = Four1`). Vérifier l'intention (filtre `WHERE four = &1` manquant) · tests : T09 · sources : [Crupt.module:83](../../../../.src/Utils/Crupt.module#L83), [Crupt.module:89-93](../../../../.src/Utils/Crupt.module#L89-L93)
