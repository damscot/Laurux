# Cetiquettes — Architecture

> Source : `.src/Reports/Cetiquettes.class`

## Vue d'ensemble

`Cetiquettes` est le **gabarit PDF des étiquettes** (`Inherits PdfWriter`, voir
[PdfWriter](../PdfWriter.class/architecture.md)) : étiquettes d'articles et de gondole, de
casiers, de promotions, de réception, de tarifs carburant/fioul, et étiquettes d'adresse des
clients et fournisseurs. Il est utilisé par les écrans de `.src/Gestion/Etiquettes`
([Etiqart](../../Gestion/Etiquettes/Etiqart.class/architecture.md), `Etigond`, `Etiqcasier`,
`EtiqPromo`, `EtiqRecpt`, `Etiqfbtarif`, `Eticli`) et par les fiches
[FClient](../../Gestion/Tables/FClient.class/architecture.md) et
[FFournisseur](../../Gestion/Tables/FFournisseur.class/architecture.md).

À la différence des gabarits de listes, il n'a ni en-tête ni pied de page : chaque méthode
imprime **un élément** d'étiquette (texte, prix, code-barres, cadre) à une position absolue
`(posX, posY)` calculée par l'écran appelant (fonctions `pos_Etiq`, en 6 variantes non
équivalentes V1 à V6 selon les notes du lot Étiquettes), avec un facteur d'échelle optionnel
`fontratio` (taille de police = `Round(fontratio × taille de base)`). Le format de page est
choisi par l'appelant au `New` : planche A4 (`PageA[0]`/`PageA[1]` lus dans le modèle
d'étiquettes) ou rouleau Dymo (`"dymog"`, `"dymoc"`, formats ajoutés à `PdfWriter`).

Rendu pur : aucune base, aucun état autre que la couleur du thème (`R`/`G`/`B`, utilisée par les
cadres et les prix).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 4 |
| `G` | var | Private |  | Integer | 5 |
| `B` | var | Private |  | Integer | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-14 | Public | 1 | 5 | 0 | méthode spéciale |
| `NewPage` | 16-20 | Public | 1 | 3 | 9 |  |
| `Nom` | 22-28 | Public | 1 | 5 | 3 |  |
| `Cp` | 30-36 | Public | 1 | 5 | 3 |  |
| `Adrexp` | 38-47 | Public | 1 | 7 | 2 |  |
| `NomC` | 49-55 | Public | 1 | 5 | 2 |  |
| `CpC` | 57-63 | Public | 1 | 5 | 2 |  |
| `casierc` | 65-71 | Public | 1 | 5 | 2 |  |
| `Codec` | 73-79 | Public | 1 | 5 | 2 |  |
| `Intitulec` | 81-87 | Public | 1 | 5 | 2 |  |
| `stockc` | 89-97 | Public | 1 | 7 | 2 |  |
| `casier` | 99-105 | Public | 1 | 5 | 2 |  |
| `Code` | 107-113 | Public | 1 | 5 | 6 |  |
| `IntituleA` | 115-121 | Public | 1 | 5 | 4 |  |
| `IntituleB` | 123-133 | Public | 2 | 9 | 1 |  |
| `Intitule` | 135-141 | Public | 1 | 5 | 3 |  |
| `Barcode` | 143-162 | Public | 3 | 14 | 7 |  |
| `stock` | 164-170 | Public | 1 | 5 | 2 |  |
| `Tva` | 172-181 | Public | 1 | 8 | 4 |  |
| `Poids` | 183-189 | Public | 1 | 5 | 1 |  |
| `volm` | 191-201 | Public | 2 | 9 | 3 |  |
| `Rectangle2` | 203-209 | Public | 1 | 5 | 2 |  |
| `Rectangle` | 211-217 | Public | 1 | 5 | 2 |  |
| `PrixHt` | 219-229 | Public | 1 | 9 | 4 |  |
| `PrixTTC` | 231-240 | Public | 1 | 8 | 5 |  |
| `PrixTTCB` | 242-248 | Public | 1 | 5 | 1 |  |
| `PrixHtP` | 251-261 | Public | 1 | 9 | 1 |  |
| `PrixTTCP` | 263-272 | Public | 1 | 8 | 1 |  |
| `Refour` | 274-280 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les méthodes sont [portée : nécessaire] (chacune a au moins un appelant externe, vérifié
par `grep`) et [nature : GUI].

### Construction et page

- **`_new()`** : copie `Start.R/G/B` (pas de `SetFillColor` ici).
- **`NewPage()`** : `AddPage` (nouvelle planche ou nouvelle étiquette Dymo). Même méthode que
  `Clivre.NewPage`.

### Textes simples (14 méthodes, un seul schéma)

Schéma commun : `SetXY(posX, posY)`, `SetFont("Helvetica", style, Round(fontratio × taille))`,
`Cell(largeur, 5, texte, False, 0, "L", False)`.

| Méthode | Style | Taille | Largeur | Usage |
|---|---|---|---|---|
| `Nom` | normal | 11 | 30 | nom (adresse client/fournisseur) |
| `Cp` | gras | 11 | 30 | code postal + ville |
| `Adrexp` | gras | 18 | 30 | « Expéditeur » + trait souligné de 36 mm, épaisseur 0,8 |
| `NomC` | gras | 14 | 30 | nom (étiquette colis) |
| `CpC` | gras | 12 | 30 | code postal (colis) |
| `casierc` | gras | 20 | 30 | casier (petite étiquette) |
| `Codec` | normal | 6 | 30 | code (petite étiquette) |
| `Intitulec` | normal | 4 | 30 | intitulé (petite étiquette) |
| `casier` | gras | 16 | 30 | casier |
| `Code` | normal | 8 | 30 | code article |
| `IntituleA` | normal | 6 | 30 | intitulé |
| `Intitule` | normal | 8 | 30 | intitulé |
| `stock` | gras | 8 | 20 | stock |
| `Refour` | normal | 8 | `Round(10 × fontratio)` | référence fournisseur |

`Code` et `Intitule` ont un corps **identique** ; `Codec` et `IntituleA` aussi.
`Adrexp` laisse l'épaisseur de trait à 0,8 pour la suite de la page (effet de bord).

### Textes composés

- **`IntituleB`** : gras 14, intitulé tronqué à 29 caractères (`If Len > 29 Then Left$`, équivalent
  à `Left$(bcode, 29)` seul).
- **`stockc`** : « Stock » (normal 6) puis valeur (gras 6), deux cellules de 10 mm.
- **`Poids(vol, unite, …)`** : « <vol> <unité> Soit », gras 6.
- **`volm(volm, unite, HT, …)`** : « <prix> HT le <unité> » ou « … TTC le … » selon `HT`, gras 6.

### Prix

- **`Tva`**, **`PrixHt`**, **`PrixTTC`** : libellé (« TVA: », « Pv HT: », « Pv TTC: », normal 8)
  dans une cellule de `Round(6 × fontratio)` mm, puis valeur (gras 10) alignée à droite à
  `posX + Round(16 × fontratio)` (18 pour `PrixTTC`), le tout à `posY + 0,6`. `PrixHt` appelle en
  plus `SetFillColor(R, G, B)` (sans effet visible : aucune cellule remplie ensuite, mais un
  opérateur de couleur est écrit dans le flux).
- **`PrixTTCB`** : prix TTC seul, gras 22, sans libellé.
- **`PrixHtP`**, **`PrixTTCP`** : prix promotionnel (« Promo HT », « Promo TTC »), décalages fixes
  de 15 et 18 mm (non proportionnels à `fontratio`) ; alignement passé `" L "` (avec espaces),
  traité comme « gauche » par défaut dans `PdfWriter.Cell` (même rendu que `"L"`).

### Cadres et code-barres

- **`Rectangle(posX, posY)`** : cadre plein couleur du thème de 70 × 5,4 mm à `posY − 1`.
- **`Rectangle2(posX, posY, SizeX, SizeY)`** : cadre plein de taille donnée (`Integer` : les
  dimensions décimales sont tronquées).
- **`Barcode(bcode, posX, posY, hauteur = "5", largeur = "33.25", fontratio = 1.0)`** (CC 3, max du
  fichier) [nature : mixte, partie extractible : le calcul de la largeur de module et de la
  hauteur] : largeur d'un module `Larg = Val(Utils.cpoint(largeur)) / 95` plafonnée à 0,55 mm,
  hauteur `Haut = Val(Utils.cpoint(hauteur))` **tronquée** à l'entier (variable `Integer`), fond
  noir, `EAN13(posX, posY − 1, …)` puis, si `fontratio > 0,3`, le texte du code sous les barres
  (normal `Round(6 × fontratio)`). Les appelants passent des `Float` (`Hauteur / 3`) convertis en
  chaîne non localisée (« 4.666… »), que `Utils.cpoint` ramène à la virgule pour `Val` :
  fonctionne en locale française seulement (vérifié avec `gbx3`). La couleur de remplissage reste
  noire après l'appel. Défauts de `PdfWriter.EAN13` (longueur ≠ 13 ignorée sans erreur, clé non
  vérifiée, barres tracées plusieurs fois) : voir PDFWRITER-A06 ; les appelants testent
  `Len = 13`.

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (cadres, `PrixHt`, `PrixHtP`).
- `Utils.cpoint` (`Barcode`).
- Aucun accès SQL. Les positions, formats et modèles d'étiquettes sont lus par les écrans.

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper `Texte(txt, posX, posY, style, taille, fontratio, Optional largeur = 30, Optional h = 5)`
  : les 14 textes simples deviennent une ligne chacun (noms publics conservés : ils sont appelés
  par 9 écrans). `Code`/`Intitule` et `Codec`/`IntituleA` délèguent au même appel.
- Helper `LibellePrix(libelle, valeur, posX, posY, fontratio, decalage)` pour `Tva`, `PrixHt`,
  `PrixTTC` ; `PrixHtP`/`PrixTTCP` avec décalage fixe. Garder l'appel `SetFillColor` de `PrixHt`
  et `PrixHtP` pour un flux identique.
- `IntituleB` : `Left$(bcode, 29)` sans test (même résultat).
- `Barcode` : extraire `ModuleEan(largeur) As Float` et `HauteurEan(hauteur) As Integer` (calcul
  pur, testable).

### Commonalisation avec d'autres fichiers

- Base commune `PdfLaurux` proposée dans [Carticles](../Carticles.class/architecture.md)
  (CARTICLES-004) : `CouleurTheme` (cadres) et `NewPage` (partagé avec
  [Clivre](../Clivre.class/architecture.md)). Les autres éléments de la base (titre, pied de page)
  ne concernent pas les étiquettes.
- Le placement des étiquettes (`pos_Etiq` V1 à V6, format de planche, ouverture A4/Dymo) est dans
  les écrans : socle `PlancheEtiquettes` proposé par
  [Etiqart](../../Gestion/Etiquettes/Etiqart.class/architecture.md) (ETIQART-010). `Cetiquettes`
  reste le moteur de rendu de ce socle ; le module `EtiqArticles` proposé par le même lot
  (contenu d'une étiquette d'article commun à `Etiqart`/`Etigond`/`Etiqcasier`) appellerait les
  mêmes méthodes.

### Réduction de portée

- Aucune : les 29 méthodes ont toutes un appelant externe.

### Séparation traitement / GUI

- `Barcode` : seul calcul du fichier (conversion des dimensions), extractible en fonctions pures.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
