# ValidinvT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 122 |
| Lignes de commentaire | 28 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 23 (`Button2_click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 122 | 26 | 23 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VALIDINVT-001 — [documentation] En-tête en français : cas de mise à jour, écarts dans
  `Fiches_Mvtexp`, historique, articulation avec `Cstock` · appelants : aucun · tests : T01-T13 ·
  sources : [ValidinvT.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L37-L155)
- [ ] VALIDINVT-002 — [code mort] Supprimer `Tab1`, `Rdate` et son `SELECT * FROM
  Fiches_Parametres`, le `SELECT * FROM Fiches_Art` par ligne inutilisé (SQL modifié, dump
  identique), `qteAch`, `qteVtes`, `Tpe`, `dte`, et les blocs `If son Then Music.Play` (`son` jamais
  initialisé) · appelants : aucun · tests : T01-T07 · sources : [ValidinvT.class:91](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L91), [ValidinvT.class:105](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L105), [ValidinvT.class:27](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L27)
- [ ] VALIDINVT-003 — [complexité] Réindenter (l. 73-146), aplatir les `If`, extraire
  `Ecart(fQteC, fQteSt)` ; CC 23 → ≤ 10 visé · appelants : aucun · tests : T01-T07 · sources : [ValidinvT.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L37-L155)
- [ ] VALIDINVT-004 — [séparation traitement/GUI] `Valider(bZeroNonSaisis)` et `Historiser()` sans
  accès aux contrôles · appelants : aucun · tests : T01-T10 · sources : [ValidinvT.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L37-L155)
- [ ] VALIDINVT-005 — [réarchitecture] `Cbase.Table("TabArt")`, `("TabInvT")`, `("TabMvtexp")` au
  lieu des littéraux ; SQL identique · appelants : aucun · tests : T01 · sources : [ValidinvT.class:55](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L55), [ValidinvT.class:59](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L59)
- [ ] VALIDINVT-006 — [commonalisation] Sauvegarde par `Utils.DumpBase` **en conservant le nom de
  base `Laurux`** tant que VALIDINVT-A01 n'est pas validée ; module `Inventaire` (`Lignes`,
  `Supprimer`) partagé avec `Validinv` · appelants : aucun · tests : T01, T13 · sources : [ValidinvT.class:71](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L71), [Validinv.class:66](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L66)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VALIDINVT-A01 — [anomalie, sécurité] `mysqldump` de la base `Laurux` en dur (et non
  `Utils.db.Name`) : sauvegarde d'une autre base ou vide ; mêmes défauts que VALIDINV-A03 (mot de
  passe en clair, avant confirmation, résultat non contrôlé) · tests : T13 · sources : [ValidinvT.class:71](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L71)
- [ ] VALIDINVT-A02 — [anomalie, grave] Non comptés avec « Laisser la valeur d'origine » : stock
  conservé mais sortie exceptionnelle `qtem = inv_qtestock` écrite dans `Fiches_Mvtexp` ; au
  prochain recalcul (`Cstock`), ces articles, non historisés, perdent leur stock théorique ;
  `Stockmvt` affiche une sortie fictive · tests : T03, T09 · sources : [ValidinvT.class:98](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L98), [ValidinvT.class:117](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L117)
- [ ] VALIDINVT-A03 — [anomalie, à confirmer] Mouvements entre génération et comptage : inclus
  dans le comptage mais rajoutés par `Cstock` depuis `inv_date` (double comptage), alors que
  `art_qte` est écrasé immédiatement → stock différent avant et après recalcul · tests : T10 ·
  sources : [ValidinvT.class:107](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L107), [ValidinvT.class:117](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L117), [Cstock.module:46](../../../../../../../.src/Utils/Cstock.module#L46)
- [ ] VALIDINVT-A04 — [anomalie] Pas de transaction : validation interrompue = `inv_valid` partiel,
  `Fiches_Mvtexp` partiels ; le contrôle « déjà validé » ne lit que la 1re ligne · tests : T07 ·
  sources : [ValidinvT.class:75](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L75), [ValidinvT.class:114](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L114)
- [ ] VALIDINVT-A05 — [anomalie] Libellé de mouvement « Inentaire tournant du … » (faute de frappe
  enregistrée en base) · tests : T01 · sources : [ValidinvT.class:117](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L117)
- [ ] VALIDINVT-A06 — [anomalie] `son As String` jamais initialisé : aucun signal sonore · tests :
  aucun · sources : [ValidinvT.class:27](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L27)
- [ ] VALIDINVT-A07 — [anomalie, règle métier à confirmer] Stock par dépôt (`Fiches_StkDepots`) non
  ajusté (comme VALIDINV-A07) · tests : T12 · sources : [ValidinvT.class:107](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L107)
