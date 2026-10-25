# Sms — Rework

> Source : `.src/Gestion/SMS/Sms.class` · Message de commit (phase 4) : `reference/.src/Gestion/SMS/Sms.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 128 |
| Lignes de commentaire | 22 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 36 |
| Complexité max (fonction) | 8 (`Form_Open`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 128 | 36 | 8 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SMS-001 — [documentation] En-tête corrigé (« Comment.class » → Sms, textes SMS prédéfinis
  utilisés par `Gsm`), rôle des boutons groupés et de leurs tags · appelants : aucun ·
  tests : aucun · sources : [Sms.class:21-24](../../../../../.src/Gestion/SMS/Sms.class#L21-L24), [Sms.class:Btn_Click](../../../../../.src/Gestion/SMS/Sms.class#L132-L150)
- [ ] SMS-002 — [code mort] Supprimer `Button3_Click` (handler inactif, bouton groupé `Btn`) et
  la branche `Case 2` inatteignable de `Lib_KeyPress` (`Intitule` hors du groupe `Lib`) ·
  appelants : aucun · tests : T01-T06 · sources : [Sms.class:Button3_Click](../../../../../.src/Gestion/SMS/Sms.class#L194-L198), [Sms.class:Lib_KeyPress](../../../../../.src/Gestion/SMS/Sms.class#L96-L119)
- [ ] SMS-003 — [complexité] `Update … SET intitule = &2 WHERE numcom = &1` sans réaffecter la clé
  (SQL modifié, dump identique) · appelants : aucun · tests : T02 · sources : [Sms.class:182](../../../../../.src/Gestion/SMS/Sms.class#L182)
- [ ] SMS-004 — [commonalisation] Module partagé code/texte avec `ComMail` et `Comment` (voir
  COMMENT-005, COMMAIL-004), table passée en paramètre (`TabSms`) ; helper de lecture de la
  première ligne réutilisé par `Gsm` · appelants : aucun · tests : T01-T05, COMMAIL-T01-T05,
  GSM-T02 · sources : [Sms.class:Form_Open](../../../../../.src/Gestion/SMS/Sms.class#L44-L68), [Sms.class:Maj_Zones](../../../../../.src/Gestion/SMS/Sms.class#L70-L80), [Sms.class:Button2_Click](../../../../../.src/Gestion/SMS/Sms.class#L170-L192), [ComMail.class:Button2_Click](../../../../../.src/Gestion/Tables/ComMail.class#L175-L203), [Gsm.class:ToggleButton4_Click](../../../../../.src/Gestion/SMS/Gsm.class#L80-L132)
- [ ] SMS-005 — [séparation traitement/GUI] `EnregistreTexte`, `SupprimeTexte`, `LitTexte` sans
  contrôles (si le module partagé n'est pas retenu) · appelants : aucun · tests : T02-T04 ·
  sources : [Sms.class:Button1_Click](../../../../../.src/Gestion/SMS/Sms.class#L158-L168), [Sms.class:Button2_Click](../../../../../.src/Gestion/SMS/Sms.class#L170-L192)
- [ ] SMS-006 — [réduction de portée] `Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`,
  `Button2_Click`, `Button4_Click` → `Private` ; `colcol_Click` reste `Public` (rejeu) ·
  appelants : aucun · tests : T01-T06 · sources : [Sms.class:Maj_Zones](../../../../../.src/Gestion/SMS/Sms.class#L70-L80), [Sms.class:CleanChamps](../../../../../.src/Gestion/SMS/Sms.class#L82-L87), [Sms.class:Refresh](../../../../../.src/Gestion/SMS/Sms.class#L89-L94), [Sms.class:Button1_Click](../../../../../.src/Gestion/SMS/Sms.class#L158-L168), [Sms.class:Button2_Click](../../../../../.src/Gestion/SMS/Sms.class#L170-L192), [Sms.class:Button4_Click](../../../../../.src/Gestion/SMS/Sms.class#L200-L204)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SMS-A01 — [anomalie] Suppression de `colcol.Current[0]` (ligne sélectionnée) et non du code
  saisi, erreur `Null` sans sélection (même défaut que COMMAIL-A01) · tests : T04 ·
  sources : [Sms.class:162](../../../../../.src/Gestion/SMS/Sms.class#L162)
- [ ] SMS-A02 — [anomalie] Code existant saisi sans sélection : `Colcol.Current.Key` lève une
  erreur après l'UPDATE ; `Maj_Zones` lit le résultat sans test `Available` (même défaut que
  COMMAIL-A02) · tests : T03 · sources : [Sms.class:183](../../../../../.src/Gestion/SMS/Sms.class#L183), [Sms.class:76](../../../../../.src/Gestion/SMS/Sms.class#L76)
- [ ] SMS-A03 — [anomalie] `Btn_KeyPress` : toute touche sur le bouton Enregistrer enregistre ·
  tests : T06 · sources : [Sms.class:Btn_KeyPress](../../../../../.src/Gestion/SMS/Sms.class#L121-L130)
