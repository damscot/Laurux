# atribvignette — Rework

> Source : `.src/Gestion/option/atribvignette.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/atribvignette.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 137 |
| Lignes de commentaire | 1 |
| Fonctions | 9 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 12 (`affiche`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 137 | 37 | 12 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ATRIBVIGNETTE-001 — [documentation] En-tête en français : rôle (vignettes de la
  comptabilité matières, régime suspendu), tables, format sur 25 chiffres, structure des clés de
  nœuds `num/bl/vignette`, convention « Mise à blanc » · appelants : aucun · tests : T01-T05 ·
  sources : [atribvignette.class:_new](../../../../../.src/Gestion/option/atribvignette.class#L6-L13), [atribvignette.class:Modif](../../../../../.src/Gestion/option/atribvignette.class#L91-L113)
- [ ] ATRIBVIGNETTE-002 — [complexité] `affiche` : extraire `LibelleDocument(num, type) As String`
  (constante au lieu des trois `SELECT 'mouvements exceptionnels'` : SQL modifié, dump identique)
  et `AjouteLignes(num)` ; même comportement pour les types non `S`/`E` (CC 12 → ≤ 5 visé) ·
  appelants : aucun · tests : T01, T07 · sources : [atribvignette.class:affiche](../../../../../.src/Gestion/option/atribvignette.class#L15-L58)
- [ ] ATRIBVIGNETTE-003 — [séparation traitement/GUI] `VignettesManquantes() As String[]` (calcul
  identique, `Float` compris), `AttribueVignette(num, bl, vignette)` et
  `VignetteExiste(vignette) As Boolean`, sans accès aux contrôles ; SQL identique · appelants :
  aucun · tests : T01-T05, T08 · sources : [atribvignette.class:manquant](../../../../../.src/Gestion/option/atribvignette.class#L60-L80), [atribvignette.class:Modif](../../../../../.src/Gestion/option/atribvignette.class#L91-L113),
  [atribvignette.class:Textvig_LostFocus](../../../../../.src/Gestion/option/atribvignette.class#L129-L154)
- [ ] ATRIBVIGNETTE-004 — [code mort] Supprimer le test `If Not txt Then Return` (toujours faux)
  dans `Modif` · appelants : aucun · tests : T02, T03, T05 · sources : [atribvignette.class:Modif](../../../../../.src/Gestion/option/atribvignette.class#L91-L113)
- [ ] ATRIBVIGNETTE-005 — [réarchitecture] `Cbase.Table` pour `Fiches_Bl` (`TabBl`),
  `Fiches_HistoFac` (`TabHisFac`), `Fiches_Entrecpt` (`TabEntrecpt`), `Fiches_Four` (`TabFour`),
  SQL identique · appelants : aucun · tests : T01 · sources : [atribvignette.class:affiche](../../../../../.src/Gestion/option/atribvignette.class#L15-L58)
- [ ] ATRIBVIGNETTE-006 — [commonalisation] `RegieSuspendue(code)` commun avec `Caleditcmat`
  (`ctrlachat`) et `calculdroit.suspendu`, et `FormatVignette(n)` commun avec `ObjFacB`/`Mvtex` ·
  appelants : `Caleditcmat`, `ObjFacB`, `Mvtex` (même commit) · tests : T01-T05 ; tests de
  Caleditcmat · sources : [atribvignette.class:suspendu](../../../../../.src/Gestion/option/atribvignette.class#L82-L89), [atribvignette.class:Textvig_LostFocus](../../../../../.src/Gestion/option/atribvignette.class#L129-L154),
  [Caleditcmat.class:ctrlachat](../../../../../.src/Gestion/option/Caleditcmat.class#L142-L169)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ATRIBVIGNETTE-A01 — [anomalie] Document de type autre que `S`/`E` (ex. `C`) : `res` non
  réaffecté → « Null object » au premier document ou libellé du document précédent ; de même,
  la branche « réception » lit `resbl!vignette` sans tester `Available` · tests : T07 · sources :
  [atribvignette.class:43](../../../../../.src/Gestion/option/atribvignette.class#L43), [atribvignette.class:52](../../../../../.src/Gestion/option/atribvignette.class#L52)
- [ ] ATRIBVIGNETTE-A02 — [anomalie] `Modif` (branche BL) : `UPDATE … WHERE num=&2 AND numlig
  LIKE &3` sans `cloture=False` ni `type='S'` : réécrit aussi la vignette de lignes déjà
  clôturées (déjà déclarées) ou d'entrées de même numéro · tests : T06 · sources : [atribvignette.class:99](../../../../../.src/Gestion/option/atribvignette.class#L99)
- [ ] ATRIBVIGNETTE-A03 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : les
  attributions de vignettes ne sont ni journalisées ni rejouables · tests : T01-T07 · sources :
  [atribvignette.class:_new](../../../../../.src/Gestion/option/atribvignette.class#L6-L13)
- [ ] ATRIBVIGNETTE-A04 — [anomalie] `manquant` calcule en `Float` sur des numéros de 25 chiffres :
  liste fausse au-delà de 2^53 et boucle non bornée sur un grand trou · tests : T08 · sources :
  [atribvignette.class:69](../../../../../.src/Gestion/option/atribvignette.class#L69), [atribvignette.class:72](../../../../../.src/Gestion/option/atribvignette.class#L72)
- [ ] ATRIBVIGNETTE-A05 — [anomalie] Collision de numéros : un même `num` présent en sortie (`S`)
  et en entrée (`E`) n'est affiché qu'une fois (`TreeView1.Exist`) ; le second document est
  inaccessible (à confirmer selon la numérotation réelle des BL et des réceptions) · tests : T01 ·
  sources : [atribvignette.class:26](../../../../../.src/Gestion/option/atribvignette.class#L26)
