# Movr — Architecture

> Source : `.src/Gestion/Tables/Movr.class`

## Vue d'ensemble

`Movr` est la fiche de gestion des **codes de main-d'œuvre** (table `Fiches_Mo`, clé `mo_code`).
Une MO est soit au **temps** (`mo_tempmont = "1"` : temps `mo_montant` × taux horaire, valeur
calculée à la facturation, `mo_valeurht = 0`), soit au **forfait** (`mo_tempmont = "0"` : valeur HT
`mo_valeurht`, valeur TTC `mo_valeurttc` arrondie selon `mo_cdarr`). Elle référence une famille
(`mo_fam` → `Fiches_Fam`, qui fournit le code et le taux de TVA), un fournisseur (`mo_four`, entier
→ `Fiches_Four`) et un taux de MO (`mo_txcd` → `Fiches_Txtmo`, qui fournit `mo_txht`). Le prix de
revient horaire `mo_prvt` et la marge `mo_marge` sont saisis/calculés ici, puis éventuellement
écrasés par [Txmo.MajMo](../Txmo.class/architecture.md).

Ouverture modale sur l'auto-instance : menu Gestion (`Fmenu.Menu37_Click`) et touche F4 dans la
saisie de MO de la facturation (`Facture.mo_KeyPress`).

Structure du formulaire : grille `Colmo` (GridView alimentée par `Utils.Base` → `Utils.rs1`,
colonne 0 de 1 px qui porte la couleur temps/forfait), en-têtes cliquables `CO`/`Inte`/`FO`/`FA`
(tri + filtre par saisie), onglets `TabStrip1` dont un onglet de statistiques géré par
`Gridvi` (`$grv`), zones du groupe `Cmpt` (tags : 1 code, 2 désignation, 3 famille, 4 fournisseur,
5 taux MO, 6 prix de revient **et** marge, 7 temps, 8 valeur HT **et** combo d'arrondi `Arr`,
9 valeur TTC ; `Txht` est dans le groupe sans tag et en lecture seule), boutons `Btn`
(1 aide, 2 supprimer, 3 enregistrer, 4 fermer), listes `fourList`, `FamList`, `CmoList`.

Nature globale : **GUI** avec SQL embarqué et calculs de prix mêlés aux contrôles.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 28 |
| `tab` | var | Private |  | String | 29 |
| `sel` | var | Private |  | String | 30 |
| `Motable` | var | Private |  | New String[5] | 31 |
| `montante` | var | Private |  | Float | 32 |
| `B` | var | Private |  | Integer | 33 |
| `rResult` | var | Private |  | Result | 34 |
| `son` | var | Private |  | Integer | 35 |
| `Dne` | var | Private |  | String | 36 |
| `sKey` | var | Private |  | String | 37 |
| `Dbl` | var | Private |  | String | 38 |
| `CoulB` | var | Private |  | Integer | 39 |
| `CoulF` | var | Private |  | Integer | 40 |
| `Fnt` | var | Private |  | String | 41 |
| `CoulZns` | var | Private |  | Integer | 42 |
| `CoulZnaf` | var | Private |  | Integer | 43 |
| `Coulfc` | var | Private |  | Integer | 44 |
| `nv` | var | Private |  | Boolean | 45 |
| `ComboTest` | var | Private |  | Boolean | 46 |
| `hColMo` | var | Private |  | Boolean | 47 |
| `$grv` | var | Private |  | Gridvi | 48 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 50-74 | Public | 1 | 21 | 0 | méthode spéciale |
| `Tabstrip1_click` | 76-80 | Public | 1 | 3 | 0 | handler GUI |
| `Form_Open` | 82-92 | Public | 1 | 9 | 0 | handler GUI |
| `Colmo_Data` | 94-153 | Public | 18 | 57 | 0 | handler GUI |
| `Tris` | 155-167 | Public | 1 | 10 | 0 | portée réductible ? |
| `Deb2` | 169-174 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 176-181 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Zones` | 183-219 | Public | 6 | 34 | 0 | portée réductible ? |
| `Refresh` | 221-225 | Public | 1 | 3 | 0 | portée réductible ? |
| `CleanChamps` | 227-255 | Public | 1 | 27 | 0 | portée réductible ? |
| `Colmo_Click` | 257-273 | Public | 2 | 15 | 0 | handler GUI |
| `Colmo_KeyPress` | 275-282 | Public | 3 | 6 | 0 | handler GUI |
| `RdimColmo` | 284-295 | Public | 2 | 10 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 297-451 | Public | 35 | 139 | 0 | handler GUI |
| `Cmpt_Click` | 453-466 | Public | 3 | 11 | 0 | handler GUI |
| `Cmpt_GotFocus` | 471-481 | Public | 3 | 9 | 0 | handler GUI |
| `Btn_keyPress` | 483-500 | Public | 5 | 15 | 0 | handler GUI |
| `Btn_Click` | 502-519 | Public | 5 | 12 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 521-624 | Public | 29 | 85 | 0 | handler GUI |
| `code_LF` | 626-634 | Public | 2 | 7 | 0 | portée réductible ? |
| `Co_GotFocus` | 636-641 | Public | 2 | 4 | 0 | handler GUI |
| `Co_LostFocus` | 643-647 | Public | 2 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 649-654 | Public | 2 | 4 | 0 | handler GUI |
| `Inte_LostFocus` | 656-660 | Public | 2 | 3 | 0 | handler GUI |
| `fo_GotFocus` | 662-667 | Public | 2 | 4 | 0 | handler GUI |
| `fo_LostFocus` | 669-673 | Public | 2 | 3 | 0 | handler GUI |
| `Fa_GotFocus` | 675-680 | Public | 2 | 4 | 0 | handler GUI |
| `Fa_LostFocus` | 682-686 | Public | 2 | 3 | 0 | handler GUI |
| `Dbclk` | 688-698 | Public | 2 | 9 | 0 | portée réductible ? |
| `Co_Click` | 700-712 | Public | 1 | 11 | 0 | handler GUI |
| `Co_Dblclick` | 714-725 | Public | 1 | 10 | 0 | handler GUI |
| `Co_KeyPress` | 727-739 | Public | 4 | 11 | 0 | handler GUI |
| `Inte_Click` | 741-753 | Public | 1 | 11 | 0 | handler GUI |
| `Inte_Dblclick` | 755-766 | Public | 1 | 10 | 0 | handler GUI |
| `Inte_KeyPress` | 768-781 | Public | 5 | 12 | 0 | handler GUI |
| `Fo_Click` | 783-795 | Public | 1 | 11 | 0 | handler GUI |
| `Fo_Dblclick` | 797-808 | Public | 1 | 10 | 0 | handler GUI |
| `fo_KeyPress` | 810-823 | Public | 5 | 12 | 0 | handler GUI |
| `Fa_Click` | 825-837 | Public | 1 | 11 | 0 | handler GUI |
| `Fa_Dblclick` | 839-850 | Public | 1 | 10 | 0 | handler GUI |
| `Fa_KeyPress` | 852-865 | Public | 5 | 12 | 0 | handler GUI |
| `Ref` | 867-875 | Public | 1 | 6 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 880-914 | Public | 5 | 32 | 0 | handler GUI |
| `fourList_Click` | 916-926 | Public | 1 | 9 | 0 | handler GUI |
| `fourList_KeyPress` | 931-958 | Public | 6 | 24 | 0 | handler GUI |
| `mo_man` | 963-995 | Public | 10 | 29 | 0 | portée réductible ? |
| `TvaMan` | 1000-1026 | Public | 7 | 24 | 0 | portée réductible ? |
| `FamMan` | 1031-1052 | Public | 6 | 19 | 0 | portée réductible ? |
| `fourMan` | 1057-1070 | Public | 4 | 12 | 0 | portée réductible ? |
| `TxMoMan` | 1075-1095 | Public | 6 | 18 | 0 | portée réductible ? |
| `Txht_LostFocus` | 1097-1116 | Public | 5 | 18 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 1121-1157 | Public | 5 | 33 | 0 | handler GUI |
| `FamList_Click` | 1162-1178 | Public | 3 | 15 | 0 | handler GUI |
| `FamList_KeyPress` | 1183-1216 | Public | 8 | 30 | 0 | handler GUI |
| `ToggleButton5_Click` | 1218-1254 | Public | 5 | 34 | 0 | handler GUI |
| `CmoList_Click` | 1256-1269 | Public | 3 | 12 | 0 | handler GUI |
| `CmoList_KeyPress` | 1274-1299 | Public | 6 | 22 | 0 | handler GUI |
| `Button3_Click` | 1304-1333 | Public | 5 | 27 | 0 | portée réductible ? |
| `Prvt_LF` | 1335-1354 | Public | 5 | 18 | 0 | portée réductible ? |
| `Valeur_LF` | 1356-1376 | Public | 5 | 19 | 0 | portée réductible ? |
| `Valeur2_LF` | 1378-1400 | Public | 6 | 21 | 0 | portée réductible ? |
| `Valeur2TTC_LF` | 1402-1421 | Public | 5 | 18 | 0 | portée réductible ? |
| `Calc_MargeMo` | 1423-1451 | Public | 7 | 19 | 0 | portée réductible ? |
| `Button4_Click` | 1456-1502 | Public | 13 | 44 | 0 | portée réductible ? |
| `Button7_Click` | 1507-1511 | Public | 1 | 3 | 0 | portée réductible ? |
| `Temps_Click` | 1513-1523 | Public | 1 | 9 | 0 | handler GUI |
| `montant_Click` | 1525-1544 | Public | 3 | 18 | 0 | handler GUI |
| `Valeur2TTC_LostFocus` | 1549-1577 | Public | 11 | 26 | 0 | portée réductible ? |
| `Valeur2TTC_Calcul` | 1582-1594 | Public | 4 | 10 | 0 | portée réductible ? |
| `arrondi` | 1599-1635 | Public | 10 | 32 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture, grille, tri

- **`_New()`** [nature : GUI] : couleurs `/Coul/Znaff|Znss|Focus` (seule `CoulZns` est relue),
  `Utils.Observers`, son, libellés des en-têtes, `Arr.ReadOnly`, libellé de taxe
  `/Soc<XX>/Taxe`, création de `$grv = New Gridvi(TabStrip1, "M")`.
- **`Tabstrip1_click()`** [handler] : relance `Utils.Observers(Me)` à chaque changement d'onglet.
- **`Form_Open()`** [handler] : `Tri = "mo_code"`, `Tris`, `Deb2`, `cleanchamps`.
- **`Colmo_Data(Row, Column)`** (CC 18) [handler] [nature : GUI] : lit `Utils.rs1` ; colonne 0 :
  couleurs `/Coul/Motps` (temps) ou `/Coul/Momnt` (forfait), relues dans `Start.LocalSettings`
  **à chaque cellule**. ⚠️ `Utils.rs1` est un `Result` global partagé avec d'autres grilles.
- **`Tris()`** [portée : réductible] : largeurs des 5 colonnes.
- **`Deb2()` / `Deb3()`** [portée : réductible] [nature : mixte] : `select * from <TabMo> where
  <Tri> like "<sel>%" order by <Tri> [Desc]` ⚠️ **par concaténation** de la saisie `sel` (une
  apostrophe ou un guillemet casse la requête, MOVR-A04).
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : relit la MO de la ligne courante
  (`<TabMo>`), remplit toutes les zones, appelle `FamMan`, `fourMan`, `Tvaman`, `Calc_MargeMo`,
  puis met à jour l'onglet statistiques (`$grv.code`, `$grv.bouton_click()`). `Catch` vide.
- **`Refresh()`** [portée : réductible] : `Form_Open`. **`CleanChamps()`** [portée : réductible] :
  remise à zéro (mode temps, liste d'arrondis `0,01…1,00`, `nv = True`).
- **`Colmo_Click()`** [handler, rejeu dynamique] : `CleanChamps`, `Maj_Zones`, en-têtes, `nv =
  False`, réduit la grille si elle était agrandie. **`Colmo_KeyPress()`** : Échap/F2 →
  `RdimColmo` (bascule grille plein écran / normale, `Deb2` à l'agrandissement).
- **En-têtes** `Co_*`, `Inte_*`, `fo_*`, `Fa_*` (GotFocus, LostFocus, Click, Dblclick, KeyPress)
  [handlers] : choix du tri (`mo_code`, `mo_design`, `mo_four`, `mo_fam`) et filtre incrémental
  (`sel` complété à chaque touche, `Deb2`) ; double clic : `Dbclk` alterne `Deb3`/`Deb2`
  (ordre inverse). Quatre jeux de 5 handlers quasi identiques. **`Dbclk()`**, **`Ref()`**
  [portée : réductible].

### Saisie (groupe `Cmpt`)

- **`Cmpt_KeyPress()`** (CC 35, max du fichier) [handler] : Entrée/Retour/Tab valident la zone
  (`code_LF`, `Utils.Remplace`, `Famman`, `fourman`, `Txmoman`, `Prvt_LF`, `Valeur_LF`,
  `Valeur2_LF`, `Valeur2TTC_LostFocus`) et passent à la suivante si `b = 0` ; F1 aide ; F2 ouvre
  la liste famille/fournisseur/taux (`Dne` = texte saisi). Le second bloc F2 (tags 1-2) teste
  `Échap` à l'intérieur d'un `If F2` : la branche `Échap` est inaccessible.
- **`Cmpt_Lostfocus()`** (CC 29) [handler] : mêmes validations à la sortie de zone. La branche
  `Case 10` (arrondi + TTC) ne correspond à aucun contrôle (aucun tag 10) : **code mort**. Le
  tag 8 est partagé par `Valeur2` et la combo `Arr` ; le tag 6 par `Prvt` et `MargeMo`.
- **`Cmpt_Click()`** [handler] : clic sur la combo `Arr` (tag 8) → `arrondi()` puis
  `Valeur2TTC_LostFocus()` (HT recalculé depuis le TTC arrondi), sauf pendant `CleanChamps`
  (`ComboTest`).
- **`Cmpt_GotFocus()`** [handler] : `Utils.ObsGotf`, grise les zones du mode inactif.
- **`code_LF()`** [portée : réductible] : code non vide → `mo_man`, sinon `b = 1`.
- **`mo_man()`** (CC 10) [portée : réductible] [nature : mixte] : `SELECT * FROM Fiches_Mo WHERE
  mo_code = &1` ; si trouvée, ne charge que code, désignation, famille, fournisseur, taux, temps et
  ne bascule en mode temps que si `mo_tempmont <> 0`. ⚠️ Valeur HT/TTC, arrondi, prix de revient,
  commentaire et impression ne sont **pas** chargés : un enregistrement juste après une saisie
  manuelle du code les écrase (MOVR-A01, à confirmer par replay).
- **`TvaMan()`** [nature : mixte] : lit `Fiches_Tvaav` ; ⚠️ un code absent ne lève pas d'erreur,
  donc le message « Ce code Tva n'existe pas » du `Catch` n'apparaît jamais (MOVR-A03).
- **`FamMan()`**, **`fourMan()`**, **`TxMoMan()`** [nature : mixte] : lecture paramétrée
  (`Fiches_Fam`, `Fiches_Four`, `Fiches_Txtmo` en dur) ; l'absence de ligne provoque une erreur de
  lecture de champ, interceptée par `Catch` pour afficher « n'existe pas » et `b = 1` (erreur
  utilisée comme contrôle de flux).
- **`Prvt_LF()`**, **`Valeur_LF()`**, **`Valeur2_LF()`** [nature : mixte] : `Utils.cpoint`,
  contrôle numérique, format `0.00` ; `Valeur_LF` → `Calc_MargeMo` ; `Valeur2_LF` →
  `Valeur2TTC_Calcul`, `arrondi`, `Calc_MargeMo`.
- **`Valeur2TTC_LostFocus()`** [pseudo-handler : `Valeur2TTC` est dans le groupe `Cmpt`]
  [nature : calcul + GUI] : HT = TTC / (1 + taux TVA/100), formats `0.00`.
- **`Valeur2TTC_Calcul()`** [nature : calcul + GUI] : TTC = HT × (1 + taux/100) puis format.
- **`arrondi()`** (CC 10) [nature : calcul sur `Valeur2TTC.Text`/`Arr.Text`] : `"0,05"` : dernier
  caractère `[34567]` → `5`, sinon arrondi au dixième (`Round(x, -1)`) ; `"0,10"` dixième ;
  `"0,50"` découpage de chaîne (≤ ,25 → ,00 ; ≤ ,75 → ,50 ; ≥ ,76 → unité supérieure) ; `"1,00"`
  unité. Suppose deux décimales. Algorithme **identique** à `Materiel.arrondi` (au format près :
  `0.00` ici, `nbdec` là-bas) et voisin de `FTvav.arrondi`.
- **`Calc_MargeMo()`** [nature : calcul + GUI] : temps : `(taux − prvt) × temps` ; forfait :
  `tx = HT / taux`, `(taux − prvt) × tx` ; erreur → `0,00`. Même formule que
  [Txmo.Calc_MargeMo](../Txmo.class/architecture.md).
- **`Txht_LostFocus()`** et **`Valeur2TTC_LF()`** : **code mort** (`Txht` est en lecture seule et
  dans le groupe `Cmpt` sans tag ; `Valeur2TTC_LF` n'est appelée nulle part).

### Listes de sélection

- **`ToggleButton1_Click()`** (fournisseurs), **`ToggleButton3_Click()`** (familles),
  **`ToggleButton5_Click()`** (taux MO) [handlers] : bascule la liste ; si `Dne` est renseigné
  (F2 depuis la zone), filtre `left(<col>,'<n>') = '<saisie>'` **par concaténation**.
  ⚠️ `ToggleButton1_Click` exécute en plus un `SELECT * FROM Fiches_Four` inutile.
  ⚠️ `ToggleButton3_Click` filtre sur une colonne `code` qui **n'existe pas** dans `Fiches_Fam`
  (`code_fam`) : F2 sur une famille saisie provoque une erreur SQL (MOVR-A05). `Dne` n'est jamais
  remis à vide.
- **`fourList_*`, `FamList_*`, `CmoList_*`** (Click, KeyPress) [handlers, `_Click` en rejeu
  dynamique] : recopie de la sélection ; incohérences clavier/souris : `fourList_Click` passe à
  `Valeur` alors qu'Entrée passe au taux ; `CmoList_KeyPress` recopie le taux sans le formater ni
  changer de zone (MOVR-A06).

### Boutons

- **`Btn_Click()`** / **`Btn_keyPress()`** [handlers, groupe `Btn`] : aiguillage par tag ;
  Entrée sur Enregistrer → `Button4_Click`.
- **`Button4_Click()`** (CC 13) [pseudo-handler] [nature : mixte] — enregistrement : `Remplace` sur
  la désignation ; code, famille et fournisseur obligatoires ; `Valeur_LF` ou
  `Valeur2TTC_LostFocus` selon le mode ; si `b <> 1` : `INSERT` ou `UPdate` paramétrés de 16
  colonnes (`Utils.PointBase` sur les montants, `Temps.Value` pour `mo_tempmont`), puis
  rafraîchissement et repositionnement. `Catch` : `Message.Error` avec `Error.Where`.
- **`Button3_Click()`** [pseudo-handler] [nature : mixte] — suppression : refus si la MO figure dans
  `Fiches_Ligbl` (`typel_ligbl = 'M'`) ; ⚠️ aucun contrôle sur `Fiches_LigblM`, l'historique des
  factures ni les produits composés (`Fiches_PrdComp.codec`) ; rafraîchit même après « Non »
  (MOVR-A02).
- **`Button7_Click()`** : `Doc.Open("Mo")`. **`Temps_Click()`** / **`montant_Click()`** [handlers] :
  bascule temps/forfait (zones actives, couleurs `/Soc<XX>/Coul_fen`).

## État global utilisé

- `Utils.db`, `Utils.rs1` (via `Utils.Base`), `Utils.cpoint`, `Utils.PointBase`, `Utils.Remplace`,
  `Utils.FColr`, `Utils.Observers`, `Utils.ObsGotf`/`ObsLstf` ; `Cbase.Table("TabMo")` (grille,
  `Maj_Zones`, enregistrement) mais `Fiches_Mo`, `Fiches_Four`, `Fiches_Fam`, `Fiches_Txtmo`,
  `Fiches_Tvaav`, `Fiches_Ligbl` en dur ailleurs.
- `Start.LocalSettings` (`/Coul/Motps`, `/Coul/Momnt`, `/Coul/Znaff|Znss|Focus`,
  `/Soc<XX>/Coul_fen`, `/Soc<XX>/Taxe`), `Start.Societe`, `Start.Son`, `Start.Musique`.
- Membres d'état : `Tri`, `sel`, `Dne`, `Dbl`, `B` (drapeau d'erreur partagé), `nv`, `ComboTest`,
  `hColMo`, `sKey`, `montante`, `rResult` (aussi masqué par des locales homonymes), couleurs.
  `tab` est réaffecté partout mais n'est lu que localement.

## Propositions d'amélioration

### Réécriture / refactorisation

- Une fonction `ChargeMo(sCode)` utilisée par `Maj_Zones` et `mo_man` : supprime la divergence de
  chargement (mais change le comportement de `mo_man` → seulement avec MOVR-A01).
- `Deb2`/`Deb3` → `ChargeGrille(bDesc)` ; les quatre jeux d'en-têtes → `ChoixTri(sTri, hEntete)` et
  `FiltreSaisi()` (noms de handlers conservés).
- `Cmpt_KeyPress`/`Cmpt_Lostfocus` : une fonction `ValideZone(iTag) As Boolean` commune aux deux
  (même ordre d'appels).
- `ToggleButton1/3/5_Click` : un remplisseur de liste `RemplitListe(hListe, sTable, sCle, …)`.

### Commonalisation avec d'autres fichiers

- Calcul de marge MO : commun avec [Txmo](../Txmo.class/architecture.md) (TXMO-005).
- Arrondi du TTC par chaîne (`arrondi`) : même algorithme que
  [Materiel.arrondi](../Materiel.class/architecture.md) et voisin de
  [FTvav.arrondi](../../../Compta/Tables/FTvav.class/architecture.md),
  [LPrix.Arrondi_Calc](../../../Utils/LPrix.class/architecture.md) et
  [Utils.arrondi](../../../Utils/Utils.module/architecture.md) (ce dernier est un arrondi décimal,
  pas un pas de 0,05). Une fonction unique `ArrondiPrix(sPrix, sArr, sFormat)` n'est adoptée
  qu'après des tests de caractérisation identiques (MOVR-T08, MATERIEL-T10, FTVAV-T06).
- Recherche famille/fournisseur avec erreur comme contrôle de flux (`FamMan`, `fourMan`) : mêmes
  fonctions dans [Materiel](../Materiel.class/architecture.md) (`Fam2`, `fourMan`).
- Grille triable avec en-têtes `CO`/`Inte`/… et `Utils.Base` : motif partagé avec `Materiel` et
  les autres fiches de `Gestion/Tables` (phase 3).

### Réduction de portée

`Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`, `CleanChamps`, `RdimColmo`, `code_LF`, `Dbclk`,
`Ref`, `mo_man`, `TvaMan`, `FamMan`, `fourMan`, `TxMoMan`, `Prvt_LF`, `Valeur_LF`, `Valeur2_LF`,
`Calc_MargeMo`, `Valeur2TTC_Calcul`, `arrondi` → `Private` (aucun appelant externe : seuls
`Fmenu` et `Facture` ouvrent l'écran). Les pseudo-handlers (`Button3_Click`, `Button4_Click`,
`Button7_Click`, `Valeur2TTC_LostFocus`) gardent nom et portée.

### Séparation traitement / GUI

- `EnregistreMo(...)` (INSERT/UPdate) et `SupprimeMo(sCode) As Boolean` sans accès aux contrôles.
- Calculs purs : `PrixTTC(fHt, fTaux)`, `PrixHT(fTtc, fTaux)`, `ArrondiPrix`, `MargeMo` ; les
  handlers ne font que lire/écrire les zones.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `mo_tempmont` en `varchar(1)` ("0"/"1") → booléen `tinyint(1)` ; `mo_cdarr` en `varchar(4)`
  ("0,05") → code numérique d'arrondi partagé avec les articles.
- `mo_txht` duplique `Fiches_Txtmo.tx_txtmo` (et `mo_prvt` son prix de revient) : jointure sur
  `mo_txcd` au lieu de la recopie de `Txmo.MajMo`.
- Clés étrangères `mo_fam`, `mo_four`, `mo_txcd`, `mo_tva` ; contrôle de suppression géré par la
  base (lignes de BL, bons d'entretien, produits composés).
