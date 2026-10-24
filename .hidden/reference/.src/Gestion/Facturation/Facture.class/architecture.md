# Facture — Architecture

> Source : `.src/Gestion/Facturation/Facture.class`

## Vue d'ensemble

`Facture` est l'**écran de gestion commerciale** de Laurux : saisie des documents de vente (commande
`C`, bon de livraison `B`, devis `D`, proforma `P`, facture `F`, facture d'abonnement `A`, fiche
atelier `T`), de leurs lignes (main d'œuvre `M`, article `A`, commentaire `C`, caractéristiques `R`,
composant de produit composé `O`, texte `T`, écotaxes `E`/`D`, taxe copie privée `P`), gestion du
stock associé, duplication, avoir et archivage. C'est le plus gros fichier legacy du projet
(12 479 lignes, 327 fonctions détectées + 4 non détectées, CC totale 3 098) : AGENTS.md règle 21
s'applique, seuls des reworks minimaux et ciblés sont proposés.

Points structurants :

- **Deux modes**, choisis par le constructeur `_New(bfacture)` : facturation standard
  (`Fmenu.Menu42_Click`, `ConVendeurs.Button1_Click`) sur `Fiches_Bl`/`Fiches_Ligbl`, et
  **facturation entretien** (`Fmenu.Menu193_Click`, `bTypeFacture = True`) sur
  `Fiches_BlM`/`Fiches_LigblM`/`Fiches_EntMat` (matériel réparé). La quasi-totalité des fonctions
  testent `bTypeFacture` pour choisir la table ; plusieurs l'oublient (voir « Tables en dur »).
- **Le document courant est un « BL »** (`Fiches_Bl.numbl`, numéroté par `Fiches_Parametres.dnbon`) ;
  le type (`Fiches_Bl.type`) change avec les boutons radio. La **facture définitive** (numéro,
  `Fiches_HistoFac`, écritures, PDF, GED) est produite hors de cette classe, par l'écran d'édition
  [`OptFac`](../OptFac.class/architecture.md) et l'objet de calcul
  [`ObjFacB`](../../option/ObjFacB.class/architecture.md) (`$fac`), via `Bl_Edit` et `Lig_Archives`.
- **La grille `Coldetail` est la source de vérité de la saisie** : chaque ligne contient, au-delà
  des 10 colonnes visibles, des colonnes cachées (type 9, temps/montant 10, TVA 12, famille 13,
  décimales 14, bloc 16, poids 17, marges 18/19, fournisseur 20, référence longue 21, tournée 22,
  consigne 23, TIPP 24, date 25), **toutes décalées de `i = 2`** avec l'option boisson (`$soption`
  `B`/`T`, colonnes palettes/colis). Chaque enregistrement de ligne relit tout le document
  (`Coldetail.Clear` + `Recup_ligbl`), et `Maj_Base` réécrit toutes les lignes depuis la grille.
- **Montants manipulés en chaînes** (`Text` des contrôles, `Utils.cpoint`, `Format$`) et stockés
  tels qu'affichés (virgule) dans `Fiches_Ligbl`. Les calculs (net, TTC, remises, marges, arrondi)
  lisent et écrivent directement les contrôles : peu de calcul pur isolable sans extraction.
- **Stock « réversible »** : à l'ouverture de la saisie des lignes, le stock de toutes les lignes
  article est réintégré (`Maj_Quantite2`) ; à la fermeture, il est re-sorti (`Maj_Quantite`).
- **Verrouillage** : document verrouillé par `DocActif.Get_Lock("Facturation", numbl)` ;
  numérotations sous `LOCK TABLES` (MySQL, neutralisé sous SQLite) ; **aucune transaction**.
- **État global** très large : ~150 variables d'instance (drapeaux texte `Modif`, `Nvart`, `B`,
  `ChkFocus`, totaux en `String`…), dont ~110 déclarées sans mot-clé (donc `Private`).

Nature globale : **GUI fortement couplée au SQL** (mixte). Les calculs ne sont séparables que par
extraction de formules (voir propositions).

### Tableau des groupes fonctionnels

Comptage à partir du bloc AUTO des fonctions (les 4 handlers `$textpal_*`/`$textcol_*`, non
détectés par le parseur, sont dans G20 mais hors comptage).

| Groupe | Lignes principales | Fonctions | LOC | CC totale | CC max | Nature |
|---|---|---|---|---|---|---|
| G01 Cycle de vie, préférences, boutons généraux | 259-1367, 5297-5336, 7664-7693 | 19 | 635 | 173 | 40 (`Btn_Click`) | GUI |
| G02 Entête : client, code postal, adresses de livraison | 726-1015, 1764-1875, 2569-2688, 10676-11178 | 26 | 802 | 213 | 52 (`Entete2_KeyPress`) | mixte |
| G03 Liste des documents et recherche | 1880-2262, 11387-12049 | 47 | 859 | 270 | 86 (`ColblSelection`) | mixte |
| G04 Numérotation, type de document, enregistrement de l'entête | 1514-1759, 3906-4177, 9571-9640, 9775-9872 | 17 | 554 | 170 | 36 (`Button4_Click`) | mixte |
| G05 Saisie des lignes : panneaux, grille, renumérotation | 1115-1274, 1372-1509, 8011-8861, 9071-9233 | 13 | 1025 | 393 | 166 (`Coldetail_KeyRelease`) | mixte |
| G06 Saisie de la main d'œuvre | 2806-3561, 4182-4400 | 34 | 812 | 224 | 41 (`mo_KeyPress`) | GUI |
| G07 Calculs MO (prix, TVA, marge, arrondi) | 3566-3901 | 10 | 260 | 82 | 14 (`Calc_moHt`) | calcul sur contrôles |
| G08 Saisie des articles | 4405-5292, 5342-5859, 6266-6754, 7093-7210 | 45 | 1779 | 584 | 96 (`Art_KeyPress`) | mixte |
| G09 Calculs article (prix, quantités, remises, TVA, arrondi, marge) | 1276-1326, 5194-5213, 5865-6264, 7499-7662, 9643-9669 | 18 | 513 | 173 | 27 (`Artnet_LF`) | calcul sur contrôles |
| G10 Taxes annexes et produits composés | 6758-6830, 7215-7454 | 5 | 289 | 59 | 22 (`Recup_Pdc`) | mixte |
| G11 Matériel et numéros de série | 6837-7086, 11183-11383 | 20 | 335 | 87 | 14 (`Enrg_Numserie`) | mixte |
| G12 Commentaires | 7712-8006 | 11 | 230 | 61 | 14 (`com_KeyPress`) | mixte |
| G13 Enregistrement des lignes (SQL) | 8868-9066 | 8 | 167 | 49 | 14 (`Enrg_LigArt`) | traitement (SQL) |
| G14 Totaux et TVA du document | 2267-2566, 12464-12469 | 4 | 268 | 65 | 49 (`Recup_ligbl`) | mixte |
| G15 Stock | 9238-9446 | 5 | 176 | 75 | 17 (`Maj_QteDep`) | traitement (SQL) |
| G16 Duplication, avoir, archivage, reprise de lignes | 8660-8841, 9686-10500, 12054-12151, 12269-12277 | 15 | 926 | 288 | 67 (`Recup_ligfac`) | mixte |
| G17 Suppression, impression, aperçu | 9451-9565, 9672-9679, 9813-9836 | 4 | 127 | 39 | 25 (`Bl_Suppr`) | mixte |
| G18 Règlement et acompte | 10601-10644, 11026-11057 | 5 | 57 | 19 | 7 (`Verif_acompte`) | GUI |
| G19 Tâches | 2695-2801 | 6 | 87 | 23 | 6 (`Coltaches_Columnclick`) | mixte |
| G20 Options P/T/B : tournées, TIPP, frais, boisson | 12176-12266, 12282-12479 | 13 (+4) | 170 | 26 | 4 | GUI |
| G21 Import portable | 10506-10595, 12153-12168 | 2 | 100 | 25 | 21 (`GenFacPort`) | mixte |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | Fcalc | 23 |
| `Factbl` | var | Private |  | New String[10] | 24 |
| `Motable` | var | Private |  | New String[4] | 25 |
| `CpTable` | var | Private |  | New String[5] | 26 |
| `n` | var | Private |  | Integer | 27 |
| `Nv` | var | Private |  | Integer | 28 |
| `Nbl` | var | Private |  | Integer | 29 |
| `Tp` | var | Private |  | String | 31 |
| `Numtk` | var | Private |  | String | 32 |
| `Tp2` | var | Private |  | String | 33 |
| `Tri` | var | Private |  | String | 34 |
| `Tribl` | var | Private |  | String | 35 |
| `Tribl2` | var | Private |  | String | 36 |
| `tab` | var | Private |  | String | 37 |
| `Tab1` | var | Private |  | String | 38 |
| `Tab2` | var | Private |  | String | 39 |
| `Tab3` | var | Private |  | String | 40 |
| `Tab4` | var | Private |  | String | 41 |
| `Tab5` | var | Private |  | String | 42 |
| `tabmo` | var | Private |  | String | 43 |
| `sel` | var | Private |  | String | 44 |
| `arr` | var | Private |  | String | 45 |
| `Atype` | var | Private |  | String | 46 |
| `typeL` | var | Private |  | String | 47 |
| `Cdivers` | var | Private |  | Boolean | 48 |
| `Nlgn` | var | Private |  | String | 49 |
| `Nbd` | var | Private |  | String | 50 |
| `Nbdec` | var | Private |  | String | 51 |
| `Totalmo` | var | Private |  | String | 52 |
| `Totalart` | var | Private |  | String | 53 |
| `Totalrem` | var | Private |  | String | 54 |
| `Totalmottc` | var | Private |  | String | 55 |
| `Totalartttc` | var | Private |  | String | 56 |
| `Totalremttc` | var | Private |  | String | 57 |
| `Totalht` | var | Private |  | String | 58 |
| `Totalttc` | var | Private |  | String | 59 |
| `Ttva` | var | Private |  | Float | 60 |
| `Tx` | var | Private |  | Float | 61 |
| `B` | var | Private |  | Integer | 62 |
| `ChkFocus` | var | Private |  | Integer | 63 |
| `Chkf` | var | Private |  | Integer | 64 |
| `Nvc` | var | Private |  | Integer | 65 |
| `ye2` | var | Private |  | Integer | 66 |
| `dte` | var | Private |  | String | 67 |
| `dte2` | var | Private |  | String | 68 |
| `dte3` | var | Private |  | String | 69 |
| `Nfac` | var | Private |  | String | 70 |
| `rResult` | var | Private |  | Result | 71 |
| `Rligbl` | var | Private |  | Result | 72 |
| `Filename` | var | Private |  | String | 73 |
| `Jour` | var | Private |  | String | 74 |
| `Jnl` | var | Private |  | String | 75 |
| `Intit` | var | Private |  | String | 76 |
| `numecr` | var | Private |  | String | 77 |
| `numr` | var | Private |  | Integer | 78 |
| `numr2` | var | Private |  | Integer | 79 |
| `numrd` | var | Private |  | Integer | 80 |
| `Cpt` | var | Private |  | String | 81 |
| `CptRem` | var | Private |  | String | 82 |
| `Ctva` | var | Private |  | String | 83 |
| `Ctx` | var | Private |  | String | 84 |
| `Cpttva` | var | Private |  | String | 85 |
| `IntitTva` | var | Private |  | String | 86 |
| `Txtleg` | var | Private |  | String | 87 |
| `Txtleg1` | var | Private |  | String | 88 |
| `Txtleg2` | var | Private |  | String | 89 |
| `Remmo` | var | Private |  | String | 90 |
| `Remart` | var | Private |  | String | 91 |
| `Stk` | var | Private |  | Boolean | 92 |
| `Ecotaxe` | var | Private |  | Boolean | 93 |
| `Valeur_ecotaxe` | var | Private |  | Float | 94 |
| `Ecotaxe2` | var | Private |  | Boolean | 95 |
| `Valeur_ecotaxe2` | var | Private |  | Float | 96 |
| `Taxepv` | var | Private |  | Boolean | 97 |
| `Valeur_Copp` | var | Private |  | Float | 98 |
| `Tva550` | var | Private |  | Integer | 99 |
| `Codetva` | var | Private |  | String | 100 |
| `Artdsg2` | var | Private |  | String | 101 |
| `dateech` | var | Private |  | String | 102 |
| `Impfac` | var | Private |  | Boolean | 103 |
| `qteecot` | var | Private |  | Float | 104 |
| `Bloc` | var | Private |  | String | 105 |
| `Ardi` | var | Private |  | String | 106 |
| `Paht` | var | Private |  | String | 107 |
| `Pmp` | var | Private |  | String | 108 |
| `Codeart` | var | Private |  | String | 109 |
| `Nvart` | var | Private |  | String | 110 |
| `Modif` | var | Private |  | String | 111 |
| `NlgModif` | var | Private |  | String | 112 |
| `qte_Cbarre` | var | Private |  | String | 113 |
| `Imp` | var | Private |  | String | 114 |
| `Editfac` | var | Private |  | String | 115 |
| `Nmfac` | var | Private |  | String | 116 |
| `Dfac` | var | Private |  | String | 117 |
| `CoulB` | var | Private |  | Integer | 118 |
| `CoulF` | var | Private |  | Integer | 119 |
| `Fnt` | var | Private |  | String | 120 |
| `ChangePu` | var | Private |  | String | 122 |
| `ChangeB` | var | Private |  | String | 123 |
| `ChangeP` | var | Private |  | String | 124 |
| `ChangeTx` | var | Private |  | String | 125 |
| `ChangeR` | var | Private |  | String | 126 |
| `ChangeT` | var | Private |  | String | 127 |
| `ChangeTm` | var | Private |  | String | 128 |
| `Numfac` | var | Private |  | String | 129 |
| `Dtefac` | var | Private |  | String | 130 |
| `Ech` | var | Private |  | String | 131 |
| `Val_retro` | var | Private |  | String | 132 |
| `Colvente` | var | Private |  | Float | 133 |
| `PVHT2` | var | Private |  | Float | 134 |
| `Prg` | var | Private |  | String | 135 |
| `Typec` | var | Private |  | String | 136 |
| `RemType` | var | Private |  | String | 137 |
| `Dbl` | var | Private |  | String | 138 |
| `Tabcli` | var | Private |  | String | 139 |
| `Rms` | var | Private |  | New String[6, 3] | 140 |
| `Mrgmo` | var | Private |  | Float | 141 |
| `Mrgart` | var | Private |  | Float | 142 |
| `PosY` | var | Private |  | Integer | 143 |
| `Visudoc` | var | Private |  | Boolean | 144 |
| `Devises` | var | Private |  | String | 145 |
| `Coulfond` | var | Private |  | New String[] | 146 |
| `Rs2` | var | Private |  | String | 147 |
| `Artbarre` | var | Private |  | String | 148 |
| `$Desc` | var | Private |  | Boolean | 149 |
| `pdx` | var | Private |  | String | 150 |
| `Gmateriel` | var | Private |  | Boolean | 151 |
| `Materiel` | var | Private |  | Boolean | 152 |
| `Tmat` | var | Private |  | String | 153 |
| `rmat` | var | Private |  | Result | 154 |
| `Produit` | var | Private |  | String | 155 |
| `Blocnum` | var | Private |  | String | 156 |
| `Numligbl2` | var | Private |  | String | 157 |
| `Mnetht` | var | Private |  | String | 158 |
| `Mnettc` | var | Private |  | String | 159 |
| `Lbarre` | var | Private |  | Integer | 160 |
| `Majnumserie` | var | Private |  | Integer | 161 |
| `l5` | var | Private |  | String | 162 |
| `Nlgapp` | var | Private |  | String | 163 |
| `Impcar` | var | Private |  | Boolean | 164 |
| `Promo` | var | Private |  | Boolean | 165 |
| `Cpromo` | var | Private |  | String | 166 |
| `Apromo` | var | Private |  | Boolean | 167 |
| `bNet` | var | Private |  | Boolean | 168 |
| `Pdc` | var | Private |  | Boolean | 169 |
| `Avr` | var | Private |  | Boolean | 170 |
| `Commentaire` | var | Private |  | String | 171 |
| `PrvtMo` | var | Private |  | Float | 172 |
| `TxhtMo` | var | Private |  | Float | 173 |
| `ComboTest` | var | Private |  | Boolean | 174 |
| `CptVente` | var | Private |  | Boolean | 175 |
| `spiece` | var | Private |  | String | 176 |
| `spvcons` | var | Private |  | String | 177 |
| `sreg` | var | Private |  | String | 178 |
| `ImpAuto` | var | Private |  | Boolean | 179 |
| `Impdclient` | var | Private |  | Boolean | 180 |
| `Franchise` | var | Private |  | Boolean | 181 |
| `Prxdec` | var | Private |  | Boolean | 182 |
| `sDsg` | var | Private |  | String | 183 |
| `sArt` | var | Private |  | String | 184 |
| `Codearticle` | var | Public |  | String | 185 |
| `CodeClient` | var | Public |  | String | 186 |
| `numeroFac` | var | Public |  | String | 187 |
| `Bsel` | var | Public |  | Boolean | 188 |
| `Bval` | var | Public |  | String | 189 |
| `bRemise` | var | Public |  | Boolean | 190 |
| `sel2` | var | Private |  | String | 191 |
| `hColbl` | var | Private |  | Boolean | 192 |
| `Proform` | var | Private |  | String | 193 |
| `Commande` | var | Private |  | String | 194 |
| `Devis` | var | Private |  | String | 195 |
| `Devis2` | var | Private |  | String | 196 |
| `Bon` | var | Private |  | String | 197 |
| `Facture` | var | Private |  | String | 198 |
| `pdf` | var | Private |  | Object | 199 |
| `pdf2` | var | Private |  | Cdocuments2 | 200 |
| `Tcli` | var | Private |  | Boolean | 201 |
| `Tcoeff` | var | Private |  | Float | 202 |
| `ComboCom` | var | Private |  | Boolean | 203 |
| `TvaCli` | var | Private |  | String | 204 |
| `Equ` | var | Private |  | Boolean | 205 |
| `encours` | var | Private |  | String | 206 |
| `bencours` | var | Private |  | Boolean | 207 |
| `bTypeFacture` | var | Private |  | Boolean | 208 |
| `soldecompte` | var | Private |  | Float | 209 |
| `Pays` | var | Private |  | String | 210 |
| `Codepostal` | var | Public |  | String | 211 |
| `Bureaudistributeur` | var | Public |  | String | 212 |
| `Dtab` | var | Private |  | String | 213 |
| `Aban` | var | Private |  | String | 214 |
| `Coefdep` | var | Private |  | Float | 216 |
| `XX` | var | Private |  | String | 217 |
| `Colis` | var | Private |  | String | 218 |
| `PO` | var | Private |  | String | 219 |
| `PJ` | var | Private |  | String | 220 |
| `$UV` | var | Private |  | String | 221 |
| `$crst` | var | Private |  | String | 222 |
| `$Four` | var | Private |  | String | 223 |
| `$Fam` | var | Private |  | String | 224 |
| `typedoc` | var | Private |  | String | 225 |
| `date2doc` | var | Private |  | Date | 226 |
| `date1doc` | var | Private |  | Date | 227 |
| `dt` | var | Private |  | String[] | 228 |
| `$numbl` | var | Private |  | String | 229 |
| `Nmuser` | var | Private |  | String | 230 |
| `Ecran` | var | Private |  | String | 231 |
| `$photo` | var | Private |  | String | 232 |
| `Refliee` | var | Private |  | String | 233 |
| `QteRefliee` | var | Private |  | String | 234 |
| `$Matlist` | var | Private |  | ColumnView | 235 |
| `bnumfac` | var | Private |  | Boolean | 236 |
| `basc` | var | Private |  | Boolean | 237 |
| `bacquitte` | var | Private |  | Boolean | 238 |
| `$lcom` | var | Private |  | Listecom | 239 |
| `$lcart` | var | Private |  | Listecom | 240 |
| `hTxtb` | var | Private |  | Textbox | 241 |
| `hpanel` | var | Private |  | Panel | 242 |
| `$soption` | var | Private |  | String | 243 |
| `$opt` | var | Private |  | Facopt | 244 |
| `$textpal` | var | Private |  | TextBox | 246 |
| `$textcol` | var | Private |  | TextBox | 247 |
| `$checcons` | var | Private |  | CheckBox | 248 |
| `$inbcol` | var | Private |  | Integer | 249 |
| `$inbbout` | var | Private |  | Integer | 250 |
| `$tarif` | var | Private |  | TarArt | 251 |
| `$process` | var | Private |  | Boolean | 252 |
| `$fac` | var | Private |  | ObjFacB | 253 |
| `$vdate` | var | Private |  | VerifDate | 254 |
<!-- /AUTO:declarations -->

⚠️ Le tableau ci-dessus ne liste que les déclarations à partir de la ligne 140 : les ~110 variables
des lignes 23-139 sont déclarées **sans mot-clé** (`hForm As Fcalc`, `Tp As String`…), donc
`Private`, et ne sont pas reconnues par le parseur. Principales :

| Variable(s) | Type | Rôle |
|---|---|---|
| `Tp`, `Atype`, `Tp2` | String | type du document courant, type précédent (transitions de stock), type du document d'origine (reprise de lignes) |
| `typeL` | String | type de la ligne en saisie (`M`, `A`, `C`, `E`, `D`, `P`…) |
| `Modif`, `NlgModif`, `Nlgapp`, `N`, `Nvart`, `Codeart` | String/Integer | drapeaux « ligne en modification », numéro de ligne modifiée, ajout (`N = 1`) |
| `B`, `ChkFocus`, `Chkf` | Integer | drapeau d'erreur de saisie (`B = 1`) ; gestion des pertes de focus (0 normal, 1 après modification, 2 bloqué) |
| `Nv`, `Nvc` | Integer | nouveau document, nouveau client |
| `Impfac`, `Numtk` | Boolean/String | facture imprimée ; ticket de caisse qui a réglé le BL (bloque toute modification) |
| `Totalmo`, `Totalart`, `Totalrem`, `Totalht`, `Totalttc`, `Totalmottc`, `Totalartttc`, `Totalremttc` | String | cumuls du document, calculés par chaîne |
| `Ttva`, `Tx` | Float | taux de TVA de la ligne courante et `1 + taux/100`, partagés entre fonctions |
| `Change*` (`ChangePu`, `ChangeB`, `ChangeP`, `ChangeTx`, `ChangeR`, `ChangeT`, `ChangeTm`) | String | valeurs à l'entrée dans un champ, pour détecter une modification |
| `Bloc`, `Blocnum`, `l5` | String | identifiant de bloc de lignes (`n° ligne & code & Rnd(1000, 9999)`) |
| `Stk`, `Materiel`, `Pdc`, `Apromo`, `Promo`, `Cpromo`, `bNet` | Boolean/String | article stocké, matériel, produit composé, promotion, mention « Net » |
| `Ecotaxe`, `Valeur_ecotaxe`, `Ecotaxe2`, `Valeur_ecotaxe2`, `Taxepv`, `Valeur_Copp`, `qteecot` | Boolean/Float | taxes annexes de l'article courant |
| `Paht`, `Pmp`, `Arr`, `Nbd`, `Nbdec`, `Colvente`, `PVHT2`, `Pdx` | String/Float | prix d'achat, PMP, arrondi, décimales, colisage, poids |
| `Rms[6, 3]` | String | tranches de remises quantitatives de l'article (`qte1..12`, `rem1..6`) |
| `Rligbl`, `rResult` | Result | résultat courant des lignes (utilisé par `CalculTotal`) ; résultat « fourre-tout » réutilisé partout |
| `tab`, `Tab1`…`Tab5`, `tabmo`, `Tmat` | String | noms de tables (souvent en dur) |
| `Factbl`, `Motable`, `CpTable` | String[] | noms de colonnes des grilles virtuelles (`Colbl`, `Colmo`, `ColTaches`) |
| `Avr` | Boolean | `True` : avoir ; `False` : duplication en devis |

Membres `Public` : `Bsel`/`Bval` (retour de sélection écrit par `TriCpt` et `TriArticles` via
`Object.SetProperty` : **à garder `Public`**), `numeroFac` (usage interne seulement),
`Codearticle`, `CodeClient`, `bRemise`, `Codepostal`, `Bureaudistributeur` (**jamais
référencés** : les sélecteurs passent par `Variables.*`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 259-504 | Public | 39 | 235 | 0 | méthode spéciale |
| `Form_Open` | 506-559 | Public | 11 | 51 | 0 | handler GUI |
| `lcoldetail` | 561-618 | Public | 27 | 55 | 0 | portée réductible ? |
| `CleanChamps` | 620-701 | Public | 3 | 80 | 0 | portée réductible ? |
| `Tabstrip1_Click` | 703-710 | Public | 2 | 7 | 0 | handler GUI |
| `ChkPrx` | 713-721 | Public | 7 | 7 | 0 | portée réductible ? |
| `Entete2_KeyPress` | 726-919 | Public | 52 | 162 | 0 | handler GUI |
| `Entete2_GotFocus` | 924-934 | Public | 3 | 9 | 0 | handler GUI |
| `Entete2_LostFocus` | 936-970 | Public | 8 | 31 | 0 | handler GUI |
| `Verif_Encours` | 972-989 | Public | 4 | 16 | 0 | portée réductible ? |
| `Raz_client` | 991-1015 | Public | 1 | 23 | 0 | portée réductible ? |
| `Btn_Click` | 1021-1094 | Public | 40 | 55 | 0 | handler GUI |
| `Btn_Keypress` | 1096-1113 | Public | 8 | 14 | 0 | handler GUI |
| `Lignes_Bon` | 1115-1205 | Public | 25 | 86 | 0 | portée réductible ? |
| `Button15_Click` | 1207-1274 | Public | 28 | 63 | 0 | portée réductible ? |
| `sTTC_Click` | 1276-1296 | Public | 6 | 19 | 0 | handler GUI |
| `sFacht_Click` | 1298-1308 | Public | 2 | 9 | 0 | handler GUI |
| `Tvar_Click` | 1310-1326 | Public | 3 | 15 | 0 | handler GUI |
| `Form_Close` | 1328-1367 | Public | 16 | 36 | 0 | handler GUI |
| `Motm_Click` | 1372-1408 | Public | 7 | 34 | 0 | handler GUI |
| `BArt_Click` | 1413-1452 | Public | 7 | 38 | 0 | handler GUI |
| `B2Art_Click` | 1457-1461 | Public | 1 | 3 | 0 | handler GUI |
| `com_Click` | 1466-1509 | Public | 8 | 41 | 0 | handler GUI |
| `Button2_Click` | 1514-1625 | Public | 28 | 103 | 0 | portée réductible ? |
| `Button4_Click` | 1630-1751 | Public | 36 | 114 | 0 | portée réductible ? |
| `modifblopt` | 1753-1759 | Private | 3 | 5 | 0 |  |
| `button6_Click` | 1764-1787 | Public | 6 | 21 | 0 | handler GUI |
| `button8_Click` | 1792-1814 | Public | 6 | 21 | 0 | handler GUI |
| `button1_Click` | 1819-1875 | Public | 11 | 54 | 0 | handler GUI |
| `Colbl_KeyPress` | 1880-1893 | Public | 6 | 11 | 0 | handler GUI |
| `RdimColbl` | 1895-1906 | Public | 2 | 10 | 0 | portée réductible ? |
| `Colbl_MouseUp` | 1911-1919 | Public | 2 | 7 | 0 | handler GUI |
| `Colbl_Deselect` | 1921-1932 | Public | 1 | 10 | 0 | handler GUI |
| `ColblSelection` | 1934-2262 | Public | 86 | 310 | 0 | portée réductible ? |
| `Recup_ligbl` | 2267-2496 | Public | 49 | 227 | 0 | portée réductible ? |
| `CalculTotal` | 2501-2531 | Public | 13 | 28 | 0 | portée réductible ? |
| `calculfindoc` | 2533-2566 | Public | 2 | 9 | 0 | portée réductible ? |
| `Cpman` | 2569-2597 | Public | 5 | 26 | 0 | portée réductible ? |
| `aff_cp` | 2599-2626 | Public | 4 | 24 | 0 | portée réductible ? |
| `Colcp_Click` | 2628-2637 | Public | 1 | 8 | 0 | handler GUI |
| `Colcp_KeyPress` | 2642-2663 | Public | 6 | 18 | 0 | handler GUI |
| `ChkCp` | 2665-2673 | Public | 7 | 7 | 0 | portée réductible ? |
| `ToggleButton8_Click` | 2675-2688 | Public | 2 | 11 | 0 | handler GUI |
| `LibelTache_KeyPress` | 2695-2699 | Public | 4 | 3 | 0 | handler GUI |
| `button33_Click` | 2701-2721 | Public | 4 | 18 | 0 | handler GUI |
| `ColTaches_KeyPress` | 2723-2734 | Public | 3 | 10 | 0 | handler GUI |
| `Coltaches_Data` | 2736-2748 | Public | 3 | 11 | 0 | handler GUI |
| `RecupTaches` | 2750-2777 | Public | 3 | 25 | 0 | portée réductible ? |
| `Coltaches_Columnclick` | 2779-2801 | Public | 6 | 20 | 0 | handler GUI |
| `SelectionMo` | 2806-2830 | Public | 4 | 23 | 0 | portée réductible ? |
| `TriMo` | 2832-2841 | Public | 1 | 8 | 0 | portée réductible ? |
| `colmo_Data` | 2843-2853 | Public | 1 | 9 | 0 | handler GUI |
| `Deb7` | 2855-2860 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb8` | 2862-2867 | Public | 1 | 4 | 0 | portée réductible ? |
| `Ref` | 2869-2874 | Public | 1 | 4 | 0 | portée réductible ? |
| `Dbclkmo` | 2876-2886 | Public | 2 | 9 | 0 | portée réductible ? |
| `Colmo_Close` | 2888-2895 | Public | 1 | 6 | 0 | handler GUI |
| `Co2_Click` | 2897-2906 | Public | 1 | 8 | 0 | handler GUI |
| `Co2_Dblclick` | 2908-2916 | Public | 1 | 7 | 0 | handler GUI |
| `CO2_GotFocus` | 2918-2924 | Public | 2 | 5 | 0 | handler GUI |
| `CO2_LostFocus` | 2926-2930 | Public | 2 | 3 | 0 | handler GUI |
| `CO2_KeyPress` | 2932-2950 | Public | 5 | 17 | 0 | handler GUI |
| `FO2_Click` | 2952-2961 | Public | 1 | 8 | 0 | handler GUI |
| `FO2_Dblclick` | 2963-2971 | Public | 1 | 7 | 0 | handler GUI |
| `FO2_GotFocus` | 2973-2979 | Public | 2 | 5 | 0 | handler GUI |
| `FO2_LostFocus` | 2981-2985 | Public | 2 | 3 | 0 | handler GUI |
| `FO2_KeyPress` | 2987-3005 | Public | 5 | 17 | 0 | handler GUI |
| `ChkInput3` | 3007-3016 | Public | 2 | 8 | 0 | portée réductible ? |
| `Colmo_Click` | 3021-3035 | Public | 1 | 12 | 0 | handler GUI |
| `Colmo_KeyPress` | 3040-3061 | Public | 6 | 18 | 0 | handler GUI |
| `mo_man` | 3066-3140 | Public | 22 | 73 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 3145-3150 | Public | 1 | 4 | 0 | handler GUI |
| `mo_KeyPress` | 3155-3338 | Public | 41 | 157 | 0 | handler GUI |
| `Tmo_KeyPress` | 3340-3344 | Public | 3 | 3 | 0 | handler GUI |
| `Tmo_LostFocus` | 3346-3352 | Public | 1 | 5 | 0 | handler GUI |
| `mo_Lostfocus` | 3354-3482 | Public | 38 | 117 | 0 | handler GUI |
| `mo_GotFocus` | 3487-3517 | Public | 9 | 29 | 0 | handler GUI |
| `Chg` | 3519-3530 | Public | 1 | 10 | 0 | portée réductible ? |
| `Razmo` | 3532-3561 | Public | 2 | 28 | 0 | portée réductible ? |
| `Calc_Net` | 3566-3579 | Public | 6 | 11 | 0 | portée réductible ? |
| `Calc_Txhr` | 3584-3605 | Public | 6 | 20 | 0 | portée réductible ? |
| `Calc_Brut` | 3610-3648 | Public | 10 | 29 | 0 | portée réductible ? |
| `Calc_Tmont` | 3653-3676 | Public | 6 | 21 | 0 | portée réductible ? |
| `Calc_Puht` | 3681-3725 | Public | 13 | 43 | 0 | portée réductible ? |
| `Calc_Rem` | 3730-3751 | Public | 6 | 19 | 0 | portée réductible ? |
| `arrondimo` | 3756-3792 | Public | 10 | 32 | 0 | portée réductible ? |
| `Calc_TC` | 3797-3814 | Public | 4 | 16 | 0 | portée réductible ? |
| `Calc_moHt` | 3819-3862 | Public | 14 | 42 | 0 | portée réductible ? |
| `Calc_MargeMo` | 3864-3901 | Public | 7 | 27 | 0 | portée réductible ? |
| `Bcomde_Click` | 3906-3926 | Public | 6 | 18 | 0 | handler GUI |
| `Bbon_Click` | 3928-3958 | Public | 14 | 27 | 0 | handler GUI |
| `Bdevis_Click` | 3960-3980 | Public | 6 | 18 | 0 | handler GUI |
| `Bprof_Click` | 3982-4002 | Public | 6 | 18 | 0 | handler GUI |
| `Bfac_Click` | 4004-4033 | Public | 13 | 27 | 0 | handler GUI |
| `BfacA_Click` | 4035-4089 | Public | 13 | 51 | 0 | handler GUI |
| `Bmajdte` | 4091-4109 | Private | 4 | 15 | 0 |  |
| `Wrg` | 4111-4124 | Public | 3 | 12 | 0 | portée réductible ? |
| `Maj_typeBL` | 4129-4177 | Public | 12 | 45 | 0 | portée réductible ? |
| `Button10_Keypress` | 4182-4220 | Public | 12 | 37 | 0 | handler GUI |
| `Button10_Click` | 4226-4248 | Public | 6 | 21 | 0 | handler GUI |
| `MajColdetailMo` | 4250-4343 | Public | 32 | 90 | 0 | portée réductible ? |
| `MajColdetailMo2` | 4345-4400 | Public | 13 | 53 | 0 | portée réductible ? |
| `SelectionArt` | 4405-4443 | Public | 8 | 36 | 0 | portée réductible ? |
| `Art_Rpl` | 4445-4511 | Public | 19 | 64 | 0 | portée réductible ? |
| `Art_Equ` | 4513-4545 | Public | 4 | 30 | 0 | portée réductible ? |
| `Art_Equ2` | 4547-4647 | Public | 32 | 96 | 0 | portée réductible ? |
| `Tarifclient` | 4649-4729 | Public | 22 | 66 | 0 | portée réductible ? |
| `hcol_click` | 4731-4742 | Public | 4 | 10 | 0 | handler GUI |
| `hcol_Keypress` | 4744-4756 | Public | 5 | 10 | 0 | handler GUI |
| `Art_man` | 4761-4865 | Public | 38 | 101 | 0 | portée réductible ? |
| `Maj_zonesArt` | 4867-5107 | Public | 86 | 231 | 0 | portée réductible ? |
| `trf_selec` | 5109-5116 | Public | 2 | 6 | 0 | handler GUI |
| `Art_DblClick` | 5118-5125 | Public | 4 | 6 | 0 | handler GUI |
| `Depg_Click` | 5127-5143 | Public | 3 | 15 | 0 | handler GUI |
| `Arttx_KeyPress` | 5145-5149 | Public | 3 | 3 | 0 | handler GUI |
| `arttx_LostFocus` | 5151-5157 | Public | 1 | 5 | 0 | handler GUI |
| `Quantite` | 5162-5189 | Public | 8 | 26 | 0 | portée réductible ? |
| `Calc_Marge` | 5194-5213 | Public | 8 | 17 | 0 | portée réductible ? |
| `Art_Mouseup` | 5219-5240 | Public | 4 | 19 | 0 | handler GUI |
| `Art_Change` | 5242-5246 | Public | 1 | 3 | 0 | handler GUI |
| `ComArt` | 5248-5279 | Public | 12 | 24 | 0 | portée réductible ? |
| `aff_photo` | 5281-5292 | Public | 4 | 9 | 0 | portée réductible ? |
| `RefLongue` | 5297-5314 | Public | 2 | 15 | 0 | portée réductible ? |
| `Txtb_GotFocus` | 5316-5320 | Public | 2 | 3 | 0 | handler GUI |
| `Txtb_LostFocus` | 5322-5326 | Public | 2 | 3 | 0 | handler GUI |
| `Txtb_Keypress` | 5328-5336 | Public | 4 | 7 | 0 | handler GUI |
| `Art_KeyPress` | 5342-5690 | Public | 96 | 299 | 0 | handler GUI |
| `Achat_KeyPress` | 5692-5705 | Public | 5 | 12 | 0 | handler GUI |
| `Achat_Lostfocus` | 5707-5728 | Public | 5 | 19 | 0 | handler GUI |
| `Art_Lostfocus` | 5733-5859 | Public | 34 | 111 | 0 | handler GUI |
| `Artpu_LF` | 5865-5901 | Public | 7 | 34 | 0 | portée réductible ? |
| `Artqte_LF` | 5903-5958 | Public | 22 | 46 | 0 | portée réductible ? |
| `Remises_quantitatives` | 5963-5987 | Public | 8 | 18 | 0 | portée réductible ? |
| `Cart_LF` | 5989-5995 | Public | 2 | 5 | 0 | portée réductible ? |
| `Artbrut_LF` | 5997-6048 | Public | 12 | 36 | 0 | portée réductible ? |
| `Artrm_LF` | 6050-6114 | Public | 20 | 60 | 0 | portée réductible ? |
| `Artnet_GF` | 6116-6139 | Public | 6 | 22 | 0 | portée réductible ? |
| `Artnet_LF` | 6141-6241 | Public | 27 | 78 | 0 | portée réductible ? |
| `Arttc_LF` | 6243-6264 | Public | 7 | 20 | 0 | portée réductible ? |
| `Art_GotFocus` | 6266-6322 | Public | 21 | 47 | 0 | handler GUI |
| `ChgArt` | 6324-6334 | Public | 1 | 9 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 6336-6341 | Public | 1 | 4 | 0 | handler GUI |
| `ArtFour_KeyPress` | 6343-6350 | Public | 3 | 6 | 0 | handler GUI |
| `fourman` | 6355-6368 | Public | 3 | 11 | 0 | portée réductible ? |
| `ToggleButton6_MouseUp` | 6370-6394 | Public | 7 | 22 | 0 | handler GUI |
| `SelectionFour` | 6396-6409 | Public | 2 | 11 | 0 | portée réductible ? |
| `Frm12` | 6412-6440 | Public | 8 | 26 | 0 | portée réductible ? |
| `Button11_Keypress` | 6445-6497 | Public | 14 | 49 | 0 | handler GUI |
| `Button11_Click` | 6502-6541 | Public | 14 | 37 | 0 | handler GUI |
| `MajColdetailArt` | 6543-6594 | Public | 10 | 49 | 0 | portée réductible ? |
| `Enrg_Art` | 6596-6734 | Public | 59 | 135 | 0 | portée réductible ? |
| `init` | 6736-6754 | Public | 2 | 17 | 0 | portée réductible ? |
| `Recup_Pdc` | 6758-6830 | Public | 22 | 70 | 0 | portée réductible ? |
| `Rcpt_GotFocus` | 6837-6841 | Public | 2 | 3 | 0 | handler GUI |
| `Rcpt_LostFocus` | 6843-6847 | Public | 1 | 2 | 0 | handler GUI |
| `Num_serie` | 6852-6858 | Public | 1 | 5 | 0 | portée réductible ? |
| `Rcpt_KeyPress` | 6863-6879 | Public | 6 | 12 | 0 | handler GUI |
| `ToggleButton9_Click` | 6885-6914 | Public | 4 | 28 | 0 | handler GUI |
| `NumsList_Click` | 6919-6927 | Public | 1 | 7 | 0 | handler GUI |
| `NumsList_KeyPress` | 6932-6951 | Public | 6 | 16 | 0 | handler GUI |
| `Button22_KeyPress` | 6956-6960 | Public | 3 | 3 | 0 | handler GUI |
| `Button22_Click` | 6965-6996 | Public | 8 | 30 | 0 | handler GUI |
| `Enrgnum` | 7001-7015 | Public | 3 | 12 | 0 | portée réductible ? |
| `Enrg_Numserie` | 7018-7070 | Public | 14 | 50 | 0 | portée réductible ? |
| `Button23_Click` | 7075-7086 | Public | 3 | 10 | 0 | handler GUI |
| `SelectionFam` | 7093-7146 | Public | 9 | 52 | 0 | portée réductible ? |
| `fam_man` | 7151-7172 | Public | 5 | 19 | 0 | portée réductible ? |
| `Colfam_Click` | 7177-7185 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam_KeyPress` | 7190-7210 | Public | 6 | 17 | 0 | handler GUI |
| `Ecot` | 7215-7285 | Public | 12 | 68 | 0 | portée réductible ? |
| `Ecot2` | 7290-7360 | Public | 12 | 68 | 0 | portée réductible ? |
| `Txpp` | 7365-7422 | Public | 10 | 55 | 0 | portée réductible ? |
| `MajColdetailEco` | 7424-7454 | Public | 3 | 28 | 0 | portée réductible ? |
| `Cleanart` | 7456-7494 | Public | 9 | 35 | 0 | portée réductible ? |
| `Decimal` | 7499-7517 | Public | 5 | 17 | 0 | portée réductible ? |
| `Dec_KeyPress` | 7522-7529 | Public | 4 | 6 | 0 | handler GUI |
| `Dec_Click` | 7531-7536 | Public | 1 | 4 | 0 | handler GUI |
| `CalcHt` | 7541-7579 | Public | 14 | 37 | 0 | portée réductible ? |
| `CalcTTC` | 7584-7598 | Public | 4 | 13 | 0 | portée réductible ? |
| `Recup_Tva` | 7603-7616 | Public | 4 | 12 | 0 | portée réductible ? |
| `arrondi` | 7621-7662 | Public | 12 | 36 | 0 | portée réductible ? |
| `Tbremq_Create` | 7664-7693 | Public | 2 | 27 | 0 | portée réductible ? |
| `Tbrem_Click` | 7695-7707 | Public | 2 | 10 | 0 | handler GUI |
| `SelectionCom` | 7712-7769 | Public | 13 | 53 | 0 | portée réductible ? |
| `Colcom_Click` | 7774-7784 | Public | 1 | 9 | 0 | handler GUI |
| `Colcom_KeyPress` | 7789-7809 | Public | 6 | 17 | 0 | handler GUI |
| `com_KeyPress` | 7814-7870 | Public | 14 | 45 | 0 | handler GUI |
| `com_GotFocus` | 7875-7880 | Public | 2 | 4 | 0 | handler GUI |
| `Com_LostFocus` | 7882-7886 | Public | 2 | 3 | 0 | handler GUI |
| `ToggleButton4_Click` | 7888-7892 | Public | 1 | 3 | 0 | handler GUI |
| `Button12_keypress` | 7894-7898 | Public | 1 | 3 | 0 | handler GUI |
| `Button12_Click` | 7900-7950 | Public | 10 | 47 | 0 | handler GUI |
| `Button24_Click` | 7952-7982 | Public | 6 | 28 | 0 | handler GUI |
| `com_man` | 7987-8006 | Public | 5 | 18 | 0 | portée réductible ? |
| `Coldetail_Activate` | 8011-8268 | Public | 58 | 242 | 0 | handler GUI |
| `Coldetail_MouseUp` | 8270-8287 | Public | 9 | 12 | 0 | handler GUI |
| `Coldetail_KeyRelease` | 8292-8655 | Public | 166 | 345 | 0 | handler GUI |
| `DupliDoc` | 8660-8841 | Public | 59 | 169 | 0 | portée réductible ? |
| `Rprodcomposes` | 8843-8861 | Public | 7 | 16 | 0 | portée réductible ? |
| `Enrg_LigMo` | 8868-8896 | Public | 9 | 27 | 0 | portée réductible ? |
| `Enrg_Ligcar2` | 8899-8917 | Public | 3 | 17 | 0 | portée réductible ? |
| `Enrg_LigArt` | 8920-8956 | Public | 14 | 33 | 0 | portée réductible ? |
| `Enrg_Promo` | 8959-8977 | Public | 3 | 17 | 0 | portée réductible ? |
| `Enrg_LigArt2` | 8980-8998 | Public | 3 | 17 | 0 | portée réductible ? |
| `Enrg_Ligcar` | 9001-9019 | Public | 3 | 17 | 0 | portée réductible ? |
| `Enrg_Ligcom` | 9022-9047 | Public | 11 | 24 | 0 | portée réductible ? |
| `Enrg_Pdc` | 9050-9066 | Public | 3 | 15 | 0 | portée réductible ? |
| `Ren_ligbl` | 9071-9121 | Public | 16 | 48 | 0 | portée réductible ? |
| `Maj_Base` | 9126-9189 | Public | 23 | 60 | 0 | portée réductible ? |
| `Maj_libelle` | 9194-9233 | Public | 38 | 37 | 0 | portée réductible ? |
| `Maj_Quantite` | 9238-9277 | Public | 15 | 36 | 0 | portée réductible ? |
| `Maj_QuantiteD` | 9282-9312 | Public | 11 | 28 | 0 | portée réductible ? |
| `Maj_Quantite2` | 9317-9356 | Public | 15 | 36 | 0 | portée réductible ? |
| `Maj_QteDep` | 9361-9401 | Public | 17 | 38 | 0 | portée réductible ? |
| `Maj_QteDep2` | 9406-9446 | Public | 17 | 38 | 0 | portée réductible ? |
| `Bl_Suppr` | 9451-9531 | Public | 25 | 75 | 0 | portée réductible ? |
| `Bl_Edit` | 9536-9565 | Public | 8 | 25 | 0 | portée réductible ? |
| `QuitteDate` | 9571-9607 | Public | 11 | 34 | 0 | portée réductible ? |
| `dateEcheance` | 9610-9640 | Public | 4 | 28 | 0 | portée réductible ? |
| `Rembasfac_LostFocus` | 9643-9669 | Public | 6 | 24 | 0 | handler GUI |
| `AffDoc` | 9672-9679 | Public | 1 | 5 | 0 | portée réductible ? |
| `Colbl_Activate` | 9686-9770 | Public | 17 | 81 | 0 | handler GUI |
| `Tot_Remises` | 9775-9796 | Public | 7 | 19 | 0 | portée réductible ? |
| `Lig_Archives` | 9801-9808 | Public | 1 | 6 | 0 | portée réductible ? |
| `Bl_Sup` | 9813-9836 | Public | 5 | 22 | 0 | portée réductible ? |
| `Ecritures` | 9841-9858 | Public | 3 | 15 | 0 | portée réductible ? |
| `Majnum` | 9863-9872 | Public | 1 | 5 | 0 | portée réductible ? |
| `ToggleButton5_Click` | 9877-9886 | Public | 6 | 8 | 0 | handler GUI |
| `Button17_Click` | 9888-9893 | Public | 1 | 4 | 0 | handler GUI |
| `EntFac` | 9895-9983 | Public | 24 | 86 | 0 | portée réductible ? |
| `Recup_ligfac` | 9988-10225 | Public | 67 | 233 | 0 | portée réductible ? |
| `Button20_Click` | 10230-10359 | Public | 42 | 126 | 0 | handler GUI |
| `Majligbl` | 10364-10407 | Public | 27 | 40 | 0 | portée réductible ? |
| `Importlig` | 10412-10500 | Public | 24 | 81 | 0 | portée réductible ? |
| `GenFacPort` | 10506-10595 | Public | 21 | 86 | 0 | portée réductible ? |
| `Button18_Click` | 10601-10609 | Public | 1 | 7 | 0 | handler GUI |
| `Verif_acompte` | 10614-10634 | Public | 7 | 19 | 0 | portée réductible ? |
| `Button19_Click` | 10639-10644 | Public | 2 | 4 | 0 | handler GUI |
| `OBS_KeyPress` | 10646-10649 | Public | 1 | 2 | 0 | handler GUI |
| `SetObservers` | 10658-10670 | Public | 4 | 10 | 0 | portée réductible ? |
| `ToggleButton1_MouseDown` | 10676-10694 | Public | 6 | 17 | 0 | handler GUI |
| `Cli_man` | 10699-10833 | Public | 38 | 130 | 0 | portée réductible ? |
| `Recup_EncoursBl` | 10836-10852 | Public | 3 | 12 | 0 | portée réductible ? |
| `Recup_Mail` | 10857-10880 | Public | 7 | 19 | 0 | portée réductible ? |
| `Recup_type` | 10885-10907 | Public | 8 | 20 | 0 | portée réductible ? |
| `ChiffreA` | 10909-10934 | Public | 5 | 23 | 0 | portée réductible ? |
| `SelectionClient` | 10939-10955 | Public | 2 | 14 | 0 | portée réductible ? |
| `ToggleButton7_MouseDown` | 10960-11024 | Public | 8 | 62 | 0 | handler GUI |
| `Rgmt_Click` | 11026-11037 | Public | 2 | 10 | 0 | handler GUI |
| `Regmt_Change` | 11039-11057 | Public | 7 | 17 | 0 | handler GUI |
| `Button7_Click` | 11062-11066 | Public | 1 | 3 | 0 | portée réductible ? |
| `ToggleButton10_Click` | 11069-11092 | Public | 2 | 23 | 0 | handler GUI |
| `Aff_AdrC` | 11094-11130 | Public | 7 | 36 | 0 | portée réductible ? |
| `Colal_Click` | 11132-11150 | Public | 2 | 16 | 0 | handler GUI |
| `Colal_Keypress` | 11152-11167 | Public | 9 | 15 | 0 | handler GUI |
| `CleanChampsAdr` | 11170-11178 | Public | 1 | 7 | 0 | portée réductible ? |
| `ToggleButton11_Click` | 11183-11249 | Public | 10 | 63 | 0 | handler GUI |
| `Matlist_Click` | 11254-11261 | Public | 2 | 6 | 0 | handler GUI |
| `Matlist_KeyPress` | 11266-11285 | Public | 6 | 16 | 0 | handler GUI |
| `matman` | 11290-11324 | Public | 3 | 32 | 0 | portée réductible ? |
| `CleanChampsMat` | 11326-11337 | Public | 1 | 10 | 0 | portée réductible ? |
| `Mat_keypress` | 11339-11367 | Public | 9 | 21 | 0 | handler GUI |
| `Mat_lostfocus` | 11369-11377 | Public | 2 | 6 | 0 | handler GUI |
| `Mat_GotFocus` | 11379-11383 | Public | 2 | 3 | 0 | handler GUI |
| `Colbl_Data` | 11387-11487 | Public | 48 | 98 | 0 | handler GUI |
| `Deb1` | 11489-11519 | Public | 12 | 28 | 0 | portée réductible ? |
| `Deb2` | 11521-11543 | Public | 6 | 20 | 0 | portée réductible ? |
| `Colbl_com` | 11545-11574 | Public | 10 | 27 | 0 | portée réductible ? |
| `Colbl_art` | 11576-11599 | Public | 6 | 21 | 0 | portée réductible ? |
| `Colbl_libel` | 11601-11624 | Public | 6 | 21 | 0 | portée réductible ? |
| `Colbl_refl` | 11626-11649 | Public | 6 | 21 | 0 | portée réductible ? |
| `creblcom` | 11651-11667 | Private | 2 | 15 | 0 |  |
| `ChkInput2` | 11669-11720 | Public | 15 | 32 | 0 | portée réductible ? |
| `Dbclkcli` | 11722-11732 | Public | 2 | 9 | 0 | portée réductible ? |
| `Titre` | 11734-11745 | Public | 2 | 10 | 0 | portée réductible ? |
| `TYB_Click` | 11747-11758 | Public | 1 | 10 | 0 | handler GUI |
| `TYB_Dblclick` | 11760-11765 | Public | 1 | 4 | 0 | handler GUI |
| `TYB_GotFocus` | 11767-11773 | Public | 2 | 5 | 0 | handler GUI |
| `TYB_LostFocus` | 11775-11779 | Public | 2 | 3 | 0 | handler GUI |
| `TYB_KeyPress` | 11781-11789 | Public | 2 | 7 | 0 | handler GUI |
| `NUMB_Click` | 11791-11802 | Public | 1 | 10 | 0 | handler GUI |
| `NUMB_Dblclick` | 11804-11809 | Public | 1 | 4 | 0 | handler GUI |
| `NUMB_GotFocus` | 11811-11817 | Public | 2 | 5 | 0 | handler GUI |
| `NUMB_LostFocus` | 11819-11823 | Public | 2 | 3 | 0 | handler GUI |
| `NUMB_KeyPress` | 11825-11833 | Public | 2 | 7 | 0 | handler GUI |
| `DAB_MouseDown` | 11835-11846 | Public | 1 | 10 | 0 | handler GUI |
| `DAB_Dblclick` | 11848-11854 | Public | 1 | 5 | 0 | handler GUI |
| `DAB_GotFocus` | 11856-11862 | Public | 2 | 5 | 0 | handler GUI |
| `DAB_LostFocus` | 11864-11868 | Public | 2 | 3 | 0 | handler GUI |
| `DAB_KeyPress` | 11870-11878 | Public | 2 | 7 | 0 | handler GUI |
| `COB_MouseDown` | 11880-11891 | Public | 1 | 10 | 0 | handler GUI |
| `COB_Dblclick` | 11893-11899 | Public | 1 | 5 | 0 | handler GUI |
| `COB_GotFocus` | 11901-11907 | Public | 2 | 5 | 0 | handler GUI |
| `COB_LostFocus` | 11909-11913 | Public | 2 | 3 | 0 | handler GUI |
| `COB_KeyPress` | 11915-11923 | Public | 2 | 7 | 0 | handler GUI |
| `NOB_Click` | 11925-11961 | Public | 9 | 35 | 0 | handler GUI |
| `NOB_MouseUp` | 11963-11973 | Public | 1 | 9 | 0 | handler GUI |
| `NOB_Dblclick` | 11975-11980 | Public | 2 | 4 | 0 | handler GUI |
| `NOB_GotFocus` | 11982-11988 | Public | 2 | 3 | 0 | handler GUI |
| `NOB_LostFocus` | 11990-11994 | Public | 2 | 3 | 0 | handler GUI |
| `NOB_KeyPress` | 11996-12005 | Public | 2 | 8 | 0 | handler GUI |
| `NUMF_Click` | 12007-12018 | Public | 1 | 10 | 0 | handler GUI |
| `NUMF_Dblclick` | 12020-12025 | Public | 1 | 4 | 0 | handler GUI |
| `NUMF_GotFocus` | 12027-12033 | Public | 2 | 5 | 0 | handler GUI |
| `NUMF_LostFocus` | 12035-12039 | Public | 2 | 3 | 0 | handler GUI |
| `NUMF_KeyPress` | 12041-12049 | Public | 2 | 7 | 0 | handler GUI |
| `Creation` | 12054-12118 | Public | 11 | 62 | 0 | portée réductible ? |
| `Button25_Click` | 12120-12131 | Public | 2 | 10 | 0 | handler GUI |
| `Button26_Click` | 12133-12144 | Public | 2 | 10 | 0 | handler GUI |
| `Button29_Click` | 12146-12151 | Public | 1 | 4 | 0 | handler GUI |
| `Button27_Click` | 12153-12168 | Public | 4 | 14 | 0 | handler GUI |
| `Edit2_MouseDown` | 12171-12173 | Public | 1 | 2 | 0 | handler GUI |
| `Textto1_LostFocus` | 12176-12191 | Public | 3 | 13 | 0 | handler GUI |
| `Butto1_Click` | 12193-12200 | Public | 1 | 5 | 0 | handler GUI |
| `to1_trouve` | 12202-12206 | Public | 1 | 3 | 0 | handler GUI |
| `Texttr1_LostFocus` | 12209-12224 | Public | 3 | 13 | 0 | handler GUI |
| `Buttr1_Click` | 12226-12233 | Public | 1 | 5 | 0 | handler GUI |
| `tr1_trouve` | 12235-12239 | Public | 1 | 3 | 0 | handler GUI |
| `Textfrais_LostFocus` | 12242-12258 | Public | 3 | 15 | 0 | handler GUI |
| `textfrais_KeyPress` | 12260-12266 | Public | 4 | 5 | 0 | handler GUI |
| `recdate` | 12269-12277 | Private | 4 | 6 | 0 |  |
| `modifpanel5` | 12282-12360 | Private | 1 | 72 | 0 |  |
| `foccons` | 12363-12378 | Private | 3 | 14 | 0 |  |
| `$textpal_LostFocus` | 12380-12400 | Public | 5 | 18 | 0 | handler GUI |
| `$textcol_LostFocus` | 12402-12420 | Public | 5 | 16 | 0 | handler GUI |
| `$textpal_KeyPress` | 12422-12430 | Public | 4 | 6 | 0 | handler GUI |
| `$textcol_KeyPress` | 12432-12440 | Public | 4 | 6 | 0 | handler GUI |
| `ersdec` | 12442-12448 | Private | 1 | 5 | 0 |  |
| `defpxpp` | 12450-12462 | Private | 2 | 10 | 0 |  |
| `option_recalcul` | 12464-12469 | Public | 1 | 4 | 0 | handler GUI |
| `Ignore_Remise_Click` | 12471-12479 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

⚠️ Non détectées par le parseur (nom commençant par `$`) : `$textpal_LostFocus` (l. 12380),
`$textcol_LostFocus` (l. 12402), `$textpal_KeyPress` (l. 12422), `$textcol_KeyPress` (l. 12432).

## Description des fonctions

Sauf mention contraire : portée **réductible** pour les fonctions qui ne sont pas des handlers (aucun
appelant externe ; vérifié par `grep`), **nécessaire** pour les handlers d'événements (nom
`Objet_Evenement`, à garder `Public`, PLAN §0) ; nature **mixte** (SQL + contrôles).

### G01 — Cycle de vie, préférences, boutons généraux

- **`_New(bfacture)`** [portée : nécessaire] [nature : GUI] (CC 39). Configure les recherches
  `TextReg` (`code` sur `Fiches_Cli`, `cart` sur `Fiches_Art`, tables **en dur**) ; mode entretien
  (`$soption = "N"`, titre, boutons « Estimation / Bon réparation / Fiche atelier ») ; `RefLongue` ;
  lit `Fiches_Parametres` (`coretro`, `devise`) et une vingtaine de préférences `/Soc<XX>/`
  (`Materiel`, `Tva550`, `Codetva`, `Depannage`, `Fht`, `AutoEnt`, `Faca`, `Franchise`, `Prxdec` →
  format `ar$`, `AffMarge`, `Taches` → `Fiches_Users`, `Poids`, `Depots` → `TabDepots` hors codes
  `01…`, `Factdef`/`Bldef`/`Devisdef`/`Prodef`, `Taxe`) ; `Utils.Observers(Me)` (journal/rejeu) ;
  colonnes de `Colbl` et `Coldetail` (`Columns.count` affecté 4 fois : 17, 23 ou 21, puis 20) ;
  option boisson → `modifpanel5` et `$vdate = New VerifDate(Now)` ; trois `Observer As "Entete2"`
  sur `Textto1`/`Texttr1`/`Textfrais` ; catégories client (`Fiches_Typec`). `date2doc = date1doc - n`
  est calculé alors que `n` vaut encore 0 (voir `Colbl_Data`) ; `Frmt` calculé et inutilisé.
- **`Form_Open()`** [nécessaire] [GUI] : promotion en cours (`TabPromo`, `datedeb <= aujourd'hui <=
  datefin`) → `Promo`/`Cpromo` ; `Tbremq_Create`, `Titre`, `Deb1`/`Deb2` ; panneau par défaut
  (`/MoArt` → `Motm_Click`, `/ComArt` → `com_Click`, sinon `BArt_Click`) ; vendeur connecté
  (`/CodeVendeur`) ; `/Afour`.
- **`lcoldetail()`** [GUI] (CC 27) : largeurs de `Coldetail` depuis `/Soc<XX>/Col/LcolF`
  (`col<n>:<largeur>;`), décalées de `i` ; `col10` a une valeur par défaut mais n'est pas relue.
  Même idiome que `Saisecrit` (`LcolS`), `Tresor`, `Extrait`, `Archives`.
- **`CleanChamps()`** [GUI] : remise à blanc de l'entête et des totaux (doublons `Totalart`,
  `Txmo`, `Txpieces` ; `Totalremttc` oublié). **`Raz_client()`** [GUI] : idem pour le client,
  avec `"0.00"` (point) au lieu de `"0,00"`.
- **`Tabstrip1_Click()`** [nécessaire] [GUI] : désactive `Button3` sur l'onglet Tâches.
- **`Form_Close()`** [nécessaire] [mixte] (CC 16) : processus en cours (`$process`) → confirmation ;
  si la saisie des lignes est ouverte : contrôle de marge (`/Marge`), sortie de stock
  (`Maj_Quantite`/`Maj_QteDep`), `Razmo`, `Cleanart`, `Button4_Click`, `Tot_Remises` ; libère le
  verrou `DocActif`. Même séquence que `Button15_Click`.
- **`Btn_Click()`** [nécessaire] [GUI] (CC 40) : aiguillage du groupe `Btn` par `Tag` : 1 aide,
  3 Nouveau (`Button2_Click`), 4 suppression (`Bl_Suppr`), 5 enregistrer (`Button4_Click`),
  6 quitter (supprime les PDF temporaires, enregistre `/Col/LcolF`, `Save`, `Me.Close`), 7 saisie
  des lignes (`Lignes_Bon`, refus sans matériel en mode entretien), 8 fin de saisie
  (`Button15_Click`), 9 impression (`Bl_Edit`), 12 `Button12_Click` ; `Case 2/10/11` vides ;
  variable `i` inutilisée. **`Btn_Keypress()`** [nécessaire] : Entrée → `Lignes_Bon` ; F6 →
  `ChiffreA`.
- **`Button7_Click()`** [nécessaire] [GUI] : aide `Doc.Open("Factures")` (F1 dans tous les panneaux).
- **`Edit2_MouseDown()`** [nécessaire] : handler vide.
- **`RefLongue()`** [GUI] : crée la zone « référence longue » `hTxtb` (`TextBox As "Txtb"`) ;
  ⚠️ lit `Settings["/Soc<XX>/Refl"]` et non `Start.LocalSettings` (fichier de configuration
  différent si `-c`, à confirmer). **`Txtb_GotFocus`/`Txtb_LostFocus`/`Txtb_Keypress`**
  [nécessaire] : journal de rejeu, Entrée → quantité.
- **`Tbremq_Create()`** [GUI] : grille `Tbrem` des remises quantitatives (même affectation répétée
  6 fois dans la boucle).
- **`ChkPrx()`** : **code mort** (filtre numérique jamais appelé).
- **`OBS_KeyPress()`** [nécessaire] : handler **vide** du contrôle `obs` (et de l'observateur
  `OBS` créé par `SetObservers`, mort). **`SetObservers(hClass, hCont)`** : **code mort**
  (récursion seule ; `hClass` inutilisé).

### G02 — Entête : client, code postal, adresses de livraison

- **`Entete2_KeyPress()`** [nécessaire] [GUI] (CC 52) : groupe `Entete2` (16 contrôles + 3
  observés). Entrée/Tab enchaîne date (`QuitteDate`) → code client (`Cli_man`, couleur si solde > 0)
  → nom (obligatoire) → adresse → code postal (`Cpman`) → téléphones → remises. F1 aide ;
  F2 : liste des documents (`RdimColbl`), clients (`SelectionClient`), codes postaux
  (`ToggleButton8_Click`) ; F3 `Bl_Edit` ; F4 `FClient.ShowModal` ; F5 `ConVendeurs.ShowModal`
  (changement de vendeur, voir FACTURE-A24) ; F6 `ChiffreA` (`/Affaire`) ; Ctrl+A `AffDoc`.
- **`Entete2_GotFocus`/`Entete2_LostFocus`** [nécessaire] [GUI] : `Utils.ObsGotf`/`ObsLstf`
  (rejeu), couleur d'alerte du solde ; perte de focus de la date → `QuitteDate`.
- **`Verif_Encours()`** [mixte] : encours dépassé → question, `Raz_client`. ⚠️ `encours > "0"`
  compare des chaînes.
- **`Cli_man()`** [mixte] (CC 38) : charge le client (`TabCli` joint à `TabTarcli` → `Tcli`), refuse
  un client inconnu ou inactif (`cli_actif` vrai = **inactif**, comme dans `FClient`), remplit
  l'entête (adresse, tournée, frais de gestion `cli_gestion`, regroupement, catégorie
  `Fiches_Typec`, TIPP, consigne, remises `cli_rmo`/`cli_rart`, encours, abonnement
  `cli_datab`/`cli_aban`, échéance `dateEcheance`, exonération forcée si auto-entrepreneur ou
  franchise), solde (`Fiches_Comptes` **en dur**), `Verif_Encours` ; puis `Recup_Mail`,
  **`Button4_Click`** (l'entête est enregistrée dès la sélection du client), `Recup_type`,
  `$fac.numcli`, `ChiffreA`. Duplique ~40 lignes de `ColblSelection`.
- **`Recup_Mail()`** [mixte] : liste `Courriel` ← `TabMailCli` + `TabContact` ; la liste n'est pas
  vidée (ligne commentée). **`Recup_type()`** [mixte] : `Tcli`/`Tcoeff` selon `TabTcli` (type
  client) puis `TabTarcli` (tarif client). **`Recup_EncoursBl()`** : **code mort**, SQL invalide
  (`like = &1`, colonne `typel_ligbl` absente de `Fiches_Bl`).
- **`ChiffreA()`** [mixte] : CA TTC du client (`Fiches_HistoFac`, + `Fiches_HistoFacM` en `UNION`
  si matériel) affiché « CA sur 12 mois » ⚠️ alors que la période commence 4 ans en arrière.
- **`SelectionClient()`** [GUI] : `TriCpt(Client, Avec_Solde, Me)` → `Bsel`/`Bval` → `Cli_Man`.
  **`ToggleButton1_MouseDown()`** [nécessaire] : clic gauche → `SelectionClient` ; clic droit →
  historique `Listecom`. **`ToggleButton7_MouseDown()`** [nécessaire] [mixte] : extrait du compte
  client (`Listextcpt(code).resext` → `Coldetail2`) ou total des BL en cours ; ⚠️ rappelle
  `Utils.Observers(Me)` et `Me.Center` à chaque clic et teste `Me.mouse = Mouse.Left` (forme du
  curseur comparée au bouton gauche).
- **`button6_Click`/`button8_Click`** [nécessaire] [mixte] : affichent/enregistrent les observations
  (`UPDATE Fiches_Cli SET cli_obs`) ; deux fonctions identiques.
- **`button1_Click()`** [nécessaire] [mixte] : **nouveau client** : `LOCK TABLES Fiches_Parametres`,
  numéro = `dnc` + 1 avec passages 411999 → 4111000 et 4119999 → 41110000 (même logique que
  `Impclient.Compteur` et `ImpSage.Compteur`) ; ⚠️ si `dnc` est invalide, `UNLOCK` n'est pas
  exécuté. La création effective (`Fiches_Cli`, compte `TabComptes` rattaché au collectif) est faite
  par `Button4_Click` (`Nvc = 1`).
- **Code postal** : **`Cpman()`** [mixte] (`TabCpostaux` `like '<cp>%'` **concaténé** ; plusieurs
  résultats → `Tricp("Facture", cp)`, retour par `Variables.Bsel/codepostal/Bureaudistributeur`) ;
  **`ToggleButton8_Click()`** [nécessaire] (`Tricp` sans filtre) ; **`aff_cp()`** et **`ChkCp()`** :
  **code mort** ; **`Colcp_Click`/`Colcp_KeyPress`** [nécessaire, `Colcp_Click` appelé par le rejeu] :
  la grille `Colcp` n'est remplie que par `aff_cp` (mort) : handlers inatteignables.
- **Adresses de livraison** : **`ToggleButton10_Click()`** [nécessaire], **`Aff_AdrC(Org)`**
  (`TabAdrC` du client, toutes avec `F2`), **`Colal_Click()`** [nécessaire, rejeu],
  **`Colal_Keypress()`** [nécessaire], **`CleanChampsAdr()`** [GUI].

### G03 — Liste des documents et recherche

- **`Colbl_KeyPress`** [nécessaire] (Entrée → `ColblSelection(False)`, F1, Échap/F2 → `RdimColbl`),
  **`RdimColbl()`** [GUI] (agrandit/réduit la liste), **`Colbl_MouseUp`** [nécessaire] (clic droit →
  `ColblSelection(True)` puis `Colbl_Activate`), **`Colbl_Deselect()`** [GUI].
- **`ColblSelection(bright)`** [mixte] (CC 86) : libère le verrou précédent (`DocActif.Free_Lock`,
  branche jamais prise, DOCACTIF-A01), prend celui du document (`Get_Lock`), tâches (`RecupTaches`),
  `Variables.bRemise = False`, lit `Fiches_Bl`/`BlM` par `numbl` puis `numfac`, remplit l'entête,
  tournée/TIPP (`Fiches_Ligbl LIMIT 1`, en dur même en mode entretien), frais (`Utils.totobs`),
  marges, remises ; **détache puis rattache** (`Object.Detach`/`Attach`, l. 2074-2092) les six boutons
  de type pour les positionner sans lever leurs `Click` ; client (`TabCli`, regroupement,
  `Fiches_Typec`, encours, échéance, `Recup_Mail`) ; matériel (`Fiches_EntMat`, `Fiches_Materiels`) ;
  solde ; si `b = 0` : `Recup_type`, `Recup_ligbl`, `option_recalcul`, panneau par défaut,
  `Maj_libelle`, `Verif_Encours`. Crée `$fac = New ObjFacB(num, ObjFac.bl)`.
- **`Colbl_Data(Row, Column)`** [nécessaire] [GUI] (CC 48) : grille virtuelle sur `Utils.rs3` ;
  couleurs par type et statut (`Utils.FColr`, bloc répété 9 fois) ; devis « périmé » coloré
  `Devis2` si sa date est antérieure à `date2doc` (= aujourd'hui, voir `_New`).
- **`Deb1()`/`Deb2()`** [mixte] : `Utils.Base3(Colbl, "select … where <TriBl> like \"%<sel>%\" …
  order by <tribl2> desc|asc")` ; filtre **concaténé** entre guillemets doubles (`"` et `&` bloqués
  par `ChkInput2`).
- **`Colbl_com`, `Colbl_art`, `Colbl_libel`, `Colbl_refl`** [mixte] : recherche dans les lignes
  (commentaire, code, libellé, référence longue) → table temporaire `Blcom` (**`creblcom`**,
  `CREATE TEMPORARY TABLE`, hors `Cbase`) → `Utils.Base3` → `DROP`. Quatre copies ; ⚠️ les trois
  dernières insèrent le nom du client dans `pnmclibl`. Ignorent le mode entretien.
- **`ChkInput2()`** [GUI] (CC 15) : Entrée → recherche dans les lignes ; sinon saisie incrémentale
  (`Utils.Obstch`) ; date → `LDate.DateFilterDB`. **`Dbclkcli()`** (sens du tri),
  **`Titre()`** (libellés des en-têtes).
- **En-têtes de tri** [nécessaire] [GUI] : `TYB_Click`, `TYB_Dblclick`, `TYB_GotFocus`,
  `TYB_LostFocus`, `TYB_KeyPress` (type) ; `NUMB_Click`, `NUMB_Dblclick`, `NUMB_GotFocus`,
  `NUMB_LostFocus`, `NUMB_KeyPress` (n° BL) ; `DAB_MouseDown`, `DAB_Dblclick`, `DAB_GotFocus`,
  `DAB_LostFocus`, `DAB_KeyPress` (date) ; `COB_MouseDown`, `COB_Dblclick`, `COB_GotFocus`,
  `COB_LostFocus`, `COB_KeyPress` (code client) ; `NOB_Click`, `NOB_MouseUp`, `NOB_Dblclick`,
  `NOB_GotFocus`, `NOB_LostFocus`, `NOB_KeyPress` (nom, ou recherche commentaire/code/libellé/
  référence) ; `NUMF_Click`, `NUMF_Dblclick`, `NUMF_GotFocus`, `NUMF_LostFocus`, `NUMF_KeyPress`
  (n° facture). Chaque `GotFocus` journalise (`ObsGotf`) puis relance le tri ; chaque `KeyPress`
  appelle `ChkInput2`.

### G04 — Numérotation, type de document, enregistrement de l'entête

- **`Button2_Click()`** [nécessaire] [mixte] (CC 28) « Nouveau » : contrôle de réplication
  (`/dbase/Con-ssh` + `/Replique` + `/Breplique` → `Utils.ControlTunnel`, même bloc que dans
  `Fmenu`) ; `LOCK TABLES` (paramètres, BL, lignes, client) ; numéro = `dnbon` + 1 sur 6 chiffres ;
  refus si déjà utilisé ; `UPDATE Fiches_Parametres SET dnbon` ; `button4_click` (crée l'entête) ;
  `Deb1` ; `DocActif.Get_Lock` ; `UNLOCK` ; `$fac = New ObjFacB($numbl, ObjFac.bl)` (⚠️ `$numbl`
  n'est pas mis à jour si le numéro était déjà pris) ; type par défaut ; exonération forcée.
- **`Button4_Click()`** [nécessaire] [mixte] (CC 36) « Enregistrer l'entête » : `Tp` d'après les
  boutons ; tournée/TIPP sur les lignes article ; `UPDATE` ou `INSERT` de `Fiches_Bl` (30 colonnes)
  ou `Fiches_BlM` (+ `Fiches_EntMat`) ; client existant : mise à jour si `Majc` (partielle pour un
  client divers) + `TabMailCli` ; nouveau client (`Nvc = 1`) : collectif = premier compte `coll = '1'`
  de mêmes 2 premiers chiffres, `INSERT TabComptes` et `Fiches_Cli` ; `Enrgcp.Ecp` (code postal) ;
  ligne de `Colbl` et repositionnement (boucle sans borne). ⚠️ l. 1674 : paramètres décalés dans
  l'`UPDATE Fiches_BlM` qui suit l'`INSERT` (FACTURE-A04) ; `mreg` lu dans `Regmt` (BlM) mais
  `Mrgt` (Bl).
- **`modifblopt()`** (Private) : **code mort**.
- **Type de document** [nécessaire] [mixte] : **`Bcomde_Click`** (C), **`Bbon_Click`** (B),
  **`Bdevis_Click`** (D), **`Bprof_Click`** (P), **`Bfac_Click`** (F), **`BfacA_Click`** (A, ou T en
  mode entretien). Si le document n'est ni imprimé ni réglé par ticket (`Numtk == Null`) : vers
  C/D/P depuis B/F → réintégration du stock (`Maj_Quantite2`/`Maj_QteDep2`) ; vers B/F/A depuis
  D/P/C → `Bmajdte` + sortie de stock ; avertissement « numéros de série » ; `Maj_typeBL`. Sinon
  `Wrg(Numtk)`. Cinq copies du même schéma. `BfacA_Click` exige un client abonné
  (`Dtab`/`Aban`, sinon proposition de compléter la fiche) et ⚠️ appelle **`Wrg()` sans argument**
  l. 4055 (`deps.py` : `arity_errors`).
- **`Bmajdte(Optional dtef)`** (Private) [traitement] : `UPDATE … SET dte_ligbl` (date du jour) ;
  variable locale `tab` et paramètre `dtef` masquent un membre et un contrôle.
- **`Wrg(numtick)`** [GUI] : message (« facture imprimée » si pas de ticket, sinon « en attente de
  moulinage ») et retour forcé sur `Bfac` ou `Bbon`.
- **`Maj_typeBL()`** [mixte] (CC 12) : `UPDATE … SET type` ; pour une facture : solde des
  règlements de trésorerie (`TabMvt`, `tresorerie = 1`, compte client, `numdoc = numfac`) →
  `acquitte`/`mtreg` (comparaison `LPrix(…).G == LPrix(…).G`) ; rechargement (`Deb1`/`Deb2`,
  repositionnement, `ColblSelection`, `Maj_libelle`).
- **`QuitteDate()`** [mixte] : normalise la date du document (`Utils.CDate_calc`/`Cdate_aff`) et
  avertit si elle précède le début de période (`dtepc`) ; ⚠️ borne construite avec `Left$(dte, 2)`
  (jour si `dd.mm.yyyy`, à confirmer) ; `ye2` (fin d'exercice suivant) calculé mais inutilisé.
- **`dateEcheance(Ech) As String`** [mixte] : `Fiches_Echeances` (en dur) → `Utils.Calcech` ou
  date de facture ; copie de `Saisecrit.dateEcheance`.
- **`Tot_Remises()`** [mixte] : cumul des remises MO et articles (brut − net) de `Fiches_Ligbl`
  (en dur) dans `Remmo`/`Remart`, enregistrés par `Button4_Click`.
- **`Ecritures(numecr)`**, **`Majnum()`** : **code mort** (copies de la séquence « numéro
  d'écriture » de `Saisecrit`, `Cielimp`, `Moulinage`, `ValidBR`, `Tresor`, `TresorFac`).

### G05 — Saisie des lignes : panneaux, grille, renumérotation

- **`Lignes_Bon()`** [mixte] (CC 25) : contrôles (numéro, date, client, nom) ; ouvre `Panel5` ;
  ⚠️ **réintègre le stock** de tout le document (`Maj_Quantite2`/`Maj_QteDep2`) si B ou F ;
  `Button4_Click` ; ligne « Vous avez été servi par … » si vendeur et document vide ; panneau par
  défaut.
- **`Button15_Click()`** [nécessaire] [mixte] (CC 28) « fin de saisie » : contrôle de marge ;
  option boisson (`$opt.affdroit/affcons/affdecons`, `calculfindoc`) ; **sortie de stock**
  (`Maj_Quantite`/`Maj_QteDep`) ; `Razmo`, `Cleanart`, `Tot_Remises`, `Button4_Click` ;
  repositionnement ; `Catch` → `Message.Error`.
- **`Motm_Click`, `BArt_Click`, `B2Art_Click`, `com_Click`** [nécessaire] [GUI] : bascule vers le
  panneau MO, article (`B2Art_Click` = `BArt_Click`), commentaire ; numéro de ligne suivant (même
  bloc dans 6 fonctions) ; repositionnement sur `Nlgapp`.
- **`Coldetail_Activate()`** [nécessaire] [mixte] (CC 58) : rappelle la ligne dans son panneau
  (MO : `Fiches_Mo` en dur pour l'arrondi, `Calc_Net`/`Calc_Tc`/`Calc_MargeMo` ; article : relit
  `TabArt` avec une jointure ⚠️ `on art_code = fo_cdech` (fausse, sans effet), décimales, arrondi,
  taxes annexes, promotion `ArtPromo.art_Promo` ; ⚠️ **matériel** : libère en base le numéro de
  série de la ligne suivante (`mat_vendu = 0`, rapprochement sur `mat_serie` seul, alors que
  `ObjFacB` rapproche `code_ligbl` de `mat_code`, FACTURE-A33) puis `Maj_Base`, dès le simple rappel ; commentaire :
  reconstitue le texte du bloc). Refus si imprimé ou réglé par ticket.
- **`Coldetail_MouseUp()`** [nécessaire] [GUI] : clic droit → référence longue ou ouverture de la
  pièce jointe (`/Bexpcheminpj`, `Visualiseur.Prog`).
- **`Coldetail_KeyRelease()`** [nécessaire] [mixte] (**CC 166, maximum du fichier**) : `*` → code
  barre ; **Suppr** → suppression du bloc de lignes (`DELETE` par bloc ou par numéro, libération du
  matériel, `$opt.suplig`), puis `Recup_Ligbl`, `Ren_Ligbl`, `Maj_Base`, `Recup_Ligbl` (deux
  fois) ; Entrée → `Coldetail_Activate` ; **`-`/`+`** → monte/descend le bloc (calcul de décalage
  `np`/`nbl`/`nbla`, `Maj_Base`, rechargement ; refus si produits composés ; ⚠️ pour `+`,
  `$opt.deplig` est appelé avant ce refus) ; **Espace** → marque la ligne pour la duplication
  (`*` dans la colonne cachée 10+i) ; Ctrl+D → `DupliDoc`. Boucles `While` sans borne (sortie
  par `Catch`).
- **`Rprodcomposes(Prod) As Boolean`** [GUI] : vrai si une ligne `O` existe (paramètre écrasé ;
  déplace le curseur de la grille).
- **`Ren_ligbl()`** [GUI] : renumérote la grille (même numéro pour un bloc de commentaires) ;
  ⚠️ teste la variable `TypeL` au lieu du type de la ligne.
- **`Maj_Base()`** [traitement] (CC 23) : **`DELETE` de toutes les lignes du document** puis
  ré-`INSERT` depuis la grille (21 colonnes ; taux de TVA relu par ligne), sans transaction.
- **`Maj_libelle()`** [mixte] (CC 38) : si `/Casier` et non imprimé, préfixe le libellé des articles
  par l'emplacement (`<casier>~ `), `Rupt~ ` (stock insuffisant) ou `Dep~ ` (non stocké) et l'écrit
  en base (une requête `TabArt` + un `UPDATE` par ligne).

### G06 — Saisie de la main d'œuvre (panneau `Panel2`, groupe `Mo`)

- **Liste des MO** [GUI] : `SelectionMo`, `TriMo`, `colmo_Data` [nécessaire] (`Utils.rs4`),
  `Deb7`/`Deb8` (`Utils.Base4`, `like "%sel%"` concaténé, `Fiches_Mo` en dur), `Dbclkmo`,
  `Colmo_Close`, `Co2_Click`, `Co2_Dblclick`, `CO2_GotFocus`, `CO2_LostFocus`, `CO2_KeyPress`,
  `FO2_Click` (⚠️ littéraux adjacents `"Code Mo" ""`), `FO2_Dblclick`, `FO2_GotFocus`,
  `FO2_LostFocus`, `FO2_KeyPress`, `ChkInput3` (saisie incrémentale), `Colmo_Click` [nécessaire,
  rejeu] → `mo_man`, `Colmo_KeyPress`, `ToggleButton2_Click` [nécessaire]. **`Ref()`** : **code
  mort**.
- **`mo_man()`** [mixte] (CC 22) : charge la MO (`TabMo`) : libellé, famille, taux horaire,
  prix de revient, TVA (ou `Codetva` si TVA réduite), temps/montant (`T`/`M`), forfait
  (`mo_valeurht` + `arrondimo`) ou temps × taux ; `Calc_Rem`, `Calc_TC`, marge ; refus si imprimé.
- **`mo_KeyPress()`** [nécessaire] [GUI] (CC 41) : Entrée enchaîne code → libellé → T/M → taux →
  temps → brut → remise → net → TTC avec les `Calc_*` ; F1, F2 (`SelectionMo`), F3/F6
  (`Button15_Click` + `Bl_Edit`), F4 `Movr`, F5 `FCalc`, F12 `Suivi`. **`mo_Lostfocus()`**
  [nécessaire] (CC 38) : mêmes cases 1-9 (copie), gardées par `chkfocus`. **`mo_GotFocus`**
  [nécessaire] : couleurs + `Chg`.
- **`Tmo_KeyPress`/`Tmo_LostFocus`** [nécessaire] : TVA MO → `Calc_Tmont`. **`Chg()`** : mémorise
  les valeurs `Change*`. **`Razmo()`** [GUI] : remise à blanc + numéro de ligne suivant.
- **`Button10_Keypress`** [nécessaire] (raccourcis M/X/P/B/R/H/T/L vers les champs ; Entrée),
  **`Button10_Click`** [nécessaire] (confirmation si prix nul), **`MajColdetailMo()`** (CC 32 ;
  contrôle de marge, cumul `Mrgmo`, recalcul selon le champ modifié), **`MajColdetailMo2()`**
  (écrit la ligne, bloc `n° & code & Rnd`, `Enrg_Ligmo`, caractéristiques `Enrg_Ligcar2`).

### G07 — Calculs MO (lisent et écrivent les contrôles)

- **`Calc_Net()`** : net = brut − brut × remise / 100. **`Calc_Txhr()`** : contrôle du taux
  horaire, recalcul si modifié. **`Calc_Brut()`** : brut modifié (en mode montant, le taux suit).
  **`Calc_Tmont()`** : brut = temps × taux (0 refusé). **`Calc_Rem()`** : remise → net → TTC.
  **`Calc_Puht()`** : net modifié → question « 1 remise / 2 brut et taux » ; `Catch`.
  **`Calc_TC()`** : taux de TVA (`Fiches_Tvaav` en dur, 0 si exonéré) → TTC → `arrondimo`.
  **`Calc_moHt()`** : TTC → HT → brut → taux horaire ; `Prxdec` → `Round` ; `Catch`.
  **`Calc_MargeMo()`** : relit `TabMo` ; temps : net − prix de revient × temps ; forfait : ⚠️ prix de
  revient × `tx` (variable `1 + TVA` d'une autre fonction) au lieu de `Txo` (FACTURE-A08).
- **`arrondimo()`** : arrondi du TTC MO au pas `Arr` (`0,05`, `0,10`, `0,50`, `1,00`) par manipulation
  de chaîne ; même algorithme que `arrondi` (articles).

### G08 — Saisie des articles (panneau `Panel3`, groupe `Art`)

- **`SelectionArt()`** [GUI] : `TriArticles(…, Me)` → `Bsel`/`Bval` →
  `Variables.$Codearticle` → `Art_Man`. **`ToggleButton3_Click`** [nécessaire].
- **`Art_man(Prod)`** [mixte] (CC 38) : paramètre ignoré (lit `Cart`) ; préfixe `*` → requête
  inutile ; recherche par `art_refcentrale` puis `art_code` ; refuse un matériel en facture
  entretien ; `Art_Rpl`, `Art_Equ`. Refus si imprimé ou réglé.
- **`Art_Rpl()`** [mixte] (CC 19) : produits de remplacement si l'article est en rupture
  (`TabRpl1` ⋈ `TabArt`) : remplacement automatique ou liste `hcol` ; ⚠️ supprime de `TabRpl1` une
  référence de remplacement inexistante (écriture pendant une lecture). **`Art_Equ(Equiv)`**
  [mixte] : équivalents (`TabCequ`) → `TriEqu` ou sélection directe → `Maj_zonesArt`.
  **`Art_Equ2`** et **`Tarifclient`** : **code mort** (seul appel de `Tarifclient` commenté).
  **`hcol_click`** [nécessaire, rejeu] (enregistre `/Col/LcolEqu`, valeur relue seulement par
  `Art_Equ2`, morte), **`hcol_Keypress`** [nécessaire].
- **`Maj_zonesArt()`** [mixte] (CC 86) : charge l'article (`TabArt` ⋈ `TabFour`) ; préférences
  incomplètes (`/Ctrlstk`) → erreur ; contrôle de stock ; désignation, famille, fournisseur
  (`Frm12`), matériel, caractéristiques, décimales (`Utils.Find_Nbdec`), prix d'achat, PMP ;
  **tarif** par `New TarArt(article, client, Me, type client, promo) As "trf"` (prix HT ou
  rétrocession, détail en info-bulle, promotion → remise 0) ; prix conseillé, unité de vente,
  arrondi, écotaxes, taxe copie privée, TVA, colisage de vente, `Quantite` + `ComArt` (stocké),
  remises, dépannage (`/Depannage` × `coefdep`), `Recup_Tva`, `Artpu_LF`, tranches de remises
  quantitatives (`Rms`), `Art_Rpl`. Variables mortes : `Remtypec`, `Tresult`, `cdr`, `Tbrlt`,
  `Tartpu`.
- **`trf_selec(value)`** [nécessaire : handler de l'événement `selec` de `TarArt`] : prix choisi.
  **`Art_DblClick`** [nécessaire] : affiche la grille tarif. **`Depg_Click`** [nécessaire] : tarif
  dépannage (copie du bloc de `Maj_zonesArt`).
- **`Quantite()`** [mixte] : stock de l'article (`Fiches_Art` en dur) et format selon `Dec`.
  **`ComArt()`** [mixte] : quantités en commande client (`TabLigbl` ⋈ `TabBl`, type C) et
  fournisseur (`Utils.Commande`) → `Message.Info`. **`aff_photo()`** : `Fcaras` (photo,
  caractéristiques).
- **`Art_KeyPress()`** [nécessaire] [GUI] (CC 96) : Ctrl+R référence longue, Ctrl+H commandes du
  client (`Listecom`), Ctrl+A historique de l'article, Ctrl+D `DupliDoc`, Ctrl+P photo ; Entrée
  enchaîne code (`*` = dernier code, code barre `Utils.Find_Cbarre`) → désignation (`*` = dernière)
  → PU → quantité → brut → remise → net → TTC ; F1, F2 (`SelectionArt`), F3/F6 (`Button15_Click` +
  `Bl_Edit`), F4 `Articles`, F5 `FCalc`, F7 `ComArt`, F8 prix d'achat ou tableau des remises
  quantitatives, F9 quantité par code barre, **F10 sur la désignation : `UPDATE Fiches_Art SET
  art_design`** (modifie la fiche article), F10 sur le prix : bascule TTC, F11 `FFournisseur` (⚠️ code postal
  perdu et `Bsel` jamais remis à faux dans la fiche ouverte, FACTURE-A32), F12 `Suivi`, `D` → décimales.
- **`Art_Lostfocus()`** [nécessaire] (CC 34) : mêmes cases 1-8 en perte de focus. **`Art_GotFocus`**
  [nécessaire] : couleurs, `ChgArt`, quantité non modifiable pour un matériel. **`ChgArt()`** :
  mémorise les `Change*`. **`Art_Mouseup`** [nécessaire], **`Art_Change`** [nécessaire] (`Chkf`).
  **`Achat_KeyPress`/`Achat_Lostfocus`** [nécessaire] : saisie du PMP. **`Arttx_KeyPress`/
  `arttx_LostFocus`** [nécessaire] : TVA → `Artqte_LF`.
- **Fournisseur, famille** : `ArtFour_KeyPress` [nécessaire], `fourman` (`Fiches_Four` en dur),
  `ToggleButton6_MouseUp` [nécessaire] (bascule Famille/Fournisseur, sélection), `SelectionFour`
  (`TriCpt` fournisseur), `Frm12` (`TabFour` ⋈ `TabEch` : franco, minimum, port),
  `SelectionFam` (`Fiches_Fam` en dur), `fam_man` (code TVA de la famille), `Colfam_Click`
  [nécessaire, rejeu], `Colfam_KeyPress` [nécessaire].
- **Validation** : **`Button11_Keypress`** [nécessaire] (raccourcis B/D/H/Q/P/R/T/L, F8),
  **`Button11_Click`** [nécessaire] (⚠️ l. 6511 `VerifDate.ClotDroi` sur l'**auto-instance** alors
  que `$vdate` existe ; prix nul → confirmation ; `MajColdetailArt` ; référence liée ; lignes de
  taxes sans code → `MajColdetailEco`), **`MajColdetailArt()`** (marge cumulée ; matériel →
  `Num_serie` ou ligne « Numéro de série non attribué »), **`Enrg_Art()`** (CC 59 : cumul de
  quantité si l'article est déjà présent et `/Cqte`, sinon nouvelle ligne ; 2e désignation,
  caractéristiques, mention promo, taxes annexes, produits composés, référence liée),
  **`init()`** [GUI], **`Cleanart()`** [GUI], **`Cart_LF()`** (focus quantité si référence liée),
  **`Dec_KeyPress`/`Dec_Click`** [nécessaire], **`Tbrem_Click`** [nécessaire] (remise choisie).

### G09 — Calculs article (lisent et écrivent les contrôles)

- **`Artpu_LF()`** : PU HT/TTC (`Recup_Tva`) puis `Artqte_LF`. **`Artqte_LF()`** (CC 22) :
  `Decimal` ; ⚠️ le refus des décimales ne vise que « ,x » ; colisage ; brut = PU × quantité ;
  `Remises_quantitatives` ; net ; `Calcttc` ; `Calc_Marge` ; poids.
- **`Remises_quantitatives()`** : remise = remise client + remise type + remise de la tranche ;
  ⚠️ boucle `0 To Rms.Bounds[0] - 1` : la 6e tranche n'est jamais appliquée.
- **`Artbrut_LF()`** (PU = brut / quantité), **`Artrm_LF()`** (CC 20 : mention « N » = Net,
  rétrocession, promotion, > 100 % refusé), **`Artnet_LF()`** (CC 27 : refus sous le prix d'achat,
  question « brut ou remise », recalcul TTC puis net), **`Arttc_LF()`** (net = TTC / (1 + TVA)).
  **`Artnet_GF()`** : **code mort** (`handlers_inactifs` : `Artnet` appartient au groupe `Art` et
  `_GF` n'est pas un événement).
- **`CalcTTC()`** : TTC = net × (1 + TVA), `arrondi`, net recalculé ; ⚠️ si remise nulle, le net
  est remplacé par le brut. **`CalcHt()`** : **code mort**. **`Recup_Tva()`** : `Ttva =
  CPrix.CTva(code)` sauf exonération. **`Decimal()`** : format de la quantité selon `Dec`.
- **`arrondi()`** : arrondi TTC au pas `arr` hors rétrocession ; ⚠️ l. 7624 affecte la chaîne
  littérale `"ar$"`. Recoupe `arrondimo`, `Utils.arrondi` (homonyme d'algorithme différent),
  `LPrix.Arrondi_Calc`, `FTvav`, `Caisse`, `Moulinage`, `Articles`, `Movr`, `Materiel`.
- **`Calc_Marge()`** : sans PMP, `net / coef_fam` (prix d'achat estimé plutôt que marge, à
  confirmer) ; sinon net − PMP × quantité ; branches `Prxdec` identiques.
- **`sTTC_Click`, `sFacht_Click`, `Tvar_Click`** [nécessaire] [GUI] : bascules HT/TTC et TVA réduite
  (libellé « Prix HT » dans les deux branches de `sFacht_Click`/`Tvar_Click`).
- **`Rembasfac_LostFocus()`** [nécessaire] : contrôle `Rembasfac` **toujours invisible** (`.form`) :
  handler inatteignable ; recalculerait le PU article.

### G10 — Taxes annexes et produits composés

- **`Ecot()`** (DEE, type `E`), **`Ecot2()`** (DEA, type `D`, seulement si `Pays = "France"`),
  **`Txpp()`** (copie privée, type `P`) : trois copies (~70 lignes) : en modification, mettent à jour
  la ligne de taxe du bloc ; sinon créent la ligne (PU = valeur unitaire, net = valeur × quantité,
  TTC = net × (1 + `Ttva`)) via **`MajColdetailEco()`**. Différences : libellé, type, valeur,
  format du PU et du TTC, `Prxdec` et `N = 1` absents de `Txpp`. Effet de bord : remise remise à 0.
- **`Recup_Pdc()`** (CC 22) : composants (`TabPrdComp`) → une ligne `O` chacun (`Enrg_Pdc`) ;
  découpage `codec;libelle;qte;mo` par chaîne ; taxes annexes des composants ; rechargement complet.

### G11 — Matériel et numéros de série

- **Numéro de série** (option `/Materiel`) : `Num_serie` (ouvre `Panel7`), `Rcpt_GotFocus`
  [nécessaire], `Rcpt_LostFocus` [nécessaire, **vide** : journalisation commentée],
  `Rcpt_KeyPress` [nécessaire], `ToggleButton9_Click` [nécessaire] (matériels non vendus,
  `Fiches_Materiels` en dur ; `Columns[1].Width` affecté deux fois), `NumsList_Click` [nécessaire,
  rejeu], `NumsList_KeyPress` [nécessaire], `Button22_KeyPress`/`Button22_Click` [nécessaire]
  (existence, déjà vendu, réception verrouillée `DocActif.Is_Lock`), **`Enrgnum()`** (`UPDATE
  Fiches_Materiels` : vendu, BL, prix `Val(Mnetht)`, client, dates de garantie), **`Enrg_Numserie()`**
  (ligne `T` « Numéro de série … » ; `Fiches_Ligbl` **en dur** même en mode entretien ; `Ren_ligbl`,
  `Maj_Base`), `Button23_Click` [nécessaire] (fermeture sans numéro).
- **Matériel de la facture entretien** : `ToggleButton11_Click` [nécessaire] (crée `$Matlist`
  `As "Matlist"`), `Matlist_Click`/`Matlist_KeyPress` [nécessaires : handlers du contrôle créé par
  code], `matman` (lecture du matériel, champs modifiables si « divers »), `CleanChampsMat`,
  `Mat_keypress`, `Mat_lostfocus`, `Mat_GotFocus` [nécessaires, groupe `Mat`].

### G12 — Commentaires (panneau `Panel4`, groupe `Com`)

- `SelectionCom` (`TabCom`), `Colcom_Click` [nécessaire, rejeu] (`Fiches_Commentaires` en dur, sans
  `Available`), `Colcom_KeyPress`, `com_KeyPress` [nécessaire] (F4 `Comment`, F2, F3/F6, F12),
  `com_GotFocus`, `Com_LostFocus`, `ToggleButton4_Click` [nécessaires], `com_man` (lecture par
  code).
- **`Button12_keypress()`** [nécessaire] : ⚠️ toute touche valide le commentaire.
  **`Button12_Click()`** [nécessaire] : ajoute une ligne de grille par ligne de texte (`XX` →
  variable `XX`), `Enrg_Ligcom` ; ⚠️ en modification, `Break` inconditionnel : seule la première
  ligne de la grille est examinée.
- **`Button24_Click()`** [nécessaire] : ajoute le texte saisi à la table des commentaires si le code
  est libre.

### G13 — Enregistrement des lignes (SQL)

Schéma commun : `SELECT` par (`num_ligbl`, `numlig_ligbl`) → `UPDATE` ou `INSERT` dans
`Fiches_Ligbl`/`Fiches_LigblM` (en dur), puis `Coldetail.Clear` + `Recup_ligbl` (rechargement complet
à chaque ligne). [nature : traitement, SQL émis depuis les valeurs des contrôles]

- **`Enrg_LigMo()`** (MO ; taux de TVA relu, `0` sinon), **`Enrg_LigArt()`** (article, 21-22
  colonnes, `rem` = « Net » si `bNet`, **`dte_ligbl = Now`** à chaque enregistrement, option
  boisson `$opt.majlig`, TIPP), **`Enrg_Ligcom()`** (commentaire), **`Enrg_Ligcar2()`**,
  **`Enrg_Ligcar()`** (caractéristiques MO/article), **`Enrg_LigArt2()`** (2e désignation),
  **`Enrg_Promo()`** (mention promotion) : ces quatre derniers passent `Bloc` à l'`UPDATE` sans
  l'utiliser. **`Enrg_Pdc(Cpdc, Lpdc, qpdc)`** : ⚠️ `UPDATE` aux paramètres décalés l. 9060
  (FACTURE-A05) ; pas de rechargement.

### G14 — Totaux et TVA du document

- **`Recup_ligbl()`** (CC 49) : charge la grille depuis `Fiches_Ligbl`/`LigblM` selon le type de
  ligne (commentaires multi-lignes ; codes spéciaux `XX`, `PO`, `PJ` mémorisés ; option boisson :
  `Fiches_ligcons`/`Fiches_consigne`), poids, marges, `CalculTotal` par ligne, coloration des
  lignes à référence longue, totaux affichés, `calculfindoc`, arrondi entier si `Prxdec`,
  `Maj_libelle`, numéros de ligne suivants.
- **`CalculTotal()`** [calcul + SQL] : cumule MO, articles, remises, HT, TTC (variables `String`)
  à partir de la variable d'instance `Rligbl` ; taux de TVA relu par ligne (`Fiches_Tvaav`) ;
  `/Impttc` → totaux TTC ; ⚠️ `Val(Totalmottc)` sans `cpoint` contrairement à `Totalmo`.
- **`calculfindoc()`** [calcul] : délègue à `$fac.calcul()` (`ObjFacB`) → HT, TVA, TTC du pied de
  document ; ~25 lignes commentées (frais, option boisson).
- **`option_recalcul()`** [nécessaire : handler de l'événement `recalcul` de `Facopt`] :
  `calculfindoc` + `button4_click`.

### G15 — Stock

- **`Maj_Quantite()`** (sortie) / **`Maj_Quantite2()`** (réintégration) : `LOCK TABLES TabArt,
  TabArtPromo, TabLigbl` ; pour chaque ligne article stockée : quantité × colisage ; `UPDATE TabArt
  SET art_qte` ; compteur de promotion (`ArtPromo.Maj_qteplus`/`Maj_qtemoins`).
- **`Maj_QuantiteD(RefD, qted)`** : sortie d'un article lors de `DupliDoc` ; l'`UPDATE` cible
  `Coldetail.current[1]` au lieu de `refd` (identique dans l'unique appel).
- **`Maj_QteDep()`** / **`Maj_QteDep2()`** : stock par dépôt (`TabStkDepots`, 2 premiers caractères
  de `Dep`) ; ⚠️ colisage lu sur une colonne absente (`art_colvte`) ; ⚠️ une quantité négative
  diminue le stock en sortie (FACTURE-A09) ; arrêt à la première ligne « Pièces en reliquat ».
- Quatre copies (~40 lignes). Le stock n'est cohérent qu'entre deux sessions de saisie.

### G16 — Duplication, avoir, archivage, reprise de lignes

- **`DupliDoc()`** (CC 59) : duplication totale ou des lignes marquées : nouveau numéro (`dnbon`,
  ⚠️ `UNLOCK` conditionnel), entête (`INSERT Fiches_Bl`), lignes, stock (`Maj_QuantiteD`) si BL ou
  facture ; **reliquat de commande** : commentaires ajoutés au nouveau document et au document
  d'origine, suppression optionnelle des lignes reprises ; enregistrement (`ColblSelection`,
  `button4_click`) et retour au document d'origine.
- **`Colbl_Activate()`** [nécessaire] [mixte] : sur une facture imprimée : « 1 avoir / 2 archiver /
  3 rien » → **`Lig_Archives()`** (`$fac.choix = ObjFac.facture ; $fac.calcul ; $fac.transblfac` :
  transfert vers `Fiches_HistoFac`, dans `ObjFacB`) ; avoir → `Button2_Click` (nouveau BL),
  `Avr = True`, colonnes de `Coldetail3`, `EntFac`.
- **Avoir / duplication depuis une facture existante** (`Panel9`) : **`ToggleButton5_Click`**
  [nécessaire] (ouvre le panneau si le document est vide), **`Creation(Avr2)`** (`TriFac` ou
  `TriFac2` → `Variables.Bsel` → `EntFac`), **`Button25_Click`** (duplication en devis),
  **`Button26_Click`** (avoir), **`Button29_Click`** (fermer), **`Button17_Click`** (mémorise
  `/SelDev`) [nécessaires].
- **`EntFac()`** (CC 24) : entête depuis `Fiches_HistoFac(M)` ou `Fiches_Bl(M)` (via
  `Variables.numeroFac`), matériel, `button4_click`, `Recup_ligfac`.
- **`Recup_ligfac()`** (CC 67) : lignes de la facture ou du document d'origine dans `Coldetail3`
  (consignes en option boisson ; « Bon n… » → « Annule le Bon n… ») ; ⚠️ appelle `Maj_libelle` à
  chaque ligne (met à jour la grille et les lignes du document courant).
- **`Button20_Click()`** [nécessaire] (CC 42) : reprise des lignes sélectionnées ou de toutes :
  contrôle de CM clôturée (`New VerifDate(recdate(…)).ClotDroi`, usage correct d'une instance),
  ligne « Reliquat de la commande », **`Importlig()`** (copie de la ligne, **signe inversé par
  chaîne** pour un avoir) puis **`Majligbl(dtcm)`** (`INSERT`, date de la ligne d'origine
  `recdate` ou du jour, cumuls) ; commentaires regroupés ; `$opt.copdecons` ; suppression optionnelle
  dans la commande d'origine ; stock ; `Button4_Click`.
- **`recdate(numbl, numlig, choix) As Date`** (Private) [traitement] : date de la ligne d'origine
  (`Fiches_Ligbl` ou `Fiches_HistoLigfac`, en dur).

### G17 — Suppression, impression, aperçu

- **`Bl_Suppr()`** (CC 25) : refus si lignes de matériel (⚠️ test `left(libel_ligbl,9) =
  "Numero de"` sans accent : vrai sous MySQL grâce à la collation `utf8mb4_unicode_ci`, insensible
  aux accents, mais jamais vrai sous SQLite), si imprimé ou réglé en caisse ; confirmation ;
  libère le verrou ; supprime le
  document GED (`LGed.Search(LGed.Clients, numbl).Supprime(False)`), l'entête, les lignes, les
  consignes ; remet les matériels en non vendus ; réintègre le stock **après** les `DELETE` (depuis la
  grille) ; `Form_Open`.
- **`Bl_Sup()`** : **code mort** (suppression sans contrôle ni stock).
- **`Bl_Edit()`** : écran d'édition `New OptFac(choix, client, numéro, Me.Parent, TTC, False,
  date, courriel)` (impression, envoi, numérotation et archivage de facture) puis `Maj_typeBL`.
- **`AffDoc()`** : aperçu `AFacture`.

### G18 — Règlement et acompte

- **`Rgmt_Click`**, **`Regmt_Change`** [nécessaires] : règlement saisi avec le document (mode, montant
  = TTC sans signe ; traite/LCR sans montant ; `/Rglt`).
- **`Button18_Click`** [nécessaire] (ouvre la saisie d'acompte), **`Verif_acompte()`** [mixte calcul]
  (contrôle numérique, `acpt`), **`Button19_Click`** [nécessaire] (ferme si correct).

### G19 — Tâches (option `/Taches`)

- `LibelTache_KeyPress`, `button33_Click` [nécessaires] (`INSERT Fiches_Taches`, en dur),
  `ColTaches_KeyPress` [nécessaire] (⚠️ toute touche propose la suppression ; `ALTER TABLE …
  ORDER BY lind` propre à MySQL), `Coltaches_Data` [nécessaire] (`Utils.rs1`), `RecupTaches`
  (`Utils.Base` avec `User.name` concaténé entre guillemets doubles), `Coltaches_Columnclick`
  [nécessaire] (tri).

### G20 — Options P/T/B : tournées, TIPP, frais, boisson

- **Tournée / TIPP** (`$soption` P ou T) : `Textto1_LostFocus` (`Fiches_tourne`), `Butto1_Click`
  (`Rechtour As "to1"`), `to1_trouve(value)`, `Texttr1_LostFocus` (`Fiches_region`),
  `Buttr1_Click` (`Rechtipp("N") As "tr1"`), `tr1_trouve(value)` [nécessaires ; `*_trouve` :
  handlers d'événements `trouve`] ; `defpxpp() As String` (Private ; prix par tranche
  `Fiches_ligtarpp`).
- **Frais de gestion** : `Textfrais_LostFocus`, `textfrais_KeyPress` [nécessaires] (`Button4_Click`
  + `calculfindoc`).
- **Option boisson** (`B`/`T`) : `modifpanel5` (Private ; `$opt = New Facopt(…) As "option"` ;
  réorganise ~25 contrôles ; ⚠️ `Print` de débogage l. 12333 et `120 + cw` au lieu de `120 * cw`
  l. 12301), `foccons` (Private ; focus palettes → colis → quantité), `$textpal_LostFocus`,
  `$textcol_LostFocus`, `$textpal_KeyPress`, `$textcol_KeyPress` [nécessaires ; quantité =
  palettes × colis × bouteilles], `ersdec` (Private ; message « sans décimale »),
  `Ignore_Remise_Click` [nécessaire].

### G21 — Import portable

- **`Button27_Click()`** [nécessaire] → **`GenFacPort()`** (CC 21) : lit `~/Portable/inventaire.txt`
  (« code barre;quantité ») et **pilote l'écran** (`Art_Man`, `Artqte_LF`, `Button11_Click`) pour
  chaque ligne ; rejets dans `~/tmp/ImpT.txt` (`Editeur.Prog_Editeur`) ; ⚠️ message « article
  inexistant » écrit pour une ligne vide ; fichier de rejets non fermé si l'inventaire est absent.

## État global utilisé

- **`Start`** : `LocalSettings["/Soc<XX>/…"]` (~60 clés : `Materiel`, `Tva550`, `Codetva`,
  `Depannage`, `Fht`, `AutoEnt`, `Faca`, `Franchise`, `Prxdec`, `AffMarge`, `Taches`, `Poids`,
  `Depots`, `Factdef`, `Bldef`, `Devisdef`, `Prodef`, `Taxe`, `MoArt`, `ComArt`, `Art`, `Afour`,
  `CodeVendeur`, `Affaire`, `Marge`, `Ctrlstk`, `Cqte`, `Casier`, `Impttc`, `Pdf`, `Rglt`, `SelDev`,
  `Replique`, `Breplique`, `Bexpcheminpj`, `Coul_fen`, `Col/LcolF`, `Col/LcolEqu`…), `/dbase/Con-ssh`,
  `/Coul/Focus`, `Start.Societe`, `Start.son`, `Start.Musique`, libellés de couleur `Start.Proform`,
  `Commande`, `Devis`, `Devis2`, `Bon`, `Facture` ; `Settings` (gb.settings par défaut) dans
  `RefLongue`.
- **`Utils`** : `db` (seul accès SQL), `cpoint`, `PointBase`, `Cdate_*`, `Calcech`, `Find_Nbdec`,
  `Find_cbarre`, `Remplace`, `ReplaceLb`, `Obstch`, `totobs`, `FColr`, `Base`/`Base3`/`Base4` et
  `rs1`/`rs3`/`rs4` (grilles virtuelles), `Observers`, `ObsGotf`, `ObsLstf`, `SetEditColor`,
  `ControlTunnel`, `Commande`, `Option`.
- **`Variables`** : `Bsel`, `$Codearticle` (« variable à supprimer »), `codepostal`,
  `Bureaudistributeur` (retour de `Tricp`), `numeroFac` (facture à reprendre), `bRemise`,
  `FMateriel` (voir [`Variables`](../../../Utils/Variables.module/architecture.md)).
- **Objets** : `$fac` ([`ObjFacB`](../../option/ObjFacB.class/architecture.md) : totaux et
  archivage), `$opt` ([`facopt`](../../option/facopt.class/architecture.md) : option boisson),
  `$tarif` ([`TarArt`](../../../Utils/TarArt.class/architecture.md)), `$vdate`
  ([`VerifDate`](../../../Utils/VerifDate.class/architecture.md)), `DocActif`, `LGed`, `ArtPromo`,
  `CPrix`, `Enrgcp`.

### Tables

| Table | Accès | Fonctions principales | Remarque |
|---|---|---|---|
| `Fiches_Bl` / `Fiches_BlM` | S/I/U/D | `Button4_Click`, `ColblSelection`, `Maj_typeBL`, `DupliDoc`, `Bl_Suppr`, `Deb1` | **en dur** (14 + 14 occurrences) |
| `Fiches_Ligbl` / `Fiches_LigblM` | S/I/U/D | `Enrg_*`, `Maj_Base`, `Recup_ligbl`, `Coldetail_KeyRelease`, `Majligbl` | **en dur** (31 + 23) ; montants en texte |
| `Fiches_Parametres` | S/U | `Button2_Click`, `button1_Click`, `DupliDoc`, `QuitteDate` | en dur ; `dnbon`, `dnc` sous `LOCK TABLES` |
| `Fiches_Cli`, `TabComptes`, `TabMailCli`, `TabContact`, `TabAdrC`, `TabTarcli`, `TabTcli`, `Fiches_Typec` | S/I/U | `Cli_man`, `Button4_Click`, `Recup_*` | `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Typec` parfois en dur |
| `TabArt`, `TabArtPromo`, `TabStkDepots` | S/U | `Maj_zonesArt`, `Maj_Quantite*`, `Maj_QteDep*`, F10 | stock sous `LOCK TABLES` |
| `Fiches_Tvaav` | S | `Calc_TC`, `CalculTotal`, `Enrg_*`, `Maj_Base` | en dur ; relu à chaque ligne |
| `Fiches_Materiels`, `Fiches_EntMat` | S/I/U | G11, `Bl_Suppr`, `Coldetail_*` | en dur |
| `Fiches_HistoFac(M)`, `Fiches_HistoLigfac(M)` | S | `EntFac`, `Recup_ligfac`, `ChiffreA`, `recdate` | lecture seule ici (écriture dans `ObjFacB`) |
| `TabMvt` | S | `Maj_typeBL` | règlements de trésorerie |
| `Fiches_Taches`, `Fiches_ligcons`, `Fiches_consigne`, `Fiches_ligregie`, `Fiches_ligtarpp`, `Fiches_tourne`, `Fiches_region`, `Fiches_Users` | divers | G19, G20, `Recup_ligbl` | en dur, **sans clé `Cbase`** |
| `Blcom` | CREATE/I/S/DROP | `Colbl_com`… | table temporaire, hors `Cbase` et `db_control.csv` |

## Propositions d'amélioration

Fichier legacy à haut risque (AGENTS.md règle 21) : uniquement des changements **ciblés**, chacun
couvert par un replay.

### Réécriture / refactorisation (dans le fichier)

- **Supprimer le code mort confirmé** : 14 fonctions (`ChkPrx`, `modifblopt`, `aff_cp`, `ChkCp`,
  `Ref`, `Art_Equ2`, `Tarifclient`, `Artnet_GF`, `CalcHt`, `Bl_Sup`, `Ecritures`, `Majnum`,
  `SetObservers`, `Recup_EncoursBl`), 5 membres `Public` jamais lus, variables locales mortes et
  blocs commentés.
- **Factoriser les copies internes** sans changer le SQL : `Ecot`/`Ecot2`/`Txpp`, les quatre
  `Maj_Quantite*`/`Maj_QteDep*`, les cinq clics de type de document, les quatre `Enrg_*` de lignes
  de texte, les quatre `Colbl_<recherche>`, `button6_Click`/`button8_Click`, le bloc « type par
  défaut » (3 copies), le bloc « numéro de ligne suivant » (6 copies), le bloc `FColr` de
  `Colbl_Data` (9 copies), les colonnes de `Coldetail3` (2 copies).
- **Découper `Coldetail_KeyRelease`** (CC 166) en sous-procédures par touche (suppression, monter,
  descendre, marquer) sans toucher à leur logique.
- Ne **pas** réécrire la logique de saisie (`Art_KeyPress`, `Maj_zonesArt`, `ColblSelection`) :
  trop de drapeaux implicites (`B`, `ChkFocus`, `Modif`, `N`) et d'effets de bord.

### Commonalisation avec d'autres fichiers

- Contrôle de réplication l. 1520 → `Utils.ReplicationOK` (voir
  [`Fmenu`](../../../Communs/Fmenu.class/rework.md), FMENU-004/005).
- Numéro du client suivant l. 1841-1847 → helper partagé avec
  [`Impclient.Compteur`](../../../Utils/Exports-Imports/Impclient.class/rework.md) (IMPCLIENT-008)
  et [`ImpSage.Compteur`](../../../Compta/Utils/ImpSage.class/architecture.md).
- Largeurs de colonnes `/Col/LcolF` → `Utils.LitLargeurs`/`SauveLargeurs` (voir
  [`Saisecrit`](../../../Compta/Saisecrit.class/rework.md), SAISECRIT-010 ; aussi `Tresor`,
  `Extrait`, `Archives`).
- Arrondi au pas (0,05…) par chaîne : `arrondi`/`arrondimo` → une fonction pure, à rapprocher de
  [`FTvav.ArrondiPrix`](../../../Compta/Tables/FTvav.class/rework.md) (même algorithme), de
  [`LPrix.Arrondi_Calc`](../../../Utils/LPrix.class/architecture.md) et des copies de `Caisse`,
  `Moulinage`, `Articles`, `Movr`, `Materiel` (≠ [`Utils.arrondi`](../../../Utils/Utils.module/architecture.md),
  homonyme d'algorithme différent).
- `dateEcheance` ↔ [`Saisecrit.dateEcheance`](../../../Compta/Saisecrit.class/architecture.md) :
  même code (`Fiches_Echeances` + `Utils.Calcech`).
- Chargement du client (`Cli_man` ↔ `ColblSelection`) et entête société : à rapprocher de
  [`ObjFac`](../ObjFac.class/architecture.md)/[`ObjFacB`](../../option/ObjFacB.class/architecture.md)
  qui relisent les mêmes colonnes.
- Code postal (`Cpman`, `ChkCp`, `ToggleButton8_Click`) et numéro de tiers suivant : dupliqués
  avec [`FClient`](../../Tables/FClient.class/rework.md) et
  [`FFournisseur`](../../Tables/FFournisseur.class/rework.md), qui proposent un socle commun
  `FicheTiers` (FCLIENT-011 à 013) ; `Facture` pourra en réutiliser la partie code postal.
- Promotion du jour (`Form_Open` l. 508) : même requête que `Articles` et `Caisse` →
  `ArtPromo.PromoDuJour()` (voir [`ArtPromo`](../../Tables/ArtPromo.module/rework.md), ARTPROMO-004).
- Les trois `New Suivi(…)` (F12) sont identiques : voir [`Suivi`](../../Suivi.class/architecture.md).
- Séquence « numéro d'écriture » (`Ecritures`/`Majnum`) : ici code mort ; la commonalisation
  (`Cielimp`, `Moulinage`, `ValidBR`, `Tresor`, `TresorFac`, `Saisecrit`) ne concerne pas `Facture`.
- `VerifDate.ClotDroi` et `DocActif.Free_Lock` : corrections à coordonner avec
  [`VerifDate`](../../../Utils/VerifDate.class/rework.md) (VERIFDATE-A02) et
  [`DocActif`](../../../Communs/DocActif.class/rework.md) (DOCACTIF-A01).

### Réduction de portée

- Fonctions non-handlers sans appelant externe (vérifié par `grep`) → `Private` : `lcoldetail`,
  `CleanChamps`, `Verif_Encours`, `Raz_client`, `Lignes_Bon`, `RdimColbl`, `ColblSelection`,
  `Recup_ligbl`, `CalculTotal`, `calculfindoc`, `Cpman`, `RecupTaches`, `SelectionMo`, `TriMo`,
  `Deb7`, `Deb8`, `Dbclkmo`, `ChkInput3`, `mo_man`, `Chg`, `Razmo`, `Calc_*`, `arrondimo`, `Wrg`,
  `Maj_typeBL`, `MajColdetailMo`, `MajColdetailMo2`, `SelectionArt`, `Art_Rpl`, `Art_Equ`, `Art_man`,
  `Maj_zonesArt`, `Quantite`, `Calc_Marge`, `ComArt`, `aff_photo`, `RefLongue`, `Artpu_LF`,
  `Artqte_LF`, `Remises_quantitatives`, `Cart_LF`, `Artbrut_LF`, `Artrm_LF`, `Artnet_LF`, `Arttc_LF`,
  `ChgArt`, `fourman`, `SelectionFour`, `Frm12`, `MajColdetailArt`, `Enrg_Art`, `init`, `Recup_Pdc`,
  `Num_serie`, `Enrgnum`, `Enrg_Numserie`, `SelectionFam`, `fam_man`, `Ecot`, `Ecot2`, `Txpp`,
  `MajColdetailEco`, `Cleanart`, `Decimal`, `CalcTTC`, `Recup_Tva`, `arrondi`, `Tbremq_Create`,
  `SelectionCom`, `com_man`, `DupliDoc`, `Rprodcomposes`, `Enrg_*`, `Ren_ligbl`, `Maj_Base`,
  `Maj_libelle`, `Maj_Quantite*`, `Maj_QteDep*`, `Bl_Suppr`, `Bl_Edit`, `QuitteDate`, `dateEcheance`,
  `AffDoc`, `Tot_Remises`, `Lig_Archives`, `EntFac`, `Recup_ligfac`, `Majligbl`, `Importlig`,
  `GenFacPort`, `Verif_acompte`, `Cli_man`, `Recup_Mail`, `Recup_type`, `ChiffreA`, `SelectionClient`,
  `Aff_AdrC`, `CleanChampsAdr`, `matman`, `CleanChampsMat`, `Deb1`, `Deb2`, `Colbl_com`, `Colbl_art`,
  `Colbl_libel`, `Colbl_refl`, `ChkInput2`, `Dbclkcli`, `Titre`, `Creation`, membre `numeroFac`.
- À **garder `Public`** : tous les handlers (y compris les pseudo-handlers de groupes et
  d'observateurs : `trf_selec`, `option_recalcul`, `to1_trouve`, `tr1_trouve`, `Matlist_*`,
  `Txtb_*`, `$text*`), les `<Grille>_Click` appelés par le rejeu (`Colcp_Click`, `Colmo_Click`,
  `hcol_click`, `NumsList_Click`, `Colfam_Click`, `Colcom_Click`, `Colal_Click`), `Bsel`/`Bval`
  (écrits par `Object.SetProperty`), `_New`.
- Règle PLAN §6 : réduction seulement si la fonction est couverte par un replay.

### Séparation traitement / GUI

Les calculs lisent les contrôles : on propose d'extraire **les formules** en fonctions privées pures,
appelées aux mêmes endroits avec les mêmes conversions (`Val`, `cpoint`, `Format$`) :

- `ArrondiPas(sMontant, sPas, sFormat) As String` (algorithme de `arrondi`/`arrondimo`, y compris
  les cas limites actuels) ;
- `RemiseTranche(fQte, Rms) As Float` (bornes de boucle actuelles conservées) ;
- `InverseSigne(sValeur) As String` (`Importlig`) ;
- `CumulLigne(...)` pour `CalculTotal` (paramètres explicites au lieu de `Rligbl`) ;
- `DeltaStock(fQte, fColisage, iSens, bDepot) As Float` (`Maj_Quantite*`, signes actuels figés) ;
- `CouleurDocument(sType, sImp) As String` (`Colbl_Data`) ;
- `EcheanceClient(sCode, sDate) As String` (`dateEcheance`, commun avec `Saisecrit`).

### Requêtes signalées par `sql_params` (après le lot Gestion-2)

- l. 11099 : `Exec(… order by nom, Code.Text)` passe `Code.Text` sans marqueur `&N` (signal `sql_params`) : toutes les adresses sont lues, sans filtre client. Même idiome qu'`OptFac:368` ; à rapprocher d'OPTFAC-A01 (à confirmer en replay).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker les montants des lignes (`pu_ligbl`, `brut_ligbl`, `netht_ligbl`, `nettc_ligbl`,
  `qte_ligbl`, `rem_ligbl`) en `DECIMAL` et non en texte formaté (virgule, espaces d'alignement
  `"  "`, mention `Net`) ; ajouter une colonne booléenne « net » au lieu de la valeur `Net` dans
  `rem_ligbl`.
- Identifiant de bloc (`block_ligbl`) généré par `Rnd(1000, 9999)` : le remplacer par un identifiant
  séquentiel ou une clé étrangère vers la ligne principale (collision possible, dump non
  déterministe).
- Préfixes `<casier>~ `, `Rupt~ `, `Dep~ ` stockés dans `libel_ligbl` : à séparer dans une colonne.
- Tables `Fiches_Bl`/`Fiches_BlM` et `Fiches_Ligbl`/`Fiches_LigblM` de structure quasi identique :
  une colonne « mode entretien » éviterait le doublement de tout le code.
- Stock : un journal de mouvements (`Fiches_Mvtstk` ou équivalent) au lieu de la réintégration /
  ressortie globale à chaque session de saisie.
- Table `Blcom` : remplacer par une requête jointe (`Fiches_Ligbl` ⋈ `Fiches_Bl`) sans table
  temporaire.
- `Fiches_Cli.cli_actif` est en réalité un drapeau « inactif » (1 = inactif, voir `FClient`,
  case `Inactif2`) : un renommage lèverait l'ambiguïté.
- Colonnes des options P/T/B (`tipp_ligbl`, `cli_tipp`, `cli_cons`…) ajoutées à l'exécution par
  `Gestion/option/modfichier.module` (`ALTER TABLE … ADD`) et absentes de `db_control.csv` : à
  intégrer au schéma de référence (ou à isoler dans des tables d'option).
