# Etiqfbtarif — Architecture

> Source : `.src/Gestion/Etiquettes/Etiqfbtarif.class`

## Vue d'ensemble

Écran d'impression des **étiquettes de gondole aux tarifs « fiche barème »** (mise à jour de tarifs
fournisseur à une date) : il sélectionne les articles dont `art_datefbt` vaut la date saisie, **recalcule**
le prix de vente à partir du prix d'achat barème (`art_pbfbt`), de la remise, du taux de conversion,
des frais, du coefficient, de la TVA et de la règle d'arrondi de l'article, puis imprime une étiquette
de gondole par article avec ce nouveau prix. Ouverture modale de l'auto-instance depuis
`Fmenu.Menu242_Click` et `Menu247_Click` (deux entrées identiques).

Le calcul de prix est une **copie** de celui de l'écran de mise à jour de tarifs (`MajFbtarif2`,
`MajTarifP`, `Impart`, `Articles` : fonctions homonymes `prix_base`, `TrC`, `PvTTC_arrondi`…). Il
travaille sur des membres `String` partagés, formatés à chaque étape.

Sortie : `~/tmp/EtiqGond.pdf` (même nom qu'Etigond et EtiqPromo). `pos_Etiq` variante **V4** (A4
seulement, espacement compté une fois). Le compteur de rangées `i2` est remis à 0 **à chaque
article** (l. 156) : le saut de page ne se produit jamais pour une planche de plus d'une rangée
(ETIQFBTARIF-A01, à confirmer en replay).

Nature globale : **mixte** (calcul de prix + GUI + PDF).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Nbdec` | var | Private |  | String | 4 |
| `code` | var | Private |  | String | 5 |
| `PbHT` | var | Private |  | String | 6 |
| `PaHT` | var | Private |  | String | 7 |
| `Txconv` | var | Private |  | String | 8 |
| `Paua` | var | Private |  | String | 9 |
| `Prvt` | var | Private |  | String | 10 |
| `Pvht` | var | Private |  | String | 11 |
| `Pvttc` | var | Private |  | String | 12 |
| `Pmp` | var | Private |  | String | 13 |
| `Stocke` | var | Private |  | String | 14 |
| `Margem` | var | Private |  | String | 15 |
| `Margep` | var | Private |  | String | 16 |
| `arr` | var | Private |  | String | 17 |
| `Remise` | var | Private |  | String | 18 |
| `Coeff` | var | Private |  | String | 19 |
| `Percent` | var | Private |  | String | 20 |
| `Mtva` | var | Private |  | String | 21 |
| `Frais` | var | Private |  | String | 22 |
| `i2` | var | Private |  | Integer | 23 |
| `Rect` | var | Private |  | String | 24 |
| `intitule` | var | Private |  | String | 25 |
| `intitule2` | var | Private |  | String | 26 |
| `Nblargeur` | var | Private |  | String | 27 |
| `Nbhauteur` | var | Private |  | String | 28 |
| `Largeur` | var | Private |  | Integer | 29 |
| `Hauteur` | var | Private |  | Integer | 30 |
| `Mrghaut` | var | Private |  | Integer | 31 |
| `Mrgauche` | var | Private |  | Integer | 32 |
| `Esplargeur` | var | Private |  | Integer | 33 |
| `Esphauteur` | var | Private |  | Integer | 34 |
| `Filename` | var | Private |  | String | 35 |
| `Nb` | var | Private |  | Boolean | 36 |
| `Nbetiq` | var | Private |  | Integer | 37 |
| `txtBarcode` | var | Private |  | String | 38 |
| `txtPosX` | var | Private |  | Integer | 39 |
| `txtPosY` | var | Private |  | Integer | 40 |
| `SorP` | var | Private |  | Boolean | 41 |
| `rArt` | var | Private |  | Result | 42 |
| `son` | var | Private |  | Integer | 43 |
| `pdf` | var | Private |  | Cetiquettes | 44 |
| `Page` | var | Private |  | String | 45 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 47-57 | Public | 4 | 9 | 0 | méthode spéciale |
| `init_ComboBox` | 59-75 | Public | 5 | 14 | 0 | portée réductible ? |
| `Button3_Click` | 77-81 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 83-165 | Public | 16 | 80 | 0 | handler GUI |
| `fin_impression` | 167-176 | Public | 2 | 8 | 0 | portée réductible ? |
| `ToggleButton2_Click` | 178-186 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 188-193 | Public | 1 | 4 | 0 | handler GUI |
| `prix_base` | 198-218 | Public | 3 | 19 | 0 | portée réductible ? |
| `TrC` | 223-237 | Public | 4 | 13 | 0 | portée réductible ? |
| `Prix_achat` | 239-262 | Public | 5 | 22 | 0 | portée réductible ? |
| `rTva` | 267-276 | Public | 2 | 7 | 0 | portée réductible ? |
| `Tva_Calcul` | 281-290 | Public | 3 | 8 | 0 | portée réductible ? |
| `Calc_Marge` | 295-308 | Public | 6 | 12 | 0 | portée réductible ? |
| `PvTTC_arrondi` | 313-350 | Public | 10 | 33 | 0 | portée réductible ? |
| `Calc_Percent` | 355-359 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_coeff` | 364-368 | Public | 2 | 3 | 0 | portée réductible ? |
| `PvTTcLF` | 373-380 | Public | 1 | 5 | 0 | portée réductible ? |
| `Imprime` | 383-437 | Public | 18 | 50 | 0 | portée réductible ? |
| `pos_Etiq` | 439-460 | Public | 4 | 20 | 0 | portée réductible ? |
| `Button1_Click` | 465-469 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Écran

- **`_new()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)`,
  imprimante selon `/Soc<XX>/Impetiq`, `init_ComboBox`.
- **`init_ComboBox()`** [réductible] [nature : mixte]. Liste `Fiches_Etiquettes` (identique à
  EtiqRecpt et EtiqPromo).
- **`Button3_Click()`** (Quitter), **`Button1_Click()`** (aide `Doc.Open("Majtarif")`),
  **`ToggleButton2_Click()`** (affiche/masque `DateChooser1`), **`DateChooser1_Activate()`** (recopie
  la date `dd.mm.yyyy`) [portée : nécessaire (handlers)] [nature : GUI].

### Impression

- **`Button2_Click()`** (CC 16) [portée : nécessaire (handler)] [nature : mixte]. Modèle obligatoire ;
  `Kill ~/tmp/EtiqGond.ps` (fichier jamais produit) ; `SELECT * FROM Fiches_Etiquettes WHERE code =
  &1` (sans la page) ; sauts `Posetiq - 1` (`pos_Etiq`) **avant** la création du PDF ; `Shell "cd ~"`,
  `Kill` du PDF ; A4 / Dymo `dymog` (dimensions de la base) ; **rien en Zebra** → `pdf.Open()` sur
  `Null` (l. 127). Requête `SELECT * FROM TabArt WHERE art_datefbt = &1 order by art_four | art_fam |
  art_casier` (`Tfour`/`Tfam`/`Tcas`, date convertie par `Utils.Cdate_Dbase`). Par article : lecture
  des paramètres de prix, `rTva`, `prix_base` (prix brut, `Tbrut`) ou `Prix_achat`, `Calc_Percent`,
  `Calc_coeff`, `i2 = 0`, `Imprime(nb)`. Aucun message si aucun article ne correspond (PDF non produit).
- **`Imprime(nb)`** (CC 18) [réductible] [nature : mixte]. Une étiquette (`nombretiq = 1`) : code,
  deux intitulés, EAN13 si 13 caractères, TVA, prix au kg/l HT (`RadioButton5`) ou TTC
  (`RadioButton6`, défaut) si > 0, cadre, PV HT et PV TTC. Positionnement **après** le dessin si `nb`
  est vrai (membre `Nb` initialisé à vrai et jamais remis à faux : toujours le cas).
- **`pos_Etiq()`** [réductible] [nature : calcul]. Variante V4 : pas de retour en haut quand
  `Nbetiq = 1`, `X = 2 + Mrgauche + Largeur × (n-1) + Esplargeur`, saut de page si `i2 >= Nbhauteur`.
- **`fin_impression()`** [réductible] [nature : mixte]. `Output`, `Visualiseur.Prog`, son, message
  (identique à EtiqPromo sans la remise à vide du modèle).

### Calcul de prix (membres `String`)

- **`rTva()`** [réductible] [nature : calcul + SQL]. `SELECT * FROM TabTvav WHERE code_tva = &1` ;
  remplace le code par le taux s'il existe.
- **`prix_base()`** [réductible] [nature : calcul]. `PbHT = PaUA`, `TrC` (remise), `PaHT = PaUA /
  Txconv`, `Prvt = PaHT + Frais`, `Pvht = Prvt × Coeff`, puis `Tva_Calcul`, `PvTTC_arrondi`,
  `PvTTcLF`, `Calc_Marge`. `Catch` → son + `Message.Error`.
- **`TrC()`** [réductible] [nature : calcul]. `PaUA = PbHT × (1 - remise/100)`.
- **`Prix_achat()`** [réductible] [nature : calcul]. Variante à partir du prix net : `PbHT = PaUA /
  (1 - remise/100)`, même suite. Compare `Val(PaUA) <> "0"` (Float contre chaîne).
- **`Tva_Calcul()`** [réductible] [nature : calcul]. `PvTTC = Pvht × (1 + taux/100)`.
- **`PvTTC_arrondi()`** (CC 10) [réductible] [nature : calcul]. Arrondi « au 5 centimes », au
  dixième, au demi ou à l'unité selon `art_cdarr` (`"0,05"`, `"0,10"`, `"0,50"`, `"1,00"`) par
  manipulation de chaîne (`Right$`, `Left$`) ; même algorithme que les copies de `MajFbtarif2`,
  `MajTarifP`, `Impart`, `Articles` (à vérifier ligne à ligne avant fusion).
- **`PvTTcLF()`** [réductible] [nature : calcul]. Recalcule `Pvht = PvTTC / (1 + taux/100)` après
  arrondi.
- **`Calc_Marge()`**, **`Calc_Percent()`**, **`Calc_coeff()`** [réductibles] [nature : calcul].
  Calculent `Margem`, `Margep`, `Percent` et réécrivent `Coeff` : **aucun de ces résultats n'est
  imprimé** et `Coeff` est relu dans la base à l'article suivant ; `Pmp` n'est jamais lu en base
  (pris égal au premier `Prvt` puis conservé), `stocke` jamais renseigné. Calculs sans effet
  observable (code mort fonctionnel, sous réserve qu'ils ne lèvent pas d'erreur).

## État global utilisé

- `Start.*` (`Impetiq`, son), `Utils.db`, `Utils.cpoint`, `Utils.Find_nbdec`, `Utils.Cdate_Dbase`,
  `Utils.Observers`, `Cbase.Table` (`TabArt`, `TabTvav`), `Visualiseur`, `Doc`, `CEtiquettes`.
- 20 membres `String` de calcul partagés entre les fonctions (état implicite), `rArt` membre.
- Fichiers `~/tmp/EtiqGond.pdf`, `~/tmp/EtiqGond.ps` (supprimé, jamais produit).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer l'état `String` partagé par une fonction pure `PrixVente(rArt, brut) As Collection`
  (ou objet `LPrix`) ; supprimer `Calc_Marge`, `Calc_Percent`, `Calc_coeff` et les membres associés
  (aucun effet sur le PDF).
- Supprimer `Kill … .ps`, `Shell "cd ~"`, `SorP`, `Rect`, `Filename` initial, `Stocke`, `Pmp`.

### Commonalisation avec d'autres fichiers

- Calcul de prix « fiche barème » : fonctions homonymes dans `MajFbtarif2`, `MajTarifP`, `Impart`
  (lot Gestion/Stock/Tarifs) et `Articles` (voir notes transverses : fabrique `PrixVente`, arrondi
  `ArrondiPrix`/`ArrondiPvTTC`) ; Etiqfbtarif doit utiliser la même fonction que `MajFbtarif2`, qui
  applique réellement ces tarifs, sous réserve d'égalité des tests.
- Socle `PlancheEtiquettes` (variante V4, `init_ComboBox`, format, sortie) : voir
  [Etiqart › Commonalisation](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers) ;
  dessin gondole proche d'[`EtiqPromo`](../EtiqPromo.class/architecture.md) et
  d'[`Etigond`](../Etigond.class/architecture.md).

### Réduction de portée

- `init_ComboBox`, `fin_impression`, `prix_base`, `TrC`, `Prix_achat`, `rTva`, `Tva_Calcul`,
  `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `PvTTcLF`, `Imprime`, `pos_Etiq` →
  `Private` (grep : aucun usage externe ; les homonymes des autres fichiers sont leurs propres copies).

### Séparation traitement / GUI

- Le calcul de prix (8 fonctions) est déjà sans contrôle, sauf `Message.Error` dans les `Catch` :
  le transformer en retour d'erreur, le message restant dans `Button2_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker le prix de vente barème calculé (`art_pvfbt`) lors de la saisie de la fiche barème
  éviterait de le recalculer à l'impression (et les divergences entre copies du calcul).
