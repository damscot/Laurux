# Comment — Rework

> Source : `.src/Gestion/Tables/Comment.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Comment.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 125 |
| Lignes de commentaire | 28 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 34 |
| Complexité max (fonction) | 7 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 125 | 34 | 7 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COMMENT-001 — [documentation] En-tête : rôle, appel depuis `Facture` (F4), effet de
  `Utils.ReplaceLb`, affichage de la seule première ligne dans la liste · appelants : aucun ·
  tests : aucun · sources : [Comment.class:20](../../../../../.src/Gestion/Tables/Comment.class#L20), [Comment.class:Form_Open](../../../../../.src/Gestion/Tables/Comment.class#L43-L61)
- [ ] COMMENT-002 — [code mort] Supprimer `Button3_Click` (handler inactif, `Button3` groupé dans
  `Btn`) et la branche `Case 2` inatteignable de `Lib_KeyPress` (`Intitule` hors groupe `Lib`) ;
  supprimer le bloc `Lib_LostFocus` commenté · appelants : aucun · tests : T01-T04 · sources : [Comment.class:Button3_Click](../../../../../.src/Gestion/Tables/Comment.class#L200-L204), [Comment.class:Lib_KeyPress](../../../../../.src/Gestion/Tables/Comment.class#L89-L112)
- [ ] COMMENT-003 — [réarchitecture] `Cbase.Table("TabCom")` pour `DELETE`/`INSERT`/`UPDATE` au
  lieu de `Fiches_Commentaires` en dur (SQL identique) · appelants : aucun · tests : T01-T04 ·
  sources : [Comment.class:Button1_Click](../../../../../.src/Gestion/Tables/Comment.class#L159-L172), [Comment.class:Button2_Click](../../../../../.src/Gestion/Tables/Comment.class#L174-L198)
- [ ] COMMENT-004 — [complexité] `Update … SET intitule = &2 WHERE numcom = &1` ; SQL modifié,
  dump identique · appelants : aucun · tests : T02 · sources : [Comment.class:188](../../../../../.src/Gestion/Tables/Comment.class#L188)
- [ ] COMMENT-005 — [commonalisation] Module partagé avec ComMail (`Charger`, `Lire`,
  `Enregistrer`, `Supprimer` pour une table code/texte) ; réutilisable par `Facture.class:7739` ·
  appelants : aucun · tests : T01-T05, COMMAIL-T01-T05 · sources : [Comment.class:Form_Open](../../../../../.src/Gestion/Tables/Comment.class#L43-L61), [Comment.class:Button2_Click](../../../../../.src/Gestion/Tables/Comment.class#L174-L198), [ComMail.class:Form_Open](../../../../../.src/Gestion/Tables/ComMail.class#L46-L65), [ComMail.class:Button2_Click](../../../../../.src/Gestion/Tables/ComMail.class#L175-L203)
- [ ] COMMENT-006 — [séparation traitement/GUI] `EnregistreCommentaire`, `SupprimeCommentaire`,
  `LitCommentaire` sans contrôle (si le module partagé n'est pas retenu) · appelants : aucun ·
  tests : T01-T04 · sources : [Comment.class:Maj_Zones](../../../../../.src/Gestion/Tables/Comment.class#L63-L73), [Comment.class:Button1_Click](../../../../../.src/Gestion/Tables/Comment.class#L159-L172), [Comment.class:Button2_Click](../../../../../.src/Gestion/Tables/Comment.class#L174-L198)
- [ ] COMMENT-007 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`,
  `Button2_Click`, `Button4_Click` → `Private` (appels internes seulement) ; `colcol_Click` reste
  `Public` (rejeu) · appelants : aucun · tests : T01-T05 · sources : [Comment.class:Maj_Zones](../../../../../.src/Gestion/Tables/Comment.class#L63-L73), [Comment.class:CleanChamps](../../../../../.src/Gestion/Tables/Comment.class#L75-L80), [Comment.class:Refresh](../../../../../.src/Gestion/Tables/Comment.class#L82-L87), [Comment.class:Button4_Click](../../../../../.src/Gestion/Tables/Comment.class#L206-L210)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] COMMENT-A01 — [anomalie] Suppression de `colcol.Current[0]` (ligne sélectionnée) alors que
  le test porte sur le code saisi ; erreur sans sélection · tests : T04 · sources : [Comment.class:166](../../../../../.src/Gestion/Tables/Comment.class#L166)
- [ ] COMMENT-A02 — [anomalie] Enregistrement d'un code existant saisi sans sélection : l'UPDATE
  est fait puis `Colcol.Current.Key` lève une erreur (`Null`) ; `Maj_Zones` lit le résultat sans
  test `Available` · tests : T03 · sources : [Comment.class:189](../../../../../.src/Gestion/Tables/Comment.class#L189), [Comment.class:69](../../../../../.src/Gestion/Tables/Comment.class#L69)
- [ ] COMMENT-A03 — [anomalie] `Utils.ReplaceLb` altère le texte saisi (`"` → `''`, `&` → `et`)
  alors que le SQL est paramétré · tests : T01 · sources : [Comment.class:181](../../../../../.src/Gestion/Tables/Comment.class#L181)
