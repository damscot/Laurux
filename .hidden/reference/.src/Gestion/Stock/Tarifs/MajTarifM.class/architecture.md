# MajTarifM — Architecture

> Source : `.src/Gestion/Stock/Tarifs/MajTarifM.class`

## Vue d'ensemble

Écran **« Maj tarif manuelle »** (Gestion > Stock > Tarif, `Fmenu.Menu249_Click`, `Show`) :
après choix d'un fournisseur, une grille (`Colarts`, `GridView` alimentée par `Utils.Base`) liste
ses articles avec recherche incrémentale par code, intitulé, famille ou code secondaire
(équivalent, référence fournisseur, code-barre, référence centrale). Un clic sur un article
affiche deux colonnes de prix :

- à gauche, les **prix actuels** en lecture seule (`PbHt`, `Tr`, `PaUA`, `Txconv`, `PaHt`, `Frais`,
  `Prvt`, `Coef`, `Percent`, `PvHt`, `PvTTc`, marges) ;
- à droite, les **nouveaux prix** saisissables (`PbHt2` … `PvTTc2`, groupe `Cmpt`, tags 8 à 16)
  avec recalcul en cascade à chaque validation de champ, comme dans la fiche article
  [`Articles`](../../../Tables/Articles.class/architecture.md).

« Enregistrer » (`Button2_Click`) écrit les nouveaux prix dans `Fiches_Art` (un seul `UPDATE`)
et prépare les étiquettes.

L'écran partage environ **20 fonctions homonymes** avec `Articles` (`Calc_Marge`, `Calc_Percent`,
`Calc_coeff`, `Calc_coeff2`, `ChkPrx`, `Rem_KeyPress`, `TrC`/`TrC2`, `arrondi`/`arrondi2`,
`Tva_Calcul`/`Tva_Calcul2`…), suffixées `2` quand elles portent sur la colonne des nouveaux prix.
Toute la logique travaille sur le **texte des contrôles** (`Val`/`Format$` localisés,
`Utils.cpoint`).

Nature globale : **GUI/mixte** ; le seul SQL est dans `Maj_Zones`, `Fam2`, les listes, `Deb5/6`,
`Maj_Etiq*` et `Button2_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Arttable` | var | Private |  | New String[5] | 3 |
| `Tri` | var | Private |  | String | 4 |
| `sel` | var | Private |  | String | 5 |
| `nbdec` | var | Private |  | String | 6 |
| `Fam` | var | Private |  | String | 7 |
| `son` | var | Private |  | Integer | 8 |
| `Dbl` | var | Private |  | String | 9 |
| `CoulZns` | var | Private |  | Integer | 10 |
| `CoulZnaf` | var | Private |  | Integer | 11 |
| `CoulFc` | var | Private |  | Integer | 12 |
| `b` | var | Private |  | Integer | 13 |
| `Chkfocus` | var | Private |  | Integer | 14 |
| `montante` | var | Private |  | String | 15 |
| `Txc` | var | Private |  | String | 16 |
| `Qte` | var | Private |  | String | 17 |
| `Etiq` | var | Private |  | String | 18 |
| `Reaf` | var | Private |  | Integer | 19 |
| `Code` | var | Private |  | String | 20 |
| `ComboTest` | var | Private |  | Boolean | 21 |
| `Etiqb` | var | Private |  | Boolean | 22 |
| `bModif` | var | Private |  | Boolean | 23 |
| `Checkcmpt` | var | Private |  | Boolean | 24 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 26-43 | Public | 1 | 14 | 0 | méthode spéciale |
| `Form_Open` | 45-56 | Public | 1 | 10 | 0 | handler GUI |
| `Cmpt_GotFocus` | 61-81 | Public | 7 | 16 | 0 | handler GUI |
| `Cmpt_Change` | 83-90 | Public | 3 | 6 | 0 | handler GUI |
| `Button4_Click` | 95-120 | Public | 3 | 23 | 0 | handler GUI |
| `fourList_Click` | 125-132 | Public | 1 | 6 | 0 | handler GUI |
| `fourList_KeyPress` | 137-149 | Public | 5 | 11 | 0 | handler GUI |
| `Cmpt_KeyPress` | 153-299 | Public | 25 | 135 | 0 | handler GUI |
| `Cmpt_dblclick` | 301-318 | Public | 3 | 15 | 0 | handler GUI |
| `pbhtLF2` | 323-352 | Public | 9 | 28 | 0 | portée réductible ? |
| `TrC2` | 357-390 | Public | 10 | 31 | 0 | portée réductible ? |
| `PaUAGF2` | 395-399 | Public | 3 | 3 | 0 | portée réductible ? |
| `PaUALF2` | 401-452 | Public | 11 | 49 | 0 | portée réductible ? |
| `TxLF2` | 457-491 | Public | 10 | 33 | 0 | portée réductible ? |
| `FraisLF2` | 496-525 | Public | 8 | 28 | 0 | portée réductible ? |
| `Coeff2` | 530-553 | Public | 7 | 22 | 0 | portée réductible ? |
| `Pourcent2` | 558-582 | Public | 8 | 23 | 0 | portée réductible ? |
| `PvhtLF2` | 587-622 | Public | 10 | 34 | 0 | portée réductible ? |
| `PvTTcLF2` | 627-668 | Public | 12 | 39 | 0 | portée réductible ? |
| `Tva_Calcul2` | 673-685 | Public | 4 | 10 | 0 | portée réductible ? |
| `arrondi2` | 690-727 | Public | 10 | 33 | 0 | portée réductible ? |
| `Ard_click` | 729-743 | Public | 3 | 11 | 0 | handler GUI |
| `Reaff2` | 748-756 | Public | 1 | 7 | 0 | portée réductible ? |
| `Tris` | 760-770 | Public | 1 | 9 | 0 | portée réductible ? |
| `Deb2` | 772-786 | Public | 2 | 11 | 0 | portée réductible ? |
| `Deb3` | 788-802 | Public | 2 | 11 | 0 | portée réductible ? |
| `Deb4` | 804-814 | Public | 1 | 7 | 0 | portée réductible ? |
| `colarts_Data` | 816-841 | Public | 6 | 22 | 0 | handler GUI |
| `CleanChamps` | 843-890 | Public | 1 | 45 | 0 | portée réductible ? |
| `colarts_Click` | 892-901 | Public | 2 | 8 | 0 | handler GUI |
| `Maj_Zones` | 903-977 | Public | 22 | 72 | 0 | portée réductible ? |
| `Fam2` | 979-996 | Public | 4 | 15 | 0 | portée réductible ? |
| `Calc_Marge` | 1001-1009 | Public | 4 | 7 | 0 | portée réductible ? |
| `Calc_Percent` | 1014-1021 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff` | 1026-1031 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_Marge2` | 1036-1044 | Public | 4 | 7 | 0 | portée réductible ? |
| `Calc_Percent2` | 1049-1056 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff2` | 1061-1066 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff3` | 1071-1075 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff4` | 1080-1084 | Public | 2 | 3 | 0 | portée réductible ? |
| `Rem_KeyPress` | 1089-1129 | Public | 16 | 34 | 0 | handler GUI |
| `ChkPrx` | 1131-1139 | Public | 7 | 7 | 0 | portée réductible ? |
| `Dbclk` | 1141-1151 | Public | 2 | 9 | 0 | portée réductible ? |
| `CO_Click` | 1153-1167 | Public | 2 | 13 | 0 | handler GUI |
| `CO_DblClick` | 1169-1173 | Public | 2 | 3 | 0 | handler GUI |
| `CO_GotFocus` | 1175-1180 | Public | 2 | 4 | 0 | handler GUI |
| `CO_LostFocus` | 1182-1186 | Public | 2 | 3 | 0 | handler GUI |
| `CO_KeyPress` | 1188-1197 | Public | 2 | 8 | 0 | handler GUI |
| `It_Click` | 1199-1213 | Public | 2 | 13 | 0 | handler GUI |
| `It_DblClick` | 1215-1219 | Public | 2 | 3 | 0 | handler GUI |
| `It_GotFocus` | 1221-1226 | Public | 2 | 4 | 0 | handler GUI |
| `It_LostFocus` | 1228-1232 | Public | 2 | 3 | 0 | handler GUI |
| `It_KeyPress` | 1234-1243 | Public | 2 | 8 | 0 | handler GUI |
| `FA_Click` | 1245-1259 | Public | 2 | 13 | 0 | handler GUI |
| `FA_DblClick` | 1261-1265 | Public | 2 | 3 | 0 | handler GUI |
| `FA_GotFocus` | 1267-1272 | Public | 2 | 4 | 0 | handler GUI |
| `FA_LostFocus` | 1274-1278 | Public | 2 | 3 | 0 | handler GUI |
| `FA_KeyPress` | 1280-1289 | Public | 2 | 8 | 0 | handler GUI |
| `Cb1_Click` | 1291-1309 | Public | 8 | 17 | 0 | handler GUI |
| `Cb1_DblClick` | 1311-1315 | Public | 2 | 3 | 0 | handler GUI |
| `Cb1_GotFocus` | 1317-1324 | Public | 2 | 6 | 0 | handler GUI |
| `Cb1_LostFocus` | 1326-1330 | Public | 2 | 3 | 0 | handler GUI |
| `Cb1_KeyPress` | 1332-1341 | Public | 2 | 8 | 0 | handler GUI |
| `Art_Dblclk` | 1343-1353 | Public | 2 | 9 | 0 | portée réductible ? |
| `ChkInput2` | 1355-1364 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb5` | 1366-1383 | Public | 3 | 15 | 0 | portée réductible ? |
| `Deb6` | 1385-1398 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button3_Click` | 1400-1409 | Public | 3 | 8 | 0 | handler GUI |
| `Maj_Etiqp` | 1411-1423 | Public | 2 | 10 | 0 | portée réductible ? |
| `Maj_Etiqg` | 1425-1435 | Public | 2 | 8 | 0 | portée réductible ? |
| `Button2_Click` | 1437-1453 | Public | 15 | 15 | 0 | handler GUI |
| `Button1_Click` | 1455-1457 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture, fournisseur

- **`_new()`** [GUI] : centrage, son, libellés `CO`/`IT`, couleurs `/Coul/Znaff`, `/Coul/Focus`,
  `/Coul/Znss` (`Utils.FColr`), `Utils.Observers(Me)` (une fois).
- **`Form_Open()`** [GUI] : tri par code, `Tris`, `CleanChamps`, largeur de la grille.
- **`Button4_Click()`** [mixte] : liste des fournisseurs (`Cbase.Table("TabFour")`) ⚠️ sans test
  `Available`. **`fourList_Click()`** [GUI] (`replay_dynamic`, `Public` requis),
  **`fourList_KeyPress()`** [GUI]. Le champ `Four` (groupe `Cmpt`, tag 1) n'a **pas** de cas dans
  `Cmpt_KeyPress` : un code saisi au clavier n'est ni vérifié ni complété (`fournom` reste vide).

### Liste des articles et recherche

- **`Tris()`** [portée : réductible] [GUI] : 4 colonnes de largeur égale aux champs de recherche.
- **`CO_*`, `It_*`, `FA_*`, `Cb1_*`** (20 handlers) [GUI] : `*_Click`/`*_GotFocus` choisissent la
  colonne de tri (`art_code`, `art_design`, `art_fam`, `art_cequ`/`art_cfour`/`art_cbarre`/
  `art_refcentrale` pour `Cb1`), vident la saisie et relancent `Deb5` si un fournisseur est
  saisi ; `*_KeyPress` → `ChkInput2` (ou avertissement sans fournisseur) ; `*_DblClick` →
  `Art_Dblclk` ; `*_LostFocus` → `Utils.ObsLstf`/`ObsLstf2`. `Cb1_Click` contient un `If combotest
  Then Endif` vide.
- **`ChkInput2()`** [portée : réductible] [GUI] : refuse `"`, `&`, `'` ; sinon `sel =
  Utils.Obstch(sel)` et `Deb5`.
- **`Deb5()` / `Deb6()`** [portée : réductible] [mixte] : `Utils.Base(colarts, "SELECT art_code, …
  FROM Fiches_Art WHERE <tri> LIKE \"<sel>%\" AND art_four = <Four.Text> ORDER BY <lpd> [DESC]")`.
  ⚠️ **SQL concaténé** : `sel` (filtré de `"&'` seulement) et surtout `Four.Text` **sans
  guillemets** : un code fournisseur alphanumérique est lu comme un nom de colonne (erreur SQL),
  un code numérique est comparé en nombre (`"001"` = `"1"`) (MAJTARIFM-A01). Chaîne entre `"`
  (identifiant en SQL standard, accepté par MySQL et par SQLite en repli). `lpad(art_code,15,' ')`
  traduit sous SQLite par `DB_Connection`.
- **`Art_Dblclk()`** [portée : réductible] : alterne `Deb6` (tri descendant) et `Deb5`.
- **`Deb2()`, `Deb3()`, `Deb4()`, `Dbclk()`** : **code mort** (`Deb4`, `Dbclk` jamais appelées ;
  `Deb2`, `Deb3` appelées seulement par `Dbclk`), anciennes recherches sans filtre fournisseur.
- **`colarts_Data(Row, Column)`** [GUI] : lecture de `Utils.rs1` à la ligne `Row` ; colonne 3 =
  code équivalent ou colonne de tri. ⚠️ Pour le tri par intitulé, `ArtTable[4]` est affecté au lieu
  de `ArtTable[3]` (colonne 3 garde la valeur précédente) : effet d'affichage seulement.
- **`colarts_Click()`** [GUI] (`replay_dynamic`) : `Maj_Zones(code)` puis focus sur `PbHt2`.

### Chargement d'un article

- **`Maj_Zones(Prod, Reaf)`** (CC 22) [portée : réductible] [mixte] : `SELECT * FROM Fiches_Art
  WHERE art_code = &1` ; remplit les deux colonnes (prix formatés selon `art_nbd`), la famille et
  la TVA (`Fam2`), `qte` et `Etiq` ; calcule marges, taux de marque et coefficients TTC
  (`Calc_Percent`, `Calc_Marge`, `Calc_coeff3`, puis `…2`, `Calc_coeff4`). `Catch` →
  `Message.Error`. ⚠️ `Pmp`/`Pmp2` ne sont jamais lus en base : au premier article ils prennent le
  prix de revient, puis **gardent celui du premier article** (`CleanChamps` n'est appelé qu'à
  l'ouverture et après enregistrement) : la marge affichée est fausse (MAJTARIFM-A05).
- **`Fam2()`** [portée : réductible] [mixte] : `SELECT * FROM Fiches_Fam` (sans test `Available`,
  l'erreur déclenche le message « Cette famille n'existe pas ») ; taux TVA par `CPrix.CTva`.
- **`CleanChamps()`** [portée : réductible] [GUI] : remise à zéro des deux colonnes, `bModif = False`.
- **`Reaff2()`** [portée : réductible] [GUI] : changement du nombre de décimales (`Nbd2`) →
  `Maj_Zones` avec `Reaf = 1` puis `pbhtLF2`.

### Cascade de calcul sur la colonne des nouveaux prix (nature mixte : lit et écrit les contrôles)

- **`Cmpt_GotFocus()`** [GUI] : couleur d'édition ; tag 9 affiche les remises en cascade
  (`Panel6`), tag 10 mémorise le prix net (`PaUAGF2`), tag 11 mémorise le taux de conversion.
- **`Cmpt_Change()`** [GUI] : tag 16 (`PvTTc2`) : `bModif = True` si `Checkcmpt`. C'est le **seul**
  drapeau de modification : `PvTTc2` étant recalculé par toute la cascade, l'enregistrement est
  autorisé dès qu'un prix change (à confirmer : `Change` levé sur affectation par code).
- **`Cmpt_KeyPress()`** (CC 25, max) [GUI] : sur Entrée/Tab, appelle la validation du champ
  (tags 8 à 16) puis déplace le focus (retour sur le champ si `b = 1`) ; F1 → `Button1_Click` (vide).
- **`Cmpt_dblclick()`** [GUI] : tag 9 bascule `Panel6` ; ⚠️ remet le focus sur `Tr` (colonne de
  gauche, lecture seule) au lieu de `Tr2`.
- **`pbhtLF2()`** : prix de base → `TrC2` → `PaUALF2`.
- **`TrC2()`** : remise → `PaUA2 = PbHt2 × (1 − Tr2/100)`, puis remises en cascade `Rem4`-`Rem6`
  par `CPrix.Cascade` si `Rem4 > 0` ; `PaUALF2`.
- **`PaUAGF2()`** : mémorise le prix net (`montante`).
- **`PaUALF2()`** : `PaHt2 = PaUA2 / Txconv2`, `Prvt2 = PaHt2 + Frais2`, `PvHt2 = Prvt2 × Coef2`,
  `Tva_Calcul2`, `arrondi2`, `Calc_Marge2`, `PvTTcLF2` ; si le prix net a changé, question :
  modifier la remise ou le prix de base. ⚠️ Teste `Val(PaUA.Text)` (colonne de gauche) au lieu de
  `PaUA2` (MAJTARIFM-A04).
- **`TxLF2()`** : taux de conversion modifiable seulement si le stock est nul (`Balloon` sinon) ;
  recalcule `PaHt2`, `Pmp2`.
- **`FraisLF2()`** : ⚠️ teste `Frais.Text` au lieu de `Frais2` (A04) ; recalcule la suite.
- **`Coeff2()`, `Pourcent2()`** : normalisation (`0.0000`, `0.000`), valeur par défaut si invalide.
- **`PvhtLF2()`** : ⚠️ teste `Pvht.Text` au lieu de `Pvht2` (A04) ; refuse un PV HT < prix
  d'achat ; recalcule taux de marque, coefficient, TTC, arrondi, marge.
- **`PvTTcLF2()`** : PV HT = PV TTC / (1 + TVA) ; taux, coefficient, arrondi, marge ; avertit si
  PV < prix d'achat.
- **`Tva_Calcul2()`** : `PvTTc2 = PvHt2 × (1 + TxTva2/100)`.
- **`arrondi2()`** : arrondi du PV TTC au 0,05/0,10/0,50/1,00 **par découpage de chaîne** selon
  `Arr2` (même algorithme que `MajFbtarif2.PvTTC_arrondi` et `Articles.arrondi`).
- **`Ard_click()`** [GUI] : groupe `Ard` (`Arr2` tag 1 → `arrondi2` + `PvTTcLF2` ; `Nbd2` tag 2 →
  `Reaff2` ; `Dec2` tag 3 : rien).
- **`Calc_Marge()`, `Calc_Percent()`, `Calc_coeff3()`** (colonne de gauche) et **`Calc_Marge2()`,
  `Calc_Percent2()`, `Calc_coeff2()`, `Calc_coeff4()`** (colonne de droite) : marge en montant
  `PvHt − Pmp`, marge en % du prix d'achat, marge sur prix de revient, taux de marque, coefficient
  `1 / (1 − taux/100)`, coefficient TTC `PvTTc / Prvt`. **`Calc_coeff()`** : jamais appelée
  (code mort).
- **`Rem_KeyPress()`** (CC 16) [GUI] : groupe `Rem` (`Rem4`-`Rem6`) : filtre `ChkPrx`, applique la
  remise en cascade et passe au champ suivant ; `Rem4` recalcule d'abord depuis le prix de base.
- **`ChkPrx()`** [portée : réductible] [GUI] : bloque les touches non numériques.

### Enregistrement

- **`Button2_Click()`** (CC 15) [mixte] : si `bModif` : étiquettes (`Maj_Etiqp` si stock > 0 et
  `art_etiq`, `Maj_Etiqg` si stock > 0), exports, puis `UPdate Fiches_Art SET art_pbht, art_tr,
  art_pauaht, art_pvht, art_pvttc, art_prvt, art_paht, art_coef, art_remcas1-3, art_ddatefbt`
  (valeurs `Val(texte)`, paramètres `&N`) ; puis `CleanChamps`. Pas de transaction (un seul
  `UPDATE`). ⚠️ Après `Maj_Etiqg`, l'export envoyé est `Serveur.Pass("Art", "M", …)` au lieu de
  `("Etiq", "G", …)`, et l'export article est envoyé deux fois (MAJTARIFM-A03). ⚠️ `qte` (texte
  formaté selon `art_dec`, ex. `"12,500"`) est passé au paramètre `Integer` de `Maj_Etiqp` :
  conversion à confirmer (T07). `art_txconv`, `art_frais` modifiés à l'écran **ne sont pas**
  enregistrés (MAJTARIFM-A06).
- **`Maj_Etiqp(Cart, nb)`** [portée : réductible] : `Cbase.Table("TabEtiqp")`, `UPDATE` ou `INSERT`.
- **`Maj_Etiqg(Cart, nb)`** [portée : réductible] : `INSERT` si absent ; utilise la variable de
  module `Code` au lieu du paramètre `Cart` (même valeur ici).
- **`Button3_Click()`** [GUI] : proposition d'imprimer les étiquettes (`EtiqRecpt.Show`), fermeture.
- **`Button1_Click()`** [GUI] : vide (bouton d'aide sans action).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/Coul/…"]`, `Utils.FColr`, `Utils.Observers`,
  `Utils.SetEditColor`, `Utils.ObsGotf/ObsLstf/ObsLstf2`, `Utils.Obstch`, `Utils.Base`,
  `Utils.rs1`, `Utils.cpoint`, `Utils.CDec`, `Utils.Find_nbdec`, `Utils.db`, `Cbase.Table`.
- `CPrix.Cascade`, `CPrix.CTva`, `Variables.Sprix/Sexport/SMajArt`, `Serveur.Pass`, `EtiqRecpt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le code mort `Deb2`, `Deb3`, `Deb4`, `Dbclk`, `Calc_coeff`, le `If combotest` vide de
  `Cb1_Click`.
- `CO_*`, `It_*`, `FA_*` : trois jeux de 5 handlers de même schéma → procédure privée
  `ChoixTri(hChamp, sTri)` appelée par chaque handler (noms et portée des handlers conservés).
- `Cmpt_KeyPress` : table tag → (validation, champ suivant) au lieu des 9 `Case` (CC 25 → ≤ 8).

### Commonalisation avec d'autres fichiers

- **Fonctions homonymes d'[`Articles`](../../../Tables/Articles.class/architecture.md)** (environ 20) :
  les calculs purs extraits par ARTICLES-011 (`PrixAchatNet`, `PrixTTC`, `ArrondiPvTTC`,
  `TauxMarque`, `CoefDepuisTaux`, `CoefTTC`, `Marges`) sont réutilisés ici par les fonctions
  `*2` et `Calc_*`, qui gardent la lecture/écriture des contrôles ; `arrondi2` utilise
  `ArrondiPvTTC` (ARTICLES-012) **après comparaison ligne à ligne** avec `Articles.arrondi`.
  Mêmes candidats dans [`Materiel`](../../../Tables/Materiel.class/architecture.md),
  [`Movr`](../../../Tables/Movr.class/architecture.md) (notes transverses : `Calc_*` marge/coef).
- **Fabrique `PrixVente`** (GESTAR-008, voir [`GesTar`](../../../Entrées/GesTar.class/architecture.md)
  et [`VarMajTar`](../../VarMajTar.class/architecture.md)) : `PaUALF2`/`FraisLF2` calculent
  `PvHt2 = Prvt2 × Coef2` puis le TTC et l'arrondi par **chaîne** ; `PrixVente` passe par
  `LPrix` (remise négative = marge, arrondi `LPrix.Arrondi_Calc`). Les deux chemins ne sont pas
  équivalents a priori (coefficient multiplicatif contre marge en %, arrondi par chaîne contre
  arrondi `LPrix`) : MAJTARIFM-T09 mesure l'écart ; aucune substitution n'est proposée sans
  équivalence prouvée.
- `ChkPrx`, liste fournisseurs : [`MajTarifP`](../MajTarifP.class/architecture.md),
  [`Impart`](../Impart.class/architecture.md). `Maj_Etiqp`/`Maj_Etiqg` : module `EtiqMaj`
  (MAJFBTARIF2-005, variante « gondole sans mise à jour »).
- Garde d'export → `Serveur.Actif` (SERVEUR-008).

### Réduction de portée

- `pbhtLF2`, `TrC2`, `PaUAGF2`, `PaUALF2`, `TxLF2`, `FraisLF2`, `Coeff2`, `Pourcent2`, `PvhtLF2`,
  `PvTTcLF2`, `Tva_Calcul2`, `arrondi2`, `Reaff2`, `Tris`, `CleanChamps`, `Maj_Zones`, `Fam2`,
  `Calc_Marge`, `Calc_Percent`, `Calc_Marge2`, `Calc_Percent2`, `Calc_coeff2`, `Calc_coeff3`,
  `Calc_coeff4`, `ChkPrx`, `Art_Dblclk`, `ChkInput2`, `Deb5`, `Deb6`, `Maj_Etiqp`, `Maj_Etiqg` →
  `Private` (aucun appelant externe ; `grep` vérifié : `FComptes` appelle `Ccomptes.Tris`, sans
  rapport). `Deb2`, `Deb3`, `Deb4`, `Dbclk`, `Calc_coeff` sont supprimées (code mort).
  `fourList_Click` et `colarts_Click` (`replay_dynamic`) restent `Public`.

### Séparation traitement / GUI

- Les fonctions `*2` mêlent lecture des champs, calcul et écriture : chacune appelle une fonction
  pure (ARTICLES-011) et ne garde que les affectations de texte.
- `Button2_Click` : `EnregistrePrix(sCode, valeurs…)` sans accès aux contrôles.
- `Deb5`/`Deb6` : construction de la requête dans une fonction pure `RequeteListe(sTri, sSel,
  sFour, bDesc) As String` (même texte SQL).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Historiser les changements de prix (`Fiches_HistoTarif`) : la mise à jour manuelle écrase les
  anciens prix sans trace autre que `art_ddatefbt`.
