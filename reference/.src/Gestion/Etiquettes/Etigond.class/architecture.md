# Etigond — Architecture

> Source : `.src/Gestion/Etiquettes/Etigond.class`

## Vue d'ensemble

Écran d'impression des **étiquettes de gondole** (code, intitulé, références fournisseur
optionnelles, EAN13, taux de TVA, prix au kilo/litre, cadre avec PV HT et/ou PV TTC). Ouverture :
`Fmenu.Menu158_Click` et `Menu162_Click` (`New Etigond("")`, modal), et `Articles.Btn_click`
(`Tag` 7, « 2- Gondole », `New Etigond(Code.text)`).

C'est une variante de [`Etiqart`](../Etiqart.class/architecture.md) (750 lignes communes, ratio
0,85, `dup.py`) : mêmes bornes article/famille/fournisseur, mêmes listes, même mode liste (table de
travail `Etiquettes`, ici **temporaire**), même import portable, même branche Zebra morte. Les
différences portent sur :
- le chargement du format dans `Init` (code **et** page), avec saut des positions `Posetiq` et
  drapeau `Nb` ;
- `Imprime(nb)`, qui choisit la mise en page d'après le **libellé** du modèle : « Gondole » (ou
  Dymo) ou « Article » ; tout autre libellé en A4 ne produit aucune étiquette ;
- la lecture du taux de TVA (`Fiches_Tvaav`) et le prix au kilo/litre (`RadioButton5` HT,
  `RadioButton6` TTC, présélection par `/Soc<XX>/Kgl`) ;
- les cases `CheckBox1..4` (PV HT, PV TTC, référence fournisseur `art_cfour`, code fournisseur
  `art_four`) ;
- `pos_Etiq` variante **V2** (A4 + branche Dymo), identique à `EtiqRecpt.pos_Etiq` ; pas de
  `pos_Etiq2`.

Sortie : `~/tmp/EtiqGond.pdf` (même nom que `EtiqPromo` et `Etiqfbtarif`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rarts` | var | Private |  | Result | 28 |
| `rarts2` | var | Private |  | Result | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `Tab3` | var | Private |  | String | 31 |
| `code` | var | Private |  | String | 32 |
| `son` | var | Private |  | Integer | 33 |
| `Nbetiq` | var | Private |  | Integer | 34 |
| `txtPosX` | var | Private |  | Integer | 35 |
| `txtPosY` | var | Private |  | Integer | 36 |
| `SorP` | var | Private |  | Boolean | 37 |
| `CoulZns` | var | Private |  | Integer | 38 |
| `CoulZnaf` | var | Private |  | Integer | 39 |
| `CoulFc` | var | Private |  | Integer | 40 |
| `i2` | var | Private |  | Integer | 41 |
| `Nbre` | var | Private |  | Integer | 42 |
| `Rect` | var | Private |  | String | 43 |
| `intitule` | var | Private |  | String | 44 |
| `intitule2` | var | Private |  | String | 45 |
| `Nblargeur` | var | Private |  | String | 46 |
| `Nbhauteur` | var | Private |  | String | 47 |
| `Largeur` | var | Private |  | Float | 48 |
| `Hauteur` | var | Private |  | Float | 49 |
| `Mrghaut` | var | Private |  | Float | 50 |
| `Mrgauche` | var | Private |  | Float | 51 |
| `Esplargeur` | var | Private |  | Float | 52 |
| `Esphauteur` | var | Private |  | Float | 53 |
| `Filename` | var | Private |  | String | 54 |
| `Nb` | var | Private |  | Boolean | 55 |
| `Bsel` | var | Public |  | Boolean | 57 |
| `Bval` | var | Public |  | String | 58 |
| `Origine` | var | Private |  | String | 60 |
| `b` | var | Private |  | Integer | 61 |
| `pdf` | var | Private |  | Cetiquettes | 62 |
| `IpZebra` | var | Private |  | String | 63 |
| `ConnZbr` | var | Private |  | Boolean | 64 |
| `MySock` | var | Private |  | Socket | 65 |
| `cd` | var | Private |  | String | 66 |
| `nombretiq` | var | Private |  | Integer | 67 |
| `Page` | var | Private |  | String | 68 |
| `PageA` | var | Private |  | String[] | 69 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 71-83 | Public | 1 | 11 | 0 | méthode spéciale |
| `form_Open` | 85-120 | Public | 6 | 32 | 0 | handler GUI |
| `init_ComboBox` | 122-138 | Public | 5 | 14 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 143-148 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 150-155 | Public | 1 | 4 | 0 | handler GUI |
| `SelectionArt` | 158-183 | Public | 5 | 23 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 188-219 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam_KeyPress` | 224-244 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 249-280 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam2_KeyPress` | 285-305 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton5_Click` | 310-341 | Public | 5 | 29 | 0 | handler GUI |
| `Colfour_KeyPress` | 346-366 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton6_Click` | 371-402 | Public | 5 | 29 | 0 | handler GUI |
| `Colfour2_KeyPress` | 407-427 | Public | 6 | 17 | 0 | handler GUI |
| `Colfam_Click` | 432-440 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 445-453 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 458-466 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 471-478 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 480-506 | Public | 8 | 20 | 0 | handler GUI |
| `Btn_KeyPress` | 508-515 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 517-604 | Public | 23 | 76 | 0 | handler GUI |
| `liste_Click` | 606-633 | Public | 2 | 25 | 0 | handler GUI |
| `EtiqStk_Click` | 635-645 | Public | 2 | 9 | 0 | handler GUI |
| `Art_man` | 650-700 | Public | 11 | 47 | 0 | portée réductible ? |
| `Art1_man` | 702-717 | Public | 3 | 14 | 0 | portée réductible ? |
| `Art2_man` | 719-738 | Public | 4 | 18 | 0 | portée réductible ? |
| `ChkInput` | 740-748 | Public | 7 | 7 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 753-759 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 761-848 | Public | 19 | 81 | 0 | portée réductible ? |
| `fin_impression` | 850-862 | Public | 2 | 11 | 0 | portée réductible ? |
| `Imprime` | 865-995 | Public | 51 | 121 | 0 | portée réductible ? |
| `pos_Etiq` | 997-1029 | Public | 6 | 31 | 0 | portée réductible ? |
| `Connect` | 1031-1050 | Public | 6 | 17 | 0 | portée réductible ? |
| `Import_Portable` | 1055-1068 | Public | 3 | 12 | 0 | portée réductible ? |
| `Init` | 1070-1101 | Public | 6 | 29 | 0 | portée réductible ? |
| `Button1_Click` | 1103-1107 | Public | 1 | 3 | 0 | handler GUI |
| `Gridbart_Update` | 1109-1129 | Public | 4 | 18 | 0 | portée réductible ? |
| `Gridbart_Click` | 1131-1153 | Public | 5 | 19 | 0 | handler GUI |
| `CheckBox1_Click` | 1155-1163 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions **identiques ou quasi identiques** à `Etiqart` sont décrites dans
[Etiqart › Description des fonctions](../Etiqart.class/architecture.md#description-des-fonctions) ;
seules les différences sont indiquées ici.

### Communes avec Etiqart (même comportement)

- `_new` [portée : nécessaire], `init_ComboBox` [réductible ; libellé `" (" & page & ")"`],
  `ToggleButton1_Click`/`ToggleButton2_Click` [handlers], `SelectionArt` [réductible ; `TriArticles`
  écrit `Bsel`/`Bval`], `ToggleButton3..6_Click`, `Colfam*_KeyPress`, `Colfour*_KeyPress`,
  `Colfam*_Click`, `Colfour*_Click` [handlers ; `Col*_Click` rejoués par `Object.Call`],
  `Btn_Click` [handler ; supprime `~/tmp/EtiqGond.ps`, jamais produit], `Btn_KeyPress`,
  `EtiqStk_Click`, `Art2_man` [réductible], `Cmpt_GotFocus`, `Button1_Click` [handler ;
  ⚠️ ouvre l'aide **`Etiqart`**], `Gridbart_Update` [réductible ; sans test `Tables.Exist`],
  `Gridbart_Click` [handler, rejeu], `Import_Portable` [réductible ; même défaut que ETIQART-A02 :
  l'éditeur reçoit `EtiqGond.pdf`].
- **`Art1_man()`** — **code mort** (`unused`, grep).
- **`Connect()`** — **code mort** (`unused`) ; seule source de `ConnZbr = True` (ZEBRA-A01).

### Différences

- **`form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. Comme `Etiqart.Form_Open`
  (deux `Utils.Observers(Me)`, l. 98 et 102) ; coche en plus `RadioButton6` si `/Soc<XX>/Kgl`.
- **`Cmpt_KeyPress()`** (CC 23) [handler]. F2 ouvre aussi la liste de la borne haute (`Tag` 2).
- **`ChkInput()`** [réductible]. Autorise en plus la touche Tab.
- **`liste_Click()`** [handler] [nature : mixte]. `CREATE temporary TABLE Etiquettes …` (table
  propre à la connexion), variable locale `Tab`.
- **`Art_man()`** [réductible] [nature : mixte]. Comme Etiqart mais **sans** le contrôle
  `art_etiq` (commenté) : tout article existant peut être ajouté ; `Gridbart_Update` n'est appelé
  qu'en mode liste.
- **`Init()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Etiquettes WHERE code
  = &1 and page = &2` (page par `Scan`), dimensions ÷ 10, `PageA` ; si `Posetiq > 1` : `Posetiq - 1`
  fois `Inc Nbetiq` + `pos_Etiq` et `Nb = True` ; `rect` selon `Nblargeur` (membre jamais lu).
  ⚠️ Appelée **avant** la création du PDF : en Dymo, `pos_Etiq` fait `pdf.NewPage()` dès la 2e
  position sautée → « Null object » à la première impression (ETIGOND-A02).
- **`Button2_Click()`** (CC 19) [portée : réductible] [nature : mixte]. `Kill` du PDF, `Init`, PDF A4
  (format de la page) ou Dymo (`dymog`, 88 × 35 forcé) ; **aucun PDF en Zebra** (« Null object »,
  ETIGOND-A01). Requêtes de sélection identiques à Etiqart (le tri casier est `Radiobutton7`). Mode
  liste : `SELECT * FROM Etiquettes` **sans** test `Available` (liste vide → PDF vide). Remet
  `txtPosX`/`txtPosY` à 0 en fin de traitement, mais pas le membre `Nb`.
- **`Imprime(nb)`** (CC 51, max du lot) [portée : réductible] [nature : mixte]. Lit l'article,
  `SELECT * FROM TabTvav WHERE code_tva = &1` **sans** test `Available` (code TVA absent → erreur),
  formate les prix, calcule `volm = prix / art_poids` (HT ou TTC). Nombre : liste, saisie, ou stock
  si `EtiqStk` (stock < 1 ou article non stocké → aucune étiquette, différent d'Etiqart). Puis :
  - mise en page **gondole** si (A4 et libellé contenant « Gondole ») ou Dymo : code, intitulé,
    références fournisseur (`CheckBox3/4`) ou 2e intitulé, EAN13, TVA, prix au kg/l, cadre, PV HT
    (`CheckBox1`), PV TTC (`CheckBox2`) ;
  - mise en page **article** si A4 et libellé contenant « Article » : intitulé large, TVA, poids et
    prix au kg/l, PV TTC grand corps, EAN13, références fournisseur ;
  - sinon : rien (ETIGOND-A03).
  Positionnement : si `nb` faux, `pos_Etiq` **avant** d'imprimer ; si vrai, **après** (le paramètre
  local repasse à faux à la dernière étiquette de l'article, mais le membre `Nb` reste vrai).
  Branche Zebra morte (choix HT/TTC selon `CheckBox1`).
- **`pos_Etiq()`** [réductible] [nature : calcul]. Variante V2 (voir le tableau d'Etiqart).
- **`fin_impression()`** [réductible]. Comme Etiqart (vide la liste via `liste_Click`).
- **`CheckBox1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Libellé de la case
  « Impression du PV HT » / « Impression du Taux de TVA » ; la TVA est pourtant imprimée dans tous
  les cas.

## État global utilisé

- Comme Etiqart, plus `/Soc<XX>/Kgl` et `Cbase.Table("TabTvav")`.
- Fichiers : `~/tmp/EtiqGond.pdf`, `~/tmp/EtiqGond.ps` (supprimé, jamais créé), `~/tmp/ImpT.txt`,
  `~/Portable/inventaire.txt`.
- Membres : `Nb` (persiste entre deux impressions), `Tab2` (vaut `"Fiches_Tvaav"` sans être
  utilisé pour une requête), `Tab3` (`"Etiquettes"`), `rect` (jamais lu), `nombretiq`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Imprime` (CC 51) : une procédure par mise en page (`DessineGondole`, `DessineArticle`) et une
  fonction de lecture de l'article ; choix de la mise en page calculé une fois par impression.
- Supprimer `Art1_man`, `rect`, `Tab2 = "Fiches_Tvaav"`, `SorP`, `dte`, couleurs jamais lues,
  `Shell "cd ~"`, second `Utils.Observers`.

### Commonalisation avec d'autres fichiers

- Module `EtiqArticles` et socle `PlancheEtiquettes` : voir
  [Etiqart › Commonalisation](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers)
  (variante V2 de `pos_Etiq`, identique à [`EtiqRecpt`](../EtiqRecpt.class/architecture.md)).
- La mise en page « gondole » est reproduite dans [`EtiqRecpt`](../EtiqRecpt.class/architecture.md)
  (branche `Etigond`, sans prix au kg ni références fournisseur) et, en version ancienne, dans
  [`EtiqPromo`](../EtiqPromo.class/architecture.md) et
  [`Etiqfbtarif`](../Etiqfbtarif.class/architecture.md) : une procédure
  `PlancheEtiquettes.DessineGondole(valeurs, options)` éviterait le commentaire « il faudrait
  plutôt s'appuyer sur les classes Etiqart/Etigond/Eticasier » d'EtiqRecpt, mais les coordonnées
  diffèrent : PDF identique à prouver fichier par fichier.
- Lecture du taux de TVA (`TabTvav` par `code_tva`) : idem `EtiqRecpt`, `Etiqfbtarif.rTva`.

### Réduction de portée

- `init_ComboBox`, `SelectionArt`, `Art_man`, `Art2_man`, `ChkInput`, `Button2_Click`,
  `fin_impression`, `Imprime`, `pos_Etiq`, `Import_Portable`, `Init`, `Gridbart_Update` →
  `Private` (grep : aucun appelant externe). `Bsel`/`Bval` restent `Public` (TriArticles).

### Séparation traitement / GUI

- Comme Etiqart ; en plus, `ValeursEtiquette(rArt) As Collection` (prix formatés, TVA, prix au
  kg/l) sans contrôle, testable en gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Type de mise en page (gondole / article) à stocker dans `Fiches_Etiquettes` au lieu de le
  déduire du libellé.
- Voir aussi Etiqart (table de travail déclarée, dimensions Dymo).
