# Movr — Rework

> Source : `.src/Gestion/Tables/Movr.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Movr.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1271 |
| Lignes de commentaire | 91 |
| Fonctions | 70 |
| Fonctions Public | 70 |
| Complexité cyclomatique totale | 323 |
| Complexité max (fonction) | 35 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1271 | 323 | 35 | 0 | 70 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MOVR-001 — [documentation] En-tête en français : modèle temps/forfait, tables liées,
  tags du groupe `Cmpt` (dont les tags partagés 6 et 8), pseudo-handlers, rôle de `Gridvi` ·
  appelants : aucun · tests : aucun · sources : [Movr.class:_New](../../../../../.src/Gestion/Tables/Movr.class#L50-L74), [Movr.class:Cmpt_KeyPress](../../../../../.src/Gestion/Tables/Movr.class#L297-L451), [Movr.class:Button4_Click](../../../../../.src/Gestion/Tables/Movr.class#L1456-L1502)
- [ ] MOVR-002 — [code mort] Supprimer `Txht_LostFocus` (contrôle en lecture seule et groupé),
  `Valeur2TTC_LF` (jamais appelée), la branche `Case 10` de `Cmpt_Lostfocus` (aucun tag 10), le
  test `Échap` inaccessible du second bloc F2 de `Cmpt_KeyPress`, le `SELECT * FROM Fiches_Four`
  inutile de `ToggleButton1_Click` (SQL modifié, dump identique), les membres `CoulZnaf`,
  `Coulfc` (écrits, jamais relus) ; `montante` devient locale de `TvaMan` ; le membre `rResult`
  devient locale de `fourMan` · appelants : aucun · tests : T01-T07 · sources : [Movr.class:Txht_LostFocus](../../../../../.src/Gestion/Tables/Movr.class#L1097-L1116), [Movr.class:Valeur2TTC_LF](../../../../../.src/Gestion/Tables/Movr.class#L1402-L1421), [Movr.class:618-621](../../../../../.src/Gestion/Tables/Movr.class#L618-L621), [Movr.class:436-449](../../../../../.src/Gestion/Tables/Movr.class#L436-L449), [Movr.class:896](../../../../../.src/Gestion/Tables/Movr.class#L896)
- [ ] MOVR-003 — [réarchitecture] `Cbase.Table("TabMo"|"TabFour"|"TabFam"|"TabTxmo"|"TabTvav"|"TabLigbl")`
  à la place des noms en dur et du membre `tab` (SQL identique) · appelants : aucun · tests :
  T01-T07 · sources : [Movr.class:mo_man](../../../../../.src/Gestion/Tables/Movr.class#L963-L995), [Movr.class:FamMan](../../../../../.src/Gestion/Tables/Movr.class#L1031-L1052), [Movr.class:fourMan](../../../../../.src/Gestion/Tables/Movr.class#L1057-L1070), [Movr.class:TxMoMan](../../../../../.src/Gestion/Tables/Movr.class#L1075-L1095), [Movr.class:TvaMan](../../../../../.src/Gestion/Tables/Movr.class#L1000-L1026), [Movr.class:Button3_Click](../../../../../.src/Gestion/Tables/Movr.class#L1304-L1333)
- [ ] MOVR-004 — [commonalisation] Les quatre jeux d'en-têtes (`Co_*`, `Inte_*`, `fo_*`, `Fa_*`)
  délèguent à `ChoixTri(sTri, hEntete, bDouble)` et `FiltreSaisi()` ; `Deb2`/`Deb3` →
  `ChargeGrille(bDesc)` (SQL identique) ; noms de handlers conservés · appelants : aucun · tests :
  T07 · sources : [Movr.class:Co_Click](../../../../../.src/Gestion/Tables/Movr.class#L700-L712), [Movr.class:Inte_KeyPress](../../../../../.src/Gestion/Tables/Movr.class#L768-L781), [Movr.class:Deb2](../../../../../.src/Gestion/Tables/Movr.class#L169-L174), [Movr.class:Deb3](../../../../../.src/Gestion/Tables/Movr.class#L176-L181)
- [ ] MOVR-005 — [complexité] `Cmpt_KeyPress` (CC 35) et `Cmpt_Lostfocus` (CC 29) : une fonction
  `ValideZone(iTag) As Boolean` partagée (même ordre d'appels, mêmes messages), les handlers ne
  gardent que la navigation · appelants : aucun · tests : T01-T04, T06 · sources : [Movr.class:Cmpt_KeyPress](../../../../../.src/Gestion/Tables/Movr.class#L297-L451), [Movr.class:Cmpt_Lostfocus](../../../../../.src/Gestion/Tables/Movr.class#L521-L624)
- [ ] MOVR-006 — [séparation traitement/GUI] `Calc_MargeMo` → `MargeMo(...)` pure, commune avec
  `Txmo` (TXMO-005, même commit) ; `Valeur2TTC_Calcul`/`Valeur2TTC_LostFocus` → `PrixTTC(fHt,
  fTaux)`/`PrixHT(fTtc, fTaux)` purs · appelants : `Txmo` · tests : T01, T02, T08, TXMO-T02, TXMO-T06 · sources : [Movr.class:Calc_MargeMo](../../../../../.src/Gestion/Tables/Movr.class#L1423-L1451), [Movr.class:Valeur2TTC_Calcul](../../../../../.src/Gestion/Tables/Movr.class#L1582-L1594), [Movr.class:Valeur2TTC_LostFocus](../../../../../.src/Gestion/Tables/Movr.class#L1549-L1577), [Txmo.class:Calc_MargeMo](../../../../../.src/Gestion/Tables/Txmo.class#L196-L226)
- [ ] MOVR-007 — [commonalisation] `arrondi` → `ArrondiPrix(sPrix, sArr, sFormat) As String` pure,
  partagée avec `Materiel.arrondi` (MATERIEL-008, même commit) et candidate pour `FTvav`
  (FTVAV-005), adoptée seulement si MOVR-T08 et MATERIEL-T10 donnent des résultats identiques ·
  appelants : `Materiel` · tests : T02, T08, MATERIEL-T03, MATERIEL-T10 · sources : [Movr.class:arrondi](../../../../../.src/Gestion/Tables/Movr.class#L1599-L1635), [Materiel.class:arrondi](../../../../../.src/Gestion/Tables/Materiel.class#L1281-L1318), [FTvav.class:arrondi](../../../../../.src/Compta/Tables/FTvav.class#L509-L547)
- [ ] MOVR-008 — [séparation traitement/GUI] `Button4_Click` : `EnregistreMo(...)` (INSERT/UPdate
  inchangés) ; `Button3_Click` : `MoUtilisee(sCode) As Boolean` + `SupprimeMo(sCode)` ·
  appelants : aucun · tests : T01, T03, T05 · sources : [Movr.class:Button4_Click](../../../../../.src/Gestion/Tables/Movr.class#L1456-L1502), [Movr.class:Button3_Click](../../../../../.src/Gestion/Tables/Movr.class#L1304-L1333)
- [ ] MOVR-009 — [réduction de portée] `Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`,
  `CleanChamps`, `RdimColmo`, `code_LF`, `Dbclk`, `Ref`, `mo_man`, `TvaMan`, `FamMan`, `fourMan`,
  `TxMoMan`, `Prvt_LF`, `Valeur_LF`, `Valeur2_LF`, `Calc_MargeMo`, `Valeur2TTC_Calcul`, `arrondi`
  → `Private` (sauf fonctions devenues communes) ; pseudo-handlers et `_Click` rejoués inchangés ·
  appelants : aucun · tests : T01-T07 · sources : [Movr.class:Maj_Zones](../../../../../.src/Gestion/Tables/Movr.class#L183-L219), [Movr.class:mo_man](../../../../../.src/Gestion/Tables/Movr.class#L963-L995), [Movr.class:arrondi](../../../../../.src/Gestion/Tables/Movr.class#L1599-L1635)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MOVR-A01 — [anomalie] `mo_man` (code existant saisi au clavier) charge partiellement la
  fiche : ni valeur HT/TTC, ni arrondi, ni prix de revient, ni commentaire, ni impression, et ne
  bascule pas en mode forfait (`If mo_tempmont <> 0 Then Temps`) ; enregistrer ensuite écrase ces
  colonnes (forfait enregistré au temps). Correction : `ChargeMo` commun avec `Maj_Zones` ·
  tests : T04 · sources : [Movr.class:mo_man](../../../../../.src/Gestion/Tables/Movr.class#L963-L995), [Movr.class:982](../../../../../.src/Gestion/Tables/Movr.class#L982), [Movr.class:1484](../../../../../.src/Gestion/Tables/Movr.class#L1484)
- [ ] MOVR-A02 — [anomalie] `Button3_Click` ne contrôle que `Fiches_Ligbl` : une MO utilisée dans un
  bon d'entretien (`Fiches_LigblM`), l'historique de factures ou un produit composé
  (`Fiches_PrdComp.codec`) peut être supprimée ; rafraîchissement et `cleanchamps` même après
  « Non » · tests : T05 · sources : [Movr.class:1317](../../../../../.src/Gestion/Tables/Movr.class#L1317), [Movr.class:1327-1330](../../../../../.src/Gestion/Tables/Movr.class#L1327-L1330)
- [ ] MOVR-A03 — [anomalie] `TvaMan` n'affiche jamais « Ce code Tva n'existe pas » (un résultat vide
  ne lève pas d'erreur) et laisse `b = 0` · tests : T06 · sources : [Movr.class:TvaMan](../../../../../.src/Gestion/Tables/Movr.class#L1000-L1026)
- [ ] MOVR-A04 — [anomalie] SQL par concaténation de la saisie : `Deb2`/`Deb3` (`sel`) et filtres
  F2 de `ToggleButton1/3/5_Click` ; apostrophe ou guillemet → erreur SQL, injection possible ·
  tests : T06, T07 · sources : [Movr.class:171](../../../../../.src/Gestion/Tables/Movr.class#L171), [Movr.class:178](../../../../../.src/Gestion/Tables/Movr.class#L178), [Movr.class:900](../../../../../.src/Gestion/Tables/Movr.class#L900), [Movr.class:1139](../../../../../.src/Gestion/Tables/Movr.class#L1139), [Movr.class:1239](../../../../../.src/Gestion/Tables/Movr.class#L1239)
- [ ] MOVR-A05 — [anomalie] `ToggleButton3_Click` filtre `Fiches_Fam` sur une colonne `code`
  inexistante (`code_fam`) : F2 sur une famille saisie → erreur SQL ; `Dne` jamais remis à vide ·
  tests : T06 · sources : [Movr.class:1139](../../../../../.src/Gestion/Tables/Movr.class#L1139), [Movr.class:420](../../../../../.src/Gestion/Tables/Movr.class#L420)
- [ ] MOVR-A06 — [anomalie] Incohérences clavier/souris des listes : `fourList_Click` passe à
  `Valeur` (Entrée passe au taux) ; `CmoList_KeyPress` recopie le taux sans format `0.00` ni
  changement de zone (le clic formate en `00.00` et passe au prix de revient) · tests : T06 · sources : [Movr.class:923](../../../../../.src/Gestion/Tables/Movr.class#L923), [Movr.class:940](../../../../../.src/Gestion/Tables/Movr.class#L940), [Movr.class:1259](../../../../../.src/Gestion/Tables/Movr.class#L1259), [Movr.class:1280](../../../../../.src/Gestion/Tables/Movr.class#L1280)
