# ObjFac — Architecture

> Source : `.src/Gestion/Facturation/ObjFac.class`

## Vue d'ensemble

`ObjFac` est l'**objet métier « document de vente à éditer »** : à partir d'un numéro de BL ou de
facture (ou d'un client pour la fin de mois), il charge l'entête et les lignes, calcule les
totaux (articles, main-d'œuvre, remises, frais de gestion, TVA par taux, écotaxes), prépare les
lignes à imprimer (`ligne`, collection de `Ledit`), les écritures comptables de vente (`ecrit`,
collection de `VarEcr`), le texte de règlement, et porte toutes les **options d'édition** lues
dans `Start.LocalSettings["/Soc<XX>/…"]`. Il sait aussi archiver le PDF produit dans la GED
(`CopieGedFac`) et passer l'écriture comptable (`ecriturecompt`, via `EcrAuto`).

**`ObjFac` n'est jamais instancié directement** (`grep "New ObjFac("` : aucun résultat) : il est la
classe parente de [`ObjFacB`](../../option/ObjFacB.class/architecture.md) (`Inherits ObjFac`,
lot Gestion/option), qui redéfinit `calcul` (en appelant `Super.calcul`) et `verifdat` (en
appelant `Super.verifdat`), et ajoute l'édition (`editef`, `editebl`, `editefm`), les droits et
consignes (option boissons), le courriel et l'archivage (`transblfac`). `Create Static` sert à
exposer l'énumération des types de document (`ObjFac.bl`, `ObjFac.facture`…) via
l'auto-instance, utilisée par une dizaine de fichiers.

Types de document (`Public Enum`) : `sans`, `bl`, `facture`, `archive`, `commande`, `proforma`,
`devis`, `atelier`, `finmois`, `abonnement`, `magasin`, et leurs libellés `Origine[]` (origine GED).

Structures publiques : `adresse` (facturation/livraison), `Ledit` (ligne éditée, montants en
chaînes), `ltva` (cumul par code TVA), `ecotaxe` (`tee`/`tea`).

Nature globale : **mixte**. Traitement et SQL dominent, mais `verifdat`, `testchem` et
`ecriturecompt` affichent des messages (`Message.Warning/Error`) et `CopieGedFac` imprime.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `nom` | var | Private |  | String | 6 |
| `adr1` | var | Private |  | String | 7 |
| `adr2` | var | Private |  | String | 8 |
| `cp` | var | Private |  | String | 9 |
| `ville` | var | Private |  | String | 10 |
| `pays` | var | Private |  | String | 11 |
| `Index` | var | Private |  | Integer | 15 |
| `code` | var | Private |  | String | 16 |
| `libel` | var | Private |  | String | 17 |
| `stk` | var | Private |  | String | 18 |
| `unit` | var | Private |  | String | 19 |
| `qte` | var | Private |  | String | 20 |
| `puht` | var | Private |  | String | 21 |
| `putc` | var | Private |  | String | 22 |
| `brht` | var | Private |  | String | 23 |
| `brtc` | var | Private |  | String | 24 |
| `rem` | var | Private |  | String | 25 |
| `neht` | var | Private |  | String | 26 |
| `nettc` | var | Private |  | String | 27 |
| `tx` | var | Private |  | String | 28 |
| `type` | var | Private |  | String | 29 |
| `num` | var | Private |  | String | 33 |
| `tottva` | var | Private |  | Float | 34 |
| `totht` | var | Private |  | Float | 35 |
| `tottc` | var | Private |  | Float | 36 |
| `taux` | var | Private |  | String | 37 |
| `tee` | var | Private |  | Float | 41 |
| `tea` | var | Private |  | Float | 42 |
| `sans` | enum | Public | oui |  | 45 |
| `bl` | enum | Public | oui |  | 45 |
| `facture` | enum | Public | oui |  | 45 |
| `archive` | enum | Public | oui |  | 45 |
| `commande` | enum | Public | oui |  | 45 |
| `proforma` | enum | Public | oui |  | 45 |
| `devis` | enum | Public | oui |  | 45 |
| `atelier` | enum | Public | oui |  | 45 |
| `finmois` | enum | Public | oui |  | 45 |
| `abonnement` | enum | Public | oui |  | 45 |
| `magasin` | enum | Public | oui |  | 45 |
| `Origine` | var | Public |  | String[] | 46 |
| `resent` | var | Public |  | Result | 48 |
| `reslig` | var | Public |  | Result | 49 |
| `livraison` | var | Public |  | Boolean | 50 |
| `devise` | var | Public |  | String | 51 |
| `gmateriel` | var | Public |  | Boolean | 52 |
| `dtmouv` | var | Public |  | Boolean | 53 |
| `sms` | var | Public |  | Boolean | 54 |
| `breg` | var | Public |  | Boolean | 55 |
| `treg` | var | Public |  | String | 56 |
| `badr` | var | Public |  | Boolean | 57 |
| `adrfac` | var | Public |  | Adresse | 58 |
| `adrliv` | var | Public |  | Adresse | 59 |
| `blchif` | var | Public |  | Boolean | 60 |
| `colon` | var | Public |  | Boolean | 61 |
| `ligne2` | var | Public |  | Boolean | 62 |
| `entete` | var | Public |  | Boolean | 63 |
| `reserve` | var | Public |  | Boolean | 64 |
| `treserve` | var | Public |  | String | 65 |
| `pied` | var | Public |  | Boolean | 66 |
| `tpied` | var | Public |  | String[] | 67 |
| `ttc` | var | Public |  | Boolean | 68 |
| `recap` | var | Public |  | Boolean | 69 |
| `sauvpdf` | var | Public |  | Boolean | 70 |
| `pdf` | var | Public |  | String | 71 |
| `remise` | var | Public |  | Boolean | 72 |
| `Stock` | var | Public |  | Boolean | 73 |
| `blrecap` | var | Public |  | Boolean | 74 |
| `saisreg` | var | Public |  | Boolean | 75 |
| `tsaisreg` | var | Public |  | String | 76 |
| `doclet` | var | Public |  | Boolean | 77 |
| `imp` | var | Public |  | Printer | 78 |
| `simpcond` | var | Public |  | Boolean | 79 |
| `coupon` | var | Public |  | Boolean | 80 |
| `nblfac` | var | Public |  | Boolean | 81 |
| `poids` | var | Public |  | Boolean | 82 |
| `affref` | var | Public |  | Boolean | 84 |
| `autoent` | var | Public |  | Boolean | 85 |
| `franctva` | var | Public |  | Boolean | 86 |
| `mdepo` | var | Public |  | Boolean | 87 |
| `libtaxe` | var | Public |  | String | 88 |
| `libsire` | var | Public |  | String | 89 |
| `pxsdec` | var | Public |  | Boolean | 90 |
| `libdev` | var | Public |  | Boolean | 91 |
| `txtlibdev` | var | Public |  | String | 92 |
| `txtvldev` | var | Public |  | String | 93 |
| `pdfchemin` | var | Public |  | String | 94 |
| `tab` | var | Public |  | String | 95 |
| `adrlogo` | var | Public |  | Boolean | 96 |
| `lgo` | var | Public |  | Boolean | 97 |
| `rescli` | var | Public |  | Result | 98 |
| `couleur` | var | Public |  | Integer | 99 |
| `couleur2` | var | Public |  | Integer | 100 |
| `journal` | var | Public |  | String | 101 |
| `numeroecr` | var | Public |  | Integer | 102 |
| `numerodef` | var | Public |  | Integer | 103 |
| `cheque` | var | Public |  | Boolean | 104 |
| `intcheque` | var | Public |  | Boolean | 105 |
| `cptcheque` | var | Public |  | String | 106 |
| `intcarte` | var | Public |  | Boolean | 107 |
| `cptcarte` | var | Public |  | String | 108 |
| `intaut` | var | Public |  | Boolean | 109 |
| `cptaut` | var | Public |  | String | 110 |
| `choix` | var | Public |  | Integer | 111 |
| `condvent` | var | Public |  | String | 113 |
| `joinfac` | var | Public |  | Boolean | 114 |
| `joinsms` | var | Public |  | Boolean | 115 |
| `AffClient` | var | Public |  | Boolean | 116 |
| `ligneart` | var | Public |  | Ledit | 118 |
| `lignecom` | var | Public |  | VarEcr | 119 |
| `lignetva` | var | Public |  | Ltva | 120 |
| `ecrit` | var | Public |  | Collection | 121 |
| `ligne` | var | Public |  | Collection | 122 |
| `tva` | var | Public |  | Collection | 123 |
| `gestion` | var | Public |  | Float | 124 |
| `montart` | var | Public |  | Float | 125 |
| `montmo` | var | Public |  | Float | 126 |
| `remart` | var | Public |  | Float | 127 |
| `remmo` | var | Public |  | Float | 128 |
| `montht` | var | Public |  | Float | 129 |
| `monttva` | var | Public |  | Float | 130 |
| `montttc` | var | Public |  | Float | 131 |
| `nomfm` | var | Public |  | String | 132 |
| `edit` | var | Public |  | Report | 133 |
| `eco` | var | Public |  | Ecotaxe | 134 |
| `$dtedoc` | var | Private |  | LDate | 136 |
| `$dteech` | var | Private |  | LDate | 137 |
| `$numcli` | var | Private |  | String | 138 |
| `$exemplaire` | var | Private |  | Integer | 139 |
| `$numfac` | var | Private |  | String | 140 |
| `$numbl` | var | Private |  | String | 141 |
| `$sreg` | var | Private |  | String | 142 |
| `$acquitte` | var | Private |  | Boolean | 143 |
| `$cdech` | var | Private |  | String | 144 |
| `$resfam` | var | Private |  | Result | 147 |
| `$restva` | var | Private |  | Result | 148 |
| `$facav` | var | Private |  | String | 149 |
| `entetef` | const | Private |  |  | 151 |
| `detailf` | const | Private |  |  | 152 |
| `dtedoc` | property | Public |  | LDate | 154 |
| `dteech` | property | Public |  | LDate | 155 |
| `numcli` | property | Public |  | String | 156 |
| `nbexplemplaire` | property | Public |  | Variant | 157 |
| `numbl` | property | Public |  | String | 158 |
| `numfac` | property | Public |  | String | 159 |
| `nombre` | event | Public |  |  | 161 |
| `fttc` | event | Public |  |  | 162 |
| `echeance` | event | Public |  |  | 163 |
| `modreg` | event | Public |  |  | 164 |
<!-- /AUTO:declarations -->

### Membres publics : usage réel (vérifié par `grep`)

`deps.py` ne relie pas les membres hérités aux variables typées `ObjFacB` (`vfac`, `$vfac`, `fac`,
`$fac`, `opt`, `cal`, `$cal`, `obj`, `ccd`) : sa liste « portée réductible » (62 membres) est
largement fausse. Usage vérifié :

| Membres | Utilisateurs externes |
|---|---|
| `resent`, `reslig`, `ligne`, `tva`, `lignetva`, `ecrit`, `montht`, `monttva`, `montttc`, `montart`, `montmo`, `remart`, `remmo`, `gestion`, `rescli`, `adrfac`, `edit`, `imp`, `choix`, `dtmouv`, `gmateriel`, `condvent`, `joinfac`, `pdf`, `AffClient`, `saisreg` | `ObjFacB` (Me./hérité), `EditfacB`, `Editfac`, `OptFac`, `Moulinage`, `Facture`, `Caleditcmat`, `ClotureF` |
| `livraison`, `sms`, `breg`, `badr`, `adrliv`, `blchif`, `colon`, `ligne2`, `entete`, `reserve`, `pied`, `ttc`, `recap`, `remise`, `Stock`, `blrecap`, `tsaisreg`, `doclet`, `simpcond`, `autoent` | `OptFac`, `Editfac`, `EditfacB`, `Moulinage` |
| `devise`, `treserve`, `tpied`, `coupon`, `affref`, `franctva`, `libtaxe`, `libsire`, `pxsdec`, `libdev`, `txtlibdev`, `txtvldev`, `adrlogo`, `lgo`, `couleur`, `couleur2`, `eco` | `Editfac` / `EditfacB` (paramètre `vfac`) |
| `journal`, `numeroecr`, `numerodef` | `Moulinage` |
| `Origine`, `treg`, `sauvpdf`, `nblfac`, `pdfchemin`, `ligneart`, `lignecom` | **interne seulement** → réductibles en `Private` |
| `poids`, `mdepo`, `cheque`, `intcheque`, `cptcheque`, `intcarte`, `cptcarte`, `intaut`, `cptaut`, `joinsms`, `nomfm` | **jamais lus** (écrits dans `_new`/`calcul` ou jamais) → code mort |

Membres privés morts : `$resfam`, `$restva`, `$facav` (déclarés, jamais utilisés).
Variables locales mortes : `num`, `tot`, `lg` (`calcul`, sauf boucle avoir), `tot` (`calc`),
`n` (`mult`), `res`, `dte` (`verifdat`), `res`, `libel_def` (`CopieGedFac`), `pos`
(`FactType2Orig`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 166-285 | Public | 24 | 107 | 0 | méthode spéciale |
| `calech` | 287-305 | Private | 3 | 15 | 0 |  |
| `numcli_Read` | 308-312 | Private | 1 | 3 | 0 |  |
| `numcli_Write` | 314-377 | Private | 17 | 60 | 0 |  |
| `nbexplemplaire_Read` | 379-383 | Private | 1 | 3 | 0 |  |
| `nbexplemplaire_Write` | 385-393 | Private | 2 | 7 | 0 |  |
| `numbl_Read` | 395-399 | Private | 1 | 3 | 0 |  |
| `numbl_Write` | 401-405 | Private | 1 | 3 | 0 |  |
| `numfac_Read` | 407-411 | Private | 1 | 3 | 0 |  |
| `numfac_Write` | 413-417 | Private | 1 | 3 | 0 |  |
| `dtedoc_Read` | 419-423 | Private | 1 | 3 | 0 |  |
| `dtedoc_Write` | 425-432 | Private | 2 | 6 | 0 |  |
| `dteech_Read` | 434-438 | Private | 1 | 3 | 0 |  |
| `dteech_Write` | 440-444 | Private | 1 | 3 | 0 |  |
| `calcul` | 447-665 | Public | 45 | 198 | 1 |  |
| `calc` | 667-755 | Private | 18 | 78 | 0 |  |
| `ecriture` | 757-788 | Public | 5 | 30 | 1 |  |
| `mult` | 791-821 | Private | 6 | 27 | 0 |  |
| `verifdat` | 824-848 | Public | 9 | 20 | 1 |  |
| `testchem` | 852-882 | Public | 13 | 30 | 1 |  |
| `CopieGedFac` | 884-945 | Public | 8 | 56 | 1 |  |
| `nom` | 947-972 | Private | 7 | 22 | 1 |  |
| `ecriturecompt` | 975-1015 | Public | 5 | 38 | 1 |  |
| `Orig2FactType` | 1018-1029 | Public | 2 | 9 | 0 | portée réductible ? |
| `FactType2Orig` | 1031-1041 | Public | 3 | 8 | 0 | portée réductible ? |
| `MajSuivis` | 1044-1056 | Private | 3 | 8 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et options

- **`_new(Optional num, Optional choi, Optional dte = LDate(Now))`** [portée : nécessaire
  (constructeur, appelé par `New ObjFacB(…)`)] [nature : calcul] (CC 24). Si `num` vide et
  `choi = sans` : retour immédiat. Sinon :
  - `archive` : `$numfac = num`, cherche dans `Fiches_HistoFac` puis `Fiches_HistoFacM`
    (`tab = "M"`) ;
  - `finmois` : `tab = num` (le « numéro » est alors le **suffixe de table** `""` ou `"M"`) ;
  - autres : cherche `num` comme `numbl` dans `Fiches_Bl` puis `Fiches_BlM`, puis comme `numfac`
    dans `Fiches_Bl` puis `Fiches_BlM` (`tab = "M"` si trouvé en `M`) ; mémorise `numbl`,
    `numfac`, `acquitte`, `reg`.
  Puis fixe `$dtedoc` et lit ≈ 40 options : `/Recap`, `/Impttc`, `/Entete`, `/Conditions`
  (+ `Fiches_Tleg.intitule`), `/Pied` (+ `Fiches_LibelFac.txtfac` découpé en lignes),
  `Fiches_Parametres` (`devise`, défaut `"Euro(s)"` ; `jrnal4`), `/Imp2L`, `/Col`,
  `/Impstocke`, `/ImpTotbl`, `/Poids`, `/TxtF` (+ `/LTxtF`), `/Rglt` (forcé à `False` en fin de
  mois), `/Totstring`, `/Coupon`, `/Impbl`, `/AffArt`, `/AutoEnt`, `/Franchise`, `/Depots`,
  `/Taxe` (défaut `"Tva"`), `/Siret` (défaut `"Siret"`), `/Prxdec`, `/Libdevis`, `/Devis2`,
  `/Devis`, `/Factchemin`, couleurs `Start.R/G/B` et `R2/G2/B2`, `/glogo3`, `/glogo`,
  `/Materiel`, `/Cheque`, `/FactcheminV`, `/Pdf5`, `/Pdf6`, `/Pdfchemin`, `/AffClient`, `/Carte`.
  Crée l'imprimante `imp = New Printer`. Tables en dur (sans `Cbase`). ⚠️ `sms` est lu sur la clé
  `/TxtF` (texte de règlement) au lieu de `/Sms` (option SMS écrite par `Prefs`) : OBJFAC-A04.
- **`calech()`** [Private] [calcul]. Calcule l'échéance `$dteech` à partir du code d'échéance
  client (`Fiches_Echeances` : `duree`, `jours`, `finmois` → `Utils.Calcech`) ou la date du
  document, puis lève `echeance`.

### Propriétés

- **`numcli`** (lecture/écriture, CC 17 en écriture) [mixte : lève des événements]. L'écriture lit
  la fiche client (`Fiches_Cli`) : nombre d'exemplaires (`cli_expl`, défaut 2, événement
  `nombre`), auto-entrepreneur (`cli_autoent`, événement `fttc(True)`), code d'échéance (puis
  `calech` si la date est valide), archivage PDF (`sauvpdf = cli_copie`), mode de règlement
  (événement `modreg`, sans gestionnaire), adresse de facturation (`adrfac`) et de livraison
  (`Fiches_AdrlivBL` du BL courant). Client inexistant non vide → `Error.Raise`. Construit enfin le
  texte de règlement `tsaisreg` (sauf s'il est déjà renseigné hors fin de mois/abonnement) :
  « Facture acquittée par … », texte des préférences (`breg`), ou « Règlement [à réception] par
  <libellé> [au <échéance>] » selon `Fiches_Reglements` (code = 2 premiers caractères de
  `cli_reg`). Les adresses ne sont **créées** que si le client existe (sinon `Null`).
- **`nbexplemplaire`** : lecture ; écriture avec test `value = gb.String` qui compare la
  **valeur** à la constante `gb.String` (9) au lieu de `TypeOf(value)` : sans conséquence pour
  des valeurs numériques (conversion implicite).
- **`numbl`**, **`numfac`**, **`dteech`** : accesseurs simples. **`dtedoc`** : l'écriture recopie
  la date et recalcule l'échéance si elle change.

### Calcul du document

- **`calcul(Optional nom)`** [portée : nécessaire (redéfinie par `ObjFacB.calcul`, qui l'appelle
  par `Super.calcul` ; appelée par `Facture`, `ClotureF`, `Caleditcmat` via `ObjFacB`)]
  [nature : calcul] (CC 45, maximum du fichier). Réinitialise collections et totaux (**sauf
  `remart`/`remmo`**, cumulés d'un appel à l'autre : OBJFAC-A02). Charge `resent`/`reslig` selon
  `choix` :
  - `archive` : `Fiches_HistoFac<tab>`/`Fiches_HistoLigfac<tab>` avec des alias (`entetef`,
    `detailf`) qui imitent les colonnes de `Fiches_Bl`/`Fiches_Ligbl` ;
  - `finmois` : lit la **table de travail `Bl`** (créée par `Facturefm`, `FacturefmA`,
    `Facturergbl` ou `SaiReg.Facture`) pour le client (et `nom` pour un client divers), construit
    deux conditions `numbl = … OR …` par `Utils.db.Subst`, puis lit `Fiches_Bl<tab>` et
    `Fiches_Ligbl<tab>` (⚠️ `"ORDER BY"` collé à la condition sans espace : accepté car la
    condition se termine par un littéral entre quotes produit par `Subst`, à confirmer sous SQLite) ; recalcule l'échéance ;
  - autres : par `numfac` ou par `numbl`, en reprenant dates d'édition et d'échéance si le
    document est déjà facturé (`imp = 1`).
  Parcourt les lignes : renumérotation `0001…` ; en-tête « Bon n° … du … » par BL si `nblfac`
  (fin de mois/facture) ; `A` et `M` → `calc` + cumuls ; `C`/`R` → une ligne par ligne de
  commentaire ; `O` (composant) affiché si l'article composé a `art_prdcomp` et `art_impdetail` ;
  `T` (2ᵉ ligne) si `ligne2` est faux ; `E`/`D`/`P` → « Dont … » via `Utils.totobs`. Ensuite :
  adresse de facturation du premier BL, **frais de gestion** du premier BL qui en a (TVA des frais
  par `Fiches_Parametres × Fiches_Tvaav × Fiches_Comptes`, écriture sur `cptfrais`), écritures de
  TVA par taux (`Fiches_Tvaav × Fiches_Comptes`), total TTC, écriture client (débit), ligne
  « Total document » en lettres (`Numtostring.Convertir`) si `doclet` et `blchif`. Si le total HT
  est négatif, les libellés d'écriture deviennent « AVOIR <nom> ».
  Partie extractible : tout (aucun accès aux contrôles) ; découpage proposé ci-dessous.
- **`calc(numlig)`** [Private] [calcul] (CC 18). Construit la ligne éditée d'un article ou d'une
  MO : lecture `Fiches_Art` (sans test `Available`) ou `Fiches_Mo` (colonnes aliasées), écotaxes
  (`art_ect`/`art_ect2`), unité de conditionnement si `simpcond`, stock (`art_qte`), prix et
  montants via `mult` (recalculés depuis la fiche article si `remise` et BL), arrondi sans décimale
  si `pxsdec`. Cumule la TVA par code `tx_ligbl` (sauf client exonéré ou auto-entrepreneur ; les frais de
  gestion de `calcul` utilisent une condition différente, voir A03) et prépare l'écriture de vente sur le compte de la famille (`compt_fam`, ou
  `compt5_fam` si `retro`). ⚠️ En mode TTC, l'écotaxe est calculée à partir de l'accumulateur
  (`eco.tee * txtva`) au lieu du montant de l'article : elle reste à 0 (OBJFAC-A01).
- **`ecriture(numcpt, tot, intitule)`** [portée : nécessaire (`ObjFacB` : 23 appels `Me.ecriture`)]
  [nature : calcul]. Cumule un montant (débit si négatif) dans `ecrit[numcpt]` ou crée l'écriture
  (`VarEcr` : compte, intitulé, libellé « FACTURE <nom> » tronqué à 50, dates, `numdoc`/`numlot`
  = numéro de facture, `etat = L_ajou`, `type = Vente`).
- **`mult(fac1, fac2, ndec)`** [Private] [calcul]. Produit de deux nombres (chaînes converties par
  `Utils.cpoint`), arrondi à `ndec` décimales et formaté par `Utils.CDec`. ⚠️ `ndec` nul est
  remplacé par la lettre `"O"` et non le chiffre `"0"` (OBJFAC-A07, à confirmer).

### Contrôles, impression et GED

- **`verifdat(Optional dtef, Dtech)`** [portée : nécessaire (`Super.verifdat` dans `ObjFacB`)]
  [nature : mixte]. Avertit si la date de document est vide, ou l'échéance vide pour une facture
  ou un abonnement (`Return True`) ; contrôle la clôture (`VerifDate.ClotFac`) pour une facture ou
  une fin de mois ; si `dtmouv`, met à jour la date de mouvement des lignes article
  (`UPDATE Fiches_Ligbl SET dte_ligbl … WHERE num_ligbl = numbl AND typel_ligbl='A'`, table en dur,
  sans variante `M`). Les paramètres `dtef`/`Dtech` sont ignorés.
- **`testchem()`** [portée : nécessaire (`ObjFacB` ×3)] [nature : mixte]. Si `sauvpdf` : vérifie
  ou crée `pdfchemin` ; sinon vérifie, crée et teste en écriture `~/Impressions`. Messages en cas
  d'échec (`Return True`).
- **`CopieGedFac()`** [portée : nécessaire (`ObjFacB` ×4)] [nature : mixte]. Imprime `edit`
  (Report fourni par `ObjFacB`) dans `~/tmp/Facture.pdf` ; s'arrête si le document est déjà
  facturé (`resent!imp = 1`). Si `sauvpdf` : réimprime, puis séquence GED (`LGed.Search` →
  `New LGed` si absent → `DTE`, `TTC`, `HT` → `PDFDupli(…, <nom>-<horodatage>.pdf)` → en cas
  d'échec `Supprime`, sinon `DelAllTag`, tags `BL<numbl>` (si facture), `<numcli>` et
  `tag_def` du client). ⚠️ La lecture de `tag_def` concatène `$numcli` **sans quotes ni
  paramètre** (`… WHERE cli_code = " & $numcli`) : OBJFAC-A05. Sinon : imprime dans
  `~/Impressions/<nom>.pdf`. La variable locale `imp` masque le membre `imp`.
- **`nom()`** [Private] [calcul]. Nom de fichier : préfixe selon le type (`F<numfac>-<numbl>_`,
  `F<numfac>_`, `B…`, `C…`, `P…`, `D…`) + nom de facturation sans espaces, `/` ni `'`, parenthèses
  remplacées par `_`. Rien pour `atelier`/`archive` (préfixe vide).

### Comptabilité et suivi

- **`ecriturecompt()`** [portée : nécessaire (`ObjFacB` ×2)] [nature : mixte]. Refuse un BL réglé
  par un ticket non mouliné (`numtick` non nul → `Message.Error`). Regroupe les écritures
  `ecrit` dans un `VarEcr`, fixe date et client, **inverse `type` et `etat`**
  (`type = L_ajou`, `etat = Vente` — sans effet aujourd'hui, les deux valent 2), puis
  `New EcrAuto("", lignecom).ecriture()`. Récupère journal, numéro de facture et numéros
  d'écriture. Pour une facture : `utils.db.Edit("Fiches_Bl", numbl)` → `numfac`, `imp = 1`,
  `reg = "Gestion"`, `dtefac`, `ech`, puis `MajSuivis`. Table en dur : sans effet ni erreur
  maîtrisée pour un BL en `Fiches_BlM` (OBJFAC-A06, à confirmer).
- **`MajSuivis()`** [Private] [calcul]. Pour chaque BL de `resent`, renseigne `numfac`/`datefac`
  de `Cbase.Table("TabSuivis")` (suivi d'affaires lié au devis), si la ligne existe.
- **`FactType2Orig(choix)`** [portée : réductible (interne, `CopieGedFac`)] [calcul]. Libellé
  `Origine[choix]` (ou `""` hors bornes).
- **`Orig2FactType(Orig)`** [portée : réductible] [calcul]. **Jamais appelée** (code mort) ; en
  outre `pos > 1` exclut `"BL"` (indice 1) qui renvoie 0.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/…"]` : ≈ 40 clés lues dans `_new` (liste ci-dessus).
- `Start.R/G/B`, `Start.R2/G2/B2` (couleurs d'édition), `Start.son`, `Music`.
- `Utils.db` (`Exec`, `Subst`, `Edit`), `Utils.arrondi`, `Utils.cpoint`, `Utils.CDec`,
  `Utils.totobs`, `Utils.Calcech`, `Numtostring.Convertir`, `Cbase.Table` (3 usages seulement).
- `EcrAuto`, `VarEcr`, `VerifDate`, `LGed`, `LDate`, `LPrix`.
- Tables : `Fiches_Bl[M]`, `Fiches_Ligbl[M]`, `Fiches_HistoFac[M]`, `Fiches_HistoLigfac[M]`,
  `Fiches_Cli`, `Fiches_AdrlivBL`, `Fiches_Reglements`, `Fiches_Echeances`, `Fiches_Tleg`,
  `Fiches_LibelFac`, `Fiches_Parametres`, `Fiches_Art`, `Fiches_Mo`, `Fiches_Fam`,
  `Fiches_Comptes`, `Fiches_Tvaav`, `Fiches_Suivis`, la table de travail `Bl`, et en GED
  `Docs_Ged`/`Docs_Tag`/`Fiches_Tag` (via `LGed`). Écritures comptables via `EcrAuto`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **`calcul` (CC 45)** : extraire, dans le même fichier et sans changer l'ordre des requêtes,
  `ChargeDocument()` (sélection de `resent`/`reslig` par `choix`), `AjouteLigne(numlig)` (corps
  du `Select Case typel_ligbl`), `FraisGestion()`, `EcrituresTva()`, `LigneTotalLettres()`.
  Objectif CC ≤ 12 par fonction.
- `_new` : remplacer la suite de 40 affectations par une table `[membre, clé, défaut]` parcourue
  par `Object.SetProperty` (même ordre de lecture), ou au minimum un helper `Opt(clé)` qui
  évite de répéter `"/Soc" & Start.Societe & "/"`.
- `_new` : factoriser les quatre recherches `Fiches_Bl`/`Fiches_BlM` par `numbl` puis `numfac`
  (boucle sur `["", "M"]` × `["numbl", "numfac"]`, même ordre de requêtes).
- `mult` : conversion Variant → Float commune à `LPrix`/`LTaxe` (`Utils.VariantToFloat`, voir
  [`LPrix`](../../../Utils/LPrix.class/architecture.md)).
- Renommer les variables locales `lg` (typée `LGed` dans `CopieGedFac`, `VarEcr` dans `calcul` et
  `ecriturecompt`) : `deps.py` fusionne les deux types et produit des membres `<inconnu:…>`
  attribués à `VarEcr`.
- Remplacer les noms de tables en dur par `Cbase.Table` (`TabBl`, `TabBlM`, `TabLigbl`,
  `TabLigblM`, `TabHisFac`, `TabHisFacm`, `TabHisLigFac`, `TabHisLigFacm`, `TabCli`, `TabEch`,
  `TabTleg`, `TabLibelFac`, `TabParam`, `TabArt`, `TabMo`, `TabFam`, `TabComptes`, `TabTvav`) :
  SQL identique. `Fiches_AdrlivBL` et `Fiches_Reglements` n'ont pas de clé `Cbase`.

### Commonalisation avec d'autres fichiers

- **Archivage GED** : la séquence `Search → New → PDFDupli → Supprime/DelAllTag → AddTag(s)` de
  `CopieGedFac` est celle de `commande1`, `Edbr` et `EcrAuto` : la remplacer par
  `LGed.Archive(type, origine, code, compte, pdf, nom, tags[])` proposée par LGED-007
  ([`LGed`](../../../Utils/LGed.class/architecture.md)), une fois cette méthode créée.
- Lecture de `tag_def` puis `AddTags(String2Array(…))` : helper `LGed.AddTagsTiers(code, …)`
  (même proposition dans `LGed`), qui corrigerait aussi la concaténation (A05) si validée.
- Les alias `entetef`/`detailf` (historique → BL) existent sous d'autres formes dans
  `ObjFacB.transblfac` (sens inverse) : un module de correspondance des colonnes BL ↔ historique
  éviterait les divergences (à confirmer avec le lot Gestion/option).
- Calcul de TVA par taux et écritures de vente : logique proche dans `Facturergbl.Maj_Totalisation`
  / `Calc_tva` (code mort, voir [`Facturergbl`](../Facturergbl.class/architecture.md)) et dans
  `Moulinage` (`Maj_Totalisation`).

### Réduction de portée

- `Private` : `FactType2Orig`, `Origine`, `treg`, `sauvpdf`, `nblfac`, `pdfchemin`, `ligneart`,
  `lignecom` (aucun usage hors du fichier, ni dans `ObjFacB` ; vérifié par `grep` sur les variables
  typées `ObjFacB`).
- Suppression (code mort) : `Orig2FactType`, `poids`, `mdepo`, `cheque`, `intcheque`,
  `cptcheque`, `intcarte`, `cptcarte`, `intaut`, `cptaut`, `joinsms`, `nomfm`, `$resfam`,
  `$restva`, `$facav`.
- **Doivent rester `Public`** malgré `deps.py` : `calcul`, `verifdat` (appelés par `Super.` depuis
  `ObjFacB` : un membre `Private` du parent n'est pas visible de la sous-classe), et tous les
  membres listés dans le tableau d'usage.

### Séparation traitement / GUI

- `verifdat` : séparer les contrôles (fonction renvoyant un code ou un message) des
  `Message.Warning`, et l'`UPDATE` des dates de mouvement.
- `testchem` : `ControleChemins() As String` (message vide si OK) + affichage dans l'appelant.
- `ecriturecompt` : remonter le message « Document en attente de moulinage » à l'appelant.
- `CopieGedFac` : l'impression (`edit.Print`) reste GUI ; la partie GED devient
  `ArchiveGed(fichier)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les montants de lignes sont manipulés en chaînes (`Ledit`) et stockés en `char`/`double` mixtes
  (`mtx_ligfac char(5)`, `pu_ligbl`…) : un passage en `DECIMAL` uniforme supprimerait les
  conversions `Utils.cpoint`/`Val`.
- Les tables `…M` (entretien) dupliquent `Fiches_Bl`/`Fiches_Ligbl`/historique : une colonne
  `entretien` éviterait le suffixe `tab` concaténé dans le SQL.
- La table de travail `Bl` (sans clé `Cbase`, recréée par 4 écrans avec des structures
  différentes) gagnerait à devenir une table temporaire de session (`CREATE TEMPORARY TABLE`)
  ou une sélection persistante par poste.
