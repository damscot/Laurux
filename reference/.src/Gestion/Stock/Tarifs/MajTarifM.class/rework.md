# MajTarifM — Rework

> Source : `.src/Gestion/Stock/Tarifs/MajTarifM.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/MajTarifM.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1107 |
| Lignes de commentaire | 91 |
| Fonctions | 72 |
| Fonctions Public | 72 |
| Complexité cyclomatique totale | 319 |
| Complexité max (fonction) | 25 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1107 | 319 | 25 | 0 | 72 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJTARIFM-001 — [documentation] En-tête de classe en français : rôle, deux colonnes de
  prix, enchaînement des validations (tags 8-16), drapeau `bModif` ; commentaires `'''` sur les
  fonctions de calcul · appelants : aucun · tests : T03 · sources : [MajTarifM.class:Cmpt_KeyPress](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L153-L299), [MajTarifM.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1437-L1453)
- [ ] MAJTARIFM-002 — [code mort] Supprimer `Deb2`, `Deb3`, `Deb4`, `Dbclk`, `Calc_coeff` et le
  `If combotest Then Endif` vide de `Cb1_Click` · appelants : aucun · tests : T01, T06 · sources : [MajTarifM.class:Deb2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L772-L786), [MajTarifM.class:Deb4](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L804-L814), [MajTarifM.class:Dbclk](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1141-L1151), [MajTarifM.class:Calc_coeff](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1026-L1031), [MajTarifM.class:Cb1_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1291-L1309)
- [ ] MAJTARIFM-003 — [réduction de portée] `pbhtLF2`, `TrC2`, `PaUAGF2`, `PaUALF2`, `TxLF2`,
  `FraisLF2`, `Coeff2`, `Pourcent2`, `PvhtLF2`, `PvTTcLF2`, `Tva_Calcul2`, `arrondi2`, `Reaff2`,
  `Tris`, `CleanChamps`, `Maj_Zones`, `Fam2`, `Calc_Marge`, `Calc_Percent`, `Calc_Marge2`,
  `Calc_Percent2`, `Calc_coeff2`, `Calc_coeff3`, `Calc_coeff4`, `ChkPrx`, `Art_Dblclk`, `ChkInput2`,
  `Deb5`, `Deb6`, `Maj_Etiqp`, `Maj_Etiqg` → `Private` (couverts par T01-T08) · appelants : aucun ·
  tests : T01-T08 · sources : [MajTarifM.class:pbhtLF2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L323-L352), [MajTarifM.class:Maj_Etiqg](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1425-L1435)
- [ ] MAJTARIFM-004 — [complexité] Handlers `CO_*`, `It_*`, `FA_*` : procédure privée
  `ChoixTri(hChamp, sTri)` (noms et portée des handlers inchangés) ; `Cmpt_KeyPress` piloté par
  une table tag → (validation, champ suivant), CC 25 → ≤ 8 · appelants : aucun · tests : T01,
  T03-T06 · sources : [MajTarifM.class:CO_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1153-L1167), [MajTarifM.class:It_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1199-L1213), [MajTarifM.class:FA_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1245-L1259), [MajTarifM.class:Cmpt_KeyPress](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L153-L299)
- [ ] MAJTARIFM-005 — [commonalisation] Calculs purs d'`Articles` (ARTICLES-011 : `PrixAchatNet`,
  `PrixTTC`, `TauxMarque`, `CoefDepuisTaux`, `CoefTTC`, `Marges`) utilisés par `TrC2`,
  `Tva_Calcul2`, `Calc_*` et `Calc_*2` ; `arrondi2` via `ArrondiPvTTC` (ARTICLES-012) seulement si
  la comparaison ligne à ligne confirme l'identité · appelants : aucun · tests : T03-T06, T09 ·
  sources : [MajTarifM.class:TrC2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L357-L390), [MajTarifM.class:Tva_Calcul2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L673-L685), [MajTarifM.class:arrondi2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L690-L727), [MajTarifM.class:Calc_Percent2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1049-L1056), [Articles.class:arrondi](../../../../../../.src/Gestion/Tables/Articles.class#L2625-L2662)
- [ ] MAJTARIFM-006 — [commonalisation] `ChkPrx` et liste fournisseurs partagés avec `MajTarifP` ;
  `Maj_Etiqp`/`Maj_Etiqg` via `EtiqMaj` (MAJFBTARIF2-005) ; garde d'export → `Serveur.Actif`
  (SERVEUR-008) · appelants : aucun · tests : T07 · sources : [MajTarifM.class:ChkPrx](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1131-L1139), [MajTarifM.class:Maj_Etiqp](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1411-L1423), [MajTarifM.class:Button4_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L95-L120)
- [ ] MAJTARIFM-007 — [séparation traitement/GUI] `Deb5`/`Deb6` : texte SQL construit par une
  fonction pure `RequeteListe(sTri, sSel, sFour, bDesc)` (texte identique) ; `Button2_Click` :
  `EnregistrePrix(sCode, …)` sans accès aux contrôles · appelants : aucun · tests : T01, T03 ·
  sources : [MajTarifM.class:Deb5](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1366-L1383), [MajTarifM.class:Deb6](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1385-L1398), [MajTarifM.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1437-L1453)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJTARIFM-A01 — [anomalie] `Deb5`/`Deb6` : `art_four = <Four.Text>` concaténé sans
  guillemets (erreur SQL pour un code alphanumérique, comparaison numérique sinon) et `sel`
  concaténé ; passer en paramètres `&N` · tests : T02, T01 · sources : [MajTarifM.class:1378](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1378), [MajTarifM.class:1380](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1380), [MajTarifM.class:1396](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1396)
- [ ] MAJTARIFM-A02 — [anomalie] Saisie clavier du fournisseur (`Four`, tag 1) sans contrôle
  d'existence ni nom affiché ; liste fournisseurs sans test `Available` · tests : T01 · sources : [MajTarifM.class:Cmpt_KeyPress](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L153-L299), [MajTarifM.class:Button4_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L95-L120)
- [ ] MAJTARIFM-A03 — [anomalie] `Button2_Click` : après `Maj_Etiqg`, export `("Art", "M")` au
  lieu de `("Etiq", "G")`, article exporté deux fois ; `qte` texte décimal passé à un paramètre
  `Integer` (à confirmer) · tests : T07 · sources : [MajTarifM.class:1446](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1446), [MajTarifM.class:1449](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1449), [MajTarifM.class:1441](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1441)
- [ ] MAJTARIFM-A04 — [anomalie] Validations sur le mauvais champ : `PaUALF2` teste `PaUA`,
  `FraisLF2` teste `Frais`, `PvhtLF2` teste `Pvht` (colonne de gauche) ; `Cmpt_dblclick` remet le
  focus sur `Tr` au lieu de `Tr2` · tests : T04, T06 · sources : [MajTarifM.class:405](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L405), [MajTarifM.class:501](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L501), [MajTarifM.class:591](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L591), [MajTarifM.class:308](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L308)
- [ ] MAJTARIFM-A05 — [anomalie] `Pmp`/`Pmp2` jamais lus en base et non réinitialisés entre deux
  articles : marges affichées calculées sur le prix de revient du premier article ; `colarts_Data`
  affecte `ArtTable[4]` au lieu de `ArtTable[3]` · tests : T08, T01 · sources : [MajTarifM.class:Calc_Marge](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1001-L1009), [MajTarifM.class:Calc_Marge2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1036-L1044), [MajTarifM.class:827](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L827)
- [ ] MAJTARIFM-A06 — [anomalie] Taux de conversion et frais modifiables à l'écran mais non
  enregistrés par `Button2_Click` (prix recalculés avec, valeurs perdues) · tests : T10 · sources : [MajTarifM.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L1437-L1453), [MajTarifM.class:TxLF2](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifM.class#L457-L491)
