# Txmo — Rework

> Source : `.src/Gestion/Tables/Txmo.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Txmo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 356 |
| Lignes de commentaire | 43 |
| Fonctions | 21 |
| Fonctions Public | 21 |
| Complexité cyclomatique totale | 80 |
| Complexité max (fonction) | 14 (`Tmo_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 356 | 80 | 14 | 0 | 21 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TXMO-001 — [documentation] En-tête en français : table gérée, répercussion sur `Fiches_Mo`
  par `MajMo`, rôle des tags du groupe `Tmo`, pseudo-handlers (`*_LostFocus` jamais levés),
  colonne cachée `Item[4]` · appelants : aucun · tests : aucun · sources : [Txmo.class:_New](../../../../../.src/Gestion/Tables/Txmo.class#L36-L54), [Txmo.class:MajMo](../../../../../.src/Gestion/Tables/Txmo.class#L180-L194), [Txmo.class:Tmo_KeyPress](../../../../../.src/Gestion/Tables/Txmo.class#L406-L466)
- [ ] TXMO-002 — [code mort] Supprimer l'en-tête `' Gambas class file` dupliqué, le `Else` vide
  et l'appel commenté de `Form_Open`, les blocs `With Utils`/`With utils` inutiles (`MajMo`), la
  variable locale `TAB` de `Button4_Click` remplacée par le nom de table (voir TXMO-003) ·
  appelants : aucun · tests : T01-T05 · sources : [Txmo.class:1-3](../../../../../.src/Gestion/Tables/Txmo.class#L1-L3), [Txmo.class:Form_Open](../../../../../.src/Gestion/Tables/Txmo.class#L56-L74), [Txmo.class:MajMo](../../../../../.src/Gestion/Tables/Txmo.class#L180-L194), [Txmo.class:Button4_Click](../../../../../.src/Gestion/Tables/Txmo.class#L260-L289)
- [ ] TXMO-003 — [réarchitecture] `Cbase.Table("TabTxmo")` et `Cbase.Table("TabComptes")` à la
  place des noms en dur `Fiches_Txtmo`/`Fiches_Comptes` et des variables locales `Tab` (SQL
  identique) · appelants : aucun · tests : T01-T05 · sources : [Txmo.class:Button1_Click](../../../../../.src/Gestion/Tables/Txmo.class#L127-L178), [Txmo.class:Button3_Click](../../../../../.src/Gestion/Tables/Txmo.class#L235-L258), [Txmo.class:Button4_Click](../../../../../.src/Gestion/Tables/Txmo.class#L260-L289), [Txmo.class:compteGman](../../../../../.src/Gestion/Tables/Txmo.class#L471-L486)
- [ ] TXMO-004 — [séparation traitement/GUI] `Calc_MargeMo` → fonction pure `MargeMo(sTempMont,
  fMontant, fValeurHt, fTaux, fPrvt) As Float` (erreur → 0, comme le `Catch` actuel) ; `MajMo`
  lit `mo_tempmont`, `mo_montant`, `mo_valeurht` dans sa propre boucle et n'émet plus le `SELECT`
  par MO — SQL modifié, dump identique · appelants : aucun · tests : T02, T06 · sources : [Txmo.class:Calc_MargeMo](../../../../../.src/Gestion/Tables/Txmo.class#L196-L226), [Txmo.class:MajMo](../../../../../.src/Gestion/Tables/Txmo.class#L180-L194)
- [ ] TXMO-005 — [commonalisation] `MargeMo` partagée avec `Movr.Calc_MargeMo` (même formule,
  voir MOVR-006), après TXMO-T06 et MOVR-T08 verts sur des entrées identiques · appelants :
  `Movr` (même commit) · tests : T02, T06, MOVR-T01, MOVR-T08 · sources : [Txmo.class:Calc_MargeMo](../../../../../.src/Gestion/Tables/Txmo.class#L196-L226), [Movr.class:Calc_MargeMo](../../../../../.src/Gestion/Tables/Movr.class#L1423-L1451)
- [ ] TXMO-006 — [séparation traitement/GUI] `Button1_Click` : partie SQL dans
  `EnregistreTaux(sCode, sLibelle, sCompte, fTaux, fPrvt) As String` (UPdate/INSERT inchangés,
  renvoie la clé à resélectionner) ; le handler garde messages, `MajMo` et rafraîchissement ·
  appelants : aucun · tests : T01-T03 · sources : [Txmo.class:Button1_Click](../../../../../.src/Gestion/Tables/Txmo.class#L127-L178)
- [ ] TXMO-007 — [réduction de portée] `Refresh`, `Maj_Zones`, `Cleanchamps`, `MajMo`,
  `Calc_MargeMo` (ou `MargeMo` si elle reste dans le fichier et n'est pas partagée), `compteGman` →
  `Private` ; les pseudo-handlers gardent nom et portée · appelants : aucun · tests : T01-T05 · sources : [Txmo.class:Refresh](../../../../../.src/Gestion/Tables/Txmo.class#L76-L83), [Txmo.class:Maj_Zones](../../../../../.src/Gestion/Tables/Txmo.class#L85-L95), [Txmo.class:Cleanchamps](../../../../../.src/Gestion/Tables/Txmo.class#L97-L105), [Txmo.class:compteGman](../../../../../.src/Gestion/Tables/Txmo.class#L471-L486)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TXMO-A01 — [anomalie] `Button1_Click` : après le message « champs obligatoires » (code vide
  avec compte valide), le traitement continue : `MajMo` sur `mo_txcd = ""`, `Refresh`/`Cleanchamps`
  effacent la saisie, `MoveTo("")` · tests : T03 · sources : [Txmo.class:141](../../../../../.src/Gestion/Tables/Txmo.class#L141), [Txmo.class:145](../../../../../.src/Gestion/Tables/Txmo.class#L145), [Txmo.class:158](../../../../../.src/Gestion/Tables/Txmo.class#L158)
- [ ] TXMO-A02 — [anomalie] `Button3_Click` contrôle `CdTx.Text` mais supprime
  `Coltxmo.Current[0]` (ligne sélectionnée, erreur si aucune ligne n'est sélectionnée) ; même
  défaut que FTVAC-A02 · tests : T04 · sources : [Txmo.class:244](../../../../../.src/Gestion/Tables/Txmo.class#L244), [Txmo.class:250](../../../../../.src/Gestion/Tables/Txmo.class#L250)
- [ ] TXMO-A03 — [anomalie] Validation et formatage du taux, du compte et du prix de revient
  seulement au clavier : `txtmo_LostFocus`, `Prvt_LostFocus`, `codecompt_LostFocus` ne sont jamais
  levés (zones du groupe `Tmo`) ; une sortie à la souris enregistre une saisie non contrôlée
  (corriger = ajouter `Tmo_LostFocus`) · tests : T03 · sources : [Txmo.class:txtmo_LostFocus](../../../../../.src/Gestion/Tables/Txmo.class#L352-L375), [Txmo.class:Prvt_LostFocus](../../../../../.src/Gestion/Tables/Txmo.class#L377-L404), [Txmo.class:codecompt_LostFocus](../../../../../.src/Gestion/Tables/Txmo.class#L345-L350)
- [ ] TXMO-A04 — [anomalie, à confirmer métier] `MajMo` remplace le prix de revient propre de
  chaque MO (`mo_prvt`, saisi dans `Movr`) par celui du taux, et `Calc_MargeMo` lit la MO sans test
  `Available` · tests : T02 · sources : [Txmo.class:189](../../../../../.src/Gestion/Tables/Txmo.class#L189), [Txmo.class:205](../../../../../.src/Gestion/Tables/Txmo.class#L205)
