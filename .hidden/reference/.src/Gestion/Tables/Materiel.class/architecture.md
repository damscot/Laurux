# Materiel — Architecture

> Source : `.src/Gestion/Tables/Materiel.class`

## Vue d'ensemble

`Materiel` est la fiche des **matériels suivis par numéro de série** (table `Fiches_Materiels`,
clé `(mat_serie, mat_code)`) : un exemplaire physique d'un article `Fiches_Art` marqué
`art_mat` et `art_stocke`, avec sa marque, son type, ses prix (achat, frais, revient, coefficient,
vente HT/TTC, arrondi, éco-taxe), son état (`mat_vendu`), son client (`mat_cli`), sa garantie
(`mat_chkgarantie`, `mat_dtevte`, `mat_dateg1`) et les références de sa réception
(`mat_rcpt`, `mat_four`, `mat_ddate`) et de sa vente (`mat_bl`).

**Lien avec les tables `*M` (bons et factures d'entretien/réparation)** — vérifié dans le code :

| Table | Rôle | Lien avec le matériel |
|---|---|---|
| `Fiches_Materiels` | fiche matériel (cet écran) | créée à la réception ([Achat](../../Entrées/Achat.class/architecture.md) : `mat_rcpt`, `mat_four`, `mat_ddate`), vendue par la facturation (`Facture.class:7009-7011` : `mat_vendu`, `mat_bl`, `mat_cli`, garantie ; `ObjFacB.class:997` : `mat_bl` ← n° de facture) |
| `Fiches_BlM` / `Fiches_LigblM` | bon d'entretien en cours (entête / lignes) | l'entête porte `numserie` + `codep` (= `mat_serie` + `mat_code`), `desg1`, `marque`, `typemat` (`Facture.class:1671`) |
| `Fiches_EntMat` | commentaire de réparation d'un bon (`numserie`, `codep`, `numbl`, `libelle`) | écrit par `Facture.class:1677-1681` ; non lu ici |
| `Fiches_HistoFacM` / `Fiches_HistoLigfacM` | factures d'entretien historisées | l'entête porte `numserie` + `codep` |
| `Fiches_HisentMat` (`TabHisEntm`) | commentaire de réparation historisé (`numserie`, `codep`, `numfac`, `libelle`) | lu par `Colventes_click` |

`Histo_Ventes` rassemble donc, pour un matériel : ses ventes (BL `Fiches_Bl`/`Fiches_Ligbl` et
factures `Fiches_HistoFac`/`Fiches_HistoLigfac` filtrées par `mat_bl` et le code de ligne) et ses
**interventions** (bons `Fiches_BlM` et factures `Fiches_HistoFacM` filtrés par n° de série et
code produit). `Colventes_click` affiche ensuite le détail des lignes et le commentaire de
réparation.

Ouverture modale : menu Gestion (`Fmenu.Menu190_Click`, `Fmenu.lblMat_MouseDown`, `New
Materiel("")`) et fiche article (`Articles.ToggleButton2_Click`, `New Materiel(Code.Text)` :
liste filtrée sur ce code produit via `Prd`).

Structure du formulaire : grille `colmat` (GridView, `Utils.Base` → `Utils.rs1`, colonne 0 de
1 px colorée selon `mat_vendu`), en-têtes cliquables `CO`, `Inte`, `CLT`, `SE`, `Fourn`, `Rcpt`
(tri + filtre par saisie), radios `RadioButton1`/`2` (groupe `Rb` : tous / non vendus), onglets
`TabStrip1` (fiche, prix, garantie, client, commentaire, photo), zones du groupe `Cmpt` (tags :
1 `CodeP` code produit, 2 `Code` n° de série, 3 `Marque`, 4 `Type`, 5 `PaHt`, 6 `Frais`, 7 `Coef`,
8 `Percent`, 9 `PvHt`, 10 `PvTTc`, 18 `Eco`), boutons du groupe `Btn` (1 supprimer, 2 enregistrer,
3 fermer, 4 historique ventes, 5 historique achats, 6-8 fermeture des panneaux de détail,
9 nouveau), listes `ColMarque`, `Colventes`, `Colachat`, panneaux de détail `Colrcp`/`Colrcp2`/
`Colrcp3` avec leurs zones du groupe `Rcpt`, `DateChooser1`, `Photos` (DrawingArea).

Nature globale : **GUI** avec SQL embarqué (aucun `Cbase.Table` : tous les noms de tables sont en
dur) et calculs de prix mêlés aux contrôles. Fichier legacy de 2 632 lignes, 107 fonctions toutes
`Public`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Rcli` | var | Private |  | Result | 28 |
| `rart` | var | Private |  | Result | 29 |
| `nv` | var | Private |  | Integer | 30 |
| `Tri` | var | Private |  | String | 31 |
| `Tricli` | var | Private |  | String | 32 |
| `tab` | var | Private |  | String | 33 |
| `Tabmat` | var | Private |  | String | 34 |
| `Tab2` | var | Private |  | String | 35 |
| `sel` | var | Private |  | String | 36 |
| `MatTable` | var | Private |  | New String[7] | 37 |
| `Clitable` | var | Private |  | New String[3] | 38 |
| `B` | var | Private |  | Integer | 39 |
| `B2` | var | Private |  | Integer | 40 |
| `Stk` | var | Private |  | Integer | 41 |
| `Stk2` | var | Private |  | Integer | 42 |
| `son` | var | Private |  | Integer | 43 |
| `nbdec` | var | Private |  | String | 44 |
| `Tvavente` | var | Private |  | Integer | 45 |
| `Ecotaxe` | var | Private |  | String | 46 |
| `Dbl` | var | Private |  | String | 47 |
| `CoulB` | var | Private |  | Integer | 48 |
| `CoulF` | var | Private |  | Integer | 49 |
| `CoulZns` | var | Private |  | Integer | 50 |
| `CoulZnaf` | var | Private |  | Integer | 51 |
| `CoulFc` | var | Private |  | Integer | 52 |
| `Fnt` | var | Private |  | String | 53 |
| `sKey` | var | Private |  | String | 54 |
| `Phot_art` | var | Private |  | String | 55 |
| `Bl` | var | Private |  | String | 56 |
| `Numrecept` | var | Private |  | String | 57 |
| `Prd` | var | Private |  | String | 58 |
| `produit` | var | Private |  | String | 59 |
| `produit2` | var | Private |  | String | 60 |
| `Sens` | var | Private |  | String | 61 |
| `hImage` | var | Private |  | Image | 62 |
| `Epuises` | var | Private |  | String | 63 |
| `Stockes` | var | Private |  | String | 64 |
| `Org` | var | Private |  | Integer | 65 |
| `Bsel` | var | Public |  | Boolean | 67 |
| `Bval` | var | Public |  | String | 68 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 71-113 | Public | 1 | 39 | 0 | méthode spéciale |
| `Form_Open` | 115-131 | Public | 2 | 15 | 0 | handler GUI |
| `Tabstrip1_Click` | 133-137 | Public | 1 | 3 | 0 | handler GUI |
| `colmat_Data` | 139-182 | Public | 14 | 41 | 0 | handler GUI |
| `Tris` | 184-197 | Public | 1 | 12 | 0 | portée réductible ? |
| `Deb` | 199-230 | Public | 7 | 29 | 0 | portée réductible ? |
| `Deb2` | 232-268 | Public | 8 | 33 | 0 | portée réductible ? |
| `Deb3` | 270-302 | Public | 7 | 29 | 0 | portée réductible ? |
| `Deb4` | 304-327 | Public | 5 | 21 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 334-348 | Public | 2 | 12 | 0 | handler GUI |
| `art_man` | 354-428 | Public | 11 | 72 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 435-465 | Public | 4 | 27 | 0 | handler GUI |
| `ColMarque_Click` | 470-476 | Public | 1 | 5 | 0 | handler GUI |
| `ColMarque_KeyPress` | 481-492 | Public | 5 | 10 | 0 | handler GUI |
| `Maj_Zones` | 494-570 | Public | 23 | 68 | 0 | portée réductible ? |
| `Maj_Cli` | 572-600 | Public | 3 | 26 | 0 | portée réductible ? |
| `Vendu_Click` | 602-614 | Public | 2 | 11 | 0 | handler GUI |
| `Refresh` | 616-620 | Public | 1 | 3 | 0 | portée réductible ? |
| `CleanChamps` | 622-685 | Public | 1 | 61 | 0 | portée réductible ? |
| `Fam2` | 690-723 | Public | 5 | 31 | 0 | portée réductible ? |
| `fourMan` | 728-743 | Public | 3 | 13 | 0 | portée réductible ? |
| `colmat_Click` | 745-782 | Public | 5 | 36 | 0 | handler GUI |
| `Btn_keyPress` | 784-795 | Public | 4 | 10 | 0 | handler GUI |
| `Rb_Click` | 797-816 | Public | 3 | 16 | 0 | handler GUI |
| `Btn_Click` | 818-869 | Public | 10 | 36 | 0 | handler GUI |
| `Dsg_GotFocus` | 871-882 | Public | 3 | 9 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 884-927 | Public | 12 | 34 | 0 | handler GUI |
| `Cmpt_KeyPress` | 929-998 | Public | 19 | 57 | 0 | handler GUI |
| `CodePLF` | 1000-1018 | Public | 4 | 17 | 0 | portée réductible ? |
| `CodeLF` | 1020-1041 | Public | 6 | 19 | 0 | portée réductible ? |
| `PaHtLF` | 1043-1082 | Public | 7 | 38 | 0 | portée réductible ? |
| `Active_champs` | 1084-1118 | Public | 2 | 32 | 0 | portée réductible ? |
| `Tva_Calcul` | 1123-1134 | Public | 3 | 7 | 0 | portée réductible ? |
| `Coeff` | 1139-1170 | Public | 4 | 28 | 0 | portée réductible ? |
| `Pourcent` | 1175-1205 | Public | 5 | 29 | 0 | portée réductible ? |
| `PvhtLF` | 1210-1238 | Public | 5 | 27 | 0 | portée réductible ? |
| `PvTTcLF` | 1243-1276 | Public | 6 | 31 | 0 | portée réductible ? |
| `arrondi` | 1281-1318 | Public | 10 | 33 | 0 | portée réductible ? |
| `Calc_Marge` | 1323-1330 | Public | 3 | 6 | 0 | portée réductible ? |
| `Calc_Percent` | 1335-1342 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff` | 1347-1352 | Public | 2 | 3 | 0 | portée réductible ? |
| `FraisLF` | 1357-1391 | Public | 6 | 31 | 0 | portée réductible ? |
| `Co_GotFocus` | 1393-1398 | Public | 2 | 4 | 0 | handler GUI |
| `Co_LostFocus` | 1400-1404 | Public | 2 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 1406-1411 | Public | 2 | 4 | 0 | handler GUI |
| `Inte_LostFocus` | 1413-1417 | Public | 2 | 3 | 0 | handler GUI |
| `CLT_GotFocus` | 1419-1424 | Public | 2 | 4 | 0 | handler GUI |
| `CLT_LostFocus` | 1426-1430 | Public | 2 | 3 | 0 | handler GUI |
| `SE_LostFocus` | 1432-1436 | Public | 2 | 3 | 0 | handler GUI |
| `SE_GotFocus` | 1438-1443 | Public | 2 | 4 | 0 | handler GUI |
| `fourn_LostFocus` | 1445-1449 | Public | 2 | 3 | 0 | handler GUI |
| `fourn_GotFocus` | 1451-1456 | Public | 2 | 4 | 0 | handler GUI |
| `Rcpt_LostFocus` | 1458-1462 | Public | 2 | 3 | 0 | handler GUI |
| `Rcpt_GotFocus` | 1464-1469 | Public | 2 | 4 | 0 | handler GUI |
| `Dbclk` | 1471-1481 | Public | 2 | 9 | 0 | portée réductible ? |
| `Co_Click` | 1483-1497 | Public | 1 | 12 | 0 | handler GUI |
| `Co_Dblclick` | 1499-1503 | Public | 1 | 3 | 0 | handler GUI |
| `Co_KeyPress` | 1505-1515 | Public | 3 | 9 | 0 | handler GUI |
| `Inte_Click` | 1517-1531 | Public | 1 | 12 | 0 | handler GUI |
| `Inte_Dblclick` | 1533-1537 | Public | 1 | 3 | 0 | handler GUI |
| `Inte_KeyPress` | 1539-1549 | Public | 3 | 9 | 0 | handler GUI |
| `CLT_Click` | 1551-1564 | Public | 1 | 11 | 0 | handler GUI |
| `CLT_Dblclick` | 1566-1570 | Public | 1 | 3 | 0 | handler GUI |
| `CLT_KeyPress` | 1572-1582 | Public | 3 | 9 | 0 | handler GUI |
| `Ta_Click` | 1584-1598 | Public | 1 | 12 | 0 | portée réductible ? |
| `Ta_Dblclick` | 1600-1604 | Public | 1 | 3 | 0 | portée réductible ? |
| `Ta_KeyPress` | 1606-1616 | Public | 3 | 9 | 0 | portée réductible ? |
| `Cof_Click` | 1618-1632 | Public | 1 | 12 | 0 | portée réductible ? |
| `Cof_Dblclick` | 1634-1638 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cof_KeyPress` | 1640-1650 | Public | 3 | 9 | 0 | portée réductible ? |
| `TTc_Click` | 1652-1666 | Public | 1 | 12 | 0 | portée réductible ? |
| `TTc_Dblclick` | 1668-1672 | Public | 1 | 3 | 0 | portée réductible ? |
| `TTc_KeyPress` | 1674-1684 | Public | 3 | 9 | 0 | portée réductible ? |
| `SE_Click` | 1686-1700 | Public | 1 | 12 | 0 | handler GUI |
| `SE_Dblclick` | 1702-1706 | Public | 1 | 3 | 0 | handler GUI |
| `SE_KeyPress` | 1708-1726 | Public | 7 | 17 | 0 | handler GUI |
| `fourn_Click` | 1728-1742 | Public | 1 | 12 | 0 | handler GUI |
| `fourn_Dblclick` | 1744-1748 | Public | 1 | 3 | 0 | handler GUI |
| `fourn_KeyPress` | 1750-1764 | Public | 4 | 13 | 0 | handler GUI |
| `Rcpt_Click` | 1765-1780 | Public | 1 | 13 | 0 | handler GUI |
| `Rcpt_Dblclick` | 1782-1786 | Public | 1 | 3 | 0 | handler GUI |
| `Rcpt_KeyPress` | 1788-1803 | Public | 4 | 14 | 0 | handler GUI |
| `Ref` | 1805-1813 | Public | 1 | 6 | 0 | portée réductible ? |
| `Cmpt_Gotfocus` | 1818-1831 | Public | 3 | 10 | 0 | handler GUI |
| `TestenrgMat` | 1853-1894 | Public | 11 | 39 | 0 | portée réductible ? |
| `EnrgMat` | 1896-1941 | Public | 10 | 42 | 0 | portée réductible ? |
| `reinit` | 1946-1963 | Public | 1 | 14 | 0 | portée réductible ? |
| `mat_Suppr` | 1968-2012 | Public | 9 | 41 | 0 | portée réductible ? |
| `Histo_Ventes` | 2017-2152 | Public | 24 | 132 | 0 | portée réductible ? |
| `Colventes_click` | 2157-2240 | Public | 11 | 81 | 0 | handler GUI |
| `recupfac` | 2246-2272 | Public | 7 | 25 | 0 | portée réductible ? |
| `recupbl` | 2277-2303 | Public | 7 | 25 | 0 | portée réductible ? |
| `Colventes_KeyPress` | 2308-2319 | Public | 5 | 10 | 0 | handler GUI |
| `Histo_Achat` | 2324-2397 | Public | 10 | 71 | 0 | portée réductible ? |
| `Colachat_click` | 2402-2468 | Public | 8 | 62 | 0 | handler GUI |
| `Colachat_KeyPress` | 2473-2484 | Public | 5 | 10 | 0 | handler GUI |
| `aff_Photo` | 2486-2497 | Public | 5 | 10 | 0 | portée réductible ? |
| `photos_Draw` | 2499-2503 | Public | 2 | 3 | 0 | handler GUI |
| `Nom_Photo` | 2505-2517 | Public | 2 | 10 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 2523-2535 | Public | 2 | 10 | 0 | handler GUI |
| `Cli_Man` | 2541-2560 | Public | 3 | 16 | 0 | portée réductible ? |
| `SetObservers` | 2562-2574 | Public | 4 | 10 | 0 | portée réductible ? |
| `Button7_Click` | 2579-2583 | Public | 1 | 3 | 0 | handler GUI |
| `Button10_Click` | 2585-2595 | Public | 2 | 9 | 0 | handler GUI |
| `ToggleButton4_Click` | 2597-2607 | Public | 2 | 9 | 0 | handler GUI |
| `DateChooser1_Activate` | 2609-2622 | Public | 2 | 12 | 0 | handler GUI |
| `ChkGarantie_Click` | 2624-2632 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture, grille, tri et filtre

- **`_New(code)`** [portée : nécessaire] [nature : GUI] : `Prd = code` (filtre sur un produit),
  lecture du chemin des photos `/Soc<XX>/Photart` (`Phot_art`, jamais relu) et de trois couleurs
  (jamais relues), `Utils.Observers`, libellés d'en-têtes, colonnes de `Colrcp`.
- **`Form_Open()`** [handler] : `Tabmat`, `Tri = "mat_code"`, `SetObservers`, `Tris`, `Deb`
  (si `Prd`) ou `Deb2`, `CleanChamps`, `Active_champs`. Rappelée par `Refresh`, `Rb_Click` et
  `EnrgMat`.
- **`Tabstrip1_Click()`** [handler] : `Utils.Observers(Me)` à chaque changement d'onglet.
- **`colmat_Data(Row, Column)`** (CC 14) [handler] : lit `Utils.rs1` ; colonne 0 colorée selon
  `mat_vendu` (`Start.Epuises` / `Start.Stockes`), repli sur des couleurs en dur.
- **`Tris()`** [portée : réductible] : largeurs des 7 colonnes.
- **`Deb()`, `Deb2()`, `Deb3()`, `Deb4()`** [portée : réductible] [nature : mixte] : quatre
  variantes de `select * from Fiches_Materiels where <tri> like "<motif>%" [and mat_vendu = 0]
  order by <ordre> [desc]` ⚠️ **par concaténation** de la saisie (`sel`, `Prd`) : `Deb` filtre sur
  `Prd`, `Deb2` sur `sel`, `Deb3` en ordre inverse, `Deb4` en « contient » (`%sel%`). Les ordres
  numériques passent par `cast(… as char)`. ⚠️ `Deb` teste `tri = "mat_code "` (espace final) :
  condition jamais vraie, l'ordre diffère de `Deb2` (A04). Toutes réécrivent `Stk`/`Stk2`, jamais
  relus.
- **`Rb_Click()`** [handler, groupe `Rb`] : `Refresh`, `CleanChamps`, puis `Select Case` sur les
  tags 1 et 2 alors que les radios ont les tags 3 et 4 : branches **mortes**, le filtre « non
  vendus » est appliqué par `Refresh` (qui relit les radios).
- **`colmat_Click()`** [handler, rejeu dynamique] : ferme les listes d'historique ; si la
  réception du matériel est verrouillée (`DocActif.Is_Lock("Reception", mat_rcpt)`, qui affiche lui-même
  un message), vide la fiche et désélectionne ; sinon `CleanChamps`, `Maj_Zones`, `Maj_Cli`, `Calc_Marge`, état du client
  (lecture seule si vendu), `Active_champs`.
- **En-têtes** `Co_*`, `Inte_*`, `CLT_*`, `SE_*`, `fourn_*`, `Rcpt_*` (GotFocus, LostFocus,
  Click, Dblclick, KeyPress) [handlers] : choix du tri (`mat_code`, `mat_design`, `mat_cli`,
  `mat_serie`, `mat_cfour`, `mat_rcpt`), filtre incrémental (`sel` + `Deb2`, `Deb4` pour
  l'intitulé), `*` en tête de saisie pour une recherche « contient » (`SE`, `fourn`, `Rcpt`),
  double clic → `Dbclk` (alterne `Deb3`/`Deb2`). Six jeux de handlers quasi identiques.
  ⚠️ **Collision de nom** : `Rcpt` est à la fois l'en-tête de colonne et le **groupe** des 9 zones
  des panneaux de détail (`Codefour`, `Numcom`, `Datej`, `Codefour2`, `Numbl2`, `Datebl`,
  `Codecli`, `Numfac`, `datef`, non `ReadOnly`) : entrer ou taper dans ces zones déclenche
  `Rcpt_GotFocus`/`Rcpt_KeyPress` et retrie/filtre la grille (A03).
- **`Ta_*`, `Cof_*`, `TTc_*`** (9 fonctions) : **code mort** — aucun contrôle `Ta`, `Cof`, `TTc`
  dans le `.form` (signalé `unused` par `deps.py`, vérifié).
- **`Dbclk()`**, **`Ref()`** (code mort, jamais appelée), **`Refresh()`** [portée : réductible].

### Chargement d'une fiche

- **`Maj_Zones()`** (CC 23) [portée : réductible] [nature : mixte] : `SELECT * FROM
  Fiches_Materiels WHERE mat_serie = &1 AND mat_code = &2` (ligne courante de la grille), remplit
  toutes les zones, la garantie (`Panel6`), `Fam2`, `fourMan`, `Calc_Percent`, puis la photo de
  l'article (`Fiches_Art.art_photo` → `aff_Photo`). ⚠️ **Erreurs de champ** : `Cequ` reçoit
  `mat_four` au lieu de `mat_cequ`, `Prvt` reçoit `mat_paht` au lieu de `mat_prvt`, et `Pmp`
  n'est pas chargé (`Calc_Marge` le remplit alors avec `Prvt`) : un simple ouvrir/enregistrer
  écrase `mat_cequ`, `mat_prvt` et `mat_pmp` (A01). `Tva` reçoit le taux `mat_tva` formaté puis
  `Fam2` le remplace par le code TVA de la famille. `Catch` : `Message.Error`.
- **`Maj_Cli()`** [portée : réductible] : lit `Fiches_Cli` et remplit l'onglet client ; client
  absent → vide `Cd`.
- **`Fam2()`** [portée : réductible] [nature : mixte] : lit la famille (libellé, code et taux de
  TVA, éco-taxe dans `Ecotaxe`, jamais relu), puis `Fiches_Tvaav` et `Fiches_Comptes` pour
  vérifier le compte de TVA. ⚠️ `Tvav!cc_tva` est lu sans test : un code TVA absent tombe dans le
  `Catch` qui affiche « Cette famille n'existe pas » (message trompeur, A07).
- **`fourMan()`** [portée : réductible] : nom du fournisseur ; absence → `Catch` → message,
  `B = 1`.
- **`art_man()`** (CC 11) [portée : réductible] [nature : mixte] : saisie du code produit :
  `CleanChamps`, lecture de l'article ; refus si non stocké, non matériel ou suspendu ; sinon
  recopie des données article (prix au format `nbdec`), `Calc_Percent`, `Calc_coeff`, `Arrondi`
  (avec l'arrondi par défaut, `Arr` n'étant renseigné qu'après), `Fam2`, taux de TVA, nom du
  fournisseur. ⚠️ `Rfours!fo_nom` est lu sans test `Available` et sans `Catch` : fournisseur
  absent → erreur non interceptée (A07).
- **`ToggleButton2_Click()`** [handler] : `New TriArticles(True, False, "art_code", "", "", Null,
  Radiobutton2.Value, True, Me)` (9 arguments corrects : le 6ᵉ est le `Parent` du `Form`) ; si
  `Bsel`, `CodeP = Bval`, `art_Man`.
- **`ToggleButton1_Click()`**, **`ColMarque_Click()`**, **`ColMarque_KeyPress()`** [handlers,
  `ColMarque_Click` rejeu dynamique] : liste des marques (`Fiches_Marques`, boucle `Do … Loop
  Until`) et recopie de l'intitulé.
- **`ToggleButton3_Click()`** [handler] : sélection du client par `New TriCpt(TriCpt.Client,
  TriCpt.Sans_Solde, Me)`. ⚠️ remet `Variables.Bsel` à `False` au lieu de `Me.Bsel`, et `TriCpt`
  ne réinitialise pas `Bsel` à l'ouverture : une annulation après une sélection précédente
  (article ou client) réapplique l'ancienne valeur (A09).
- **`aff_Photo()`** / **`photos_Draw()`** [handler] : chargement et dessin de l'image.
  **`Nom_Photo()`** et **`Cli_Man()`** : **code mort** (jamais appelées).

### Saisie et calcul des prix (groupe `Cmpt`)

- **`Cmpt_KeyPress()`** (CC 19) [handler] : Entrée/Retour/Tab : tag 1 `CodePLF`, 2 `CodeLF`, 3-4
  navigation, 5 `PaHtLF`, 6 `FraisLF`, 7 `Coeff`, 8 `Pourcent`, 9 `PvhtLF`, 10 `PvTTcLF`.
- **`Cmpt_Lostfocus()`** (CC 12) [handler] : si `CodeP` est renseigné, mêmes validations à la
  sortie de zone (tags 1-2 seulement en création, `nv = 1`).
- **`Cmpt_Gotfocus()`** [handler] : `Utils.SetEditColor` ; sur `CodeP` hors création, renvoie le
  focus au n° de série.
- **`CodePLF()`** [portée : réductible] : `art_Man` puis, en création, `Active_champs`.
- **`CodeLF()`** [portée : réductible] [nature : mixte] : en création, refuse un n° de série déjà
  attribué au produit (sauf matériel divers `Matdiv`) ; sinon focus sur la marque, **ou
  `TestenrgMat` si `B2 = 1`** (voir A02).
- **`PaHtLF()`**, **`FraisLF()`**, **`Coeff()`**, **`Pourcent()`**, **`PvhtLF()`**, **`PvTTcLF()`**
  [portée : réductible] [nature : calcul + GUI] : chaîne de recalcul des prix à partir de la zone
  modifiée : `Prvt = PaHt + Frais` ; `PvHt = Prvt × Coef` ; `PvTTc = PvHt × (1 + TVA/100)`
  (`Tva_Calcul`) ; ou inversement `PvHt = PvTTc / (1 + TVA/100)` ; puis `arrondi`,
  `Calc_Percent`, `Calc_coeff`, `Calc_Marge`. Format `nbdec` (selon `mat_nbd`). Saisie non
  numérique → message, `b = 1`, retour sur la zone. `PaHtLF` remet tout à zéro si le PA vaut 0.
- **`Tva_Calcul()`** [nature : calcul + GUI] : `PvTTc = PvHt + PvHt × Txtva / 100`.
- **`arrondi()`** (CC 10) [nature : calcul sur `PvTTc.Text`/`Arr.Text`] : arrondi du TTC au pas
  `0,05`/`0,10`/`0,50`/`1,00` **par chaîne** (dernier caractère `[34567]` → `5`, `Round(x, -1)`,
  découpage `Left$(…, Len − 2)` pour `0,50`), format `nbdec`. Algorithme **identique** à
  [Movr.arrondi](../Movr.class/architecture.md) (format `0.00` là-bas) ; suppose deux décimales
  (`nbdec` à 3 décimales non géré pour `0,50`).
- **`Calc_Marge()`** [nature : calcul + GUI] : `Pmp = Prvt` si vide ; `Margem = PvHt − Pmp` ;
  `Margep = Margem × 100 / Pmp` (marge sur coût, comme `Prodcomposes.Calc_Marge`).
- **`Calc_Percent()`** : taux de marque `(PvHt − Prvt) / PvHt × 100` ; **`Calc_coeff()`** :
  `Coef = 1 / (1 − taux/100)`.
- **`Active_champs()`** [nature : GUI] : zones modifiables ; code produit et n° de série
  modifiables seulement en création (`nv = 1`). **`reinit()`** : **code mort** (appel commenté).
- **`Vendu_Click()`**, **`ChkGarantie_Click()`**, **`Button10_Click()`**,
  **`ToggleButton4_Click()`**, **`DateChooser1_Activate()`** [handlers] : état du client, panneau
  de garantie, choix de la date de début (`DateG1`) ou de fin (`DateG2`). ⚠️ `DateG2` (« Date de
  fin ») n'est ni chargée ni enregistrée (aucune colonne) : la saisie est perdue (A08).
- **`Dsg_GotFocus()`** [handler, groupe `Dsg`] : si `B2 = 1`, `TestenrgMat`. `Desg3`, seul
  contrôle du groupe, est **invisible** : cet événement n'est probablement jamais levé (A02, à
  confirmer).
- **`SetObservers(hClass, hCont)`** [portée : réductible] : crée récursivement un `Observer`
  `"OBS"` sur chaque `TextBox` ; aucun handler `OBS_*` n'existe : **sans effet** (code mort).

### Enregistrement, suppression

- **`Btn_Click()`** (CC 10) [handler, groupe `Btn`] : tag 1 `mat_Suppr` ; tag 2 : `B2 = 1`,
  `Desg3.SetFocus` (contrôle invisible), `Stop Event`, `TestenrgMat`, focus sur le n° de série
  (A02) ; 3 fermeture ; 4 `Histo_ventes` ; 5 `Histo_Achat` ; 6-8 fermeture des panneaux ;
  9 nouveau (`CleanChamps`, `nv = 1`). **`Btn_keyPress()`** : Entrée sur Enregistrer →
  `TestenrgMat`.
- **`TestenrgMat()`** (CC 11) [portée : réductible] : si `b = 0` et matériel non divers, exige
  n° de série et marque ; puis `EnrgMat`. `Catch` : message, `b2 = 0`.
- **`EnrgMat()`** (CC 10) [portée : réductible] [nature : mixte] : `Utils.Remplace` sur les
  désignations ; si le couple (code, série) n'existe pas : `INSERT` de 26 colonnes (29 avec la
  garantie : `mat_dtevte`, `mat_dateg1`, `mat_chkgarantie = True`), `mat_qte = 0`,
  `mat_vendu = 0` ; sinon, hors création, `Update` de 25 colonnes (avec garantie et sans
  `mat_cli` si vendu ; sans garantie et avec `mat_cli` sinon), `mat_qte = "1"` si vendu ; en
  création avec un couple existant : message « existe déjà », sauf matériel divers où **rien
  n'est enregistré** (A12, à confirmer). Montants par `Val(…)` (virgule) ou
  `Val(Utils.cpoint(…))`. `mat_tva` n'est jamais écrit. Puis `Form_Open`/`Refresh`,
  `Active_champs`.
- **`mat_Suppr()`** [portée : réductible] [nature : mixte] : hors création, confirmation, refus si
  `Fiches_Ligbl.code_ligbl` = **n° de série** (cohérent avec `Facture.class:8190` qui rapproche le
  code de ligne du n° de série, mais pas avec `ObjFacB.class:997` qui le rapproche de `mat_code` :
  à confirmer), sinon `DELETE`. Aucun contrôle sur les bons/factures d'entretien (`*M`) ni sur
  l'historique (A11). En création : vide la fiche.

### Historiques

- **`Histo_Ventes()`** (CC 24, max du fichier) [portée : réductible] [nature : mixte] : liste
  `Colventes` (8 colonnes) : lignes de BL (`Fiches_Ligbl` où `num_ligbl = mat_bl` et `code_ligbl =
  n° de série`, entête `Fiches_Bl` de type `B`/`F`), lignes de factures historisées
  (`Fiches_HistoLigfac`, entête `Fiches_HistoFac`, lue sans test), bons d'entretien
  (`Fiches_BlM`, ⚠️ **une seule ligne** affichée, sans boucle, et colonnes prix/quantité vides) et
  factures d'entretien (`Fiches_HistoFacM`). Une requête d'entête par ligne (N+1) (A06).
- **`Colventes_click()`** (CC 11) [handler, rejeu dynamique] : détail du document choisi dans
  `Colrcp3` : client (`Fiches_Cli`, **sans test**), commentaire de réparation (`Fiches_HisentMat`),
  puis lignes de `Fiches_HistoLigfac`, `Fiches_HistoLigfacM`, `Fiches_Ligbl` ou `Fiches_LigblM`
  selon ce qui existe. ⚠️ `Bl = Rcli!numbl` sur `Fiches_BlM` sans test `Available` et sans
  `Catch` : erreur non interceptée si le bon n'existe pas (A07). La variable locale `bl` masque
  le membre `Bl`.
- **`recupfac(rcli)`** / **`recupbl()`** [portée : réductible] : remplissage de `Colrcp3` et du
  total. ⚠️ `recupfac` écrit la quantité formatée dans la colonne 2 (aussitôt écrasée par le
  libellé) au lieu de la colonne 3 ; `recupbl` lit le membre `Rcli` (état partagé) (A06).
- **`Colventes_KeyPress()`** [handler] : Entrée → `Colventes_click` ; Échap/F2 ferme.
- **`Histo_Achat()`** (CC 10) [portée : réductible] : liste `Colachat` des lignes de réception
  (`Fiches_Ligrecpt` où `numrecpt = mat_rcpt` et `code` = code article ou réf. fournisseur),
  nom du fournisseur lu sans test.
- **`Colachat_click()`** / **`Colachat_KeyPress()`** [handlers, `Colachat_click` rejeu
  dynamique] : détail de la réception dans `Colrcp2` (fournisseur lu sans test).
- **`Button7_Click()`** [handler] : `Doc.Open("Materiels")`.

## État global utilisé

- `Utils.db`, `Utils.rs1` (via `Utils.Base`), `Utils.cpoint`, `Utils.CDec`, `Utils.Cdate_Aff`,
  `Utils.Cdate_Dbase`, `Utils.Find_nbdec`, `Utils.FColr`, `Utils.Remplace`,
  `Utils.SetEditColor`, `Utils.Observers`, `Utils.ObsGotf`/`ObsLstf` ; `LDate(…).L` ;
  `DocActif.Is_Lock`.
- `Start.LocalSettings` (`/Soc<XX>/Photart`, `/Soc<XX>/Coul_fen`, `/Coul/*`), `Start.Epuises`,
  `Start.Stockes`, `Start.Societe`, `Start.Son`, `Start.Musique` ; `Variables.Bsel` (écrit par
  erreur, A09).
- Membres `Public` `Bsel`/`Bval` : écrits par [`TriArticles`](../../../Affichages/TriArticles.class/architecture.md) et [`TriCpt`](../../../Affichages/TriCpt.class/architecture.md) via
  `Object.SetProperty` (portée `Public` obligatoire).
- Membres d'état nombreux : `nv` (mode création), `B`/`B2` (drapeaux), `Tri`, `sel`, `Dbl`, `Prd`,
  `nbdec`, `Bl`, `Numrecept`, `produit`/`produit2` (partagés entre `Histo_Achat` et
  `Colachat_click`), `Rcli`/`rart` (résultats partagés entre fonctions), `Tab`/`Tab2`/`Tabmat`.
  Membres jamais lus : `Tricli`, `Clitable`, `Sens`, `Stk`, `Stk2`, `Tvavente`, `Ecotaxe`,
  `Phot_art`, `CoulZns`, `CoulZnaf`, `CoulFc`.

## Propositions d'amélioration

### Réécriture / refactorisation

Fichier legacy : reworks minimaux et ciblés.
- `Deb`/`Deb2`/`Deb3`/`Deb4` → `ChargeGrille(sMotif, bContient, bDesc)` (SQL identique, y compris
  la particularité de `Deb`) ; les six jeux d'en-têtes → `ChoixTri(sTri, hEntete)` et
  `FiltreSaisi(bEtoile)` (noms de handlers conservés).
- `Histo_Ventes` (CC 24) → quatre fonctions (`HistoBl`, `HistoFac`, `HistoBlM`, `HistoFacM`), même
  ordre de requêtes.
- `EnrgMat` : liste des colonnes communes construite une fois pour les deux `INSERT` et les deux
  `Update` (SQL identique).
- `Maj_Zones` (CC 23) : `ChargeMateriel(sSerie, sCode)` sans accès à la grille.

### Commonalisation avec d'autres fichiers

- Arrondi du TTC par chaîne : identique à [Movr.arrondi](../Movr.class/architecture.md) ;
  voisin de [FTvav.arrondi](../../../Compta/Tables/FTvav.class/architecture.md),
  [LPrix.Arrondi_Calc](../../../Utils/LPrix.class/architecture.md) (pas d'arrondi « au 5 » par
  chaîne) ; [Utils.arrondi](../../../Utils/Utils.module/architecture.md) est un arrondi décimal,
  pas un pas. `ArrondiPrix(sPrix, sArr, sFormat)` commune seulement après des tests de
  caractérisation identiques (MATERIEL-T10, MOVR-T08, FTVAV-T06).
- Chaîne de calcul de prix (PA + frais → revient → coefficient/taux de marque → PV HT → TTC →
  arrondi → marge) : même logique que la fiche [Articles](../Articles.class/architecture.md) (à
  confirmer avec le document d'`Articles`) ; candidate à un objet de calcul commun (ou
  [LPrix](../../../Utils/LPrix.class/architecture.md)) en phase 3.
- `Calc_Marge` (marge sur coût) : même formule que
  [Prodcomposes.Calc_Marge](../Prodcomposes.class/architecture.md).
- `Fam2`/`fourMan` : mêmes recherches que [Movr](../Movr.class/architecture.md) (`FamMan`,
  `fourMan`).
- Historique des ventes/achats d'un article : à rapprocher de l'onglet statistiques `Gridvi` et
  de `Histocliart` (phase 3).

### Réduction de portée

Fonctions sans appelant externe ni forme de handler → `Private` : `Tris`, `Deb`, `Deb2`, `Deb3`,
`Deb4`, `art_man`, `Maj_Zones`, `Maj_Cli`, `Refresh`, `CleanChamps`, `Fam2`, `fourMan`, `CodePLF`,
`CodeLF`, `PaHtLF`, `Active_champs`, `Tva_Calcul`, `Coeff`, `Pourcent`, `PvhtLF`, `PvTTcLF`,
`arrondi`, `Calc_Marge`, `Calc_Percent`, `Calc_coeff`, `FraisLF`, `Dbclk`, `TestenrgMat`,
`EnrgMat`, `mat_Suppr`, `Histo_Ventes`, `recupfac`, `recupbl`, `Histo_Achat`, `aff_Photo`.
`_New`, `Bsel`/`Bval` et tous les handlers restent `Public` (`ColMarque_Click`, `colmat_Click`,
`Colventes_click`, `Colachat_click` sont en plus rejoués par `Object.Call`).

### Séparation traitement / GUI

- Calculs purs sur Float/String : `PrixRevient(fPa, fFrais)`, `PrixVenteHT(fPrvt, fCoef)`,
  `PrixTTC(fHt, fTaux)`, `PrixHT(fTtc, fTaux)`, `TauxMarque(fPvht, fPrvt)`,
  `CoefDepuisTaux(fTaux)`, `MargeSurCout(fPvht, fPmp)`, `ArrondiPrix(…)` ; les `*LF` ne font plus
  que lire/écrire les zones dans le même ordre.
- `EnregistreMateriel(...)`, `SupprimeMateriel(sSerie, sCode)`, `MaterielFacture(sSerie) As
  Boolean` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Colonne de **date de fin de garantie** (`mat_dateg2`) : la zone `DateG2` existe mais n'a pas de
  colonne.
- `mat_bl` contient successivement un n° de BL puis un n° de facture (`ObjFacB.class:997`) : deux
  colonnes distinctes clarifieraient l'historique des ventes.
- Clés étrangères `mat_code` → `Fiches_Art`, `mat_cli` → `Fiches_Cli`, `mat_four` →
  `Fiches_Four`, et `(numserie, codep)` des tables `*M` → `Fiches_Materiels`.
- `mat_cdarr` en `char(4)` (`"0,05"`), `mat_nbd`/`mat_dec`/`mat_qte` en `char(1)` : codes numériques
  ou types adaptés.
- `mat_tva` (taux) n'est écrit qu'à la réception (`Achat.class:1565`), jamais par cet écran :
  redondant avec le code TVA de la famille.
