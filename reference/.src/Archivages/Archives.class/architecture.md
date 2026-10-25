# Archives — Architecture

> Source : `.src/Archivages/Archives.class`

## Vue d'ensemble

`Archives` est l'écran **« Factures archivées »** (`Fmenu.Menu72` et clic sur l'étiquette
`lblArch` du menu, modal ; auteur J. Tripoteau, 2005) : consultation des factures clients émises
(`Fiches_HistoFac` + `Fiches_HistoLigfac`) et, avec l'option matériel (`/Soc<XX>/Materiel`), des
factures entretien (`Fiches_HistoFacM` + `Fiches_HistoLigfacM`, matériel `Fiches_HisentMat`).
Les mêmes tables sont purgées par [`RazHistoFac`](../RazHistoFac.class/architecture.md).

Organisation :

- **liste** paginée `Colbl` (GridView virtuelle : `Utils.Base` remplit `Utils.rs1`, `Colbl_Data`
  lit la ligne demandée) ; trois boutons radio `Fact` (toutes), `Face` (entretien), `Facn` (hors
  entretien) ; une rangée d'en-têtes `NO`, `DA`, `CO`, `NM` (ComboBox : Nom / Commentaire / Code
  produit / Libellé produit), `MT`, `MTC`, `NUMS` qui servent de tri (prise de focus), de filtre
  (frappe, `LIKE "%…%"`) et d'inversion (double-clic) ; 24 variantes de requêtes dans `Deb2`,
  `Deb2b`, `Deb3`, `Deb3b` ;
- **recherche dans les lignes** (commentaire, code ou libellé produit) par la table de travail
  `Blcom` (`Colfac_com`, `Colfac_art`, `Colfac_libel`, puis `Debcom`) ;
- **détail** (`Colbl_click` → `Recup_ligbl`) : en-tête client, lignes dans `Coldetail`
  (ColumnView), totaux MO / articles / remise / HT / TVA / TTC, bloc matériel pour une facture
  entretien ; navigation facture suivante / précédente (`Button1`/`Button2`) ;
- **réimpression / envoi** (`Button9_Click`) : `New OptFac(ObjFac.archive, code, numfac, Me.Parent,
  TTC, False, LDate(date), mail)` → [`OptFac`](../../Gestion/Facturation/OptFac.class/architecture.md)
  instancie [`ObjFacB`](../../Gestion/option/ObjFacB.class/architecture.md) en mode `archive`, qui
  relit la facture comme [`ObjFac`](../../Gestion/Facturation/ObjFac.class/architecture.md)
  (`Fiches_HistoFac` puis `…M`) et produit le PDF (archivage GED par
  [`LGed`](../../Utils/LGed.class/architecture.md) côté facturation) ;
- **suivi** (F12 dans le détail) : `New Suivi(…)`.

Lecture seule sur les données métier, sauf la table de travail `Blcom` (créée **permanente** par
`Colfac_com`/`Colfac_libel`, **temporaire** par `Colfac_art` ; même nom que la table temporaire de
`Facture`, de structure différente) et la clé de configuration `/Soc<XX>/Col/LcolH` (largeurs des
colonnes du détail).

Le fichier porte beaucoup d'état hérité d'une ancienne impression locale : **20 membres privés
jamais utilisés** et une quinzaine écrits mais jamais relus (voir ARCHIVES-003/004).

Instrumenté (`Utils.Observers(Me)` dans `_New`). Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Factbl` | var | Private |  | New String[8] | 26 |
| `n` | var | Private |  | Integer | 27 |
| `typeL` | var | Private |  | String | 28 |
| `rResult` | var | Private |  | Result | 29 |
| `Rhistolig` | var | Private |  | Result | 30 |
| `datej` | var | Private |  | String | 31 |
| `Cv` | var | Private |  | String | 32 |
| `Txmo` | var | Private |  | String | 33 |
| `Txpieces` | var | Private |  | String | 34 |
| `Tp` | var | Private |  | String | 35 |
| `Totalmo` | var | Private |  | String | 36 |
| `Totalart` | var | Private |  | String | 37 |
| `Totalrem` | var | Private |  | String | 38 |
| `totalht` | var | Private |  | String | 39 |
| `Totalttc` | var | Private |  | String | 40 |
| `TvaCli` | var | Private |  | String | 41 |
| `Pnm` | var | Private |  | String | 42 |
| `adr1` | var | Private |  | String | 43 |
| `adr2` | var | Private |  | String | 44 |
| `cp` | var | Private |  | String | 45 |
| `cpt` | var | Private |  | String | 46 |
| `Burd` | var | Private |  | String | 47 |
| `Intit` | var | Private |  | String | 48 |
| `dateech` | var | Private |  | String | 49 |
| `reglt` | var | Private |  | String | 50 |
| `Ttva` | var | Private |  | Float | 51 |
| `Nbl` | var | Private |  | Float | 52 |
| `Txtleg` | var | Private |  | String | 53 |
| `Txtleg2` | var | Private |  | String | 54 |
| `sMail` | var | Private |  | String | 55 |
| `jour` | var | Private |  | String | 56 |
| `Prxdec` | var | Private |  | Boolean | 57 |
| `NbEnreg` | var | Private |  | Integer | 58 |
| `NbEnregTot` | var | Private |  | Integer | 59 |
| `sDa` | var | Private |  | String | 60 |
| `Filename` | var | Private |  | String | 61 |
| `Ardi` | var | Private |  | String | 62 |
| `nbdec` | var | Private |  | String | 63 |
| `CoulB` | var | Private |  | Integer | 64 |
| `CoulF` | var | Private |  | Integer | 65 |
| `Fnt` | var | Private |  | String | 66 |
| `CoulFoc` | var | Private |  | Integer | 67 |
| `Coulfond` | var | Private |  | New String[] | 68 |
| `Tri` | var | Private |  | String | 69 |
| `sel` | var | Private |  | String | 70 |
| `Dbl` | var | Private |  | String | 71 |
| `com` | var | Private |  | Boolean | 72 |
| `Dat` | var | Private |  | Integer | 73 |
| `PosY` | var | Private |  | Integer | 74 |
| `Visudoc` | var | Private |  | Boolean | 75 |
| `Devises` | var | Private |  | String | 76 |
| `Typefac` | var | Private |  | String | 77 |
| `Ctva` | var | Private |  | String | 78 |
| `Txtva` | var | Private |  | String | 79 |
| `spiece` | var | Private |  | String | 80 |
| `ImpAuto` | var | Private |  | Boolean | 81 |
| `Franchise` | var | Private |  | Boolean | 82 |
| `Prenom` | var | Private |  | String | 83 |
| `sel2` | var | Private |  | String | 84 |
| `pdf` | var | Private |  | Object | 85 |
| `Pays` | var | Private |  | String | 86 |
| `lg` | var | Private |  | Integer | 87 |
| `Dep` | var | Private |  | String | 88 |
| `ComboCom` | var | Private |  | Boolean | 89 |
| `Ty` | var | Private |  | String | 90 |
| `chkfocus` | var | Private |  | Boolean | 91 |
| `$soption` | var | Private |  | String | 92 |
| `$sfrais` | var | Private |  | String | 93 |
| `$borientation` | var | Private |  | Boolean | 94 |
| `$snum` | var | Private |  | String | 95 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 100-207 | Public | 25 | 102 | 0 | méthode spéciale |
| `Form_Open` | 209-219 | Public | 2 | 9 | 0 | handler GUI |
| `Colbl_Data` | 221-278 | Public | 22 | 55 | 0 | handler GUI |
| `Deb2` | 280-314 | Public | 9 | 32 | 0 | portée réductible ? |
| `Deb2b` | 316-347 | Public | 8 | 30 | 0 | portée réductible ? |
| `Deb3b` | 349-380 | Public | 8 | 30 | 0 | portée réductible ? |
| `Deb3` | 382-413 | Public | 8 | 30 | 0 | portée réductible ? |
| `Debcom` | 415-423 | Public | 1 | 6 | 0 | portée réductible ? |
| `Tris` | 425-445 | Public | 2 | 19 | 0 | portée réductible ? |
| `Face_Click` | 447-460 | Public | 2 | 11 | 0 | handler GUI |
| `Fact_Click` | 462-475 | Public | 2 | 11 | 0 | handler GUI |
| `Facn_Click` | 477-489 | Public | 2 | 10 | 0 | handler GUI |
| `Titre` | 491-501 | Public | 2 | 9 | 0 | portée réductible ? |
| `NO_Click` | 503-516 | Public | 1 | 12 | 0 | handler GUI |
| `NO_Dblclick` | 518-523 | Public | 1 | 4 | 0 | handler GUI |
| `NO_KeyPress` | 525-538 | Public | 4 | 12 | 0 | handler GUI |
| `DA_Click` | 540-553 | Public | 1 | 12 | 0 | handler GUI |
| `DA_Dblclick` | 555-561 | Public | 1 | 5 | 0 | handler GUI |
| `DA_KeyPress` | 563-587 | Public | 8 | 23 | 0 | handler GUI |
| `CO_Click` | 589-602 | Public | 1 | 12 | 0 | handler GUI |
| `CO_Dblclick` | 604-609 | Public | 1 | 4 | 0 | handler GUI |
| `CO_KeyPress` | 611-624 | Public | 4 | 12 | 0 | handler GUI |
| `NM_Dblclick` | 626-631 | Public | 1 | 4 | 0 | handler GUI |
| `MT_Click` | 633-646 | Public | 1 | 12 | 0 | handler GUI |
| `MT_Dblclick` | 648-653 | Public | 1 | 4 | 0 | handler GUI |
| `MT_KeyPress` | 655-668 | Public | 4 | 12 | 0 | handler GUI |
| `MTC_Click` | 670-683 | Public | 1 | 12 | 0 | handler GUI |
| `MTC_Dblclick` | 685-690 | Public | 1 | 4 | 0 | handler GUI |
| `MTC_KeyPress` | 692-705 | Public | 4 | 12 | 0 | handler GUI |
| `NUMS_Click` | 707-720 | Public | 1 | 12 | 0 | handler GUI |
| `NUMS_Dblclick` | 722-727 | Public | 1 | 4 | 0 | handler GUI |
| `NUMS_KeyPress` | 729-742 | Public | 4 | 12 | 0 | handler GUI |
| `Dbclk` | 744-765 | Public | 5 | 20 | 0 | portée réductible ? |
| `NO_GotFocus` | 770-775 | Public | 1 | 4 | 0 | handler GUI |
| `NO_LostFocus` | 777-781 | Public | 2 | 3 | 0 | handler GUI |
| `DA_GotFocus` | 783-788 | Public | 1 | 4 | 0 | handler GUI |
| `DA_LostFocus` | 790-794 | Public | 2 | 3 | 0 | handler GUI |
| `CO_GotFocus` | 796-801 | Public | 1 | 4 | 0 | handler GUI |
| `CO_LostFocus` | 803-807 | Public | 2 | 3 | 0 | handler GUI |
| `NM_Gotfocus` | 809-850 | Public | 6 | 32 | 0 | handler GUI |
| `NM_LostFocus` | 852-856 | Public | 1 | 2 | 0 | handler GUI |
| `NM_KeyPress` | 858-885 | Public | 11 | 26 | 0 | handler GUI |
| `Colfac_com` | 887-926 | Public | 10 | 35 | 0 | portée réductible ? |
| `Colfac_art` | 928-966 | Public | 6 | 30 | 0 | portée réductible ? |
| `Colfac_libel` | 968-1005 | Public | 6 | 30 | 0 | portée réductible ? |
| `MT_GotFocus` | 1007-1012 | Public | 1 | 4 | 0 | handler GUI |
| `MT_LostFocus` | 1014-1018 | Public | 2 | 3 | 0 | handler GUI |
| `MTC_GotFocus` | 1020-1025 | Public | 1 | 4 | 0 | handler GUI |
| `MTC_LostFocus` | 1027-1031 | Public | 2 | 3 | 0 | handler GUI |
| `NUMS_GotFocus` | 1033-1038 | Public | 1 | 4 | 0 | handler GUI |
| `NUMS_LostFocus` | 1040-1044 | Public | 2 | 3 | 0 | handler GUI |
| `Maj_Zones` | 1046-1048 | Public | 1 | 2 | 0 | portée réductible ? |
| `Refresh` | 1050-1054 | Public | 1 | 3 | 0 | portée réductible ? |
| `CleanChamps` | 1056-1066 | Public | 1 | 9 | 0 | portée réductible ? |
| `Colbl_MouseWheel` | 1068-1077 | Public | 2 | 8 | 0 | handler GUI |
| `Colbl_KeyPress` | 1079-1103 | Public | 9 | 21 | 0 | handler GUI |
| `Descendre_Click` | 1105-1115 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 1117-1125 | Public | 4 | 7 | 0 | handler GUI |
| `Deplacement` | 1127-1157 | Public | 10 | 29 | 0 | portée réductible ? |
| `Descendre_KeyPress` | 1159-1168 | Public | 5 | 8 | 0 | handler GUI |
| `Remonter_KeyPress` | 1170-1179 | Public | 5 | 8 | 0 | handler GUI |
| `Colbl_click` | 1181-1252 | Public | 18 | 68 | 0 | handler GUI |
| `Recup_ligbl` | 1254-1410 | Public | 35 | 147 | 0 | portée réductible ? |
| `CalculTotal` | 1412-1428 | Public | 3 | 14 | 0 | portée réductible ? |
| `Coldetail_KeyPress` | 1430-1440 | Public | 2 | 8 | 0 | handler GUI |
| `Button15_Click` | 1442-1450 | Public | 1 | 5 | 0 | handler GUI |
| `Button5_Click` | 1452-1458 | Public | 3 | 5 | 0 | handler GUI |
| `Button9_Click` | 1460-1468 | Public | 1 | 6 | 0 | handler GUI |
| `Button1_Click` | 1471-1482 | Public | 2 | 10 | 0 | handler GUI |
| `Button2_Click` | 1484-1495 | Public | 2 | 10 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** (CC 25) [portée : nécessaire (spéciale)] [nature : mixte]. `Music.Load` ;
  `SELECT * FROM <TabParam>` pour la seule devise (`devises`, jamais relue) ; calcul de `lg` ;
  couleurs de focus ; sans option matériel : masque `HBox3`/`NUMS`, réduit et décale `Colbl`, coche
  `Facn` ; `Utils.Observers(Me)` ; `Prxdec` (prix sans décimales) ; libellés des en-têtes ; largeurs
  des 9 colonnes de `Coldetail` depuis `/Soc<XX>/Col/LcolH` (`col0:60;col1:140;…`, `Scan`) ou valeurs
  par défaut ; `SELECT numfac FROM <TabHisFac>` pour compter **toutes** les factures (`NbEnregTot`,
  factures entretien non comptées) ; `$soption = Utils.Option()`.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. `Tri = "numfac"`, `Tris`, puis
  `Facn_Click` (sans matériel) ou `Fact_Click`.
- **`Tris()`** [portée : réductible] [nature : GUI]. Largeurs des 8 colonnes de `Colbl`.
- **`Titre()`** [portée : réductible] [nature : GUI]. Remet les libellés des en-têtes (sauf `NM`
  quand `ComboCom`).

### Liste des factures

- **`Colbl_Data(Row, Column)`** (CC 22) [portée : nécessaire (handler)] [nature : GUI]. Lit
  `Utils.rs1` à la ligne `Row` ; relit les couleurs `/Coul/Facts` (et `/Coul/Avs`, inutilisée) **à
  chaque cellule** ; date tronquée à 10 caractères, nom + prénom, montants `0.00` (arrondis si
  `Prxdec`), `numserie` « False » masqué. Dépend de l'état global `Utils.rs1` : toute autre fenêtre
  qui appelle `Utils.Base` pendant que l'écran est ouvert (ex. `OptFac` modal) peut changer les
  données affichées au prochain rafraîchissement (à confirmer).
- **`Deb2()` / `Deb3()`** (CC 9/8) [portée : réductible] [nature : mixte]. Selon le bouton radio :
  `select pnmclifac, numfac, datefac, cdclifac, nmclifac, totfac, totfacttc, numserie from
  <TabHisFac>|<TabHisFacm>|union des deux where <Tri> like "%<sel>%" order by …` avec, si `dat = 0`,
  `order by abs(lpad(<tri>,10,' '))` (tri numérique) et sinon `order by <tri>,datefac` (`Deb2`) ou
  `<tri> desc` (`Deb3`) ; `limit NbEnreg, lg`. ⚠️ Dans l'union (« Toutes »), la partie entretien
  filtre par **préfixe** (`like "<sel>%"`) et non par sous-chaîne (A04). Saisie concaténée (A06).
  Sous SQLite, `abs(lpad(…))` est traduit en SQL invalide par `DB_Connection` (DB_CONNECTION-A03) :
  l'ouverture de l'écran échoue (A07, à confirmer).
- **`Deb2b()` / `Deb3b()`** [portée : réductible] [nature : mixte]. Même chose avec `sel2` (motif de
  date `%-MM-JJ` ou `AA-MM-JJ`) et `order by <tri> [desc]` ; les branches `dat = 0` et `dat ≠ 0`
  sont identiques.
- **`Debcom()`** [portée : réductible] [nature : mixte]. `select … from Blcom order by numfac limit …`.
- **`Face_Click`, `Fact_Click`, `Facn_Click`** [portée : nécessaire (handlers)] [nature : GUI].
  Disposition de `Colbl`/`HBox2` (`Archives.Width` : auto-instance = `Me`), `Deb3`, focus.
- **`Dbclk()`** [portée : réductible] [nature : GUI]. Inverse l'ordre (`Deb3`/`Deb3b` ↔
  `Deb2`/`Deb2b`), sauf en recherche par commentaire.
- **`Deplacement()`** (CC 10) [portée : réductible] [nature : GUI]. Borne `NbEnreg` à
  `[0, NbEnregTot]` puis recharge selon `sDa`, `Dbl`, `com`, `Dat`. ⚠️ En mode filtre par date
  (`sDa`), le rechargement appelle `Deb2` avec `sel` (chiffres saisis) au lieu de `Deb2b` avec `sel2`
  → page vide ; avec `Dbl` et `Dat = 0`, rien n'est rechargé (A02, à confirmer).

### En-têtes de tri et de filtre

- **`NO_Click`, `DA_Click`, `CO_Click`, `MT_Click`, `MTC_Click`, `NUMS_Click`** [portée : nécessaire
  (noms de handler conservés)] [nature : GUI]. Réinitialisent le filtre et fixent `Tri` (`numfac`,
  `datefac`, `cdclifac`, `totfac`, `totfacttc`, `numserie`) et `Dat` puis `Deb2`. Un `TextBox` ne
  lève pas `Click` : ces fonctions ne sont appelées que par les `*_GotFocus` correspondants.
- **`NO_GotFocus`, `DA_GotFocus`, `CO_GotFocus`, `MT_GotFocus`, `MTC_GotFocus`, `NUMS_GotFocus`**
  [portée : nécessaire (handlers)] [nature : GUI]. Couleur de focus puis `*_Click`.
- **`*_LostFocus`** (`NO`, `DA`, `CO`, `MT`, `MTC`, `NUMS`) [portée : nécessaire (handlers)].
  `Try Utils.ObsLstf(zone)` ; `NM_LostFocus` est vide (appel commenté).
- **`*_Dblclick`** (`NO`, `DA`, `CO`, `NM`, `MT`, `MTC`, `NUMS`) [portée : nécessaire (handlers)].
  Fixent `Dat` (et `sDa` pour `DA`) puis `Dbclk`.
- **`NO_KeyPress`, `CO_KeyPress`, `MT_KeyPress`, `MTC_KeyPress`, `NUMS_KeyPress`** [portée :
  nécessaire (handlers)] [nature : GUI]. Ajoutent ou retirent un caractère à `sel` puis `Deb2`
  (`CO_KeyPress` force `Dat = 1`, alors que `CO_Click` le met à 0).
- **`DA_KeyPress`** (CC 8) [portée : nécessaire (handler)]. Ignore Entrée et `.` ; à 4 chiffres
  (`JJMM`) → `sel2 = "%-MM-JJ"`, à 8 chiffres (`JJMMAAAA`) → `sel2 = "AA-MM-JJ"` puis `Deb2b`.
- **`NM_Gotfocus`** [portée : nécessaire (handler)]. Selon le texte affiché par la ComboBox **au
  moment de la prise de focus** : `Tri = "nmclifac"` (et `Deb2`), ou `com_ligfac`, `code_ligfac`,
  `libel_ligfac` ; vide ensuite la zone. Il n'y a pas de `NM_Click` : choisir un critère dans la
  liste sans reprendre le focus laisse le tri par nom (A10, à confirmer).
- **`NM_KeyPress`** (CC 11) [portée : nécessaire (handler)]. Entrée : lance `Colfac_com`,
  `Colfac_art` ou `Colfac_libel` selon `Tri` ; tri par nom : filtre au fil de la frappe.

### Recherche dans les lignes de facture (table `Blcom`)

- **`Colfac_com()`** [portée : réductible] [nature : mixte]. `drop TABLE if exists Blcom` +
  `CREATE TABLE Blcom` (**permanente**, 7 colonnes) ; lignes `C` de `<TabHisLigFac>` dont le
  commentaire contient la saisie (concaténée) ; pour chaque facture, insertion (`Try`) de l'en-tête
  avec la 1re ligne non vide du commentaire à la place du nom ; puis `Debcom`.
- **`Colfac_art()`** [portée : réductible] [nature : mixte]. `CREATE TEMPORARY TABLE Blcom` **sans
  suppression préalable** : au 2e appel dans la session (ou après `Facture.creblcom`), la création
  échoue (A01) ; lignes `A` dont le code contient la saisie ; `commentaire` jamais affecté (nom
  vide) ; trace `Print rLib.count`.
- **`Colfac_libel()`** [portée : réductible] [nature : mixte]. Comme `Colfac_com` (table permanente)
  sur `libel_ligfac` des lignes `A` ; `commentaire` jamais affecté.
- Les trois fonctions ne cherchent que dans les factures hors entretien (`TabHisLigFac`).

### Détail d'une facture

- **`Colbl_click()`** (CC 18) [portée : nécessaire (handler, rejoué par `Object.Call`, doit rester
  `Public`)] [nature : mixte]. `CleanChamps` ; numéro de la ligne courante ; en-tête lu dans
  `<TabHisFac>` ou `<TabHisFacm>` selon le bouton radio (`Typefac` `N`/`E`) ; adresse, échéance,
  règlement, dépôt, frais de gestion (variables pour la plupart jamais relues) ; client
  (`cli_email`, `cli_pays`, `cli_id_tva`) : `rmail!cli_id_tva` est lu **sans test `Available`**
  (client supprimé → erreur, A05, à confirmer) ; remise à zéro des totaux ; `Recup_ligbl`. `Catch`
  → son + `Message.Error`.
- **`CleanChamps()`** [portée : réductible] [nature : GUI]. Totaux texte à « 0,00 », dépôt vide.
- **`Recup_ligbl(Typef)`** (CC 35, max du fichier) [portée : réductible] [nature : mixte].
  `Variables.bRemise = False` ; options boissons (`$soption` `B`/`T`) : lecture de `Fiches_ligcons`
  puis `Fiches_ligregie` pour `$snum`, jamais relu ; matériel (`<TabHisEntm>` = `Fiches_HisentMat`,
  lu même pour une facture `N`) ; lignes de `<TabHisLigFac>` ou `<TabHisLigFacm>` (boucle
  `Do … Loop Until MoveNext()`) : commentaires `C`/`R` éclatés par ligne, lignes `O` (qté seule),
  autres lignes avec prix (arrondis si `Prxdec`) et `Variables.bRemise` si remise ; écrit aussi
  `Coldetail.Item[10..13]` alors que la vue n'a que 9 colonnes (jamais relus) ; `CalculTotal` sauf
  pour `E`/`T` ; totaux HT/TTC repris de la **ligne de liste** (`colbl[row, 5/6]`), TVA = TTC − HT ;
  `Utils.orientation` (résultat `$borientation` jamais relu) ; disposition du détail et du bloc
  matériel. `Catch` → `Message.Error`.
- **`CalculTotal()`** [portée : réductible] [nature : calcul]. Cumule MO (`M`), articles (`A`),
  remise (brut − net), HT et TTC de la ligne courante `Rhistolig` en texte `0.00`.
- **`Coldetail_KeyPress()`** [portée : nécessaire (handler)]. F12 → `New Suivi(code, "", "", "", "",
  "", numfac, "", False, True, True).ShowModal()` (11 arguments, conforme à `Suivi._new`).
- **`Button15_Click()`** [portée : nécessaire (handler)]. Retour à la liste.
- **`Button1_Click()` / `Button2_Click()`** [portée : nécessaire (handlers)]. Facture suivante /
  précédente : ⚠️ bornes de page codées en dur (`row + 1 = 26`, `row + 25`) au lieu de `lg` (A03).
- **`Button9_Click()`** [portée : nécessaire (handler)]. `OptFac` en mode `ObjFac.archive` (appel
  conforme : 3 paramètres obligatoires, `Parent`, puis les optionnels), puis `Colbl_Click` pour
  rafraîchir le détail.
- **`Button5_Click()`** [portée : nécessaire (handler)]. `Kill filename` (jamais affecté : sans
  effet), sauvegarde des largeurs `/Soc<XX>/Col/LcolH`, fermeture.

### Pagination

- **`Colbl_MouseWheel`, `Colbl_KeyPress`, `Descendre_Click`, `Remonter_Click`,
  `Descendre_KeyPress`, `Remonter_KeyPress`** [portée : nécessaire (handlers)] [nature : GUI]. Même
  schéma que [`ArchivesTck`](../ArchivesTck.class/architecture.md) ; Échap/F2 sur les boutons
  sauvegardent les largeurs (copie de `Button5_Click`) et ferment.

### Code mort

- **`Maj_Zones()`** (vide) et **`Refresh()`** (rappelle le handler d'ouverture) [portée : réductible] : signal
  `unused` vérifié (aucun appel, aucune chaîne d'appel dynamique). `Refresh` masque
  `Control.Refresh`, jamais appelé sur cette fenêtre.

## État global utilisé

- `Utils.db`, `Utils.Base`/`Utils.rs1` (état global partagé), `Utils.FColr`, `Utils.cpoint`,
  `Utils.Cdate_Aff`, `Utils.Option`, `Utils.orientation`, `Utils.ObsLstf`, `Utils.Observers` ;
  `Variables.bRemise` (lu par `Cdocuments` à l'impression) ; `Start.Societe`, `Start.Musique`,
  `Start.son`, `Start.LocalSettings` (`/Soc<XX>/Materiel`, `/Prxdec`, `/Coul_fen`, `/Col/LcolH`,
  `/Coul/Focus`, `/Coul/Fnets`, `/Coul/Coulfonds`, `/Coul/Facts`, `/Coul/Avs`).
- Table de travail `Blcom` (nom en dur).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les membres jamais utilisés et ceux écrits sans être relus, avec les lectures SQL qui ne
  servent qu'à eux (`TabParam` pour la devise, `Fiches_ligcons`/`Fiches_ligregie`,
  `Utils.orientation`) : SQL modifié, dump identique. `TvaCli`/`rmail!cli_id_tva` reste lié à A05.
- `NbEnregTot` par `SELECT COUNT(*)` (SQL modifié, même valeur).
- 24 requêtes de liste → une fonction pure `RequeteFactures(iMode, sTri, sFiltre, bFiltreDate,
  bNumerique, bDesc, iDebut, iNb) As String` produisant **exactement** les textes actuels (dont le
  `like "<sel>%"` de l'union, A04) ; `Deb2`/`Deb2b`/`Deb3`/`Deb3b` deviennent des appels.
- `Colbl_Data` : lire les couleurs une fois (dans `_New` ou au changement de mode).
- `Colfac_com`/`Colfac_art`/`Colfac_libel` → `RechercheLignes(sColonne, sTypeLigne, bCommentaire)`
  en conservant chaque DDL actuel (A01 inchangée).
- Supprimer `Print rLib.count`, `Kill filename` et la réaffectation redondante de `nlig`.

### Commonalisation avec d'autres fichiers

- Pagination → `PaginationListe` (TRICARTES-005, voir [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md)),
  partagée avec [`ArchivesTck`](../ArchivesTck.class/architecture.md) et les `Tri*`.
- Largeurs de colonnes `/Col/LcolH` (lecture dans `_New`, écriture 3 fois) →
  `Utils.LitLargeurs`/`Utils.SauveLargeurs` (SAISECRIT-010, FACTURE-007).
- Couleurs `/Coul/Facts` : même lecture dans `TriFac`, `TriFac2`, `Carch` (commonalisation
  « Couleurs /Coul/* » des notes transverses).
- Table `Blcom` : même usage dans `Facture` (`creblcom`, recherche dans les BL) avec une autre
  structure ; une fonction de recherche commune ne viendra qu'après décision sur A01.
- Lecture d'une facture archivée (en-tête puis `…M` à défaut) : déjà faite par `ObjFac._new`
  (`ObjFac.class:172-179`) ; `Colbl_click` pourrait la réutiliser.

### Réduction de portée

- `Deb2`, `Deb2b`, `Deb3b`, `Deb3`, `Debcom`, `Tris`, `Titre`, `Dbclk`, `Colfac_com`,
  `Colfac_art`, `Colfac_libel`, `CleanChamps`, `Deplacement`, `Recup_ligbl`, `CalculTotal` : aucun
  appelant externe (seul `Fmenu` référence la classe, par `ShowModal`) → `Private`. `Colbl_click`
  reste `Public` (rejeu) ; les `*_Click` des en-têtes gardent leur nom et leur portée.

### Séparation traitement / GUI

- `RequeteFactures` (pure) ; `LitFacture(numfac, iMode) As Result` et `LitLignes(numfac, sType) As
  Result` sans accès aux contrôles ; `CalculTotal` transformé en fonction pure de cumul (ligne →
  totaux) appelée par `Recup_ligbl`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une seule table de factures avec un indicateur « entretien » supprimerait l'union
  `Fiches_HistoFac`/`Fiches_HistoFacM` et les doubles requêtes.
- Montants en `varchar` (`pu_ligfac`, `netht_ligfac`…) → `DECIMAL`.
- Index plein texte sur `com_ligfac`/`libel_ligfac` pour la recherche dans les lignes, sans table de
  travail.
