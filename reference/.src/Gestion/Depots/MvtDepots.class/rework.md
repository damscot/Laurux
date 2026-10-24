# MvtDepots — Rework

> Source : `.src/Gestion/Depots/MvtDepots.class` · Message de commit (phase 4) : `reference/.src/Gestion/Depots/MvtDepots.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 409 |
| Lignes de commentaire | 23 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 103 |
| Complexité max (fonction) | 11 (`Dep_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 409 | 103 | 11 | 0 | 26 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MVTDEPOTS-001 — [documentation] En-tête (absent) : principe du transfert, tables mises à
  jour, rôle du dépôt `01`, double sens du drapeau `b`, défauts connus (A01-A05) · appelants :
  aucun · tests : aucun · sources : [MvtDepots.class:_new](../../../../../.src/Gestion/Depots/MvtDepots.class#L10-L38), [MvtDepots.class:Button3_Click](../../../../../.src/Gestion/Depots/MvtDepots.class#L331-L352)
- [ ] MVTDEPOTS-002 — [code mort] Supprimer `Button2_Click` (vide, aucun `Button2` dans le `.form`),
  la variable locale `Tab` de `ToggleButton1_Click`, le paramètre superflu du `DELETE` de
  `Maj_Qtearr` · appelants : aucun · tests : T01-T06 · sources : [MvtDepots.class:Button2_Click](../../../../../.src/Gestion/Depots/MvtDepots.class#L182-L184), [MvtDepots.class:194](../../../../../.src/Gestion/Depots/MvtDepots.class#L194), [MvtDepots.class:470](../../../../../.src/Gestion/Depots/MvtDepots.class#L470)
- [ ] MVTDEPOTS-003 — [séparation traitement/GUI] `TransfereArticle(sDep, sArr, sArt, fQte, sDate)`
  sans contrôle, regroupant `Maj_QteArt`, `Maj_Qtearr`, `Maj_Qtedep`, `Maj_Sdepots` (SQL identique,
  défauts conservés) · appelants : aucun · tests : T01, T02, T06 · sources : [MvtDepots.class:Maj_QteArt](../../../../../.src/Gestion/Depots/MvtDepots.class#L391-L416), [MvtDepots.class:Maj_Qtedep](../../../../../.src/Gestion/Depots/MvtDepots.class#L421-L448), [MvtDepots.class:Maj_Qtearr](../../../../../.src/Gestion/Depots/MvtDepots.class#L453-L478), [MvtDepots.class:Maj_Sdepots](../../../../../.src/Gestion/Depots/MvtDepots.class#L483-L493)
- [ ] MVTDEPOTS-004 — [commonalisation] Module `Depot` partagé avec Sdepots/ImpDepots/Depots
  (`aff_Depot`, `Cman`, liste du stock d'un dépôt, `Maj_Colrcp`) · appelants : aucun · tests :
  T01-T06, SDEPOTS-T01-T05 · sources : [MvtDepots.class:aff_Depot](../../../../../.src/Gestion/Depots/MvtDepots.class#L73-L87), [MvtDepots.class:Maj_Colrcp](../../../../../.src/Gestion/Depots/MvtDepots.class#L354-L386), [Sdepots.class:aff_Depot](../../../../../.src/Gestion/Depots/Sdepots.class#L65-L79), [Sdepots.class:Maj_Colrcp](../../../../../.src/Gestion/Depots/Sdepots.class#L335-L368)
- [ ] MVTDEPOTS-005 — [réduction de portée] `aff_Depot`, `Cman`, `art_man`, `Maj_Colrcp`,
  `Maj_QteArt`, `Maj_Qtedep`, `Maj_Qtearr`, `Maj_Sdepots`, `B` → `Private` ; `Bsel`/`Bval`,
  `Coldep_Click`, `Coldepa_Click` restent `Public` · appelants : aucun · tests : T01-T06 · sources : [MvtDepots.class:6](../../../../../.src/Gestion/Depots/MvtDepots.class#L6), [MvtDepots.class:Cman](../../../../../.src/Gestion/Depots/MvtDepots.class#L163-L178), [MvtDepots.class:art_man](../../../../../.src/Gestion/Depots/MvtDepots.class#L243-L295)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MVTDEPOTS-A01 — [anomalie] **Grave** : `Maj_Qtedep` exécute l'`UPDATE` puis un `DELETE`
  inconditionnel de la ligne de stock du dépôt de départ (le `If qtec > 0` est commenté, pas le
  `DELETE`) : tout transfert efface le stock restant du dépôt de départ ; pour le dépôt `01`, une
  ligne négative est créée puis supprimée au transfert suivant · tests : T01, T02 · sources : [MvtDepots.class:436](../../../../../.src/Gestion/Depots/MvtDepots.class#L436), [MvtDepots.class:438](../../../../../.src/Gestion/Depots/MvtDepots.class#L438), [MvtDepots.class:443](../../../../../.src/Gestion/Depots/MvtDepots.class#L443)
- [ ] MVTDEPOTS-A02 — [anomalie] `Cman` relit toujours `Code.Text` : le libellé affiché pour le
  dépôt d'arrivée est celui du départ · tests : T03 · sources : [MvtDepots.class:167](../../../../../.src/Gestion/Depots/MvtDepots.class#L167)
- [ ] MVTDEPOTS-A03 — [anomalie] `art_man` (dépôt `01`) : recherches par code-barres et référence
  centrale inatteignables (imbrication `If`/`Else` erronée) · tests : T05 · sources : [MvtDepots.class:250](../../../../../.src/Gestion/Depots/MvtDepots.class#L250), [MvtDepots.class:253](../../../../../.src/Gestion/Depots/MvtDepots.class#L253)
- [ ] MVTDEPOTS-A04 — [anomalie] Drapeau `b` à double sens : un article introuvable (`b` vrai)
  est transféré car `Maj_Colrcp` remet `b` à vrai ; dépôt d'arrivée et quantité non contrôlés ·
  tests : T04 · sources : [MvtDepots.class:274](../../../../../.src/Gestion/Depots/MvtDepots.class#L274), [MvtDepots.class:362](../../../../../.src/Gestion/Depots/MvtDepots.class#L362), [MvtDepots.class:335](../../../../../.src/Gestion/Depots/MvtDepots.class#L335)
- [ ] MVTDEPOTS-A05 — [anomalie] `db.Exec` (classe `DB`, connexion courante) au lieu de
  `Utils.db.Exec` : requête non journalisée et non traduite pour SQLite · tests : T01 (SQLite) ·
  sources : [MvtDepots.class:277](../../../../../.src/Gestion/Depots/MvtDepots.class#L277)
