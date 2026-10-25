# Caleditcmat — Rework

> Source : `.src/Gestion/option/Caleditcmat.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/Caleditcmat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 765 |
| Lignes de commentaire | 38 |
| Fonctions | 22 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 121 |
| Complexité max (fonction) | 35 (`Edit`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 765 | 121 | 35 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CALEDITCMAT-001 — [documentation] En-tête en français : comptabilité matières (pas le
  matériel), régimes, types de lignes `E/S/C/M/I`, cycle contrôle → édition → clôture, structures
  `Volume`/`Stk`/`Declaration`, rôle de `ddcl` ; renommer `ctrlachat` dans les commentaires (la
  fonction contrôle des BL de vente) · appelants : aucun · tests : T01-T10 · sources :
  [Caleditcmat.class:_new](../../../../../.src/Gestion/option/Caleditcmat.class#L31-L49), [Caleditcmat.class:ctrlachat](../../../../../.src/Gestion/option/Caleditcmat.class#L142-L169), [Caleditcmat.class:Edition_Click](../../../../../.src/Gestion/option/Caleditcmat.class#L223-L257)
- [ ] CALEDITCMAT-002 — [complexité] `Edit` (CC 35) : extraire `StockDebut`, `Entrees`, `Sorties`,
  `TotauxEtArrondis`, `ImprimeDeclaration` et `DeclarationRegie(tabl, code, res)` ; SQL et calculs
  identiques (CC max ≤ 10 visé) · appelants : aucun · tests : T03-T05, T07, T08 · sources :
  [Caleditcmat.class:Edit](../../../../../.src/Gestion/option/Caleditcmat.class#L272-L440)
- [ ] CALEDITCMAT-003 — [séparation traitement/GUI] `CalculDeclaration(debut, regime, clt,
  calcregie, nbdec, arrondi) As Collection` sans accès aux contrôles (`decim` reçoit `nbd`) ;
  `Edit` lit les contrôles et appelle le calcul · appelants : aucun · tests : T03, T04, T08, T14 ·
  sources : [Caleditcmat.class:Edit](../../../../../.src/Gestion/option/Caleditcmat.class#L272-L440), [Caleditcmat.class:decim](../../../../../.src/Gestion/option/Caleditcmat.class#L442-L456)
- [ ] CALEDITCMAT-004 — [séparation traitement/GUI] `ctrl`/`calcdate`/`ctrlachat` renvoient leurs
  messages (`String[]`) ; les handlers gèrent `Textcontrol`, ballons et `Busy` ; `Cloture(debut,
  regime, tabl)` isole l'`UPDATE` et les insertions `M` (même SQL, même ordre) · appelants :
  aucun · tests : T01, T02, T05, T06, T11 · sources : [Caleditcmat.class:ctrl](../../../../../.src/Gestion/option/Caleditcmat.class#L57-L139),
  [Caleditcmat.class:calcdate](../../../../../.src/Gestion/option/Caleditcmat.class#L172-L221), [Caleditcmat.class:Edition_Click](../../../../../.src/Gestion/option/Caleditcmat.class#L223-L257)
- [ ] CALEDITCMAT-005 — [réarchitecture] Supprimer `ddcl` après EINVMAT-002 et ECOMPTAMAT-002
  (variables locales dans les reports) · appelants : `Einvmat`, `Ecomptamat` (commits précédents) ·
  tests : T03, T04 · sources : [Caleditcmat.class:29](../../../../../.src/Gestion/option/Caleditcmat.class#L29), [Einvmat.class:vaehldp_Data](../../../../../.src/Gestion/option/Einvmat.class#L60-L65),
  [Ecomptamat.class:vaehldp_Data](../../../../../.src/Gestion/option/Ecomptamat.class#L72-L77)
- [ ] CALEDITCMAT-006 — [commonalisation] Fabrique de `ReportLabel` commune avec EditStkDepart
  (`dimention`) pour `entete`, `soustot`, `ligne` (~300 lignes) ; rendu identique · appelants :
  `EditStkDepart` (même commit, EDITSTKDEPART-005) · tests : T09, T10 · sources :
  [Caleditcmat.class:entete](../../../../../.src/Gestion/option/Caleditcmat.class#L592-L720), [Caleditcmat.class:ligne](../../../../../.src/Gestion/option/Caleditcmat.class#L783-L893), [Caleditcmat.class:soustot](../../../../../.src/Gestion/option/Caleditcmat.class#L732-L781),
  [EditStkDepart.class:dimention](../../../../../.src/Gestion/option/EditStkDepart.class#L170-L183)
- [ ] CALEDITCMAT-007 — [code mort] Supprimer la branche `Else` inatteignable des « mouvements non
  validés » de `detail_Click` (requête limitée à `'S'`), le bloc commenté des achats de `ctrl` et
  les variables inutilisées d'`Edit` (`resreg`, `restx`) et de `detail_Click` (`ccd`) ·
  appelants : aucun · tests : T01, T09 · sources : [Caleditcmat.class:571](../../../../../.src/Gestion/option/Caleditcmat.class#L571),
  [Caleditcmat.class:ctrl](../../../../../.src/Gestion/option/Caleditcmat.class#L57-L139), [Caleditcmat.class:Edit](../../../../../.src/Gestion/option/Caleditcmat.class#L272-L440), [Caleditcmat.class:detail_Click](../../../../../.src/Gestion/option/Caleditcmat.class#L476-L590)
- [ ] CALEDITCMAT-008 — [complexité] `detail_Click` (CC 13) : extraire `MouvementsRegie(code)` et
  `MouvementsNonValides(code)` du rendu · appelants : aucun · tests : T09 · sources :
  [Caleditcmat.class:detail_Click](../../../../../.src/Gestion/option/Caleditcmat.class#L476-L590)
- [ ] CALEDITCMAT-009 — [commonalisation] `RegieSuspendue(code)` commun avec atribvignette et
  calculdroit (voir ATRIBVIGNETTE-006) · appelants : `atribvignette`, `calculdroit` · tests : T01,
  T02 · sources : [Caleditcmat.class:ctrlachat](../../../../../.src/Gestion/option/Caleditcmat.class#L142-L169), [atribvignette.class:suspendu](../../../../../.src/Gestion/option/atribvignette.class#L82-L89)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CALEDITCMAT-A01 — [anomalie] `ctrl` sort par `Return True` après l'échec de `calcdate` sans
  `Application.Busy -= 1` : curseur d'attente persistant (Control, Edition, Rédition) · tests :
  T11 · sources : [Caleditcmat.class:66](../../../../../.src/Gestion/option/Caleditcmat.class#L66), [Caleditcmat.class:68](../../../../../.src/Gestion/option/Caleditcmat.class#L68)
- [ ] CALEDITCMAT-A02 — [anomalie] Date invalide en édition provisoire, Rédition ou Detail : le
  résultat de `ctrl`/`calcdate` est ignoré et la période précédemment calculée (`$dteinf`) est
  éditée · tests : T11 · sources : [Caleditcmat.class:Edition_Click](../../../../../.src/Gestion/option/Caleditcmat.class#L223-L257), [Caleditcmat.class:261](../../../../../.src/Gestion/option/Caleditcmat.class#L261),
  [Caleditcmat.class:488](../../../../../.src/Gestion/option/Caleditcmat.class#L488)
- [ ] CALEDITCMAT-A03 — [anomalie] `calcdate` : « Période précédente non cloturée » remplace les
  messages précédents (`=` au lieu de `&=`), et ce contrôle ne filtre pas le régime · tests : T06 ·
  sources : [Caleditcmat.class:217](../../../../../.src/Gestion/option/Caleditcmat.class#L217), [Caleditcmat.class:215](../../../../../.src/Gestion/option/Caleditcmat.class#L215)
- [ ] CALEDITCMAT-A04 — [anomalie] Clôture non atomique : l'`UPDATE cloture=True` est exécuté
  avant et hors de la transaction des lignes `M` ; un échec d'insertion laisse le mois clôturé
  sans stock reporté · tests : T05 · sources : [Caleditcmat.class:240](../../../../../.src/Gestion/option/Caleditcmat.class#L240), [Caleditcmat.class:242](../../../../../.src/Gestion/option/Caleditcmat.class#L242)
- [ ] CALEDITCMAT-A05 — [anomalie] Réédition : `New Ecomptamat(…, False)` en dur, alors que les
  lignes rééditées sont clôturées : la plage de vignettes imprimée est celle des lignes non
  clôturées (vide ou fausse) ; correction : passer `clt` · tests : T07 · sources :
  [Caleditcmat.class:427](../../../../../.src/Gestion/option/Caleditcmat.class#L427), [Ecomptamat.class:44](../../../../../.src/Gestion/option/Ecomptamat.class#L44)
- [ ] CALEDITCMAT-A06 — [anomalie] `UPDATE Fiches_ligregie,Fiches_regie …` (multi-tables) : syntaxe
  MySQL non traduite, la clôture échoue sous SQLite · tests : T12 · sources : [Caleditcmat.class:240](../../../../../.src/Gestion/option/Caleditcmat.class#L240)
- [ ] CALEDITCMAT-A07 — [anomalie] `detail_Click` : `rpr.Print` sur `Null` si `Fiches_regie` est
  vide (« Null object ») · tests : T13 · sources : [Caleditcmat.class:587](../../../../../.src/Gestion/option/Caleditcmat.class#L587)
- [ ] CALEDITCMAT-A08 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : la
  clôture n'est ni journalisée ni rejouable · tests : T01-T13 · sources : [Caleditcmat.class:_new](../../../../../.src/Gestion/option/Caleditcmat.class#L31-L49)
- [ ] CALEDITCMAT-A09 — [anomalie] Ligne `M` de clôture : `volumess` reçoit le volume SS des
  **sorties du mois** et non un stock (à confirmer avec la réglementation ; non relu par `Edit`) ·
  tests : T05 · sources : [Caleditcmat.class:Edition_Click](../../../../../.src/Gestion/option/Caleditcmat.class#L223-L257)
