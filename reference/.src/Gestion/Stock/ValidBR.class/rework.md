# ValidBR — Rework

> Source : `.src/Gestion/Stock/ValidBR.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/ValidBR.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1079 |
| Lignes de commentaire | 80 |
| Fonctions | 34 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 231 |
| Complexité max (fonction) | 40 (`Gen_ecr`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1079 | 231 | 40 | 0 | 32 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Le fichier étant inaccessible (A01), seuls des reworks sans risque sont proposés ; ils deviennent
sans objet si la suppression est validée.

- [ ] VALIDBR-001 — [documentation] En-tête : écran **remplacé par `ValidBR1`** depuis le commit
  `a06ada7a`, plus aucun point d'entrée, tables de travail utilisées · appelants : aucun · tests :
  T01 · sources : [ValidBR.class:_New](../../../../../.src/Gestion/Stock/ValidBR.class#L89-L145)
- [ ] VALIDBR-002 — [code mort] Supprimer `Quittedate`, `FileFilter`, `Bl_Sup` (colonnes
  inexistantes), `ard` (copie de `Facturergbl.ard`) et `Button16_Click` (aucun `Button16`) ·
  appelants : aucun · tests : T01 · sources : [ValidBR.class:Quittedate](../../../../../.src/Gestion/Stock/ValidBR.class#L401-L452), [ValidBR.class:FileFilter](../../../../../.src/Gestion/Stock/ValidBR.class#L765-L772), [ValidBR.class:Bl_Sup](../../../../../.src/Gestion/Stock/ValidBR.class#L1138-L1148), [ValidBR.class:ard](../../../../../.src/Gestion/Stock/ValidBR.class#L1176-L1213), [ValidBR.class:Button16_Click](../../../../../.src/Gestion/Stock/ValidBR.class#L1215-L1219), [Facturergbl.class:ard](../../../../../.src/Gestion/Facturation/Facturergbl.class#L1364-L1401)
- [ ] VALIDBR-003 — [réduction de portée] `recup_bl`, `Gen_ecr`, `Parametres`, `Ventilation`,
  `Raz_Ventilation`, `Maj_Totalisation`, `Verif_solde`, `Maj_Compta`, `Ecritures`, `Majnum` →
  `Private` (aucun appelant externe ; `Colbl_Click` et les handlers restent `Public`) · appelants :
  aucun · tests : T01 · sources : [ValidBR.class:recup_bl](../../../../../.src/Gestion/Stock/ValidBR.class#L150-L268), [ValidBR.class:Gen_ecr](../../../../../.src/Gestion/Stock/ValidBR.class#L553-L763), [ValidBR.class:Maj_Compta](../../../../../.src/Gestion/Stock/ValidBR.class#L959-L1099)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VALIDBR-A01 — [anomalie] Couple `ValidBR.class` + `ValidBR.form` mort (aucun appelant
  depuis le commit `a06ada7a`, remplacé par `ValidBR1`) : suppression proposée, avec la branche
  `Org == "ValidBR"` d'`Edbr.Ed` et les mentions dans les docs `LVar`/`LGed` · tests : T01 ·
  sources : [ValidBR.class:_New](../../../../../.src/Gestion/Stock/ValidBR.class#L89-L145), [Edbr.module:216](../../../../../.src/Gestion/Impressions/Edbr.module#L216)
- [ ] VALIDBR-A02 — [anomalie] (si conservé) Tags GED lus par `"… WHERE fo_code = " & CCli` et
  libellé par `LIKE '" & CodeFour.Text & "%'` (concaténations sans `&N`) ; tables de travail
  `BRfm`/`Br`/`Totalisation` recréées par chaque poste (collision multi-poste) · tests : T03 ·
  sources : [ValidBR.class:724](../../../../../.src/Gestion/Stock/ValidBR.class#L724), [ValidBR.class:479](../../../../../.src/Gestion/Stock/ValidBR.class#L479), [ValidBR.class:recup_bl](../../../../../.src/Gestion/Stock/ValidBR.class#L150-L268)
