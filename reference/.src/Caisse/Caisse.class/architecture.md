# Caisse — Architecture

> Source : `.src/Caisse/Caisse.class`

## Vue d'ensemble

`Caisse` est l'**écran de point de vente** de Laurux (PDV/POS, lancé par `./Laurux -p` puis le menu
caisse [`Cmenu`](../Cmenu.class/architecture.md), `Cmenu.class:253` : `OCaisse = New Caisse`). Il
gère la saisie des articles d'un ticket, les remises, les avoirs, les crédits, les règlements
multiples (12 modes), la fidélité, les mouvements hors vente, les tickets en attente, le règlement
de BL/factures de clients en compte, l'impression (imprimante série ESC/POS ou PDF), les
facturettes, les tickets X et Z, le tiroir-caisse, l'afficheur client et la balance. C'est le
deuxième plus gros fichier legacy du projet (8 734 lignes, 242 fonctions, CC totale 2 102) :
AGENTS.md règle 21 s'applique, seuls des reworks **minimaux et ciblés** sont proposés.

Points structurants :

- **Le ticket en cours vit dans le contrôle `LigTk`** (ColumnView, 13 colonnes dont 5 visibles) :
  0 n° de ligne affiché, 1 code (article, client, compte), 2 libellé, 3 PU TTC ou montant,
  4 quantité, 5 **type de ligne**, 6 HT, 7 remise / n° de document / `lind`, 8 **bloc**, 9 montant de
  TVA, 10 taux de TVA, 11 montant TTC retenu, 12 code TVA de l'article. Les clés des lignes sont
  `iligne` (compteur), les blocs regroupent une ligne article et ses lignes dépendantes.
- **Types de ligne** (`Item[5]`) : `A` article, `S` remise en % de la ligne, `T` prix total
  (quantité ≠ 1), `O` écotaxe / copie privée, `C` commentaire, `MT` remise sur total (3 lignes),
  `EZ` en-tête d'avoir, `EA` acompte reçu, `EH` entrée hors vente, `SH` sortie hors vente, `BL`
  règlement d'un BL/facture, `L` pointillé, `BH` total HT, `BA` TVA par taux, `BC` total TTC, `BB`
  points de fidélité, `M` bon de caisse client en compte, `K` ligne centrée (impression), puis les
  **lignes de règlement** recopiées depuis `ColumnView1` par `Aff_bastk` : `N` espèces, `Q` rendu,
  `U` carte, `V` chèque, `W` crédit, `X` bon d'achat, `Y` chèque cadeau, `Z` avoir utilisé, `E`
  autre, `1` ticket restaurant, `B` bonus, `RA` acompte utilisé.
- **Les règlements saisis vivent dans `ColumnView1`** (code, libellé, montant, n° de document,
  client, `lind`) jusqu'à `Aff_bastk`, qui les recopie en fin de ticket.
- **Cycle d'un ticket** : `Ent_tk` réserve un numéro (`Fiches_Caisses.cutk`, sinon
  `LockIncrement("cutk")` de `Fiches_Parametres`) → saisie (`Valid_Cart` → `Init_Art` →
  `Art_man`) → paiement (`Button6_Click`, F7 : cadre `Frame2`, modes `Button11…53`, `Valid_*`,
  `Calc_reste`) → solde nul : `Aff_bastk` (bas de ticket, TVA via la table de travail `Tottva`) +
  `pointsF` → `Button15_Click` → `Serial_Tk` (ESC/POS) ou `Defaut_Tk` (PDF `Cfacture`) →
  `Maj_Quantite`/`Maj_QteDep` (stock) → **`Enrg_Tk`** (écriture `Fiches_EntTicketz`,
  `Fiches_LigTicketz`, avoirs, acomptes, totaux de caisse, chaînage SHA1, BL du client en compte)
  → `Dupli` (archive PDF). La bande Z (`Ticketz`) délègue à
  [`Moulinage.Livre_caisse`](../Moulinage.class/architecture.md) l'archivage dans
  `Fiches_HisEntTickets`/`Fiches_HisLigTickets`, la comptabilisation et la facturation des BL réglés.
- **Montants manipulés en chaînes** (`Text` des contrôles, `Utils.cpoint`, `Format$`), avec des
  `Val()` parfois sans `cpoint` (dépend de la locale française).
- **Navigation par « zone »** (`Zone = "Article" | "Qte" | "Especes"…`) : le clavier virtuel
  (`Clav_click`, `Entree_Click`, `Efface`) et les boutons tactiles (`Button38/39`) agissent sur le
  champ de la zone courante.
- **Raccourcis clavier** très nombreux (F1-F12, Ctrl+F1-F12, Ctrl+M/N/R/T/X, Alt+V) répartis dans
  `Cart_KeyPress`, `Qte_KeyPress`, `Inpm_KeyPress` et dix `*_KeyPress` de modes de paiement.
- **Mot de passe administrateur** (`/caisse/admin`) : les actions sensibles positionnent `org` et
  ouvrent `Frame8` (non modal) ; `Valid_Mdp` exécute l'action différée.
- **Périphériques** : imprimante ticket série (`SPort`, `#SerialPort` du `.form`, ESC/POS
  `6000III`/`Tmu950`), tiroir (ESC p), afficheur client (sur le port imprimante, ou afficheur USB
  BA63 par socket `BA6X`), balance (`SPort2` : Tropper, Mettler Toledo, Precia Molen). Le TPE
  (`Telium.class`) n'est **pas** piloté par cette classe.
- **Aucune transaction** : `Enrg_Tk` enchaîne une vingtaine d'écritures ; le stock est mis à jour
  **avant** l'enregistrement du ticket. Verrous `LOCK TABLES` (stock, BL) et `DocActif`
  (avoirs, acomptes).
- **État global** très large : ~170 variables d'instance, dont ~110 sans mot-clé (donc `Private`),
  drapeaux entiers (`iQte`, `iRem`, `iAvoir`, `ipaiement`, `icarte`…) et montants `String`.

Nature globale : **GUI fortement couplée au SQL et aux périphériques** (mixte). Seuls `arrondi` et
quelques formules sont du calcul pur.

### Tableau des groupes fonctionnels

| Groupe | Lignes principales | Fonctions | LOC | CC totale | CC max | Nature |
|---|---|---|---|---|---|---|
| G01 Cycle de vie, initialisation, entête de ticket | 169-482, 6228-6265, 6965-6969, 8480-8484, 8723-8734 | 16 | 281 | 72 | 26 (`Form_Open`) | mixte |
| G02 Saisie et validation d'un article | 527-819, 855-1259, 1320-1485, 1591-1916, 6973-7056 | 36 | 1070 | 323 | 77 (`Art_man`) | mixte |
| G03 Calculs prix, TVA, arrondi | 487-522, 821-828, 1921-1951 | 5 | 58 | 16 | 11 (`arrondi`) | calcul (+ SQL TVA) |
| G04 Remises en % et remises quantitatives | 1487-1589, 1702-1720, 1734-1763, 7478-7523 | 8 | 171 | 56 | 20 (`RemqShow`) | GUI |
| G05 Remise sur le total | 1960-2142, 7936-7944 | 4 | 161 | 42 | 27 (`Valid_Remtot`) | mixte |
| G06 Lignes du ticket : suppression, recalcul, renumérotation | 7610-7803 | 6 | 146 | 43 | 20 (`Ligtk_Delete`) | mixte |
| G07 Tickets en attente, rappel, suppression | 2190-2475 | 7 | 243 | 48 | 15 (`ColTka_Click`) | mixte |
| G08 Avoirs et crédits (saisie du client) | 2480-2629 | 5 | 124 | 27 | 9 (`Button10_Click`) | mixte |
| G09 Paiement : cadre, modes de règlement, lignes de règlement | 2145-2188, 2636-4343, 5530-5610, 6267-6288, 7525-7608 | 50 | 1548 | 562 | 23 (`Delete_Reglements_Tk`) | GUI (+ SQL avoirs/acomptes) |
| G10 Fidélité : cartes, points, bonus | 3994-4108, 7324-7382 | 4 | 161 | 39 | 31 (`pointsF`) | mixte |
| G11 Hors vente, acomptes reçus, fond de caisse | 1261-1317, 4349-4597 | 17 | 242 | 60 | 8 (`horsven_evkeypress`) | GUI (+ INSERT acompte) |
| G12 Bas de ticket, validation et enregistrement | 4736-4844, 5615-6226, 6950-6963 | 8 | 620 | 173 | 72 (`Enrg_Tk`) | traitement (SQL) + GUI |
| G13 Impression, chèque, mail, périphériques série | 830-853, 4602-4734, 4846-5396 | 20 | 622 | 161 | 21 (`Defaut_Tk`) | périphériques / GUI |
| G14 Stock | 7388-7475 | 2 | 76 | 19 | 10 (`Maj_Quantite`) | traitement (SQL) |
| G15 Client en compte et règlement de BL/factures | 7059-7243 | 3 | 160 | 40 | 16 (`Button30_click`) | mixte |
| G16 Facturettes et clients divers | 6292-6769, 7249-7318, 7874-7878, 7946-7957, 8296-8310 | 21 | 495 | 141 | 32 (`Defaut_Facture`) | mixte |
| G17 Tickets X et Z | 6774-6948 | 6 | 146 | 44 | 15 (`Ticketz`) | mixte |
| G18 Mot de passe administrateur | 5403-5525 | 3 | 114 | 33 | 24 (`Valid_Mdp`) | GUI |
| G19 Écran tactile, clavier virtuel, touches de famille | 370-389, 1953-1957, 7805-8721 | 21 | 703 | 203 | 32 (`Echap_Click`) | GUI |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Adr` | var | Private |  | String | 3 |
| `Siret` | var | Private |  | String | 4 |
| `Tel` | var | Private |  | String | 5 |
| `Tvaintra` | var | Private |  | String | 6 |
| `iQte` | var | Private |  | Integer | 7 |
| `Fcinq` | var | Private |  | Boolean | 8 |
| `Qt1` | var | Private |  | Boolean | 9 |
| `iComm` | var | Private |  | Integer | 10 |
| `iRem` | var | Private |  | Integer | 11 |
| `iRemq` | var | Private |  | Integer | 12 |
| `iremT` | var | Private |  | Integer | 13 |
| `ibarre` | var | Private |  | Integer | 14 |
| `iModif` | var | Private |  | Integer | 15 |
| `iNlg` | var | Private |  | Integer | 16 |
| `iAvoir` | var | Private |  | Integer | 17 |
| `sAvoir` | var | Private |  | String | 18 |
| `Numavoir` | var | Private |  | String | 19 |
| `cliavoir` | var | Private |  | String | 20 |
| `lindavoir` | var | Private |  | String | 21 |
| `iAttente` | var | Private |  | Integer | 22 |
| `iRattente` | var | Private |  | Integer | 23 |
| `ipaiement` | var | Private |  | Integer | 24 |
| `icarte` | var | Private |  | Integer | 25 |
| `snmcarte` | var | Private |  | String | 26 |
| `icheque` | var | Private |  | Integer | 27 |
| `snmcheque` | var | Private |  | String | 28 |
| `bcheque` | var | Private |  | Boolean | 29 |
| `icredit` | var | Private |  | Integer | 30 |
| `snmcredit` | var | Private |  | String | 31 |
| `clicredit` | var | Private |  | String | 32 |
| `iachat` | var | Private |  | Integer | 33 |
| `snmachat` | var | Private |  | String | 34 |
| `ichequecad` | var | Private |  | Integer | 35 |
| `snmchequecad` | var | Private |  | String | 36 |
| `snmautre` | var | Private |  | String | 37 |
| `icartef` | var | Private |  | Integer | 38 |
| `scartef` | var | Private |  | String | 39 |
| `snmcartef` | var | Private |  | String | 40 |
| `ftpoint` | var | Private |  | Float | 41 |
| `ftpoint2` | var | Private |  | Float | 42 |
| `Ftpointg` | var | Private |  | Float | 43 |
| `fbonusv` | var | Private |  | Float | 44 |
| `fbonus` | var | Private |  | Float | 45 |
| `fbonusg` | var | Private |  | Float | 46 |
| `frem` | var | Private |  | Boolean | 47 |
| `fpromo` | var | Private |  | Boolean | 48 |
| `Chkart` | var | Private |  | Boolean | 49 |
| `Ntk` | var | Private |  | String | 50 |
| `Numtk` | var | Private |  | String | 51 |
| `Ncaisse` | var | Private |  | String | 52 |
| `FndCaisse` | var | Private |  | Float | 53 |
| `hForm` | var | Private |  | FCalc | 54 |
| `hForm2` | var | Private |  | Fondcaisse | 55 |
| `sDec` | var | Private |  | String | 56 |
| `Tva` | var | Private |  | String | 57 |
| `TxTva` | var | Private |  | String | 58 |
| `mtva` | var | Private |  | String | 59 |
| `Artpu` | var | Private |  | String | 60 |
| `pvht` | var | Private |  | String | 61 |
| `paht` | var | Private |  | String | 62 |
| `Totalht` | var | Private |  | String | 63 |
| `Tottva` | var | Private |  | String | 64 |
| `totaltva` | var | Private |  | Float | 65 |
| `Nbdec` | var | Private |  | String | 66 |
| `Nbd` | var | Private |  | String | 67 |
| `sel` | var | Private |  | String | 68 |
| `Tri` | var | Private |  | String | 69 |
| `Rms` | var | Private |  | New String[] | 70 |
| `artrmq` | var | Private |  | String | 71 |
| `Clicaisse` | var | Private |  | String | 72 |
| `CodeclientDefault` | var | Private |  | String | 73 |
| `Clicompte` | var | Private |  | Integer | 74 |
| `Clicode` | var | Public |  | String | 75 |
| `Coulfc` | var | Private |  | Integer | 76 |
| `Datetk` | var | Private |  | LDate | 77 |
| `Datetk2` | var | Private |  | LDate | 78 |
| `Client` | var | Private |  | String | 79 |
| `Caissiere` | var | Private |  | String | 80 |
| `$Caissiere` | var | Private |  | String | 81 |
| `Pointille` | var | Private |  | String | 82 |
| `Imprimante` | var | Private |  | String | 83 |
| `Famille` | var | Private |  | String | 84 |
| `Dtck` | var | Private |  | String | 87 |
| `Entetet` | var | Private |  | String | 88 |
| `Entetcli` | var | Private |  | String | 89 |
| `admin` | var | Private |  | Integer | 90 |
| `rResult` | var | Private |  | Result | 91 |
| `mdpadmin` | var | Private |  | String | 92 |
| `org` | var | Private |  | String | 93 |
| `$iSpc` | var | Private | oui | New String[20] | 94 |
| `$iSpc2` | var | Private | oui | New String[20] | 95 |
| `GestMdp` | var | Private |  | Integer | 96 |
| `Bsel` | var | Public |  | Boolean | 97 |
| `Bval` | var | Public |  | Variant | 98 |
| `Clinom` | var | Private |  | String | 99 |
| `Clipnm` | var | Private |  | String | 100 |
| `Clicp` | var | Private |  | String | 101 |
| `Cliburdist` | var | Private |  | String | 102 |
| `$Cli` | var | Private |  | String | 103 |
| `$Nomd` | var | Private |  | String | 104 |
| `sDon` | var | Private |  | Integer | 105 |
| `Tkz` | var | Private |  | Integer | 106 |
| `Ecole` | var | Private |  | Boolean | 107 |
| `Typeimp` | var | Private |  | String | 108 |
| `Texte_Vis` | var | Private |  | String | 109 |
| `Txtvis` | var | Private |  | String | 110 |
| `Promo` | var | Private |  | Boolean | 111 |
| `Cpromo` | var | Private |  | String | 112 |
| `Apromo` | var | Private |  | Boolean | 113 |
| `Bloc` | var | Private |  | String | 114 |
| `totgain` | var | Private |  | Float | 115 |
| `BonusArt` | var | Private |  | Float | 116 |
| `Ctrlstk` | var | Private |  | Boolean | 117 |
| `tx` | var | Private |  | Float | 118 |
| `devises` | var | Private |  | String | 119 |
| `Crt` | var | Private |  | Boolean | 120 |
| `origine` | var | Public |  | String | 121 |
| `sIacompte` | var | Private |  | String | 122 |
| `cliacompte` | var | Private |  | String | 123 |
| `lindacompte` | var | Private |  | String | 124 |
| `numacompte` | var | Private |  | String | 125 |
| `numr` | var | Private |  | Integer | 126 |
| `numr2` | var | Private |  | Integer | 127 |
| `numecr` | var | Private |  | String | 128 |
| `jour` | var | Private |  | String | 129 |
| `Photo` | var | Private |  | String | 130 |
| `Colvente` | var | Private |  | Float | 131 |
| `Pvht2` | var | Private |  | Float | 132 |
| `sBalance` | var | Private |  | Boolean | 133 |
| `pdf` | var | Private |  | Cfacture | 134 |
| `Nbf` | var | Private |  | Integer | 135 |
| `bt` | var | Private |  | Integer | 136 |
| `iligne` | var | Private |  | Integer | 137 |
| `Codearticle` | var | Public |  | String | 138 |
| `$Vendeur` | var | Public |  | Boolean | 139 |
| `Ba4` | var | Public |  | Boolean | 140 |
| `slind` | var | Private |  | String | 141 |
| `Zone` | var | Private |  | String | 142 |
| `$saisie` | var | Private |  | String | 143 |
| `TouchFam` | var | Private |  | Boolean | 144 |
| `btn` | var | Private |  | ImageButton | 145 |
| `codeA` | var | Private |  | New String[72] | 146 |
| `ToucheS` | var | Private |  | New String[110] | 147 |
| `hpan` | var | Private |  | Panel | 148 |
| `hbutton` | var | Private |  | ImageButton | 149 |
| `Pan` | var | Private |  | Boolean | 150 |
| `mtrem` | var | Private |  | String | 151 |
| `nbc` | var | Private |  | Integer | 152 |
| `Prix` | var | Private |  | String | 153 |
| `bFam` | var | Private |  | Boolean | 154 |
| `rremT` | var | Private |  | String | 155 |
| `iart` | var | Private |  | Integer | 156 |
| `Touche_P` | var | Private |  | String | 157 |
| `BA6X` | var | Private |  | Socket | 158 |
| `bAffUSB` | var | Private |  | Boolean | 159 |
| `$depot` | var | Private |  | String | 160 |
| `bretro` | var | Private |  | Boolean | 161 |
| `bmodifregl` | var | Private |  | Boolean | 162 |
| `Val_retro` | var | Private |  | String | 163 |
| `Blexists` | var | Private |  | Boolean | 164 |
| `RecapSoldeCli` | var | Private |  | Boolean | 165 |
| `$keyObserver` | var | Private |  | Observer | 166 |
<!-- /AUTO:declarations -->

Variables d'instance notables (la plupart sans mot-clé, donc `Private`) :

| Variable(s) | Type | Rôle |
|---|---|---|
| `Ntk`, `Numtk`, `Dtck` | String | n° du ticket courant, n° du ticket rappelé (attente), dernier ticket enregistré (facturette par défaut) |
| `Ncaisse`, `Caissiere`, `$Caissiere`, `Imprimante`, `Typeimp`, `$depot`, `Ecole` | String/Boolean | caisse (`/caisse/Ncai` = `caisse;vendeur`), vendeur, imprimante (`/dev…`, `DéfautA4`, `Défaut80`), modèle ESC/POS, dépôt de stock, caisse école (pas de stock ni de bande Z) |
| `iligne`, `iNlg`, `Bloc` | Integer/String | clé de ligne, n° affiché, bloc courant de `LigTk` |
| `iQte`, `Fcinq`, `iComm`, `iRem`, `iRemq`, `iremT`, `ibarre`, `iModif`, `iart`, `bt`, `Chkart`, `Crt` | drapeaux | quantité ≠ 1, F5, commentaire, remise, remise quantitative, remise totale, code-barre, prix modifié, article introuvable, erreur, recherche article, carte saisie |
| `iAvoir`, `sAvoir`, `Numavoir`, `cliavoir`, `lindavoir` | — | ticket d'avoir (⚠️ même variable que `iavoir`, remise à 0 par `init_paiement`) ; avoir utilisé en règlement |
| `iAttente`, `iRattente`, `ipaiement`, `bmodifregl`, `bretro`, `Blexists` | drapeaux | mise en attente, ticket rappelé, cadre de paiement ouvert, ticket « modification de règlement », ticket de rétrocession, BL réglés dans le ticket |
| `icarte`, `icheque`, `icredit`, `iachat`, `ichequecad`, `snm*`, `clicredit`, `nbc` | — | mode de paiement en cours de saisie, libellés, client du crédit, suffixe de doublon |
| `sIacompte`, `cliacompte`, `lindacompte`, `numacompte` | String | acompte utilisé en règlement |
| `icartef`, `scartef`, `snmcartef`, `ftpoint`, `ftpoint2`, `Ftpointg`, `fbonusv`, `fbonus`, `fbonusg`, `frem`, `fpromo`, `totgain`, `BonusArt` | — | carte de fidélité et calcul des points/bonus |
| `Clicompte`, `Clicode`, `CodeclientDefault`, `Clicaisse`, `Clinom`, `Clipnm`, `Clicp`, `Cliburdist`, `$Cli`, `$Nomd`, `slind` | — | client en compte (bon de caisse) ou client caisse par défaut (`Fiches_ClientCaisse`) |
| `Tva`, `TxTva`, `tx`, `mtva`, `Artpu`, `pvht`, `paht`, `Totalht`, `Tottva`, `totaltva`, `Nbd`, `Nbdec`, `sDec`, `Colvente`, `Pvht2` | String/Float | calculs de la ligne courante (⚠️ `Tva` contient un code TVA puis un taux après `Calc_Tva`) |
| `Rms` | `New String[]` | tranches de remises quantitatives : ⚠️ tableau à **une** dimension utilisé en `Rms[i, j]` (CAISSE-A02) |
| `Promo`, `Cpromo`, `Apromo` | — | promotion du jour (`Form_Open`), article en promotion |
| `GestMdp`, `admin`, `org`, `mdpadmin` | — | mot de passe administrateur et action différée |
| `BA6X`, `bAffUSB` | Socket/Boolean | afficheur USB BA63 (jamais connecté, CAISSE-A09) |
| `Zone`, `$saisie`, `TouchFam`, `Touche_P`, `codeA`, `ToucheS`, `hpan`, `hbutton`, `btn`, `Pan`, `bFam` | — | clavier virtuel et touches de famille / sous-famille |
| `$iSpc`, `$iSpc2` | `Static Private String[20]` | lignes d'entête des facturettes (vidées seulement par `Button26_Click`) |
| `pdf`, `Ba4`, `Nbf` | Cfacture/Boolean/Integer | ticket PDF, format A4 (lu par `Cfacture` via l'auto-instance, CAISSE-A05 / CFACTURE-A01), nombre d'exemplaires |

Membres `Public` : `Bsel`/`Bval` (écrits par `TriCpt`, `TriArticles`, `Tricartes` via
`Object.SetProperty` : **à garder `Public`**) ; `$Vendeur` (écrit par `Svendeur`) et `Ba4` (lu par
`Cfacture`) : accédés **par le nom de classe**, donc sur l'auto-instance et non sur la caisse ouverte
(CAISSE-A04, A05) ; `origine` (écrit par `Attrib:22`, jamais lu ; l'écriture crée une auto-instance cachée de `Caisse`, ATTRIB-A06) ; `Clicode`, `Codearticle`
(usage interne seulement).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `InitBA6X` | 169-183 | Public | 5 | 11 | 0 | portée réductible ? |
| `PrintBA6X` | 185-195 | Public | 2 | 7 | 0 | portée réductible ? |
| `Form_Open` | 197-325 | Public | 26 | 115 | 0 | handler GUI |
| `SetObservers` | 327-342 | Public | 5 | 13 | 0 | portée réductible ? |
| `Obs_Enter` | 344-349 | Public | 1 | 3 | 0 | handler GUI |
| `Obs_Leave` | 351-356 | Public | 1 | 3 | 0 | handler GUI |
| `Obs2_Enter` | 358-362 | Public | 1 | 3 | 0 | handler GUI |
| `Obs2_Leave` | 364-368 | Public | 1 | 3 | 0 | handler GUI |
| `InitTouche` | 370-389 | Public | 8 | 17 | 0 | portée réductible ? |
| `Timer1_Timer` | 391-399 | Public | 1 | 6 | 0 | handler GUI |
| `Form_Close` | 401-417 | Public | 6 | 14 | 0 | handler GUI |
| `Ent_tk` | 419-482 | Public | 16 | 53 | 0 | portée réductible ? |
| `arrondi` | 487-522 | Public | 11 | 30 | 0 | portée réductible ? |
| `Art_man` | 527-819 | Public | 77 | 282 | 0 | portée réductible ? |
| `calc_total` | 821-828 | Public | 1 | 6 | 0 | portée réductible ? |
| `Ouv_Tiroir` | 830-837 | Public | 4 | 6 | 0 | portée réductible ? |
| `Aff_viseur` | 839-853 | Public | 7 | 11 | 0 | portée réductible ? |
| `Cart_MouseDown` | 855-860 | Public | 1 | 3 | 0 | handler GUI |
| `Design_MouseDown` | 862-866 | Public | 1 | 3 | 0 | handler GUI |
| `Pvttc_MouseDown` | 868-872 | Public | 1 | 3 | 0 | handler GUI |
| `Qte_Mousedown` | 874-878 | Public | 1 | 3 | 0 | handler GUI |
| `Cart_GotFocus` | 880-885 | Public | 1 | 4 | 0 | handler GUI |
| `Design_GotFocus` | 887-893 | Public | 1 | 5 | 0 | handler GUI |
| `Cart_KeyPress` | 895-1082 | Public | 50 | 180 | 0 | handler GUI |
| `panel17_KeyPress` | 1084-1091 | Public | 2 | 6 | 0 | handler GUI |
| `aff_Photo` | 1093-1106 | Public | 5 | 11 | 0 | portée réductible ? |
| `Photos_MouseDown` | 1108-1113 | Public | 1 | 4 | 0 | handler GUI |
| `Prix_promo` | 1115-1128 | Public | 4 | 12 | 0 | portée réductible ? |
| `Qte_GotFocus` | 1133-1139 | Public | 1 | 5 | 0 | handler GUI |
| `Qte_KeyPress` | 1141-1205 | Public | 18 | 63 | 0 | handler GUI |
| `Valid_Qte` | 1207-1238 | Public | 6 | 30 | 0 | portée réductible ? |
| `Valid_commentaire` | 1240-1259 | Public | 1 | 17 | 0 | portée réductible ? |
| `Valid_HorsVte` | 1261-1317 | Public | 5 | 52 | 0 | portée réductible ? |
| `Valid_Cart` | 1320-1485 | Public | 48 | 155 | 0 | portée réductible ? |
| `Remise_GotFocus` | 1487-1492 | Public | 1 | 4 | 0 | handler GUI |
| `Valid_Remise` | 1494-1527 | Public | 9 | 31 | 0 | portée réductible ? |
| `Remise_KeyPress` | 1532-1557 | Public | 10 | 24 | 0 | handler GUI |
| `RemqShow` | 1559-1589 | Public | 20 | 29 | 0 | portée réductible ? |
| `Init_Art` | 1591-1614 | Public | 6 | 18 | 0 | portée réductible ? |
| `Raz` | 1616-1623 | Public | 1 | 6 | 0 | portée réductible ? |
| `Button40_Click` | 1625-1629 | Public | 1 | 3 | 0 | handler GUI |
| `AppArt` | 1631-1641 | Public | 3 | 9 | 0 | portée réductible ? |
| `Button2_Click` | 1643-1659 | Public | 6 | 15 | 0 | handler GUI |
| `Recup_dec` | 1661-1674 | Public | 3 | 11 | 0 | portée réductible ? |
| `Decimal` | 1679-1697 | Public | 5 | 17 | 0 | portée réductible ? |
| `Remises_quantitatives` | 1702-1720 | Public | 7 | 16 | 0 | portée réductible ? |
| `Button1_Click` | 1722-1732 | Public | 2 | 9 | 0 | handler GUI |
| `Button3_Click` | 1734-1763 | Public | 5 | 28 | 0 | handler GUI |
| `Button4_Click` | 1765-1780 | Public | 3 | 14 | 0 | handler GUI |
| `modif_Tk` | 1782-1796 | Public | 2 | 13 | 0 | portée réductible ? |
| `Design_KeyPress` | 1798-1807 | Public | 4 | 8 | 0 | handler GUI |
| `Pvttc_GotFocus` | 1809-1815 | Public | 1 | 5 | 0 | handler GUI |
| `pvttc_LostFocus` | 1817-1829 | Public | 1 | 7 | 0 | handler GUI |
| `Pvttc_KeyPress` | 1831-1844 | Public | 9 | 12 | 0 | handler GUI |
| `TestPvttc` | 1846-1916 | Public | 16 | 66 | 0 | portée réductible ? |
| `Calc_Tva` | 1921-1933 | Public | 2 | 10 | 0 | portée réductible ? |
| `calc_HT` | 1935-1942 | Public | 1 | 6 | 0 | portée réductible ? |
| `Calc_TTC` | 1944-1951 | Public | 1 | 6 | 0 | portée réductible ? |
| `Button5_Click` | 1953-1957 | Public | 1 | 3 | 0 | handler GUI |
| `Button33_Click` | 1960-1997 | Public | 6 | 29 | 0 | handler GUI |
| `RemTot_KeyPress` | 1999-2015 | Public | 7 | 13 | 0 | handler GUI |
| `Valid_Remtot` | 2017-2142 | Public | 27 | 112 | 0 | portée réductible ? |
| `Button6_Click` | 2145-2188 | Public | 12 | 41 | 0 | handler GUI |
| `Ticket_Attente` | 2190-2233 | Public | 7 | 41 | 0 | portée réductible ? |
| `Button7_Click` | 2235-2239 | Public | 1 | 3 | 0 | handler GUI |
| `Button8_Click` | 2241-2276 | Public | 6 | 29 | 0 | handler GUI |
| `ColTka_KeyPress` | 2278-2286 | Public | 7 | 7 | 0 | handler GUI |
| `ColTka_Click` | 2288-2396 | Public | 15 | 92 | 0 | handler GUI |
| `Button9_Click` | 2399-2418 | Public | 4 | 18 | 0 | handler GUI |
| `suppr_Tk` | 2420-2475 | Public | 8 | 53 | 0 | portée réductible ? |
| `Button10_Click` | 2480-2527 | Public | 9 | 44 | 0 | handler GUI |
| `button17_Click` | 2529-2590 | Public | 6 | 52 | 0 | handler GUI |
| `Button52_Click` | 2592-2596 | Public | 1 | 3 | 0 | handler GUI |
| `Nmc_KeyPress` | 2598-2609 | Public | 8 | 10 | 0 | handler GUI |
| `CliAv_Select_Click` | 2612-2629 | Public | 3 | 15 | 0 | handler GUI |
| `Button11_Click` | 2636-2656 | Public | 1 | 9 | 0 | handler GUI |
| `Especes_KeyPress` | 2658-2686 | Public | 20 | 27 | 0 | handler GUI |
| `Valid_Especes` | 2688-2757 | Public | 15 | 60 | 0 | portée réductible ? |
| `Valid_Reste` | 2759-2777 | Public | 5 | 15 | 0 | portée réductible ? |
| `Button12_Click` | 2783-2814 | Public | 4 | 21 | 0 | handler GUI |
| `Nmc2_KeyPress` | 2816-2831 | Public | 10 | 12 | 0 | handler GUI |
| `button19_Click` | 2833-2895 | Public | 9 | 60 | 0 | handler GUI |
| `carte_KeyPress` | 2897-2925 | Public | 22 | 27 | 0 | handler GUI |
| `Valid_Carte` | 2927-2982 | Public | 10 | 39 | 0 | portée réductible ? |
| `Button13_Click` | 2987-3018 | Public | 4 | 21 | 0 | handler GUI |
| `Cheque_KeyPress` | 3020-3048 | Public | 22 | 27 | 0 | handler GUI |
| `Valid_Cheque` | 3050-3109 | Public | 11 | 44 | 0 | portée réductible ? |
| `Button14_Click` | 3114-3131 | Public | 3 | 15 | 0 | handler GUI |
| `credit_KeyPress` | 3133-3161 | Public | 22 | 27 | 0 | handler GUI |
| `Valid_Credit` | 3163-3226 | Public | 16 | 62 | 0 | portée réductible ? |
| `Button16_Click` | 3231-3247 | Public | 3 | 14 | 0 | handler GUI |
| `Bachat_KeyPress` | 3249-3277 | Public | 21 | 27 | 0 | handler GUI |
| `Valid_Bachat` | 3279-3339 | Public | 15 | 59 | 0 | portée réductible ? |
| `Button18_Click` | 3344-3399 | Public | 11 | 52 | 0 | handler GUI |
| `cavoirs_keyPress` | 3401-3421 | Public | 9 | 19 | 0 | handler GUI |
| `Bavoir_KeyPress` | 3423-3451 | Public | 22 | 27 | 0 | handler GUI |
| `Valid_Bavoir` | 3453-3529 | Public | 16 | 72 | 0 | portée réductible ? |
| `Cavoirs_Click` | 3531-3545 | Public | 1 | 13 | 0 | handler GUI |
| `Button27_Click` | 3550-3568 | Public | 3 | 16 | 0 | handler GUI |
| `Chequecad_KeyPress` | 3570-3599 | Public | 22 | 27 | 0 | handler GUI |
| `Valid_Chequecad` | 3601-3660 | Public | 15 | 58 | 0 | portée réductible ? |
| `Button36_Click` | 3665-3674 | Public | 1 | 8 | 0 | handler GUI |
| `Bautre_KeyPress` | 3676-3704 | Public | 21 | 26 | 0 | handler GUI |
| `Valid_Bautre` | 3706-3766 | Public | 15 | 59 | 0 | portée réductible ? |
| `Button53_Click` | 3771-3780 | Public | 1 | 8 | 0 | handler GUI |
| `Tresto_KeyPress` | 3782-3810 | Public | 22 | 26 | 0 | handler GUI |
| `Valid_Tresto` | 3812-3872 | Public | 15 | 59 | 0 | portée réductible ? |
| `Button31_Click` | 3877-3895 | Public | 3 | 17 | 0 | handler GUI |
| `Bonus_KeyPress` | 3897-3925 | Public | 21 | 26 | 0 | handler GUI |
| `Valid_Bonus` | 3927-3991 | Public | 16 | 63 | 0 | portée réductible ? |
| `pointsF` | 3994-4108 | Public | 31 | 112 | 0 | portée réductible ? |
| `Button35_Click` | 4113-4183 | Public | 12 | 67 | 0 | handler GUI |
| `cacomptes_keyPress` | 4185-4202 | Public | 9 | 16 | 0 | handler GUI |
| `Bacompte_KeyPress` | 4204-4232 | Public | 22 | 27 | 0 | handler GUI |
| `Valid_Bacompte` | 4234-4308 | Public | 14 | 71 | 0 | portée réductible ? |
| `Cacomptes_Click` | 4310-4343 | Public | 5 | 30 | 0 | handler GUI |
| `Btn_EntreeEnc_Click` | 4349-4384 | Public | 6 | 34 | 0 | handler GUI |
| `horsven_evkeypress` | 4386-4399 | Public | 8 | 12 | 0 | portée réductible ? |
| `MvtHV_Sortie_Click` | 4401-4414 | Public | 2 | 12 | 0 | handler GUI |
| `MvtHV_Entree_Click` | 4416-4431 | Public | 3 | 14 | 0 | handler GUI |
| `AcomptesE_Click` | 4433-4460 | Public | 3 | 26 | 0 | handler GUI |
| `AcptChClicpt_Click` | 4462-4479 | Public | 3 | 15 | 0 | handler GUI |
| `AcptClicpt_KeyPress` | 4481-4490 | Public | 6 | 8 | 0 | handler GUI |
| `Nmc3_KeyPress` | 4492-4501 | Public | 6 | 8 | 0 | handler GUI |
| `Especes2_GotFocus` | 4503-4508 | Public | 1 | 4 | 0 | handler GUI |
| `Especes2_KeyPress` | 4510-4519 | Public | 4 | 8 | 0 | handler GUI |
| `Btn_Valid_HorsEnc_KeyPress` | 4521-4525 | Public | 1 | 3 | 0 | handler GUI |
| `Btn_Valid_HorsEnc_Click` | 4527-4531 | Public | 1 | 3 | 0 | handler GUI |
| `Mvt_HorsEnc` | 4533-4562 | Public | 7 | 26 | 0 | portée réductible ? |
| `Btn_Find_Click` | 4567-4571 | Public | 1 | 3 | 0 | handler GUI |
| `Maj_Acomptes` | 4573-4587 | Public | 2 | 10 | 0 | portée réductible ? |
| `button21_Click` | 4592-4597 | Public | 1 | 4 | 0 | handler GUI |
| `buttonma_KeyPress` | 4602-4618 | Public | 10 | 15 | 0 | handler GUI |
| `Buttonma_Click` | 4620-4641 | Public | 9 | 18 | 0 | handler GUI |
| `entremail` | 4643-4711 | Private | 4 | 62 | 0 |  |
| `mail_lostfocus` | 4713-4717 | Public | 2 | 3 | 0 | handler GUI |
| `valid_click` | 4719-4728 | Public | 3 | 8 | 0 | handler GUI |
| `annul_click` | 4730-4734 | Public | 1 | 3 | 0 | handler GUI |
| `button15_KeyPress` | 4736-4752 | Public | 10 | 15 | 0 | handler GUI |
| `Button15_Click` | 4754-4795 | Public | 21 | 32 | 0 | handler GUI |
| `Button37_Click` | 4797-4826 | Public | 15 | 26 | 0 | handler GUI |
| `button37_KeyPress` | 4828-4844 | Public | 9 | 15 | 0 | handler GUI |
| `Entete_Tck` | 4846-4893 | Public | 16 | 44 | 0 | portée réductible ? |
| `Serial_Tk` | 4895-4936 | Public | 11 | 36 | 0 | portée réductible ? |
| `imp_ligtk` | 4938-4990 | Public | 10 | 48 | 0 | portée réductible ? |
| `imp_ligtk2` | 4992-5035 | Public | 8 | 41 | 0 | portée réductible ? |
| `Imp_Cheque` | 5037-5116 | Public | 15 | 77 | 0 | portée réductible ? |
| `Imp_Cheque1` | 5118-5204 | Public | 17 | 84 | 0 | portée réductible ? |
| `Defaut_Tk` | 5206-5308 | Public | 21 | 96 | 0 | portée réductible ? |
| `Init_sport` | 5311-5333 | Public | 8 | 21 | 0 | portée réductible ? |
| `Init_sport2` | 5336-5364 | Public | 7 | 27 | 0 | portée réductible ? |
| `SPort2_Read` | 5366-5373 | Public | 2 | 5 | 0 | handler GUI |
| `Recup_Poids` | 5375-5385 | Public | 4 | 9 | 0 | portée réductible ? |
| `Button34_Click` | 5387-5396 | Public | 2 | 8 | 0 | handler GUI |
| `mdp_admin` | 5403-5407 | Public | 2 | 3 | 0 | portée réductible ? |
| `Mdp_KeyPress` | 5409-5423 | Public | 7 | 13 | 0 | handler GUI |
| `Valid_Mdp` | 5425-5525 | Public | 24 | 98 | 0 | portée réductible ? |
| `init_paiement` | 5530-5562 | Public | 1 | 31 | 0 | portée réductible ? |
| `Inpm_KeyPress` | 5567-5593 | Public | 18 | 25 | 0 | handler GUI |
| `Calc_reste` | 5598-5610 | Public | 2 | 11 | 0 | portée réductible ? |
| `TabTva` | 5615-5625 | Public | 1 | 8 | 0 | portée réductible ? |
| `Aff_bastk` | 5631-5817 | Public | 39 | 174 | 0 | portée réductible ? |
| `Enrg_Tk` | 5822-6226 | Public | 72 | 339 | 0 | portée réductible ? |
| `Init_LigTk` | 6228-6244 | Public | 1 | 15 | 0 | portée réductible ? |
| `Init_Columnview1` | 6246-6265 | Public | 1 | 19 | 0 | portée réductible ? |
| `Init_Reg` | 6267-6288 | Public | 1 | 20 | 0 | portée réductible ? |
| `Button26_Click` | 6292-6330 | Public | 7 | 36 | 0 | handler GUI |
| `Nticket_KeyPress` | 6332-6344 | Public | 7 | 12 | 0 | handler GUI |
| `Valid_Nticket` | 6346-6406 | Public | 10 | 55 | 0 | portée réductible ? |
| `impressionbon` | 6408-6443 | Public | 6 | 33 | 0 | portée réductible ? |
| `ChkNtk` | 6445-6453 | Public | 12 | 7 | 0 | portée réductible ? |
| `Nmc4_KeyPress` | 6455-6472 | Public | 6 | 16 | 0 | handler GUI |
| `Nmc5_KeyPress` | 6474-6491 | Public | 6 | 16 | 0 | handler GUI |
| `Nmc6_KeyPress` | 6493-6510 | Public | 6 | 16 | 0 | handler GUI |
| `button42_Click` | 6513-6515 | Public | 1 | 3 | 0 | handler GUI |
| `button29_Click` | 6518-6543 | Public | 10 | 22 | 0 | handler GUI |
| `Ent_tk2` | 6545-6562 | Public | 5 | 13 | 0 | portée réductible ? |
| `Serial_Facture` | 6564-6637 | Public | 16 | 66 | 0 | portée réductible ? |
| `Defaut_Facture` | 6639-6769 | Public | 32 | 125 | 0 | portée réductible ? |
| `Button20_Click` | 6774-6786 | Public | 4 | 10 | 0 | handler GUI |
| `button24_Click` | 6789-6817 | Public | 7 | 27 | 0 | handler GUI |
| `Ticketz` | 6819-6880 | Public | 15 | 58 | 0 | portée réductible ? |
| `margeart` | 6886-6903 | Private | 5 | 15 | 0 |  |
| `Defaut_Ticketxz` | 6905-6923 | Public | 4 | 15 | 0 | portée réductible ? |
| `DupliZ` | 6925-6948 | Public | 9 | 21 | 0 | portée réductible ? |
| `Dupli` | 6950-6963 | Public | 6 | 11 | 0 | portée réductible ? |
| `Button25_Click` | 6965-6969 | Public | 1 | 3 | 0 | handler GUI |
| `SelectionArt` | 6973-6987 | Public | 2 | 12 | 0 | portée réductible ? |
| `ChkPrx` | 6989-7003 | Public | 17 | 13 | 0 | portée réductible ? |
| `ChkBs` | 7005-7013 | Public | 13 | 7 | 0 | portée réductible ? |
| `Aff_Art` | 7015-7056 | Public | 9 | 39 | 0 | portée réductible ? |
| `Ajout_Reg_Bl` | 7059-7117 | Public | 9 | 53 | 0 | portée réductible ? |
| `Button30_click` | 7122-7181 | Public | 16 | 52 | 0 | handler GUI |
| `Recup_Client` | 7186-7243 | Public | 15 | 55 | 0 | portée réductible ? |
| `ClientsDivers` | 7249-7271 | Public | 5 | 20 | 0 | portée réductible ? |
| `RecupClientd` | 7276-7296 | Public | 3 | 17 | 0 | portée réductible ? |
| `Enrg_Clientd` | 7298-7318 | Public | 4 | 18 | 0 | portée réductible ? |
| `Button32_Click` | 7324-7328 | Public | 1 | 3 | 0 | handler GUI |
| `CartesFidelite` | 7330-7352 | Public | 5 | 20 | 0 | portée réductible ? |
| `RecupCarte` | 7354-7382 | Public | 2 | 26 | 0 | portée réductible ? |
| `Maj_Quantite` | 7388-7429 | Public | 10 | 39 | 0 | portée réductible ? |
| `Maj_QteDep` | 7436-7475 | Public | 9 | 37 | 0 | portée réductible ? |
| `Tbremq_Create` | 7478-7507 | Public | 2 | 27 | 0 | portée réductible ? |
| `Tbrem_Click` | 7509-7523 | Public | 2 | 12 | 0 | handler GUI |
| `Delete_Reglements_Tk` | 7525-7553 | Public | 23 | 24 | 0 | portée réductible ? |
| `ColumnView1_KeyPress` | 7556-7564 | Public | 4 | 7 | 0 | handler GUI |
| `ColumnView1_Activate` | 7566-7570 | Public | 1 | 3 | 0 | handler GUI |
| `ColumnView1_Delete` | 7572-7608 | Public | 10 | 30 | 0 | portée réductible ? |
| `LigTk_KeyPress` | 7610-7616 | Public | 2 | 5 | 0 | handler GUI |
| `Suppr_Click` | 7618-7622 | Public | 1 | 3 | 0 | handler GUI |
| `LigTk_Activate` | 7624-7628 | Public | 1 | 3 | 0 | handler GUI |
| `Recalc_Tottk` | 7631-7710 | Public | 14 | 61 | 0 | portée réductible ? |
| `Ligtk_Delete` | 7714-7782 | Public | 20 | 59 | 0 | portée réductible ? |
| `RenameLigne` | 7784-7803 | Public | 5 | 15 | 0 | portée réductible ? |
| `Button38_Click` | 7805-7831 | Public | 7 | 20 | 0 | handler GUI |
| `Button39_Click` | 7833-7872 | Public | 12 | 26 | 0 | handler GUI |
| `Button41_Click` | 7874-7878 | Public | 1 | 3 | 0 | handler GUI |
| `Button43_Click` | 7880-7921 | Public | 14 | 40 | 0 | handler GUI |
| `Button44b_click` | 7923-7934 | Public | 4 | 10 | 0 | portée réductible ? |
| `Button46_click` | 7936-7944 | Public | 2 | 7 | 0 | handler GUI |
| `Button47_Click` | 7946-7951 | Public | 1 | 4 | 0 | handler GUI |
| `Button50_Click` | 7953-7957 | Public | 1 | 3 | 0 | portée réductible ? |
| `Entree_Click` | 7959-8003 | Public | 10 | 35 | 0 | handler GUI |
| `Panel12_KeyPress` | 8005-8009 | Public | 2 | 3 | 0 | handler GUI |
| `Efface_Click` | 8011-8116 | Public | 26 | 79 | 0 | portée réductible ? |
| `Clav_click` | 8118-8246 | Public | 26 | 103 | 0 | handler GUI |
| `Numerique` | 8248-8262 | Public | 4 | 13 | 0 | portée réductible ? |
| `Alpha` | 8264-8294 | Public | 9 | 29 | 0 | portée réductible ? |
| `Button48_Click` | 8296-8301 | Public | 1 | 4 | 0 | handler GUI |
| `Button49_Click` | 8303-8310 | Public | 1 | 6 | 0 | handler GUI |
| `ClavFam` | 8312-8321 | Public | 2 | 8 | 0 | portée réductible ? |
| `Clav2_Click` | 8323-8402 | Public | 15 | 75 | 0 | handler GUI |
| `Clav3_Click` | 8404-8467 | Public | 10 | 61 | 0 | handler GUI |
| `Fermer2` | 8469-8474 | Public | 1 | 4 | 0 | portée réductible ? |
| `Entree2_Click` | 8476-8478 | Public | 1 | 2 | 0 | portée réductible ? |
| `F1_Click` | 8480-8484 | Public | 1 | 3 | 0 | handler GUI |
| `F2_Click` | 8486-8490 | Public | 1 | 3 | 0 | handler GUI |
| `Echap_Click` | 8492-8649 | Public | 32 | 117 | 0 | handler GUI |
| `createPanel` | 8651-8662 | Public | 1 | 10 | 0 | portée réductible ? |
| `Cbutton` | 8667-8684 | Public | 5 | 15 | 0 | portée réductible ? |
| `Init2` | 8686-8721 | Public | 13 | 33 | 0 | portée réductible ? |
| `KeyObserver_Keypress` | 8723-8734 | Public | 3 | 10 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Sauf mention contraire : portée **réductible** pour les fonctions qui ne sont pas des handlers
(aucun appelant externe, vérifié par `grep -rn` sur `.src`) ; portée **nécessaire** pour les
handlers (`Objet_Evenement`, à garder `Public`, PLAN §0) ; nature **mixte** (SQL + contrôles).

### G01 — Cycle de vie, initialisation, entête de ticket

- **`Form_Open()`** [nécessaire] [mixte] (CC 26) : `Utils.Observers(Me)` (une seule fois), observateur
  clavier `KeyObserver`, `Music.Load(Start.Musique)`, `SetObservers(Me, Me)` ; préférences
  `/Soc<XX>/caisse/` : `recapsoldecli`, `tactile` (Button38/39, hauteur réduite), `nbf`,
  `Txt_viseur`, `affusbwn`, `balance`, `choiximp`, `ctrlstk`, `touchfam`, `Tfamilles`, `Ncai` ;
  promotion du jour (l. 218, `TabPromo` `datedeb <= &1 and datefin >= &1`, **même requête** que
  `Articles:231` et `Facture:508`) ; client caisse (`TabCliCaisse`, sans `Available`) ; société
  (`TabSoc` : adresse, Siret, téléphone, TVA intracommunautaire) ; vendeur (`TabVendeurs`) ; caisse
  (`TabCaisses` : `imp`, `typeimp`, `depot`) ; `Ent_tk(Null)` ; imprimante série → `Init_sport` +
  afficheur ; balance → `Init_sport2` ; libellé d'avoir (`"Fiches_LibelAvoirs"` **en dur**) ;
  `TabParam` (`coretro`, `devise`) ; touches (`createPanel`, `Cbutton(Panel17)`, `InitTouche`).
  `Catch` → `Message.Error`.
- **`Form_Close()`** [nécessaire] [GUI] : refuse la fermeture si un ticket est en cours ; ferme les
  ports, supprime `~/Ticket.ps`, `Close #BA6X` si `bAffUSB` (socket jamais ouvert, CAISSE-A09) ;
  appelle `Me.Close` dans son propre `Close` (à confirmer : sans effet).
- **`Timer1_Timer()`** [nécessaire] [GUI] : réécrit l'heure en fin d'`Entete` (toutes les 60 s).
- **`SetObservers(hClass, hCont)`** [GUI] : observateurs `Obs` (Button) et `Obs2` (ImageButton),
  récursif ; `hClass` inutilisé. **`Obs_Enter`/`Obs_Leave`/`Obs2_Enter`/`Obs2_Leave`**
  [nécessaire] [GUI] : police grasse au survol.
- **`InitBA6X(ip, port)`** [GUI] : connexion socket à l'afficheur USB BA63 — **jamais appelée**
  (`unused`, vérifié). **`PrintBA6X(haut, bas)`** [calcul/périphérique] : `print|haut|bas` sur le
  socket ; appelée par `Aff_viseur` si `bAffUSB` alors que `BA6X` vaut `Null` (CAISSE-A09).
- **`KeyObserver_Keypress()`** [nécessaire] [GUI] : F11 → plein écran.
- **`Init_LigTk()`** [GUI] : colonnes de `LigTk`, client par défaut, `Clicompte = 0`,
  `Blexists = False`. **`Init_Columnview1()`** [GUI] : colonnes de `ColumnView1`.
- **`Ent_tk(numtk)`** [mixte] (CC 16) : entête du ticket selon l'imprimante (largeur des
  pointillés) ; `Ecole` ; numéro : rappel → `numtk`, sinon `TabCaisses.cutk` si non nul, sinon
  `Utils.db.LockIncrement("cutk", TabParam, "0000000")` puis `UPDATE TabCaisses SET cutk` ;
  `Ntk` ; `/caisse/choiximp2`. `If numtk == Null` sans `Then`.
- **`Button25_Click()`** [nécessaire] : `Me.Close` (Ctrl+F7). **`F1_Click()`** [nécessaire] : aide
  `Doc.Open("Laurux.PosIndexParCategories")`.

### G02 — Saisie et validation d'un article

- **`Cart_KeyPress()`** [nécessaire] [GUI] (CC 50) : clavier de la zone article. Esc (ferme le
  paiement ou la photo) ; F1 aide ; Alt+V (code 86, commenté « CTRL+X ») et Ctrl+X : changement de
  vendeur (`Svendeur.ShowModal`, `$Vendeur`, `Start.$Cai`, `TabVendeurs`, `Ent_tk(Null)` : **deux
  copies**, et sans effet, CAISSE-A04) ; Ctrl+M ticket de modification de règlement
  (`bmodifregl`, `Init_Reg`, `Button6_Click`) ; Ctrl+N `ClientsDivers` ; Ctrl+R rétrocession
  (`bretro`) ; Ctrl+T tiroir ; Ctrl+F2 recherche (non implémentée) ; Ctrl+F3 hors vente ; Ctrl+F4
  ticket X ; Ctrl+F5 bande Z ; Ctrl+F6 fond de caisse ; Ctrl+F7 fermer ; Ctrl+F8 carte de fidélité ;
  Ctrl+F9 remise sur total ; Ctrl+F11 tiroir (mot de passe) ; Ctrl+F12 client en compte ; F2 liste
  des articles ; F3 modification du prix ; F4 commentaire ; F5 quantité ; F7 paiement ; F8 mise en
  attente ; F9 tickets en attente ; F10 suppression ; F11 avoir ; F12 facturette ; Entrée/Tab →
  `Valid_commentaire` ou `Valid_Cart`.
- **`Valid_Cart() As Boolean`** [mixte] (CC 48) : code `*…` = code-barre (chiffres seulement) :
  14 caractères `*299999…` (code-barres interne des cartes, l. 1337 ; longueur attendue à confirmer avec le générateur de `FClientcarte`) ou ≤ 7 caractères → **carte de fidélité** (`Crt`, `Codearticle`,
  `RecupCarte` si client caisse), sinon `Utils.Find_cbarre` (`ibarre = 1`) ; recherche `TabArt`
  par `art_code`, puis `art_cequ`, puis `art_cfour` ; remplit désignation, prix, TVA, rétrocession
  (`art_prvt × coretro`), promotion, tranches `Rms` (sans effet, CAISSE-A02), photo ; code-barre →
  quantité automatique (`/caisse/qt1`, F5) puis `Init_Art` + `calc_total` ; prix nul → `modif_Tk`.
- **`Init_Art() As Boolean`** [mixte] : une remise sur total existe → question de suppression
  (« Non » → `Return True` sans ajouter la ligne, et l'appelant cumule quand même `calc_total`,
  CAISSE-A24) ; `Recup_dec`, `Decimal` ; quantité nulle → `False` ; `|qté| ≠ 1` → `iQte = 1` ;
  `Art_man`.
- **`Art_man()`** [mixte] (CC 77, max du fichier, 282 LOC) : ajoute l'article au ticket. Contrôle de
  stock (`art_stocke` + `/caisse/ctrlstk` + quantité ≤ 0 → refus) ; prix HT, colisage
  (`art_colvte`/`art_pvht2`), arrondi `art_cdarr`, TVA, rétrocession, promotion (`ArtPromo`),
  écotaxe (`art_ect`/`art_eco`) et copie privée (`art_cpp`/`art_copp`) TTC ; lignes `C` (« Produit
  en promotion »), `A`, `O`, `O`, `S` (remise %), `T` (prix total si quantité ≠ 1) ; prix modifié →
  `arrondi(arr, Pvttc)` ; quantité négative → montants négatifs ; `TotalTk += Artpu` ;
  `Aff_viseur` ; `Raz`. Variables `Sk` (utilisée), `Materiel`, `pmp` (inutilisées).
- **`Aff_Art()`** [mixte] : remplit la saisie depuis l'article choisi dans `TriArticles`.
  **`SelectionArt()`** [GUI] : `New TriArticles(…, Me)` → `Bsel`/`Bval` → `Aff_Art`.
  **`AppArt()`** [GUI] / **`Button40_Click()`** [nécessaire] : liste des articles (F2).
- **`Valid_Qte()`** [mixte] : quantité ≠ 0 → `Init_Art` + `calc_total`, ou focus remise.
  **`Qte_KeyPress()`** [nécessaire] (CC 18) : Ctrl+T, F3, F5 (calculette), F6 (remise), F8 (remise
  quantitative), F10 (balance), Entrée → `Valid_Qte`. **`Qte_GotFocus`**, **`Qte_Mousedown`**.
- **`Valid_commentaire()`** [GUI] : ligne `C`. **`Button1_Click()`** [nécessaire] : mode commentaire.
- **`TestPvttc()`** [mixte] (CC 16) : contrôle du prix saisi (prix nul, prix de vente < prix
  d'achat → alerte), `calc_HT` appelé deux fois. **`Pvttc_KeyPress`**, **`pvttc_LostFocus`**,
  **`Pvttc_GotFocus`**, **`Pvttc_MouseDown`**, **`Design_KeyPress`**, **`Design_GotFocus`**,
  **`Design_MouseDown`** [nécessaire] [GUI].
- **`Button4_Click()`** [nécessaire] (F3, mot de passe `F3`) → **`modif_Tk()`** [GUI] : déverrouille
  désignation et prix (`iModif = 1`).
- **`Button2_Click()`** [nécessaire] : calculette `FCalc` → quantité (`FCalc.Resultat`, `Static
  Public` jamais remis à zéro, voir [`FCalc`](../../Utils/FCalc.class/architecture.md)).
- **`Recup_dec()`** [mixte] (`art_dec`), **`Decimal()`** [GUI] (format de la quantité),
  **`Raz()`** [GUI], **`Prix_promo()`** [mixte] (`ArtPromo.Prix_Promo`/`Prix_Promottc`/
  `Intitule_Promo`), **`aff_Photo()`** [GUI], **`Photos_MouseDown()`** [nécessaire],
  **`panel17_KeyPress()`** [nécessaire], **`Cart_MouseDown`**, **`Cart_GotFocus`** [nécessaire].
- **`ChkPrx(Optional Sign)`** / **`ChkBs()`** [GUI] : filtres de saisie numérique (`Stop Event`).

### G03 — Calculs prix, TVA, arrondi

- **`arrondi(arr, Arttc) As String`** [calcul pur] (CC 11) : arrondi du TTC au pas `0,05`
  (dernier chiffre 3-7 → 5, sinon arrondi au dixième), `0,10`, `0,50` (bornes 25/75/76 par
  chaîne) ou `1,00`. Algorithme par manipulation de chaîne, **copie** de celui de `Facture`,
  `Moulinage`, `Articles`, `Movr`, `Materiel`, `FTvav` (voir propositions). Appelée seulement par
  `Art_man` (prix modifié).
- **`Calc_Tva()`** [mixte] : `TabTvav` par `code_tva = Tva` → `TxTva` = code, `Tva` = **taux**.
  ⚠️ Effet de bord : un second appel cherche `code_tva = <taux>` (sans résultat en pratique, donc
  sans effet ; à confirmer si un code TVA égal à un taux existe).
- **`calc_HT()`** / **`Calc_TTC()`** [mixte] : HT ↔ TTC de la ligne courante, `Mtva`.
- **`calc_total()`** [calcul] : `Totalht += Pvht × Qte`.

### G04 — Remises en % et remises quantitatives

- **`Button3_Click()`** [nécessaire] (F6, mot de passe `F6`) : remise % de la ligne (refus si
  promotion). **`Valid_Remise()`**, **`Remise_KeyPress()`** [nécessaire], **`Remise_GotFocus`**.
- **`Remises_quantitatives()`** [calcul] : recherche de la tranche dans `Rms`. ⚠️ `Rms` est un
  `String[]` à une dimension : les 18 affectations `Try Rms[i, j] = …` échouent (« Bad number of
  dimensions », vérifié avec `gbs3`), `Rms.Bounds[0] = 0` → **aucune remise quantitative n'est
  jamais appliquée en caisse** (CAISSE-A02).
- **`RemqShow()`** [GUI] (CC 20, 18 `Try` identiques) : affiche `Rms` dans `Tbrem` (toujours vide).
  **`Tbremq_Create()`** [GUI], **`Tbrem_Click()`** [nécessaire].

### G05 — Remise sur le total

- **`Button33_Click()`** [nécessaire] (Ctrl+F9, mot de passe `CtrlF9`) : refusé si des BL sont
  réglés dans le ticket. **`RemTot_KeyPress()`**, **`Button46_click()`** [nécessaire].
- **`Valid_Remtot(RemiseTotal)`** [mixte] (CC 27) : supprime les lignes `MT`, `Recalc_Tottk`,
  applique le pourcentage aux lignes `A`/`S` (relit `art_nbd` **par ligne**), ajoute trois lignes
  `MT` (brut, remise, net), `RenameLigne`. ⚠️ Le test `LigTk.Item[2] = Space$(15) & "Prix total "`
  ne correspond jamais au libellé écrit par `Art_man` (`Space$(3) & "\tPrix total"`) : les lignes
  `T` ne sont pas remisées (CAISSE-A10). Variables locales `Nbd`/`Nbdec` masquant les membres.

### G06 — Lignes du ticket : suppression, recalcul, renumérotation

- **`Ligtk_Delete(Need_Confirmation)`** [mixte] (CC 20) : supprime le bloc sélectionné (refus si un
  règlement est saisi) ; ligne `BL` → `UPDATE TabBl SET numtick = NULL` ; `EZ` → annule l'avoir ;
  `Valid_Remtot("0")` ; `Catch` vide. Le paramètre vaut toujours `True`.
  **`LigTk_KeyPress`**, **`LigTk_Activate`**, **`Suppr_Click`** [nécessaire].
- **`Recalc_Tottk()`** [GUI/calcul] (CC 14) : recalcule `TotalTk`/`Totalht` depuis les lignes
  `BL`, `EA` et les blocs `A` (+ `S`) ; ignore `EH`/`SH` (CAISSE-A30) ; `Message("Unsupported
  line")` sur type inattendu (même parcours de bloc qu'`Aff_bastk`).
- **`RenameLigne()`** [GUI] : renumérote la colonne 0.

### G07 — Tickets en attente, rappel, suppression

- **`Ticket_Attente() As Boolean`** [mixte] : question, `iAttente = 1`, `Enrg_Tk(False)` (statut 1),
  remise à zéro. **`Button7_Click()`** [nécessaire] (F8).
- **`Button8_Click()`** [nécessaire] (F9) : liste `Fiches_EntTicketz` (**en dur**) `statut = 1`.
  **`ColTka_KeyPress()`** [nécessaire].
- **`ColTka_Click()`** [nécessaire, appelé par le rejeu] (CC 15) : met le ticket courant en
  attente, recharge entête (`client`, `type` 1 → bon de caisse, `savoir` → avoir) et lignes
  (`Fiches_LigTicketz` en dur, `ORDER BY cast(numlig as unsigned), cast(block as unsigned)`, blocs
  renumérotés, `art_tva` relu par ligne, `BL` → `Blexists`), `iRattente = 1`, puis **supprime** le
  ticket en attente (entête + lignes) : il sera réécrit par `Enrg_Tk`. Résultat `RTck` lu sans
  `Available`.
- **`Button9_Click()`** [nécessaire] (F10, mot de passe `F10`) → **`suppr_Tk()`** [mixte] : libère
  les BL (`UPDATE TabBl SET numtick = NULL`), archive le ticket comme **supprimé**
  (`Dupli(Enrg_Tk(True))`), sauf s'il existe déjà dans la ticketz ; remise à zéro.

### G08 — Avoirs et crédits (saisie du client)

- **`Button10_Click()`** [nécessaire] (F11, mot de passe `F11`) : avoir en début de ticket
  seulement, refusé si client en compte ; suppression d'un avoir défini (`TotalTk.Text = 0`).
- **`button17_Click()`** [nécessaire] : valide `Frame3` : « Avoir de » → `iAvoir = 1`, ligne `EZ`
  + 4 lignes de `sAvoir` ; « Crédit accordé à » → `iCredit = 1`, `button19_Click`.
- **`CliAv_Select_Click()`** [nécessaire] : `TriCpt(Client, Sans_Solde, Me)` → `Bsel`/`Bval`.
  **`Nmc_KeyPress`**, **`Button52_Click`** [nécessaire].

### G09 — Paiement : cadre, modes de règlement, lignes de règlement

- **`Button6_Click()`** [nécessaire] (F7) / **`F2_Click()`** [nécessaire] : bon de caisse d'un
  client en compte → `Aff_bastk` + `Button15_Click` directement (sans règlement) ; avoir à total
  positif → idem ; sinon ouvre `Frame2` (`Mticket`, `Rticket`, `ipaiement = 1`).
- **`init_paiement()`** [GUI] : masque et vide tous les champs de montant, remet les drapeaux de
  mode — ⚠️ y compris `iavoir = 0` (même variable que `iAvoir`, CAISSE-A20).
- **`Inpm_KeyPress()`** [nécessaire] : F1-F12 → modes ; F7/Esc → `Init_Reg` ou suppression du
  ticket. **`Init_Reg()`** [GUI] : ferme le cadre de paiement.
- **`Calc_reste(Montant)`** [GUI/calcul] : `Rticket -= Montant`, « A rendre » / « Reste à payer »,
  afficheur. **`Valid_Reste()`** [GUI] : ligne `Q` (rendu) si reste < 0 hors `bmodifregl`.
- **Un mode = un bouton + un `*_KeyPress` + un `Valid_*`** :
  | Mode | Bouton (touche) | Saisie | Validation | Code `ColumnView1` |
  |---|---|---|---|---|
  | Espèces | `Button11_Click` (F1) | `Especes_KeyPress` | `Valid_Especes` (montant 0 permis pour un échange) | `N` (cumulé) |
  | Carte | `Button12_Click` (F2, nom si `/choiximpc` faux) | `carte_KeyPress` | `Valid_Carte` | `U`, `U<nbc>` |
  | Chèque | `Button13_Click` (F3, `/choiximpn`) | `Cheque_KeyPress` | `Valid_Cheque` (question → `Imp_Cheque`) | `V`, `V<nbc>` |
  | Crédit | `Button14_Click` (F4, `Frame3`) | `credit_KeyPress` | `Valid_Credit` | `W` |
  | Bon d'achat | `Button16_Click` (F5) | `Bachat_KeyPress` | `Valid_Bachat` | `X` |
  | Avoir | `Button18_Click` (F8, liste `TabAvoirs`) | `cavoirs_keyPress`, `Cavoirs_Click`, `Bavoir_KeyPress` | `Valid_Bavoir` (≤ montant, `DocActif.Get_Lock("Avoirs")`) | `Z<lind>` |
  | Chèque cadeau | `Button27_Click` (F6) | `Chequecad_KeyPress` | `Valid_Chequecad` | `Y<n°>` |
  | Autre | `Button36_Click` (F11) | `Bautre_KeyPress` | `Valid_Bautre` (⚠️ l. 3734 modifie `Chequecad`, CAISSE-A11) | `E` |
  | Ticket restaurant | `Button53_Click` (F12) | `Tresto_KeyPress` | `Valid_Tresto` | `1` |
  | Bonus fidélité | `Button31_Click` (F9) | `Bonus_KeyPress` (`ChkBs`) | `Valid_Bonus` (≤ `fbonusg`) | `B` |
  | Acompte | `Button35_Click` (F10, liste `TabAcomptes` + `TabCli` par ligne) | `cacomptes_keyPress` (⚠️ ne renseigne pas `lindacompte`, CAISSE-A12), `Cacomptes_Click` (choix « montant restant uniquement »), `Bacompte_KeyPress` | `Valid_Bacompte` (≤ montant, `Get_Lock("Acomptes")`) | `RA<lind>` |

  Tous les handlers sont [nécessaire] [GUI] ; les `Valid_*` sont [GUI] (sauf `Valid_Bavoir` et
  `Valid_Bacompte`, [mixte]). **`button19_Click()`** [nécessaire] et **`Nmc2_KeyPress()`**
  [nécessaire] aiguillent après la saisie du nom (`Frame4`). Les dix `*_KeyPress` de mode (CC 21-22)
  sont des copies avec des trous différents (Bachat, Bavoir, Chequecad sans F12) ; huit `Valid_*`
  sont quasi identiques (Bachat, Bautre, Tresto, Bonus, Credit diffèrent par le code et le
  libellé ; Chequecad, Bavoir, Bacompte remplacent au lieu de cumuler). `Cavoirs_Click` et
  `Cacomptes_Click` sont appelés par le rejeu (`replay_dynamic`).
- **`Delete_Reglements_Tk()`** [GUI] (CC 23) : retire de `LigTk` les lignes de bas de ticket et
  de règlement ; ⚠️ `Left(…, 2) = "E"` jamais vrai (lignes `E` conservées) et la première ligne
  n'est jamais examinée (CAISSE-A19). **`ColumnView1_Delete(Confirm)`** [GUI] : supprime les
  règlements et libère les verrous `DocActif` (même parcours : verrou de la 1re ligne non libéré,
  à confirmer). **`ColumnView1_KeyPress`**, **`ColumnView1_Activate`** [nécessaire].

### G10 — Fidélité : cartes, points, bonus

- **`pointsF()`** [mixte] (CC 31) : bas de ticket (`TabLibelTicket`), `Delete_Reglements_Tk`,
  `Aff_bastk`, calcul des points par bloc (articles, remises si `frem`, promotions exclues si
  `fpromo` faux, `art_bonus` relu par ligne), lignes `BB` (`/caisse/recapbonus`), 3 lignes de pied.
- **`CartesFidelite()`** [GUI] (Ctrl+F8) / **`Button32_Click()`** [nécessaire] : `New Tricartes(0,
  Null, Me)` (Parent `Null`, retour par `Me`) → **`RecupCarte(code)`** [mixte] : `TabCarte` →
  points (`tp2`), seuil (`tp1`), bonus (`tg1`, `tg2`), options `rem`/`promo`, libellés.

### G11 — Hors vente, acomptes reçus, fond de caisse

- **`Btn_EntreeEnc_Click()`** [nécessaire] (Ctrl+F3, mot de passe `EF3` → ⚠️ ouvre `Frame2` au lieu
  de `Frame5`, CAISSE-A13) : cadre `Frame5`. **`MvtHV_Sortie_Click`**, **`MvtHV_Entree_Click`**,
  **`AcomptesE_Click`**, **`AcptChClicpt_Click`** (TriCpt), **`AcptClicpt_KeyPress`**,
  **`Nmc3_KeyPress`**, **`Especes2_GotFocus`**, **`Especes2_KeyPress`**,
  **`Btn_Valid_HorsEnc_KeyPress`** (toute touche valide), **`Btn_Valid_HorsEnc_Click`**
  [nécessaire] [GUI].
- **`horsven_evkeypress()`** [GUI] : **pas un handler** (le groupe de `Frame5` est `horsven_ev`,
  l'événement serait `horsven_ev_KeyPress`) ; appelé explicitement par trois handlers.
- **`Mvt_HorsEnc(Enc)`** [GUI] : libellé ≥ 15 caractères → **`Valid_HorsVte(Acompte, Enc, Libelle,
  Acptcli)`** [GUI] : lignes `C` + `EA` (acompte, code = compte client) / `EH` / `SH` (montant
  négatif) ; `TotalTk += Val(…)` sans `cpoint`.
- **`Maj_Acomptes(cli_code, intitule, smnt, libelac, ntk)`** [traitement] : `INSERT TabAcomptes`
  (client par défaut si vide, `type = libelac`, `dte = LDate.DT` de l'**auto-instance**,
  CAISSE-A21) ; appelée par `Enrg_Tk` pour chaque ligne `EA`. `rJnl`, `CptCaisse` inutilisés.
- **`Btn_Find_Click()`** [nécessaire] : « Non implementé ». **`button21_Click()`** [nécessaire] :
  `Fondcaisse` modal.

### G12 — Bas de ticket, validation et enregistrement

- **`TabTva()`** [traitement] : `DROP TABLE IF EXISTS Tottva` + `CREATE TABLE Tottva (…)
  ENGINE = MYISAM` : table de travail **partagée** (non temporaire, hors `Cbase` et
  `db_control.csv`), syntaxe non SQLite (CAISSE-A17).
- **`Aff_bastk() As Boolean`** [mixte] (CC 39) : cumule HT et TVA par taux (lignes `A` + `S`, `EH`,
  `SH`, `EA`, et `BL` dont la TVA est relue dans `TabLigbl` `typel_ligbl = "A"`) dans `Tottva`
  (SELECT/INSERT/UPDATE par ligne), ajoute `L`, `BH`, `BA` (un par taux), `BC`, puis les
  règlements de `ColumnView1` (ou la ligne `M` du bon de caisse) et une ligne vide.
- **`Button15_Click()`** [nécessaire] (CC 21) / **`button15_KeyPress()`** [nécessaire] : impression
  et validation : ticket de modification de règlement à solde nul ; avoir ou bon de caisse →
  `Defaut_Tk` (même sur imprimante série, CAISSE-A22) ; sinon solde nul → `Defaut_Tk` ou `Serial_Tk`.
- **`Button37_Click()`** [nécessaire] / **`button37_KeyPress()`** [nécessaire] (`/caisse/choiximp`)
  : validation **sans impression** : stock + `Enrg_Tk(False)`, sans `Dupli`.
- **`Enrg_Tk(Supprime) As String`** [traitement + GUI] (CC 72, 339 LOC) — voir « Flux des
  règlements » ci-dessous. Résumé : contrôle d'unicité dans `Fiches_EntTicketz` (sinon libère
  `cutk` et abandonne **sans enregistrer**, alors que le stock a déjà été mouvementé,
  CAISSE-A29) ; cumul des règlements par type ; consommation des avoirs (`TabAvoirs`) et acomptes
  (`TabAcomptes`) utilisés, libération des verrous ; `INSERT` des acomptes reçus ; `INSERT` des
  lignes dans `Fiches_LigTicketz` (famille relue par ligne) ; une 3e boucle recalcule des montants
  remisés **sans jamais les écrire** (code mort) ; `UPDATE Fiches_Caisses` (en dur) `fndtotp`,
  `fndtotg` ; avoir → `INSERT TabAvoirs` ; `INSERT Fiches_EntTicketz` (36 colonnes ; ⚠️ `mtva` =
  **dernière** ligne `BA`, pas la somme des taux, CAISSE-A18) ; `tkz = 0` ; client en compte →
  `Moulinage.Generation_BL` + mise à jour de la ligne `M` + ligne de commentaire ;
  `Sha1Calc.CalcSha1T("Fiches_EntTicketz", n°, précédent)` ; `TabParam.dntk` ; `cutk = NULL` ;
  conversion des points de fidélité (`UPDATE TabCarte`) ; remise à zéro de l'écran.
- **`Dupli(numero)`** [GUI/fichiers] : copie `~/Ticket.pdf` dans `~/HistoTickets-<user>/aaaa/mm/`
  (`Shell cp`/`mv` sans guillemets) ; ⚠️ appelée aussi après une impression série ou une suppression,
  où aucun PDF n'a été produit : archive le PDF **du ticket précédent** sous le nouveau numéro
  (CAISSE-A16).

### G13 — Impression, chèque, mail, périphériques série

- **`Ouv_Tiroir()`** [périphérique] : ESC p 0 + GS a 1. **`Aff_viseur(texte, sup)`**
  [périphérique] : afficheur sur le port imprimante, et `PrintBA6X` si `bAffUSB`.
- **`Entete_Tck(origine)`** [périphérique] : entête ESC/POS (`6000III` ; `Tmu950` en deux passes
  receipt/journal avec coupe). **`Serial_Tk()`** [mixte] : entête, lignes (`imp_ligtk` 6000III /
  `imp_ligtk2` Tmu950), chèque, stock, `Dupli(Enrg_Tk(False))`, coupe. **`imp_ligtk()`** /
  **`imp_ligtk2()`** [périphérique] : formatage 23/21 colonnes (même test mort `Space$(15) &
  "Prix total "`).
- **`Imp_Cheque()`** [périphérique] : montant en lettres par `numtostring.nbtostring` — ⚠️ les
  modules `Utils/Numtostring.module` et `Caisse/numtostring.module` sont homonymes à la casse près,
  seul le premier est compilé (`.gambas/NUMTOSTRING` ne contient que `Convertir` et `Num2Text`,
  vérifié) : **l'impression du chèque échoue** (CAISSE-A01) ; ordre (`/caisse/ordre`), lieu
  (`/caisse/lieu`), date. **`Imp_Cheque1()`** : **code mort** (`unused`, variante parcourant les
  lignes `V`).
- **`Defaut_Tk(mail)`** [mixte] (CC 21) : PDF `Cfacture` A4 ou 80 mm (`Ba4`), entête, logo, bon de
  caisse (`TabCli` sans `Available`), lignes `Level1`, `~/Ticket.pdf`, `Impression.Ticket` (sauf
  mail), stock, `Dupli(Enrg_Tk(False))`. Si l'imprimante n'est ni `DéfautA4` ni `Défaut80` et que
  `mail` est faux, `pdf` reste `Null` (CAISSE-A22).
- **`Init_sport()`** [périphérique] : ouverture de `SPort` (9600/19200 bauds) ; échec →
  message puis **`Quit`** (CAISSE-A25). **`Init_sport2()`** : balance. **`SPort2_Read()`**
  [nécessaire : événement `Read` de `SPort2`, aussi appelé directement]. **`Recup_Poids()`**,
  **`Button34_Click()`** [nécessaire] : pesée.
- **Envoi par mail** : **`Buttonma_Click()`** [nécessaire] : solde nul → `entremail` →
  `Defaut_Tk(True)` (PDF A4, **et enregistrement** du ticket) → `EnvMail.Envoi`.
  **`buttonma_KeyPress()`** [nécessaire]. **`entremail()`** [GUI, déjà `Private`] : fenêtre
  construite par code (`Window "win"`, `TextReg "mail"`, boutons `"annul"`/`"valid"`), courriel du
  client en compte (`Fiches_Cli` **en dur**). **`mail_lostfocus`**, **`valid_click`**,
  **`annul_click`** [nécessaire] : handlers de ces contrôles dynamiques.

### G14 — Stock

- **`Maj_Quantite()`** [traitement] : `LOCK TABLES TabArt, TabArtPromo` ; pour chaque ligne `A`
  stockée : `art_qte ± qté` (+ si avoir) ; `ArtPromo.Maj_qteplus` si promotion ; `UNLOCK`.
- **`Maj_QteDep()`** [traitement] : même chose sur `Fiches_StkDepots` (**en dur**) pour le dépôt de
  la caisse ; ⚠️ lit `rStk!art_qte` alors que la table n'a que `coded`, `codea`, `qte`
  (`db_control.csv`) → erreur non interceptée dès qu'une ligne de dépôt existe, `LOCK TABLES`
  conservé (CAISSE-A03).

### G15 — Client en compte et règlement de BL/factures

- **`Button30_click()`** [nécessaire] (Ctrl+F12) : ⚠️ ticket d'avoir → message sans `Return`
  (CAISSE-A14). Choix 1 : nouveau bon de caisse (annule les règlements de BL déjà sélectionnés) →
  `TriCpt` → `Recup_Client`. Choix 2 : régler des BL/factures : `TriFacture(Null,
  BonFacNonPaye, Null, n° ticket, LTrans)` → `LOCK TABLES TabBl` ; `numtick = NULL` puis
  `numtick = n° ticket` pour la liste (**`IN (…)` concaténé**) ; `UNLOCK` ; `Ajout_Reg_Bl`.
- **`Ajout_Reg_Bl(numtick) As Boolean`** [mixte] : remplace les lignes `BL` du ticket par une ligne
  par BL marqué (`code = nmclibl`, `[6] = totalht`, `[7] = numbl`, `[11] = totalttc`), cumule le
  total. Variable locale `Blexists` masquant le membre.
- **`Recup_Client(codeclient)`** [mixte] (CC 15) : client ⋈ compte (`Try` inutile, lecture sans
  `Available`), encours = solde comptable + BL non facturés (`imp = 0`, `numtick IS NULL`) ;
  dépassement du plafond → question ; avec mot de passe admin : `Frame8` (`org = "EF12"`, non traité
  par `Valid_Mdp`) **et le code continue** : le bon de caisse est accepté sans mot de passe
  (CAISSE-A13) ; `Clicompte = 1`.

### G16 — Facturettes et clients divers

- **`Button26_Click()`** [nécessaire] (F12) : `Frame6` (n° de ticket, défaut `Dtck`), vide
  `$iSpc`/`$iSpc2`. **`Nticket_KeyPress`**, **`Button41_Click`**, **`Button48_Click`**,
  **`Button49_Click`**, **`Button47_Click`** [nécessaire].
- **`Valid_Nticket()`** [mixte] : `Fiches_EntTicketz` (en dur) `statut = 0` (ticketz du jour
  seulement : après la bande Z le ticket est introuvable) ; ticket client caisse → `Frame7`
  (coordonnées) ; bon de caisse → entête client + `Serial_Facture`/`Defaut_Facture`.
- **`button29_Click()`** [nécessaire] : `/caisse/histocli` → `Enrg_Clientd(Caisse.Codearticle)`
  (⚠️ auto-instance, CAISSE-A06) ; `Ent_tk2` ; impression. **`Ent_tk2()`** [GUI] : entête de
  facture. **`impressionbon(clientc)`** [mixte] : réimpression ; ⚠️ toujours `Serial_Facture` pour
  un ticket non client compte, même sur imprimante PDF (CAISSE-A23).
- **`Serial_Facture()`** [périphérique] / **`Defaut_Facture()`** [mixte] (CC 32) : lignes de
  `Fiches_LigTicketz` (en dur) `ORDER BY lind` ; PDF `Cfacture` (sans `Catch` dans `Defaut_Tk` : logo invalide → impression interrompue, CAISSE-A31) ; `Impression.Facture(fichier,
  Nbf|1)` (lit `/FACpdf`, `/CmdImp` globaux, voir
  [IMPRESSION-A01/A02](../../Utils/Impression.module/rework.md)) ; `Kill`.
- **`ChkNtk()`** [GUI], **`Nmc4_KeyPress`**, **`Nmc5_KeyPress`**, **`Nmc6_KeyPress`** [nécessaire]
  (trois copies : Esc/F12 → `impressionbon("")`, F2 → `ClientsDivers`, Tab → champ suivant),
  **`button42_Click`** [nécessaire].
- **`ClientsDivers()`** [GUI] (Ctrl+N) : ⚠️ `New Tricartes(-1)` sans objet de retour → `Bsel` reste
  faux, `RecupClientd` n'est jamais appelé (et recevrait `Codearticle`, pas la sélection) :
  **fonction sans effet** (CAISSE-A07, TRICARTES-A01). **`RecupClientd(code, Update_Field)`** [mixte] (`TabCarte`).
  **`Enrg_Clientd(code)`** [traitement] : `UPDATE` ou `INSERT TabCarte` (code = dernier + 1 par
  `ORDER BY code` + `MoveLast`, `divers = -1`) avec `LDate(Now)` passé comme paramètre SQL (objet,
  à confirmer).
- **`Button50_Click()`** : **code mort** (aucun contrôle `Button50` dans le `.form`).

### G17 — Tickets X et Z

- **`Button20_Click()`** [nécessaire] (Ctrl+F4) : ticket X → `Defaut_Ticketxz(…, False)`.
- **`button24_Click()`** [nécessaire] (Ctrl+F5, mot de passe `B24`) : total nul et `/caisse/ChmZ`
  défini → **`Ticketz()`** [mixte] : refusé en caisse école ou s'il reste des tickets en attente ;
  `Defaut_Ticketxz(…, True)` ; ⚠️ sur imprimante série : ticket X (`False`) mais `tkz = 1` quand
  même (CAISSE-A15). Le `Catch` de `button24_Click` attribue toute erreur au chemin `ChmZ`.
- **`Defaut_Ticketxz(sintitule, org)`** [mixte] : `Moulinage.Livre_caisse(Ncaisse, "0", org, Null,
  "A4", fichier)` ; Z → **`DupliZ(Zfile)`** [fichiers] : copie dans `ChmZ/aaaa/mm` ; ⚠️ si `ChmZ`
  n'existe pas, il est créé mais **rien n'est copié** ; message contenant le texte littéral
  `& Chemin'` (CAISSE-A16).
- **`margeart(…)`** [déjà `Private`] : **code mort** (`unused`), `Fiches_Art` en dur.

### G18 — Mot de passe administrateur

- **`mdp_admin()`** [GUI] : `GestMdp = 1` si `/caisse/admin`. **`Mdp_KeyPress()`** [nécessaire].
- **`Valid_Mdp()`** [mixte] (CC 24) : `TabVendeurs` `admin = "-1"`, `hexdblKey.Crypt("de", mdp,
  "Laurux")` comparé à la saisie ; exécute l'action `org` : `F3`, `F10`, `F11`, `F2` (non
  implémenté), `EF3` (⚠️ `Frame2`), `F6`, `F8`, `CtrlF9`, `B24`, `CtrlF11`, `Credit` (**jamais
  affecté** : branche morte) ; `EF12` n'est pas traité.

### G19 — Écran tactile, clavier virtuel, touches de famille

- **`InitTouche()`** [mixte] : libellés, codes (`codeA`), sous-famille (`ToucheS`), couleurs et
  images des boutons depuis `TabTouches` (`cai = Ncaisse`).
- **`Button38_Click()`** / **`Button39_Click()`** [nécessaire] : « Entrée » tactile selon la zone
  (article / paiement). **`Entree_Click()`** [nécessaire] : Entrée du clavier virtuel.
  **`Button43_Click()`** [nécessaire] : vide le champ de la zone (test `Especes` en double).
  **`Echap_Click()`** [nécessaire] (CC 32) : sortie de zone ; 11 branches identiques
  `init_paiement` ; ⚠️ `Case "Espece2"` (la zone s'appelle `Especes2`) : branche morte.
- **`Clav_click()`** [nécessaire] (groupe `Clav`, 46 boutons) → **`Numerique()`** / **`Alpha()`**
  [GUI] : construction de `$saisie` depuis `Last.name`.
- **`Efface_Click()`** : **code mort** — `Efface` appartient au groupe `Clav` (`.form` l. 878), seul
  `Clav_click` est levé (`handlers_inactifs`). **`Button44b_click()`**, **`Entree2_Click()`**
  (vide) : **code mort** (aucun contrôle).
- **`Panel12_KeyPress()`** [nécessaire] : ajoute `Key.code` (code numérique) à la quantité.
- **`Clav2_Click()`** [nécessaire] (groupe `Clav2`, 40 touches de famille) : sous-famille →
  `createPanel` + `Cbutton` + `Init2` ; touches spéciales « REMISE % », « APPEL QTE » (message
  erroné « remise en % »), « FACTURETTE », « REMISE\nSUR TOTAL » ; sinon article `codeA[Tag]` →
  `Valid_Cart`. **`Clav3_Click()`** [nécessaire] (boutons de sous-famille créés par code) : idem.
- **`ClavFam()`**, **`Fermer2()`** [GUI], **`Button5_Click()`** [nécessaire] : panneau des familles.
  **`createPanel()`** [GUI] : nouveau panneau `hpan` à chaque appel (l'ancien n'est pas toujours
  supprimé). **`Cbutton(oObj)`** [GUI] : `ImageButton` « Clav3 » par bouton à `Tag`. **`Init2()`**
  [mixte] : libellés des sous-familles (`TabTouches`).

## Flux des règlements (tables `Fiches_EntTicketz`, `Fiches_LigTicketz`, avoirs, acomptes, BL)

1. **Saisie** : chaque règlement est une ligne de `ColumnView1` (code du mode, libellé, montant,
   n° de document, client, `lind`). Avoir utilisé (`Valid_Bavoir`) et acompte utilisé
   (`Valid_Bacompte`) sont **verrouillés** par `DocActif.Get_Lock("Avoirs"|"Acomptes", lind)` et
   contrôlés contre le montant restant en base (`TabAvoirs`, `TabAcomptes`) ; l'acompte peut être
   partiel (« Montant restant uniquement », commit `556d1f0f`).
2. **Bas de ticket** (`Aff_bastk`, appelé par `pointsF` ou directement) : les règlements sont
   recopiés dans `LigTk` (type = code du mode, `[7] = lind`, `[1] = client`).
3. **Enregistrement** (`Enrg_Tk`) :
   - entête `Fiches_EntTicketz` : un couple (indicateur, montant) par famille de mode (`scheque`/
     `mcheque`, `scarte`/`mcarte`, `sespeces`/`mespeces` (rendu `Q` inclus, négatif), `scredit`/
     `mcredit`, `sbachat`/`mbachat`, `scavoir`/`mavoir`, `sbonus`/`mbonus`, `sresto`/`mresto`,
     `sautre`/`mautre`) ; **l'acompte utilisé n'a pas de colonne** dans l'entête : il n'existe que
     comme ligne `RA` de `Fiches_LigTicketz` (`mrem` = `lind`) ;
   - lignes `Fiches_LigTicketz` : toutes les lignes de `LigTk`, dont les règlements (`RA`, `Z`,
     `EA`, `BL` avec `mrem` = n° de BL, `M` avec `mrem` = n° du BL généré) ;
   - `Z` : `TabAvoirs.montant -= utilisé` (suppression à zéro), `Free_Lock` ;
   - `RA` : `TabAcomptes.montant -= utilisé` (suppression à zéro), `Free_Lock` ;
   - `EA` (acompte reçu, saisi en hors vente) : `INSERT TabAcomptes` (`Maj_Acomptes`), montant
     exclu des totaux de caisse (`Fiches_Caisses.fndtotp/fndtotg -= TotAcompte`) ;
   - avoir émis (`iavoir = 1`) : `INSERT TabAvoirs` du total ;
   - bon de caisse (client en compte) : pas de règlement ; `Moulinage.Generation_BL` crée le BL.
4. **Règlement de BL/factures en caisse** (`Button30_click` choix 2) : les BL choisis reçoivent
   `Fiches_Bl.numtick = n° du ticket` (réservation) ; chaque BL devient une ligne `BL` encaissée
   comme une vente ; la suppression de la ligne ou du ticket remet `numtick` à `NULL`. La
   facturation (`type = "F"`, `acquitte = 1`, `reg = "Caisse"`, `mtreg`, `numfac`) et l'historique
   sont faits par `Moulinage.Livre_caisse` à la bande Z (`Moulinage.class:1111-1371`), pas par
   `Caisse`. `Fiches_Reglements` est seulement le référentiel des modes (lu par `Moulinage`).
5. **Bande Z** (`Ticketz`) : `Moulinage.Livre_caisse` archive `Fiches_EntTicketz`/`LigTicketz`
   dans `Fiches_HisEntTickets`/`Fiches_HisLigTickets`, génère les écritures (avoirs/acomptes par
   `Moulinage_Acomptes_Avoir`) ; `Caisse` marque `Fiches_Caisses.tkz = 1`.

## État global utilisé

- **`Start`** : `LocalSettings["/Soc<XX>/caisse/…"]` (~35 clés : `qt1`, `recapsoldecli`,
  `tactile`, `nbf`, `Txt_viseur`, `affusbwn`, `Ncai`, `balance`, `Tbalance`, `portb`, `choiximp`,
  `choiximp2`, `choiximpc`, `choiximpn`, `ctrlstk`, `touchfam`, `Tfamilles`, `recapbonus`, `admin`,
  `histocli`, `ChmZ`, `ordre`, `lieu`…), `/Soc<XX>/Siret`, `/Coul/Focus` ; `Start.Societe`,
  `Start.son`, `Start.Musique`, `Start.$Cai` (vendeur choisi dans `Svendeur`).
- **`Utils`** : `db` (seul accès SQL, `LockIncrement`), `cpoint`, `Find_cbarre`, `Find_Nbdec`,
  `FColr`, `Replace`, `Remplace`, `convBool`, `Bip`, `Observers`.
- **Objets et classes** : `ArtPromo` (promotions), `DocActif` (verrous), `Sha1Calc` (chaînage),
  `Moulinage` (`Generation_BL`, `Livre_caisse` sur l'auto-instance du formulaire), `Impression`
  (`Ticket`, `Facture`), `EnvMail`, `Cfacture` (PDF), `hexdblKey.Crypt`, `LDate`, `LTrans`, `FCalc`,
  `Fondcaisse`, `Svendeur`, `TriCpt`, `TriArticles`, `TriFacture`, `Tricartes`, `TextReg`,
  `ImageButton`, `Doc`, `numtostring` (voir CAISSE-A01).

### Tables

| Table | Accès | Fonctions principales | Remarque |
|---|---|---|---|
| `Fiches_EntTicketz` | S/I/D | `Enrg_Tk`, `ColTka_Click`, `Button8_Click`, `suppr_Tk`, `Valid_Nticket`, `Ticketz` | **en dur** (clé `TabEntTck` existante) |
| `Fiches_LigTicketz` | S/I/U/D | `Enrg_Tk`, `ColTka_Click`, `Serial_Facture`, `Defaut_Facture` | **en dur** (clé `TabLigTck`) |
| `Fiches_Caisses` (`TabCaisses`) | S/U | `Form_Open`, `Ent_tk`, `Enrg_Tk`, `Ticketz` | `cutk`, `tkz`, `fndtotp`, `fndtotg` ; en dur dans `Enrg_Tk` |
| `Fiches_Parametres` (`TabParam`) | S/U | `Ent_tk` (`LockIncrement cutk`), `Enrg_Tk` (`dntk`), `Form_Open` | |
| `Fiches_Art` (`TabArt`), `Fiches_ArtPromo`, `Fiches_Promo` | S/U | G02, `Maj_Quantite`, `Valid_Remtot`, `pointsF`, `Enrg_Tk` | stock sous `LOCK TABLES` ; relu ligne à ligne |
| `Fiches_StkDepots` | S/U | `Maj_QteDep` | **en dur** ; colonne `art_qte` inexistante (A03) |
| `Fiches_Tvaav` (`TabTvav`) | S | `Calc_Tva` | relu à chaque calcul |
| `Fiches_Avoirs` (`TabAvoirs`) | S/I/U/D | `Button18_Click`, `Valid_Bavoir`, `Enrg_Tk` | |
| `Fiches_Acomptes` (`TabAcomptes`) | S/I/U/D | `Button35_Click`, `Valid_Bacompte`, `Maj_Acomptes`, `Enrg_Tk` | |
| `Fiches_Bl` (`TabBl`), `Fiches_Ligbl` (`TabLigbl`) | S/U | `Button30_click`, `Ajout_Reg_Bl`, `Recup_Client`, `suppr_Tk`, `Ligtk_Delete`, `Aff_bastk` | `numtick` = réservation par le ticket |
| `Fiches_Cli`, `Fiches_Comptes` | S | `Recup_Client`, `ColTka_Click`, `Defaut_Tk`, `CliAv_Select_Click`, `entremail` | `Fiches_Cli` en dur dans `entremail` |
| `Fiches_Carte` (`TabCarte`) | S/I/U | `RecupCarte`, `RecupClientd`, `Enrg_Clientd`, `Enrg_Tk` | cartes de fidélité et clients divers |
| `Fiches_Vendeurs`, `Fiches_ClientCaisse`, `Fiches_Societes`, `Fiches_Touches`, `Fiches_LibelTicket`, `Fiches_LibelAvoirs` | S | G01, G10, G18, G19 | `Fiches_LibelAvoirs` en dur |
| `Tottva` | DROP/CREATE/S/I/U | `TabTva`, `Aff_bastk` | table de travail partagée, `ENGINE = MYISAM`, hors `Cbase` |

## Propositions d'amélioration

Fichier legacy à haut risque (AGENTS.md règle 21) : uniquement des changements **ciblés**, chacun
couvert par un replay. Ne **pas** réécrire la logique de saisie (`Art_man`, `Valid_Cart`,
`Cart_KeyPress`) ni celle de l'enregistrement (`Enrg_Tk`) : trop de drapeaux implicites.

### Réécriture / refactorisation (dans le fichier)

- **Code mort confirmé** : `Imp_Cheque1`, `margeart`, `Button44b_click`, `Button50_Click`,
  `Efface_Click`, `Entree2_Click` ; 3e boucle d'`Enrg_Tk` ; branches `org = "Credit"` de
  `Valid_Mdp` et `Case "Espece2"` d'`Echap_Click` ; variables locales inutilisées (`Materiel`,
  `pmp` d'`Art_man`, `rJnl`/`CptCaisse` de `Maj_Acomptes`, `Tiketx`/`MntFam`/`QteFam` d'`Enrg_Tk`…).
  `InitBA6X` est conservé tant que CAISSE-A09 n'est pas tranchée.
- **Copies internes** à factoriser sans changer le SQL : les dix `*_KeyPress` de mode de paiement
  (aiguillage F1-F12 avec leurs trous actuels), la fin commune des `Valid_*` (solde atteint →
  question de rendu, tiroir, `pointsF`), le changement de vendeur (2 copies), les 18 `Try Rms…`
  (2 copies) et les 18 `Try Tbrem…`, `Nmc4/5/6_KeyPress`, l'entête société (`Ent_tk`,
  `Ent_tk2`, `Valid_Nticket`, `impressionbon`), le bloc « `If Start.son Then Music.Play` »
  (≈ 105 occurrences, souvent doublé), les 11 branches `init_paiement` d'`Echap_Click`.
- **Parcours de blocs** dupliqué entre `Aff_bastk` et `Recalc_Tottk` : un itérateur privé
  `FinDeBloc()` (sans changer les cumuls).

### Commonalisation avec d'autres fichiers

- Promotion du jour (l. 218) → `ArtPromo.PromoDuJour()`
  ([ARTPROMO-004](../../Gestion/Tables/ArtPromo.module/rework.md)), avec `Articles:231` et
  `Facture:508`.
- Arrondi au pas (`arrondi`) : même famille d'algorithmes que
  [`Facture.arrondi`](../../Gestion/Facturation/Facture.class/architecture.md) (FACTURE-008,
  `ArrondiPas`), [`Articles`](../../Gestion/Tables/Articles.class/rework.md) (ARTICLES-011,
  `ArrondiPvTTC`), [`FTvav.ArrondiPrix`](../../Compta/Tables/FTvav.class/rework.md),
  [`Moulinage.arrondi`](../Moulinage.class/architecture.md) (paramètres inversés),
  [`LPrix.Arrondi_Calc`](../../Utils/LPrix.class/architecture.md) : une seule fonction pure à
  retenir en phase 3, **après comparaison cas par cas** (les variantes diffèrent sur 0,50).
- Montant en lettres du chèque : utiliser `Numtostring.Convertir` de
  [`Utils/Numtostring`](../../Utils/Numtostring.module/architecture.md) (seul module compilé) au
  lieu de [`Caisse/numtostring`](../numtostring.module/architecture.md) (CAISSE-A01).
- Préférences d'impression : `Impression.Facture` lit des clés globales alors que
  [`Preferences`](../Preferences.class/architecture.md) de la caisse écrit `/Soc<XX>/caisse/…`
  ([IMPRESSION-A01/A02](../../Utils/Impression.module/rework.md)).
- Numéro de carte suivant (`Enrg_Clientd`) ↔ `FClientcarte.Button2_Click` : `ProchainCodeCarte()`
  (CAISSE-017) ; lecture de `Fiches_Carte` commune avec [`Tricartes`](../Affichages/Tricartes.class/architecture.md)
  et [`FClientcarte`](../FClientcarte.class/architecture.md).
- `Numerique`/`Alpha` ↔ [`Clavier`](../Clavier.class/architecture.md) : fonction pure `ToucheVirtuelle`
  (CLAVIER-005/006, CAISSE-018).
- Libellé d'avoir `Fiches_LibelAvoirs` (en dur l. 289) : socle « texte unique » (TLEG-003,
  [`LibelAvoirs`](../LibelAvoirs.class/architecture.md)).
- Connexion / changement de vendeur : [`Svendeur`](../Svendeur.class/architecture.md),
  [`Ouverture`](../Ouverture.class/architecture.md) et
  [`ConVendeurs`](../../Gestion/Facturation/ConVendeurs.class/architecture.md).
- Calcul des encours client (`Recup_Client`) : à rapprocher de `Facture.Verif_Encours` et de
  `Csolde` (solde comptable + BL non facturés).
- Mouvement de stock d'une ligne (`Maj_Quantite`, `Maj_QteDep`) : à rapprocher de
  `Facture.Maj_Quantite*` et de `Moulinage.Recup_Art` (liste des sources de mouvements de stock,
  STOCKMVT-A05).
- Archivage d'un PDF horodaté (`Dupli`, `DupliZ`) : même idiome que `LGed.Archive` ; un helper
  `Utils.ArchivePdf(source, répertoire, nom)` avec chemins entre guillemets.
- `Tottva` : même besoin de cumul par taux que `Moulinage` (table `Totalisation`) ; une
  `Collection` en mémoire suffirait (CAISSE-A17).

### Réduction de portée

- Fonctions non-handlers sans appelant externe (vérifié par `grep`) → `Private` : `PrintBA6X`,
  `SetObservers`, `InitTouche`, `Ent_tk`, `arrondi`, `Art_man`, `calc_total`, `Ouv_Tiroir`,
  `Aff_viseur`, `aff_Photo`, `Prix_promo`, `Valid_Qte`, `Valid_commentaire`, `Valid_HorsVte`,
  `Valid_Cart`, `Valid_Remise`, `RemqShow`, `Init_Art`, `Raz`, `AppArt`, `Recup_dec`, `Decimal`,
  `Remises_quantitatives`, `modif_Tk`, `TestPvttc`, `Calc_Tva`, `calc_HT`, `Calc_TTC`,
  `Valid_Remtot`, `Ticket_Attente`, `suppr_Tk`, les 11 `Valid_<mode>`, `pointsF`,
  `horsven_evkeypress`, `Mvt_HorsEnc`, `Maj_Acomptes`, `Entete_Tck`, `Serial_Tk`, `imp_ligtk`,
  `imp_ligtk2`, `Imp_Cheque`, `Defaut_Tk`, `Init_sport`, `Init_sport2`, `Recup_Poids`, `mdp_admin`,
  `Valid_Mdp`, `init_paiement`, `Calc_reste`, `TabTva`, `Aff_bastk`, `Enrg_Tk`, `Init_LigTk`,
  `Init_Columnview1`, `Init_Reg`, `Valid_Nticket`, `impressionbon`, `ChkNtk`, `Ent_tk2`,
  `Serial_Facture`, `Defaut_Facture`, `Ticketz`, `Defaut_Ticketxz`, `DupliZ`, `Dupli`,
  `SelectionArt`, `ChkPrx`, `ChkBs`, `Aff_Art`, `Ajout_Reg_Bl`, `Recup_Client`, `ClientsDivers`,
  `RecupClientd`, `Enrg_Clientd`, `CartesFidelite`, `RecupCarte`, `Maj_Quantite`, `Maj_QteDep`,
  `Tbremq_Create`, `Delete_Reglements_Tk`, `ColumnView1_Delete`, `Recalc_Tottk`, `Ligtk_Delete`,
  `RenameLigne`, `Numerique`, `Alpha`, `ClavFam`, `Fermer2`, `createPanel`, `Cbutton`, `Init2`,
  membre `Clicode`.
- À **garder `Public`** : tous les handlers (y compris `SPort2_Read`, `KeyObserver_Keypress`,
  `Obs*`, `mail_lostfocus`, `valid_click`, `annul_click`, `Clav3_Click`), les `<Grille>_Click`
  appelés par le rejeu (`ColTka_Click`, `Cavoirs_Click`, `Cacomptes_Click`), `Bsel`/`Bval`
  (écrits par `Object.SetProperty`), `$Vendeur`, `Ba4`, `origine` (accédés par le nom de classe
  depuis `Svendeur`, `Cfacture`, `Attrib`), `Codearticle` (lu par `Caisse.Codearticle`, A06).
- Règle PLAN §6 : réduction seulement si la fonction est couverte par un replay.

### Séparation traitement / GUI

Dans le même fichier, extraire en fonctions privées **sans accès aux contrôles**, appelées aux mêmes
endroits avec les mêmes valeurs (SQL inchangé) :

- `Enrg_Tk` : `EnregistreLigneTicket(…)`, `EnregistreEnteteTicket(…)` (36 paramètres regroupés),
  `ConsommeAvoir(sLind, sMontant) As Boolean`, `ConsommeAcompte(sLind, sMontant) As Boolean`,
  `MajTotauxCaisse(sCaisse, fTtc, fAcomptes)`, `ConvertitPoints(fPoints, fSeuil, fBonus, fGain)`
  (calcul pur de la boucle `Do`) ;
- stock : `MouvementStockArticle(sCode, fQte, bAvoir)` pour `Maj_Quantite` ;
- `Recup_Client` : `EncoursClient(sCode) As Float` (SQL) séparé de la question ;
- `Imp_Cheque` : `MontantEnLettres(sMontant) As String` (après CAISSE-A01) ;
- impression ESC/POS : `FormateLigneTicket(sLibelle, sMontant, sQte, iLargeur) As String`
  (`imp_ligtk`, `imp_ligtk2`) ;
- `Calc_Tva` : lecture SQL `LitTva(sCode) As String[]`, affectations de `Tva`/`TxTva` inchangées.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_EntTicketz` : une colonne par mode de règlement (`scheque`/`mcheque`, …) ; une table de
  règlements de ticket (`numero`, `mode`, `montant`, `document`) éviterait les 20 colonnes et
  donnerait une place aux acomptes utilisés (`RA`), aujourd'hui seulement en lignes.
- Montants (`montant`, `mht`, `mtva`, `mrem`) en texte formaté : à passer en `DECIMAL`.
  `mrem` sert tantôt de remise, tantôt de n° de BL ou d'`lind` : à séparer.
- `Tottva` : supprimer la table de travail (calcul en mémoire) ou la déclarer `TEMPORARY`.
- Lignes de règlement stockées comme lignes de ticket (`N`, `U`, `RA`…) et lignes de présentation
  (`L`, `BH`, `BA`, `BC`, `BB`) : à séparer des lignes de vente.
- `Fiches_Bl.numtick` utilisé comme verrou de réservation : une table de liaison
  ticket ↔ BL serait plus sûre (BL bloqués si la caisse plante entre sélection et validation).
- Numérotation des tickets (`cutk` par caisse + `dntk` global + chaînage SHA1) : une séquence
  dédiée transactionnelle.
