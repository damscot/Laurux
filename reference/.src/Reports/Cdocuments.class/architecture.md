# Cdocuments — Architecture

> Source : `.src/Reports/Cdocuments.class`

## Vue d'ensemble

`Cdocuments` est une **bibliothèque de gabarits PDF** pour les documents commerciaux et quelques
listes de gestion. Elle hérite de [`PdfWriter`](../PdfWriter.class/architecture.md) (portage Gambas
de FPDF) et n'ajoute que des méthodes de dessin : chacune positionne le curseur (`SetXY`), choisit
une police (`SetFont`), puis écrit des cellules (`Cell`, `MultiCell`) ou des traits (`Line`).
Aucune méthode ne lit la base : toutes les valeurs arrivent déjà formatées en `String` depuis
l'appelant, qui gère lui-même la position verticale (`PosY`) et les sauts de page (seuils
propres à chaque appelant, voir [dependencies.md](dependencies.md)).

Construction : `New Cdocuments("Portrait", "mm", "A4")`. Gambas transmet ces trois arguments à
`PdfWriter._new` (orientation `p/portrait/l/landscape`, unité, format), puis appelle
`Cdocuments._new()` sans argument, qui copie les couleurs du thème (`Start.R/G/B`, `Start.R2/G2/B2`,
cette seconde couleur retombant sur la première si `R2 = 0`). La séquence d'usage est toujours
`Open()`, `AliasNbPages()` (remplacement de `{nb}`), méthodes de dessin, `Output(fichier, False)`.
Les en-têtes et pieds automatiques de `PdfWriter` (`Header`/`Footer`) ne sont **pas** appelés par
`AddPage` (appels commentés dans `PdfWriter`) ; le saut de page automatique de `Cell` reste actif,
au seuil `$h - marge + 18` (295 mm en A4 portrait, 208 mm en paysage, `PdfWriter.SetAutoPageBreak`).

Le fichier est organisé en **familles de méthodes par document**, nommées `Level<n><suffixe>` :

| Famille | Document | Appelant réel (atteignable) |
|---|---|---|
| `Entete`, `Entete2`, `Logo`, `Logo3` | en-tête société + destinataire (format lettre) | `Edcom`, `RelvMo` (et `Facturergbl`, inatteignable) |
| `Level1` … `Level4` | commande fournisseur | `Edcom` |
| `Level1R` … `Level4R` | relevé des prestations (MO) | `RelvMo` |
| `Level1F` … `Level13F`, `Colonnes` | facture (ancienne édition PDF) | `Facturergbl` seulement, code **inatteignable** (FACTURERGBL-A01) ; `Level7F`, `Level9F`, `Level10F`, `Level11F` aussi par `Edbr` |
| `EnteteN`, `Level1br` … `Level3br`, `BasPage` | bon de réception fournisseur | `Edbr` |
| `EnteteP`, `Level1D`, `Level2D`, `Level2DLG`, `Level2DLG2`, `Level4D`, `LinesLG`, `LinesP`, `BasPageP` | liste des documents (paysage) | `EdDocs`, `EdPrep` |
| `Level1FAM`, `Level2FAM`, `Lines` | liste des familles | `EdFam` |
| `Level2RL`, `Level4RL`, `Level5RL` | historique ventes client/MO/produit | `RelMoprod` |
| `EnteteV`, `Level4V`, `Entete3`, `Logo2`, `Level1bis`, `Level3bis`, `Level4RB`, `Level1LV`, `Level1DP`, `Level2FAC`, `Level2Fa`, `Level3FAC`, `Level10F2`, `Level10F3`, `LevelM`, `Level2M`, `Level14F`, `Level15F`, `Level16F`, `EnteteD`, `Level1RL`, `Signature`, `SignatureD` | variantes devis/atelier/conditionnement/coupon… | **aucun** (code mort) |

Historique : les factures, BL, devis et commandes clients sont édités depuis 2019 par le report
[`Editfac`](../Editfac.class/architecture.md) (commit `a2e027f1`, « Factorisation des éditions de
facture ») ; la famille `*F` n'est plus appelée que par le code mort de `Facturergbl`.
[`Cdocuments2`](../Cdocuments2.class/architecture.md) est une copie « deux exemplaires en paysage »
du même fichier (ratio de similarité 0,55, 25 fonctions identiques), jamais instanciée ;
[`Cdocuments3`](../Cdocuments3.class/architecture.md) est un gabarit distinct (bon de
préparation, ratio 0,08) qui partage `_new` et `BasPage` à l'identique.

Nature globale : **GUI (dessin PDF)**, sans SQL. Toutes les méthodes sont `Public` (72 sur 72).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
| `R2` | var | Private |  | Integer | 6 |
| `G2` | var | Private |  | Integer | 7 |
| `B2` | var | Private |  | Integer | 8 |
| `Coln` | var | Private |  | Boolean | 9 |
<!-- /AUTO:declarations -->

Variables d'instance sans mot-clé (donc `Private`) : `R`, `G`, `B` (couleur de fond des
en-têtes), `R2`, `G2`, `B2` (couleur des colonnes), `Coln` (bandes de couleur alternées dans les
lignes de facture, fixé par le paramètre `Col` d'`Entete` ; tous les appelants passent `False`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 12-26 | Public | 2 | 13 | 0 | méthode spéciale |
| `EnteteN` | 33-41 | Public | 1 | 7 | 3 |  |
| `EnteteP` | 44-52 | Public | 1 | 7 | 2 |  |
| `EnteteV` | 54-58 | Public | 1 | 3 | 0 | portée réductible ? |
| `Level4V` | 61-67 | Public | 1 | 5 | 0 | portée réductible ? |
| `Lines` | 70-76 | Public | 1 | 5 | 2 |  |
| `LinesLG` | 79-85 | Public | 1 | 5 | 2 |  |
| `LinesP` | 88-94 | Public | 1 | 5 | 2 |  |
| `Entete` | 96-196 | Public | 23 | 97 | 3 |  |
| `Entete2` | 199-229 | Public | 3 | 28 | 3 |  |
| `Entete3` | 232-266 | Public | 5 | 32 | 0 | portée réductible ? |
| `Logo3` | 268-281 | Public | 7 | 11 | 0 | portée réductible ? |
| `Logo2` | 283-296 | Public | 5 | 11 | 0 | portée réductible ? |
| `Logo` | 298-319 | Public | 9 | 19 | 0 | portée réductible ? |
| `Level1` | 322-332 | Public | 1 | 9 | 1 |  |
| `Level1bis` | 335-341 | Public | 2 | 5 | 0 | portée réductible ? |
| `Level2` | 344-359 | Public | 2 | 14 | 1 |  |
| `Level3` | 362-386 | Public | 4 | 23 | 1 |  |
| `Level3bis` | 388-394 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level1R` | 397-404 | Public | 1 | 6 | 1 |  |
| `Level2R` | 407-417 | Public | 1 | 9 | 1 |  |
| `Level3R` | 420-429 | Public | 1 | 8 | 1 |  |
| `Level4R` | 432-438 | Public | 1 | 5 | 1 |  |
| `Level4RB` | 441-447 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level4` | 450-458 | Public | 1 | 7 | 1 |  |
| `Level4D` | 461-469 | Public | 1 | 7 | 1 |  |
| `Level1F` | 472-485 | Public | 1 | 12 | 1 |  |
| `Level1LV` | 488-495 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level1DP` | 498-504 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level2F` | 507-562 | Public | 18 | 54 | 1 |  |
| `Level2FAC` | 565-623 | Public | 18 | 57 | 0 | portée réductible ? |
| `Level2Fa` | 626-635 | Public | 1 | 8 | 0 | portée réductible ? |
| `Level3F` | 638-663 | Public | 7 | 24 | 1 |  |
| `Level3FAC` | 666-692 | Public | 7 | 25 | 0 | portée réductible ? |
| `Colonnes` | 694-721 | Public | 2 | 26 | 0 | portée réductible ? |
| `Level4F` | 724-731 | Public | 2 | 6 | 1 |  |
| `Level4aF` | 734-741 | Public | 2 | 6 | 1 |  |
| `Level4bF` | 744-750 | Public | 1 | 5 | 1 |  |
| `Level5F` | 753-761 | Public | 1 | 6 | 1 |  |
| `Level6F` | 764-787 | Public | 4 | 21 | 1 |  |
| `Level7F` | 790-812 | Public | 6 | 21 | 2 |  |
| `Level8F` | 815-824 | Public | 2 | 7 | 1 |  |
| `Level9F` | 827-836 | Public | 1 | 8 | 2 |  |
| `Level10F` | 839-886 | Public | 16 | 43 | 2 |  |
| `Level10F2` | 889-901 | Public | 2 | 10 | 0 | portée réductible ? |
| `Level10F3` | 903-909 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level11F` | 912-918 | Public | 1 | 5 | 2 |  |
| `Level12F` | 921-928 | Public | 1 | 6 | 1 |  |
| `Level13F` | 931-943 | Public | 5 | 11 | 1 |  |
| `LevelM` | 946-970 | Public | 2 | 22 | 0 | portée réductible ? |
| `Level2M` | 973-979 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level14F` | 982-992 | Public | 1 | 9 | 0 | portée réductible ? |
| `Signature` | 995-1006 | Public | 4 | 9 | 0 | portée réductible ? |
| `Level15F` | 1009-1028 | Public | 1 | 18 | 0 | portée réductible ? |
| `Level16F` | 1031-1040 | Public | 1 | 7 | 0 | portée réductible ? |
| `SignatureD` | 1043-1054 | Public | 4 | 9 | 0 | portée réductible ? |
| `Level1br` | 1058-1092 | Public | 1 | 32 | 1 |  |
| `Level2br` | 1096-1111 | Public | 1 | 12 | 1 |  |
| `Level3br` | 1114-1120 | Public | 1 | 5 | 1 |  |
| `EnteteD` | 1123-1131 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level1D` | 1134-1158 | Public | 1 | 23 | 2 |  |
| `Level2D` | 1161-1180 | Public | 3 | 17 | 2 |  |
| `Level2DLG` | 1183-1191 | Public | 1 | 7 | 2 |  |
| `Level2DLG2` | 1194-1199 | Public | 1 | 4 | 2 |  |
| `BasPage` | 1202-1208 | Public | 1 | 5 | 3 |  |
| `BasPageP` | 1211-1217 | Public | 1 | 5 | 2 |  |
| `Level1FAM` | 1220-1233 | Public | 1 | 12 | 1 |  |
| `Level2FAM` | 1236-1249 | Public | 1 | 12 | 1 |  |
| `Level1RL` | 1253-1260 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level2RL` | 1263-1277 | Public | 2 | 13 | 1 |  |
| `Level4RL` | 1280-1287 | Public | 1 | 6 | 1 |  |
| `Level5RL` | 1290-1296 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Sauf mention contraire, chaque méthode est [nature : GUI] (dessin PDF pur, sans effet de bord
hors du document en cours) et n'émet aucun SQL. « Nécessaire » signifie : appelée hors du fichier
(liste des appelants dans [dependencies.md](dependencies.md)).

### Construction

- **`_new()`** [portée : nécessaire (spéciale)] [nature : calcul] : copie `Start.R/G/B` et
  `Start.R2/G2/B2` ; si `R2 = 0`, reprend `R/G/B` (le test ne porte que sur la composante rouge :
  une seconde couleur `0,x,y` est remplacée). Code **identique** à `Cdocuments3._new`. Le
  `_free` est commenté.

### En-têtes de page

- **`EnteteN(ent)`** [portée : nécessaire] : `AddPage`, bandeau titre de 206 mm (portrait) sur
  fond `R,G,B`. Identique à `Cdocuments2`, [`Creleve`](../Creleve.class/architecture.md) et
  `Ctraites` (`EnteteN`).
- **`EnteteP(ent)`** [portée : nécessaire] : idem en paysage (288 mm).
- **`EnteteV()`** [portée : réductible, code mort] : `AddPage` seul. Aucun appelant.
- **`EnteteD(ent)`** [portée : réductible, code mort] : copie d'`EnteteP` avec une largeur de
  206 mm. Aucun appelant.
- **`Entete(rs, adr11, adr22, ville, cap, rcs, siret, ape, Tvaintra, tel, portable, fax, mail,
  site, Visudoc, Pays, Iban, Col, Libre)`** (CC 23, maximum du fichier) [portée : nécessaire] :
  **19 paramètres positionnels obligatoires**, aucun `Optional`. Mémorise `Col` dans `Coln`,
  `AddPage`, trace le cadre société (6-100 × 6-90 mm), puis :
  - logos : si `Variables.EnvoiMail = ""`, `Logo()` si `/Soc<XX>/glogo`, `Logo3()` si `glogo3` ;
    si `EnvoiMail = "Mail"`, mêmes appels selon `glogo5`/`glogo6`. `Variables.EnvoiMail` n'est
    **jamais affectée** dans le projet : seule la première branche est vivante (voir
    [VARIABLES-003 / VARIABLES-A02](../../Utils/Variables.module/rework.md)) ;
  - adresse société (ligne 118) : imprimée si le logo pleine largeur `glogo3` n'est pas actif.
    Ordre : `rs` (gras 12), `Libre`, `adr11`, `adr22`, `ville` (gras 10), puis chaque ligne non
    nulle parmi `cap`, `rcs`, `siret`, `ape`, `tvaintra`, `tel`, `portable`, `fax`, **`site` puis
    `mail`**, `iban` (italique 8), avec un pas de 5 mm. Les libellés (« Capital : », « APE : »…)
    sont préparés par l'appelant, de façon différente selon les appelants (« Naf : » dans
    `RelvMo`, libellé SIRET paramétrable dans `Facturergbl`).
  - `Visudoc` et `Pays` sont **inutilisés**. Le `SetXY(6, PosY)` de la ligne 124 est sans effet
    (écrasé deux lignes plus loin).
  - Précédence vérifiée avec `gbs3` : `A And B Or If C And D` vaut `(A And B) Or (C And D)`.
  ⚠️ **Arité** : `RelvMo:427` l'appelle avec 18 arguments (sans `Libre`) au saut de page → erreur
  « Not enough arguments » (RELVMO-A01, CDOCUMENTS-A01). La signature à 19 paramètres est un
  défaut de conception : voir « Réarchitecture » plus bas.
- **`Entete2(rs2, adr1, adr2, ville, Pays, Col, entete)`** [portée : nécessaire] : bloc
  destinataire à x = 114 mm, y = 50 mm ; si `entete`, `AddPage` **et** cadre. `Col` inutilisé.
  Raison sociale tronquée à 40 caractères.
- **`Entete3(rs2, adr1, adr2, ville, Pays, Tel, Portable, Col, entete)`** [portée : réductible,
  code mort] : `Entete2` + téléphone/GSM (« bon atelier »). Aucun appelant (les
  `pdf.Entete3` de `Caisse.class:5251/5253` visent `Cfacture`).

### Logos et signatures

- **`Logo()`** [portée : réductible, usage interne par `Entete`] : charge
  `/Soc<XX>/Logo` (`Image.Load` sous `Try`) et le place à `X + L / L2`, `Y + h / hauteur`, avec
  une taille en mm égale aux pixels / 5. `L2 = largeur / 10` est entier : pour une image de moins
  de 10 pixels de large, `L2 = 0` et `L / L2` lève « Division by zero » **hors `Try`**
  (vérifié avec `gbs3`) → génération interrompue (CDOCUMENTS-A02). La condition
  `Or If Variables.EnvoiMail = "Mail"` est morte.
- **`Logo3()`** [portée : réductible, usage interne par `Entete`] : logo pleine largeur
  `/Soc<XX>/Logo2` (100 × 88 mm) si `glogo3`.
- **`Logo2()`** [portée : réductible, code mort] : variante 40 × 40 mm, aucun appelant
  (les `Logo2` de `Prefs` sont des contrôles).
- **`Signature()`**, **`SignatureD()`** [portée : réductible, code mort par transitivité] :
  image `Icones/signature.jpg` ; appelées seulement par `Level14F`/`Level16F`, eux-mêmes morts.
  Le `Try` porte sur une affectation de constante et ne protège rien.

### Commande fournisseur (`Edcom`)

- **`Level1(Jour, codef)`** [portée : nécessaire] : ligne 92 mm, numéro/date, code fournisseur,
  « Page n/{nb} ».
- **`Level2(Chiffree)`** [portée : nécessaire] : en-tête de colonnes (Code, Intitulé, Quantité,
  et si chiffré PB HT, Remise, PA HT, PA total).
- **`Level3(code, intitule, qte, pbht, rem, paht, patot, cbarre, barcode, PosY)`**
  [portée : nécessaire] : ligne de détail ; si `cbarre` et code-barres, `EAN13` à la place du
  code. `Edcom` passe toujours `cbarre = False`.
- **`Level4(patot, PosY)`** [portée : nécessaire] : total commande. Identique à `Level4D` au
  libellé près.
- **`Level1bis(Code)`**, **`Level3bis(intitule2, PosY)`** [portée : réductible, code mort].

### Relevé des prestations (`RelvMo`)

- **`Level1R(Jour)`**, **`Level2R()`**, **`Level3R(code, lib, qte, mt, posy)`**,
  **`Level4R(Txt)`** [portée : nécessaire] : date et page, en-tête de colonnes MO, ligne,
  texte de période.
- **`Level4RB(Txt, PosY)`** [portée : réductible, code mort].

### Facture (famille `*F`)

Appelée uniquement par `Facturergbl.Button14_Click`/`Calc_tva` (inatteignables, voir
[FACTURERGBL-A01](../../Gestion/Facturation/Facturergbl.class/rework.md)), sauf `Level7F`,
`Level9F`, `Level10F`, `Level11F` aussi utilisées par `Edbr` (bon de réception).

- **`Level1F(Jour, Cde, Page, IdTva)`** [portée : nécessaire] : date, n° de document, page,
  n° de TVA client. `Page` inutilisé.
- **`Level1LV()`**, **`Level1DP(Depot)`** [portée : réductible, code mort] : « A livrer »,
  référence dépôt.
- **`Level2F(Coulfond, Impttc, PosY)`** (CC 18) [portée : nécessaire] [nature : mixte : lecture
  de `Start.LocalSettings` `/AutoEnt`, `/Franchise` et de `Variables.bRemise`/`bImpref`] :
  en-tête des colonnes ; libellés TTC, HT ou neutres. `Coulfond` inutilisé. La condition TTC
  `Impttc And Not AutoEnt Or If Impttc And Not Franchise` imprime « PU TTC » quand un seul des
  deux régimes sans TVA est actif, alors que `Level3F` vide la colonne de taux ; la colonne
  « Tx » fait 9 mm au lieu de 8 dans ce cas (décalage de 1 mm). Sans effet aujourd'hui : seul
  l'appelant mort `Facturergbl` l'utilise.
- **`Level2FAC`**, **`Level2Fa`**, **`Level3FAC`** [portée : réductible, code mort] : variantes
  « avec conditionnement » et simplifiée.
- **`Level3F(code, intitule, Pu, qte, Brut, Rem, Total, Txtva, PosY)`** [portée : nécessaire]
  [nature : mixte, mêmes lectures que `Level2F` + `Variables.TypeL`/`Qte`] : ligne de détail ;
  bandes de couleur via `Colonnes` si `Coln`. La branche `Variables.TypeL = "B"` est morte
  (`TypeL` jamais affectée, VARIABLES-003).
- **`Colonnes(PosY)`** [portée : réductible, usage interne] : fond alterné `R2,G2,B2` /
  `R2-10…` (valeurs négatives possibles si une composante < 10). Atteinte seulement si
  `Coln = True`, ce qu'aucun appelant ne demande.
- **`Level4F`**, **`Level4aF`** (identiques au style de police près), **`Level4bF`**,
  **`Level5F`**, **`Level8F`**, **`Level12F`**, **`Level13F`** [portée : nécessaire] : lignes
  d'écotaxe, de commentaire, d'intitulé du bon, récapitulatif écotaxe, composants, report, acompte
  (type `F/D/B/C` traduit en libellé).
- **`Level6F(Tmo, Tart, Trem, Txtbf, frais, PosY)`** [portée : nécessaire] : récapitulatif de bas
  de facture (texte libre en `MultiCell`, totaux MO/articles/remise, frais de gestion si
  `Val(frais) <> 0`). ⚠️ Seul appelant : `Facturergbl:948/953/960` avec **5 arguments pour 6**
  (`frais` absent), dans du code inatteignable (FACTURERGBL-A01, CDOCUMENTS-A01).
- **`Level7F(Coulfond, PosY, ImpAuto, Franchise, exo)`** [portée : nécessaire] : en-tête du
  tableau de TVA (vide si régime sans TVA). `Coulfond` inutilisé ; `Edbr` passe `""` pour les
  trois booléens (convertis en `False`).
- **`Level9F(Ctx, Mht, Ttx, Mtva, Mttc, PosY)`** [portée : nécessaire] : ligne de TVA ; `Mttc`
  inutilisé (4 colonnes imprimées).
- **`Level10F(Totht, Mtva2, Toteuros, Txtleg, PosY, ImpAuto, Exo, Franchise)`** (CC 16)
  [portée : nécessaire] [nature : mixte, lecture `/AutoEnt`] : mentions légales
  auto-entrepreneur (art. 293 B du CGI, dispense d'immatriculation), totaux HT/TVA/TTC ou « Net à
  payer », texte légal. `Txtexo` vaut `""` (mention d'exonération commentée). `posy = posy` sans
  effet.
- **`Level10F2`**, **`Level10F3`** [portée : réductible, code mort] : seconde ligne de règlement,
  « Facture acquittée ».
- **`Level11F(Txtleg2, PosY)`** [portée : nécessaire] : texte légal en `MultiCell` de 280 mm
  (déborde de la page portrait de 210 mm).
- **`LevelM`**, **`Level2M`**, **`Level14F`**, **`Level15F`**, **`Level16F`** [portée :
  réductible, code mort] : matériel, intervention, bas de fiche atelier, coupon détachable, bas de
  devis (ces présentations sont reprises par `Editfac`).

### Bon de réception fournisseur (`Edbr`)

- **`Level1br(codef, intitulef, Nblf, datercp, adr1, adr2, cp, tel)`**, **`Level2br(…, casier,
  PosY)`**, **`Level3br(total, Posy)`** [portée : nécessaire] : en-tête fournisseur + colonnes,
  ligne, total.

### Listes de documents (`EdDocs`, `EdPrep`, paysage)

- **`Level1D(Posy)`** [portée : nécessaire] : en-tête sur deux lignes (288 mm).
- **`Level2D(Type2, intitule2, Adr12, Adr22, Burdis2, Dte2, Numero, Tot, Posy, TypeD, detail,
  livrer)`** [portée : nécessaire] : 12 paramètres ; fond gris si `detail` ; « X » si `livrer`.
  `TypeD` inutilisé ; champs tronqués à 30 caractères.
- **`Level2DLG`**, **`Level2DLG2`**, **`Level4D`** [portée : nécessaire] : lignes d'articles,
  ligne de commentaire, total général.
- **`Lines(PosY)`**, **`LinesLG(PosY)`**, **`LinesP(PosY)`** [portée : nécessaire] : trait
  horizontal de 210 ou 302 mm ; `LinesLG` et `LinesP` ne diffèrent que par le `SetXY` initial
  (7 ou 4 mm), sans effet sur le trait. `PosY` est déclaré `String` (converti par `Line`, dont les
  coordonnées sont entières).
- **`BasPage()`**, **`BasPageP()`** [portée : nécessaire] : pied « Page n/{nb} – date –
  Impression demandée par <utilisateur> » à 10 mm du bas. Déclarées `Function` sans type de
  retour. `BasPage` est identique dans `Cdocuments2`/`Cdocuments3` ; 7 autres classes `C*` ont une
  variante identique entre elles (voir « Commonalisation »).

### Familles et historiques (`EdFam`, `RelMoprod`)

- **`Level1FAM(PosY)`** [nature : mixte, lit `/Soc<XX>/Taxe`], **`Level2FAM(…)`**
  [portée : nécessaire] : en-tête et ligne de la liste des familles.
- **`Level2RL`**, **`Level4RL`**, **`Level5RL`** [portée : nécessaire] : lignes, client et titres
  de l'historique ; `Level1RL` [portée : réductible, code mort].

## État global utilisé

- `Start.R/G/B`, `Start.R2/G2/B2` (lus une fois dans `_new`).
- `Start.LocalSettings["/Soc" & Start.Societe & "/…"]` : `glogo`, `glogo3`, `glogo5`, `glogo6`,
  `Logo`, `Logo2`, `AutoEnt`, `Franchise`, `Taxe`, `Devis2` (lus à chaque appel).
- `Variables.EnvoiMail`, `Variables.TypeL`, `Variables.Qte`, `Variables.bImpref` (jamais
  affectées : branches mortes) et `Variables.bRemise` (affectée par `Facture`, `Facturergbl`,
  `Archives` ; seul `Facturergbl` imprime avec `Cdocuments`).
- `User.Name`, `Now` (pied de page) : à figer pour les tests (`faketime`, utilisateur de test).

## Propositions d'amélioration

### Réécriture / refactorisation

- **Réarchitecture des signatures** : `Entete` a 19 paramètres positionnels obligatoires dont 2
  inutilisés, et les trois appelants construisent les mêmes 17 chaînes depuis `Fiches_Societes`
  (`Edcom:211-227`, `RelvMo:376-391`, `Facturergbl:587-603`). Proposition : un objet valeur
  `LEnteteSoc` (préfixe `L*` comme `LPrix`/`LDate`) portant `Rs`, `Libre`, `Adr1`, `Adr2`,
  `Ville`, `Lignes As String[]` (capital… courriel, dans l'ordre d'impression), `Iban`, et une
  fabrique `LEnteteSoc.Lit(sCodeSoc)` (requête `WHERE cd_sc = &1` sur `Cbase.Table("TabSoc")`,
  libellés par défaut). Méthode de dessin `EnteteSoc(soc As LEnteteSoc, Optional Col As Boolean)`.
  L'appelant qui imprime un libellé différent (« Naf : » de `RelvMo`, libellé SIRET local de
  `Facturergbl`) remplace la ligne concernée après `Lit`, ce qui garde le texte imprimé
  identique. `Entete` devient d'abord un adaptateur qui construit un `LEnteteSoc` (aucun appelant
  modifié), puis est supprimée quand tous les appelants sont migrés. La migration de `RelvMo`
  corrige de fait RELVMO-A01 : elle se fait dans le commit de l'anomalie.
- Même approche pour les lignes de facture `Level3F` (9 paramètres) et `Level2D` (12) si la
  famille facture est conservée.
- `Entete` (CC 23) : les 11 blocs `If Not IsNull(x)` deviennent une boucle sur
  `[cap, rcs, siret, ape, tvaintra, tel, portable, fax, site, mail]` (même pas de 5 mm), puis
  `iban` en italique ; logos par un helper privé. Sortie identique.
- `Level2F` (CC 18) : calculer une fois le suffixe (`" TTC"`, `" HT"`, `""`) et la présence de
  la remise, puis écrire les mêmes cellules ; la table de décision actuelle (y compris l'effet
  `Or If` décrit plus haut) est conservée.
- Paires quasi identiques : `Level4F`/`Level4aF` (style de police), `Level4`/`Level4D`
  (libellé), `Lines`/`LinesLG`/`LinesP` (largeur) → un helper privé paramétré, wrappers `Public`
  conservés.
- Supprimer les paramètres inutilisés (`Visudoc`, `Pays` d'`Entete` ; `Col` d'`Entete2` ;
  `Page` de `Level1F` ; `Coulfond` de `Level2F`/`Level7F` ; `Mttc` de `Level9F` ; `TypeD` de
  `Level2D`) avec mise à jour des appelants listés.

### Commonalisation avec d'autres fichiers

- **Socle PDF commun** : classe intermédiaire `PdfLaurux Inherits PdfWriter` proposée par
  [PDFWRITER-011](../PdfWriter.class/rework.md) (newPage, `BasPage`, `Logo`, couleurs) ; une
  sous-classe y appelle les membres hérités par `Me.X` et ne voit pas leurs membres `Private`.
  Candidats de ce fichier : `_new`
  (couleurs du thème : code identique dans `Cdocuments` et [`Cdocuments3`](../Cdocuments3.class/architecture.md),
  variante identique dans 12 classes `C*`, une autre dans `Carticles`, `Chistoriques`, `Cmat`,
  [`Creleve`](../Creleve.class/architecture.md), `Ctraites`), `BasPage` (identique dans
  `Cdocuments`, `Cdocuments2`, `Cdocuments3` ; variante identique dans `CLcr`, `Cbalances`,
  `Cbilan`, [`Ccompta`](../Ccompta.class/architecture.md), `Cecheancier`, `Cresultat`,
  [`Cstocks`](../Cstocks.class/architecture.md)), `EnteteN` (identique dans `Creleve`, `Ctraites`),
  `Lines` (identique dans `Clivre`). Mesure par empreinte du corps normalisé (script
  `output/claude/2026-10-24_rework/phase1/reports_cdoc/samefun.py`).
- **En-tête société** : `Cdocuments.Entete` ≈ `Creleve.Entete` (ratio 0,87), `Entete2` ≈
  `Creleve.Entete2` (0,81), `Logo` ≈ `Creleve.Logo` (0,84) ; à fusionner dans le socle avec
  `LEnteteSoc`, en lien avec `Creleve.EnteteSociete` proposé par
  [LIGCLI-004](../../Compta/Relances/Ligcli.class/rework.md) et `Utils.LitSociete` proposé par
  [EDART4](../../Gestion/Impressions/Edart4.class/rework.md) et
  [EDCOM-005](../../Gestion/Impressions/Edcom.class/rework.md). Le report `Editfac` lit les
  mêmes colonnes (`Editfac.class:42-59`) et peut consommer le même `LEnteteSoc`.
- [`Cdocuments2`](../Cdocuments2.class/architecture.md) : copie jamais instanciée, à supprimer
  (CDOCUMENTS2-001) plutôt qu'à fusionner.

### Réduction de portée

- `Logo`, `Logo3`, `Colonnes` : utilisées seulement dans le fichier → `Private`.
- Les 23 fonctions sans appelant (`EnteteV`, `Level4V`, `Entete3`, `Logo2`, `Level1bis`,
  `Level3bis`, `Level4RB`, `Level1LV`, `Level1DP`, `Level2FAC`, `Level2Fa`, `Level3FAC`,
  `Level10F2`, `Level10F3`, `LevelM`, `Level2M`, `Level14F`, `Level15F`, `Level16F`,
  `EnteteD`, `Level1RL`, `Signature`, `SignatureD`) sont supprimées plutôt que réduites.

### Séparation traitement / GUI

- Fichier de dessin : la seule logique métier est le choix des libellés selon le régime de TVA
  (`/AutoEnt`, `/Franchise`, `ImpAuto`, `Exo`) dans `Level2F`, `Level3F`, `Level7F`,
  `Level10F`. Proposition : une fonction privée `SansTva() As Boolean` (lecture des réglages)
  utilisée par ces quatre méthodes, testable via l'API `Public` existante.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base. Un champ `Fiches_Societes.libelle_siret` (au lieu
  du réglage local `/Soc<XX>/Siret` lu par `Facturergbl`) homogénéiserait l'en-tête société entre
  postes.
