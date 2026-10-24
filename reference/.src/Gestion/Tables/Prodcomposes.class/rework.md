# Prodcomposes — Rework

> Source : `.src/Gestion/Tables/Prodcomposes.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Prodcomposes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 534 |
| Lignes de commentaire | 64 |
| Fonctions | 34 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 130 |
| Complexité max (fonction) | 20 (`Cmpt_Keypress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 534 | 130 | 20 | 0 | 34 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] PRODCOMPOSES-001 — [documentation] En-tête en français : modèle `Fiches_PrdComp`
  (article/MO), écriture du coût dans `Fiches_Art` à chaque affichage, ordre des calculs, rôle de
  `Bsel`/`Bval` (écrits par `TriArticles`) · appelants : aucun · tests : aucun · sources : [Prodcomposes.class:_New](../../../../../.src/Gestion/Tables/Prodcomposes.class#L46-L83), [Prodcomposes.class:Cprdcomp](../../../../../.src/Gestion/Tables/Prodcomposes.class#L177-L207), [Prodcomposes.class:Calc_Pmp](../../../../../.src/Gestion/Tables/Prodcomposes.class#L563-L601)
- [ ] PRODCOMPOSES-002 — [code mort] Supprimer `Code_KeyPress` (handler inactif, `Code` groupé
  dans `Cmpt`), `CalcTTC`, `CalcHt`, `Recup_Tva`, les membres `Ttva`, `Txtva`, `CoulZns`,
  `CoulZnaf`, `Coulfc` et leurs lectures de configuration dans `_New`, l'affectation `Sel =
  "codep"` de `delArt` (écrasée par `Cprdcomp`) ; `iPmp` et `rResult` deviennent locaux.
  `Calc_coeff` est conservé jusqu'à la décision sur A02 · appelants : aucun · tests : T01-T05 · sources : [Prodcomposes.class:Code_KeyPress](../../../../../.src/Gestion/Tables/Prodcomposes.class#L88-L103), [Prodcomposes.class:CalcTTC](../../../../../.src/Gestion/Tables/Prodcomposes.class#L527-L532), [Prodcomposes.class:CalcHt](../../../../../.src/Gestion/Tables/Prodcomposes.class#L537-L545), [Prodcomposes.class:Recup_Tva](../../../../../.src/Gestion/Tables/Prodcomposes.class#L550-L558), [Prodcomposes.class:451](../../../../../.src/Gestion/Tables/Prodcomposes.class#L451)
- [ ] PRODCOMPOSES-003 — [réarchitecture] `Cbase.Table("TabPrdComp"|"TabMo"|"TabArt")` à la place
  de `Fiches_PrdComp` (`Deb2`, texte passé à `Subst` inchangé), `Fiches_Mo` (`Colartprdc_Click`,
  `Calc_Pmp`, `Calc_Prvt`) et `Fiches_Art` (`Calc_Prvt`) — SQL identique · appelants : aucun ·
  tests : T01-T04 · sources : [Prodcomposes.class:Deb2](../../../../../.src/Gestion/Tables/Prodcomposes.class#L292-L296), [Prodcomposes.class:405](../../../../../.src/Gestion/Tables/Prodcomposes.class#L405), [Prodcomposes.class:583](../../../../../.src/Gestion/Tables/Prodcomposes.class#L583), [Prodcomposes.class:646](../../../../../.src/Gestion/Tables/Prodcomposes.class#L646), [Prodcomposes.class:650](../../../../../.src/Gestion/Tables/Prodcomposes.class#L650)
- [ ] PRODCOMPOSES-004 — [séparation traitement/GUI] `Calc_Pmp` → `CoutCompose(sCode,
  sQteSaisie) As Float` (quantité saisie passée en paramètre pour préserver A01) +
  `MajCoutArticle(sCode, fPmp, fPrvt, fCoef)` ; `Calc_Prvt` → `PrixRevientCompose(sCode) As Float` ;
  même ordre d'appels et même SQL · appelants : aucun · tests : T01-T03, T06, T07 · sources : [Prodcomposes.class:Calc_Pmp](../../../../../.src/Gestion/Tables/Prodcomposes.class#L563-L601), [Prodcomposes.class:Calc_Prvt](../../../../../.src/Gestion/Tables/Prodcomposes.class#L637-L657)
- [ ] PRODCOMPOSES-005 — [séparation traitement/GUI] `Button3_Click` / `delArt` :
  `AjouteComposant(...)` et `RetireComposant(sCodep, sCodec)` sans accès aux contrôles ; messages
  et rafraîchissements dans les handlers · appelants : aucun · tests : T02-T04 · sources : [Prodcomposes.class:Button3_Click](../../../../../.src/Gestion/Tables/Prodcomposes.class#L304-L343), [Prodcomposes.class:delArt](../../../../../.src/Gestion/Tables/Prodcomposes.class#L447-L457)
- [ ] PRODCOMPOSES-006 — [complexité] `Cmpt_Keypress` (CC 20) : une fonction par touche
  (`ValideZone(iTag)`, `OuvreListe(iTag)`, `OuvreArticles()`), comportement identique (y compris
  A06) ; `SelectionArt`/`SelectionMo` → `Selection(sTri)` · appelants : aucun · tests : T02, T03,
  T05 · sources : [Prodcomposes.class:Cmpt_Keypress](../../../../../.src/Gestion/Tables/Prodcomposes.class#L209-L271), [Prodcomposes.class:SelectionArt](../../../../../.src/Gestion/Tables/Prodcomposes.class#L460-L471), [Prodcomposes.class:SelectionMo](../../../../../.src/Gestion/Tables/Prodcomposes.class#L669-L680)
- [ ] PRODCOMPOSES-007 — [réduction de portée] `Cprdcomp`, `Cmpt_LF`, `Deb2`, `CleanChamps`,
  `delArt`, `SelectionArt`, `SelectionMo`, `ChkPrx`, `Art_Man`, `Mo_man`, `Calc_Pmp`, `Calc_Marge`,
  `Calc_Prvt` → `Private` ; `Bsel`/`Bval` restent `Public` (`Object.SetProperty`) · appelants :
  aucun · tests : T01-T05 · sources : [Prodcomposes.class:Cprdcomp](../../../../../.src/Gestion/Tables/Prodcomposes.class#L177-L207), [Prodcomposes.class:Art_Man](../../../../../.src/Gestion/Tables/Prodcomposes.class#L486-L522), [Prodcomposes.class:Calc_Marge](../../../../../.src/Gestion/Tables/Prodcomposes.class#L609-L635)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] PRODCOMPOSES-A01 — [anomalie] `Calc_Pmp` utilise la quantité de la zone de saisie `Qte`
  (si ≠ `"0"` et non vide) pour **tous** les composants articles au lieu de la quantité de chaque
  ligne ; appelé par `Cmpt_LF` (avant l'ajout) et par `Cprdcomp` (sélection d'un produit alors
  qu'une quantité est affichée) → PMP faux écrit dans `Fiches_Art` · tests : T02, T03 · sources : [Prodcomposes.class:577-581](../../../../../.src/Gestion/Tables/Prodcomposes.class#L577-L581), [Prodcomposes.class:Cmpt_LF](../../../../../.src/Gestion/Tables/Prodcomposes.class#L273-L279), [Prodcomposes.class:596](../../../../../.src/Gestion/Tables/Prodcomposes.class#L596)
- [ ] PRODCOMPOSES-A02 — [anomalie] L'`UPdate` de `Calc_Pmp` écrit `art_coef = Coeff`, jamais
  calculé (`Calc_coeff` n'est appelé nulle part) : le coefficient du produit composé est remis à 0
  à chaque affichage ; il écrit aussi `art_prvt` à partir de `Pxrvt` calculé à l'appel
  **précédent** (`Calc_Prvt` est appelé après `Calc_Pmp`) · tests : T01, T02 · sources : [Prodcomposes.class:596](../../../../../.src/Gestion/Tables/Prodcomposes.class#L596), [Prodcomposes.class:193-195](../../../../../.src/Gestion/Tables/Prodcomposes.class#L193-L195), [Prodcomposes.class:Calc_coeff](../../../../../.src/Gestion/Tables/Prodcomposes.class#L603-L607)
- [ ] PRODCOMPOSES-A03 — [anomalie] `Calc_Pmp` lit `art_pmp` sans test `Available` : un composant
  article supprimé interrompt le calcul (`Catch` muet), sans mise à jour ni message · tests : T06 · sources : [Prodcomposes.class:575](../../../../../.src/Gestion/Tables/Prodcomposes.class#L575), [Prodcomposes.class:598](../../../../../.src/Gestion/Tables/Prodcomposes.class#L598)
- [ ] PRODCOMPOSES-A04 — [anomalie] `Deb2` : `ORDER BY &2` devient `ORDER BY 'codec'` (constante) :
  les composants ne sont pas triés · tests : T01 · sources : [Prodcomposes.class:Deb2](../../../../../.src/Gestion/Tables/Prodcomposes.class#L292-L296)
- [ ] PRODCOMPOSES-A05 — [anomalie] `button3_KeyPress` ajoute/modifie le composant pour
  n'importe quelle touche sur le bouton, Tab compris (même défaut que FTVAV-A02) · tests : T05 · sources : [Prodcomposes.class:button3_KeyPress](../../../../../.src/Gestion/Tables/Prodcomposes.class#L298-L302)
- [ ] PRODCOMPOSES-A06 — [anomalie, à confirmer] F4 sur la zone composant (tag 2) ouvre `Articles`
  puis recharge le produit composé (`Cprdcomp`) au lieu du composant (`Art_Man`) · tests : T05 · sources : [Prodcomposes.class:264-267](../../../../../.src/Gestion/Tables/Prodcomposes.class#L264-L267)
- [ ] PRODCOMPOSES-A07 — [anomalie] Pour une MO, `Mo_man` affiche le taux horaire (`mo_txht`) dans
  la zone « Prix revient » alors que `Colartprdc_Click` affiche `mo_prvt` et que le calcul utilise
  `mo_prvt` ; `Mo_man` ne formate pas la quantité · tests : T03 · sources : [Prodcomposes.class:687](../../../../../.src/Gestion/Tables/Prodcomposes.class#L687), [Prodcomposes.class:407](../../../../../.src/Gestion/Tables/Prodcomposes.class#L407)
- [ ] PRODCOMPOSES-A08 — [anomalie, à confirmer] `Colartprdc_Click` distingue article et MO par le
  texte `"False"` de la colonne `mo` (`Str()` d'un booléen) : dépend de la conversion
  `tinyint(1)` → Boolean du pilote (à vérifier sous SQLite) · tests : T08 · sources : [Prodcomposes.class:387](../../../../../.src/Gestion/Tables/Prodcomposes.class#L387), [Prodcomposes.class:288](../../../../../.src/Gestion/Tables/Prodcomposes.class#L288)
