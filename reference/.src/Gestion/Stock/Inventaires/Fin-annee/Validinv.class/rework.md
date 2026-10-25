# Validinv — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 158 |
| Lignes de commentaire | 103 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 32 |
| Complexité max (fonction) | 20 (`Button2_click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 158 | 32 | 20 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VALIDINV-001 — [documentation] En-tête en français : les trois cas de mise à jour, rôle de
  `dteinv`/`art_stkdep`, effets sur `Fiches_HisInvT`, compta matière · appelants : aucun · tests :
  T01-T16 · sources : [Validinv.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L44-L218), [Validinv.class:button4_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L221-L271)
- [ ] VALIDINV-002 — [code mort] Supprimer les 72 lignes commentées (l. 86-158), les variables
  inutilisées (`Rqte`, `dte`, `Rbl`, `Ligbl`, `Tpe`, `res`, `i`, `finexo`, `qteAch`, `qteVtes`),
  le calcul neutre l. 159-168, et les blocs `If son Then Music.Play` (`son` jamais initialisé) ;
  `$soption` → local · appelants : aucun · tests : T01-T06 · sources : [Validinv.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L44-L218), [Validinv.class:159](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L159), [Validinv.class:27](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L27)
- [ ] VALIDINV-003 — [code mort] Supprimer le `SELECT dteinv` (l. 77) qui n'alimente que `finexo`
  inutilisé (SQL modifié, dump identique) · appelants : aucun · tests : T01 · sources : [Validinv.class:77](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L77)
- [ ] VALIDINV-004 — [complexité] Décision `QteFinale(bComptee, fQteC, bZero, fQteActuelle)` et un
  seul `UPDATE` paramétré ; lecture de `Fiches_Art` limitée au cas « laisser » (SQL modifié, dump
  identique) · appelants : aucun · tests : T01-T04, T11 · sources : [Validinv.class:169](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L169), [Validinv.class:171](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L171), [Validinv.class:177](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L177)
- [ ] VALIDINV-005 — [séparation traitement/GUI] `Valider(bZeroNonSaisis, dDate)` et
  `StockDepartRegie(dDate)` sans accès aux contrôles · appelants : aucun · tests : T01-T15 ·
  sources : [Validinv.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L44-L218), [Validinv.class:button4_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L221-L271)
- [ ] VALIDINV-006 — [commonalisation] Sauvegarde par `Utils.DumpBase` (SAUVESAUTO-003 /
  UTILS-014) avec la même ligne de commande ; partagé avec `ValidinvT` · appelants : aucun · tests :
  T16 · sources : [Validinv.class:66](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L66), [ValidinvT.class:71](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L71)
- [ ] VALIDINV-007 — [réarchitecture] `Cbase.Table("TabParam")`, `("TabInv")`, `("TabArt")` dans
  `button4_Click` au lieu des littéraux ; SQL identique · appelants : aucun · tests : T14, T15 ·
  sources : [Validinv.class:button4_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L221-L271)
- [ ] VALIDINV-008 — [commonalisation] Lecture des lignes d'inventaire par le module `Inventaire`
  (`Lignes("F")`), partagée avec `ValidinvT` (voir GENINV-006) · appelants : aucun · tests :
  T01-T06 · sources : [Validinv.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L44-L218), [ValidinvT.class:Button2_click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/ValidinvT.class#L37-L155)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VALIDINV-A01 — [anomalie] `Cstock.Calc_stock("", "")` ne recalcule rien (CSTOCK-A01 : radios
  de l'instance automatique de `Calcstock`) ; les mouvements postérieurs à `dteinv` ne sont pas
  réappliqués · tests : T07 · sources : [Validinv.class:190](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L190), [Cstock.module:28](../../../../../../../.src/Utils/Cstock.module#L28)
- [ ] VALIDINV-A02 — [anomalie] `son As String` jamais initialisé : aucun signal sonore, contrairement
  au paramétrage `Start.Son` des autres écrans · tests : aucun (non observable) · sources : [Validinv.class:27](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L27)
- [ ] VALIDINV-A03 — [anomalie, sécurité] `mysqldump` lancé avant la confirmation, mot de passe en
  clair dans la ligne de commande (visible par `ps`), arguments non échappés, sans port, résultat
  non contrôlé, inopérant en SQLite · tests : T05, T16 · sources : [Validinv.class:66](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L66)
- [ ] VALIDINV-A04 — [anomalie] Pas de transaction : une erreur en cours de boucle (ex. article
  supprimé, `rarts!art_qte` sans `Available`) laisse une validation partielle, `dteinv` non mis à
  jour · tests : T11 · sources : [Validinv.class:169](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L169), [Validinv.class:177](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L177)
- [ ] VALIDINV-A05 — [anomalie] `Fiches_Inv` ni supprimée ni marquée validée (le `.form` annonce sa
  suppression) : revalidation possible sans alerte, `Geninv` n'affiche jamais « validé » · tests :
  T10 · sources : [Validinv.class:187](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L187)
- [ ] VALIDINV-A06 — [anomalie] `Truncate table Fiches_HisInvT` non traduit pour SQLite : erreur
  non gérée en fin de traitement, après les mises à jour · tests : T12 · sources : [Validinv.class:193](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L193)
- [ ] VALIDINV-A07 — [anomalie, règle métier à confirmer] Le stock par dépôt (`Fiches_StkDepots`)
  n'est pas ajusté : après validation, le stock global ne correspond plus à la somme des dépôts ·
  tests : T13 · sources : [Validinv.class:171](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L171)
- [ ] VALIDINV-A08 — [anomalie, à confirmer] Quantités comptées à `inv_date` mais `dteinv` = date
  saisie à la validation : les mouvements entre les deux dates ne sont plus corrigés (code commenté)
  · tests : T08 · sources : [Validinv.class:188](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L188)
- [ ] VALIDINV-A09 — [anomalie, à confirmer] Compta matière : contrôle de clôture à `arrete + 13
  mois` mais création à `dtepec + 1 mois` ; transaction sans `Rollback` ; aucun message de fin ;
  erreur si `Fiches_Inv` absente · tests : T14, T15 · sources : [Validinv.class:231](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L231), [Validinv.class:239](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L239), [Validinv.class:269](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Validinv.class#L269)
