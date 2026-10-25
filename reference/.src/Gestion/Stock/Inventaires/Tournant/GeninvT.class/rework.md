# GeninvT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 531 |
| Lignes de commentaire | 61 |
| Fonctions | 22 |
| Fonctions Public | 22 |
| Complexité cyclomatique totale | 110 |
| Complexité max (fonction) | 20 (`button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 531 | 110 | 20 | 0 | 22 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GENINVT-001 — [documentation] En-tête en français : critères et bornes par défaut,
  structure de `Fiches_InvT`, renumérotation à l'impression, place dans la chaîne tournante ·
  appelants : aucun · tests : T01-T14 · sources : [GeninvT.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L35-L52), [GeninvT.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L486-L573)
- [ ] GENINVT-002 — [code mort] Supprimer `CoulZns`, `Coulfond`, `Frmt` (lus, jamais utilisés), la
  valeur initiale `~/tmp/EdinvT.ps`, `Nbpage`, `Stktheorique`, `qtecomptee` (jamais affectée,
  remplacée par `""`), le `Shell "cd ~"` et les `With Utils` inutiles ; `tri` devient local ·
  appelants : aucun · tests : T01, T10 · sources : [GeninvT.class:_New](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L35-L52), [GeninvT.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L575-L666), [GeninvT.class:608](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L608)
- [ ] GENINVT-003 — [commonalisation] Helpers privés `Liste_Affiche(hCol, sTable, sCode, sLibelle)`
  et `Liste_Touche(…)` pour les 4 `ToggleButtonN_Click` et les 4 `<Col>_KeyPress`, et
  `Critere_Active(sCritere)` pour `Fm/Fr/Cs_Click` (appel à `Utils.Observers` conservé à
  l'identique) ; handlers conservés (noms et `Public`) · appelants : aucun · tests : T12, T13 ·
  sources : [GeninvT.class:ToggleButton1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L174-L209), [GeninvT.class:ToggleButton4_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L372-L407), [GeninvT.class:Colfam_KeyPress](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L214-L235), [GeninvT.class:Fm_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L105-L125), [GeninvT.class:Cs_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L149-L169)
- [ ] GENINVT-004 — [complexité] `gen_Inv` : clause de critère et `ORDER BY` par listes blanches,
  un seul `SELECT` (texte SQL identique pour chaque cas) ; CC 16 → ≤ 6 visé ; `button1_Click`
  (CC 20) : condition de bornes extraite dans `BornesSaisies() As Boolean` · appelants : aucun ·
  tests : T01-T05, T09 · sources : [GeninvT.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L486-L573), [GeninvT.class:button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L65-L103)
- [ ] GENINVT-005 — [séparation traitement/GUI] `Generer(sCritere, sInf, sSup, sOrdre, sDate)` et
  `Renumeroter(sTri)` sans accès aux contrôles · appelants : aucun · tests : T01-T11 · sources : [GeninvT.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L486-L573), [GeninvT.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L575-L666)
- [ ] GENINVT-006 — [commonalisation] Utiliser le module `Inventaire` (GENINV-006) : `Supprimer`,
  `Creer("T")`, `Generer`, `Libelle` ; SQL identique · appelants : aucun · tests : T01-T14 ·
  sources : [GeninvT.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L486-L573), [Geninv.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class#L77-L153)
- [ ] GENINVT-007 — [réarchitecture] `Cbase.Table("TabInvT")`, `("TabFam")`, `("TabFour")` au lieu
  des littéraux ; SQL identique · appelants : aucun · tests : T01, T12 · sources : [GeninvT.class:button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L65-L103), [GeninvT.class:ToggleButton1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L174-L209), [GeninvT.class:ToggleButton3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L306-L341), [GeninvT.class:Button3_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L575-L666)
- [ ] GENINVT-008 — [réduction de portée] `gen_Inv` → `Private` (aucun appelant externe ; les
  handlers `Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click` restent `Public`,
  appel dynamique du rejeu) · appelants : aucun · tests : T01-T09 · sources : [GeninvT.class:gen_Inv](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L486-L573)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] GENINVT-A01 — [anomalie] L'impression **renumérote `inv_nlig`** en base selon le tri choisi :
  réimprimer avec un autre tri après le début du comptage rend les feuilles déjà distribuées
  incohérentes avec la saisie par n° de ligne de `SaisieInvT` · tests : T10 · sources : [GeninvT.class:614](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L614), [GeninvT.class:618](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L618)
- [ ] GENINVT-A02 — [anomalie] Flux par exception : table absente → erreur SQL puis `gen_Inv`
  dans le `Catch` ; une erreur dans `gen_Inv` après confirmation relance la génération · tests :
  T08 · sources : [GeninvT.class:100](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L100), [GeninvT.class:101](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L101)
- [ ] GENINVT-A03 — [anomalie] Tri : quand « Code article » n'est pas coché, le tri choisi
  (Désignation/Casier) est ignoré à la génération (ordre `critère, art_design`) mais appliqué à
  l'impression ; `art_qte` Null non traité (`= ""` seulement, contrairement à `Geninv`) · tests :
  T01, T03, T04 · sources : [GeninvT.class:534](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L534), [GeninvT.class:551](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L551)
- [ ] GENINVT-A04 — [anomalie] `Fm_Click`, `Fr_Click`, `Cs_Click` rappellent `Utils.Observers(Me)`
  à chaque clic : cumul d'observateurs (événements journalisés/rejoués plusieurs fois) · tests :
  T13 · sources : [GeninvT.class:107](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L107), [GeninvT.class:129](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L129), [GeninvT.class:151](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L151)
- [ ] GENINVT-A05 — [anomalie] Focus après les listes : `Colfour2_Click` place le focus sur
  « Quitter » (Entrée ferme l'écran), `Colfam2_Click` sur `four` (lecture seule en mode famille),
  `Colfam2_KeyPress` focalise `fam` mais sélectionne `fam2` · tests : T12 · sources : [GeninvT.class:482](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L482), [GeninvT.class:456](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L456), [GeninvT.class:297](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class#L297)
