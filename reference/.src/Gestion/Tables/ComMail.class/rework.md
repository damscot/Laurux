# ComMail — Rework

> Source : `.src/Gestion/Tables/ComMail.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/ComMail.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 130 |
| Lignes de commentaire | 28 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 7 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 130 | 36 | 7 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COMMAIL-001 — [documentation] En-tête corrigé (« Comment.class » → ComMail), description des
  deux modes (`Org` = `""` / `"F"`), contrat `Variables.sTexte` avec `FClient` et `ObjFacB` ·
  appelants : aucun · tests : aucun · sources : [ComMail.class:21](../../../../../.src/Gestion/Tables/ComMail.class#L21), [ComMail.class:_New](../../../../../.src/Gestion/Tables/ComMail.class#L30-L44)
- [ ] COMMAIL-002 — [code mort] Supprimer `Button3_Click` (handler inactif, bouton groupé `Btn`),
  la variable `Public stexte` inutilisée, la branche `Case 2` inatteignable de `Lib_KeyPress` et le
  bloc commenté `Lib_LostFocus` · appelants : aucun · tests : T01-T05 · sources : [ComMail.class:Button3_Click](../../../../../.src/Gestion/Tables/ComMail.class#L205-L209), [ComMail.class:27](../../../../../.src/Gestion/Tables/ComMail.class#L27), [ComMail.class:Lib_KeyPress](../../../../../.src/Gestion/Tables/ComMail.class#L93-L116)
- [ ] COMMAIL-003 — [complexité] Mode « choix » mémorisé dans un booléen privé au lieu du test sur
  `Button2.Text` ; `Update … SET intitule = &2 WHERE numcom = &1` (SQL modifié, dump identique) ·
  appelants : aucun · tests : T02, T04 · sources : [ComMail.class:Form_Open](../../../../../.src/Gestion/Tables/ComMail.class#L46-L65), [ComMail.class:Button2_Click](../../../../../.src/Gestion/Tables/ComMail.class#L175-L203)
- [ ] COMMAIL-004 — [commonalisation] Module partagé avec Comment (voir COMMENT-005) · appelants :
  aucun · tests : T01-T05 · sources : [ComMail.class:Form_Open](../../../../../.src/Gestion/Tables/ComMail.class#L46-L65), [ComMail.class:Maj_Zones](../../../../../.src/Gestion/Tables/ComMail.class#L67-L77), [ComMail.class:Button1_Click](../../../../../.src/Gestion/Tables/ComMail.class#L163-L173), [ComMail.class:Button2_Click](../../../../../.src/Gestion/Tables/ComMail.class#L175-L203)
- [ ] COMMAIL-005 — [séparation traitement/GUI] `EnregistreTexte`, `SupprimeTexte`, `LitTexte`
  sans contrôle (si le module partagé n'est pas retenu) · appelants : aucun · tests : T01-T03 ·
  sources : [ComMail.class:Button1_Click](../../../../../.src/Gestion/Tables/ComMail.class#L163-L173), [ComMail.class:Button2_Click](../../../../../.src/Gestion/Tables/ComMail.class#L175-L203)
- [ ] COMMAIL-006 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`,
  `Button2_Click`, `Button4_Click` → `Private` ; `colcol_Click` reste `Public` (rejeu) ·
  appelants : aucun · tests : T01-T05 · sources : [ComMail.class:Maj_Zones](../../../../../.src/Gestion/Tables/ComMail.class#L67-L77), [ComMail.class:CleanChamps](../../../../../.src/Gestion/Tables/ComMail.class#L79-L84), [ComMail.class:Refresh](../../../../../.src/Gestion/Tables/ComMail.class#L86-L91), [ComMail.class:Button4_Click](../../../../../.src/Gestion/Tables/ComMail.class#L211-L215)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] COMMAIL-A01 — [anomalie] Suppression de `colcol.Current[0]` sans confirmation du code saisi
  ni test de sélection (erreur `Null`) · tests : T03 · sources : [ComMail.class:167](../../../../../.src/Gestion/Tables/ComMail.class#L167)
- [ ] COMMAIL-A02 — [anomalie] Enregistrement d'un code existant saisi sans sélection :
  `Colcol.Current.Key` lève une erreur après l'UPDATE ; `Maj_Zones` sans test `Available` ·
  tests : T02 · sources : [ComMail.class:190](../../../../../.src/Gestion/Tables/ComMail.class#L190), [ComMail.class:73](../../../../../.src/Gestion/Tables/ComMail.class#L73)
- [ ] COMMAIL-A03 — [anomalie] Aide : ouvre la page `Commentaires` (écran Comment) ; texte altéré
  par `Utils.ReplaceLb` à l'enregistrement mais pas au choix · tests : T01, T04 · sources : [ComMail.class:213](../../../../../.src/Gestion/Tables/ComMail.class#L213), [ComMail.class:182](../../../../../.src/Gestion/Tables/ComMail.class#L182)
