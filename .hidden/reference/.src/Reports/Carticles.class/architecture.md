# Carticles — Architecture

> Source : `.src/Reports/Carticles.class`

## Vue d'ensemble

`Carticles` est un **gabarit PDF** (`Inherits PdfWriter`, voir
[PdfWriter](../PdfWriter.class/architecture.md)) qui regroupe les en-têtes de colonnes et les lignes
de détail des **éditions d'articles et de stock** de la gestion commerciale : stock chiffré ou non
(`EdStk`), tarif interne (`EdArt1`, `EdArt3`), tarif client (`EdArt2`, écran mort), ruptures et
ventes (`EdRup`), régularisations de stock (`Edregul`, `Edregulprdc`), mains d'oeuvre (`Edmo`).

La classe ne fait **aucun calcul** et **aucun accès à la base** : chaque méthode positionne le
curseur (`SetXY`), choisit la police (`SetFont`) puis émet une suite de `Cell` de largeurs fixes.
Les valeurs arrivent déjà formatées (chaînes) depuis l'écran appelant, qui gère aussi la
pagination (`PosY`, seuil de saut de page) et l'ordre des appels (`Entete` → `LevelN` en-tête →
lignes → `Footer`). Le nommage `LevelN` ne suit pas l'ordre d'impression : il reflète l'ordre
historique d'ajout (voir le tableau ci-dessous).

Nature globale : **GUI de rendu PDF** (aucune logique métier). Le seul état est la couleur de
fond `R`/`G`/`B` lue sur `Start` à la construction.

| Édition (appelant) | En-tête | Lignes | Total / divers |
|---|---|---|---|
| Stock chiffré (`EdStk`) | `Level1` | `Level3` | `Level5` |
| Stock non chiffré (`EdStk`) | `Level2` | `Level4` | — |
| Tarif interne (`EdArt1`, `EdArt3`) | `Level7` / `Level7bis` (photo) / `Level7M` (marge, `EdArt1`) | `Level6` / `Level6bis` / `Level6M` | `Level10` (PV conseillé), `Photo`, `Ligne` |
| Tarif client (`EdArt2`, mort) | `Level9` / `Level9bis` | `Level8` / `Level8bis` | `Photo`, `Ligne2` |
| Ruptures / ventes (`EdRup`) | `Level13` / `Level13R` / `Level13V` | `Level14` / `Level14V` | `Ligne` |
| Régularisations (`Edregul`, `Edregulprdc`) | `Level11` | `Level12` | `Ligne` |
| Mains d'oeuvre (`Edmo`) | `Level1MO` | `Level2MO` | — |
| Tarif client « TC » (aucun appelant) | `EnteteTC`, `Level2TC` | `Level3TC` | — |
| Stock chiffré sans famille (aucun appelant) | — | `Level3bis` | — |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-16 | Public | 1 | 6 | 0 | méthode spéciale |
| `_free` | 18-20 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 22-29 | Public | 1 | 6 | 8 |  |
| `Footer` | 32-38 | Public | 1 | 5 | 7 |  |
| `Level1` | 41-56 | Public | 1 | 14 | 1 |  |
| `Level3` | 59-76 | Public | 1 | 15 | 1 |  |
| `Level3bis` | 78-93 | Public | 1 | 13 | 0 | portée réductible ? |
| `Level2` | 96-106 | Public | 1 | 9 | 1 |  |
| `EnteteTC` | 108-115 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level2TC` | 118-130 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level3TC` | 133-147 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level4` | 150-162 | Public | 1 | 10 | 1 |  |
| `Level5` | 165-176 | Public | 1 | 10 | 1 |  |
| `Level6` | 179-195 | Public | 1 | 14 | 2 |  |
| `Level6bis` | 198-212 | Public | 1 | 12 | 2 |  |
| `Level7` | 215-229 | Public | 1 | 13 | 2 |  |
| `Level7bis` | 232-245 | Public | 1 | 12 | 2 |  |
| `Level8` | 248-262 | Public | 1 | 12 | 1 |  |
| `Level8bis` | 265-277 | Public | 1 | 10 | 1 |  |
| `Level9` | 280-292 | Public | 1 | 11 | 1 |  |
| `Level9bis` | 295-306 | Public | 1 | 10 | 1 |  |
| `Level10` | 309-315 | Public | 1 | 5 | 2 |  |
| `Level11` | 318-329 | Public | 1 | 10 | 2 |  |
| `Level12` | 332-345 | Public | 1 | 11 | 2 |  |
| `Level13` | 348-361 | Public | 1 | 12 | 1 |  |
| `Level13R` | 363-376 | Public | 1 | 12 | 1 |  |
| `Level13V` | 378-391 | Public | 1 | 12 | 1 |  |
| `Level14` | 394-409 | Public | 1 | 13 | 1 |  |
| `Level14V` | 412-427 | Public | 1 | 13 | 1 |  |
| `Photo` | 429-433 | Public | 2 | 3 | 3 |  |
| `Ligne` | 435-439 | Public | 1 | 3 | 5 |  |
| `Ligne2` | 441-445 | Public | 1 | 3 | 1 |  |
| `Level1MO` | 448-463 | Public | 1 | 14 | 1 |  |
| `Level2MO` | 466-483 | Public | 1 | 15 | 1 |  |
| `Level6M` | 486-502 | Public | 1 | 14 | 1 |  |
| `Level7M` | 505-519 | Public | 1 | 13 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et cadre de page

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Copie `Start.R`/`G`/`B` dans
  les membres privés `R`/`G`/`B` puis `SetFillColor(R, G, B)` : toutes les cellules
  `fill = True` (titres et en-têtes) prennent la couleur du thème. Les paramètres passés par
  `New CArticles("Portrait", "mm", "A4")` vont au constructeur de `PdfWriter` (le `_new` de
  `Carticles` n'en déclare aucun). `R`/`G`/`B` ne servent qu'ici : de simples variables locales
  suffiraient.
- **`_free()`** [portée : nécessaire (spéciale)] — vide, **code mort**.
- **`Entete(sEntete)`** [portée : nécessaire, 8 appelants] [nature : GUI]. `AddPage`, puis titre
  centré en Helvetica gras italique 16, cadre plein de 206 mm à partir de x = **40** (le cadre
  déborde donc de la page A4 : 40 + 206 = 246 mm > 210 mm ; le texte centré est décalé vers la
  droite). `EnteteTC` est la même méthode avec x = 2 (comportement des autres gabarits).
  Effet de bord : nouvelle page PDF.
- **`Footer()`** [portée : nécessaire, 7 appelants] [nature : GUI]. Surcharge de
  `PdfWriter.Footer` (déclarée `Function` sans type de retour ; jamais appelée par `PdfWriter`,
  dont l'appel automatique est commenté). Pied de page à 10 mm du bas : « Page n/{nb} - date -
  Impression demandée par `User.Name` » (alias `{nb}` remplacé à la sortie grâce à
  `AliasNbPages`). Texte identique dans 23 méthodes de 19 sous-classes de `PdfWriter` (voir
  « Commonalisation »). `EdStk` ne l'appelle jamais (aucun numéro de page dans le stock).
- **`Ligne(PosY)`** [portée : nécessaire, 5 appelants] / **`Ligne2(PosY)`** [portée : nécessaire,
  1 appelant mort] [nature : GUI]. Trait horizontal de 2 à 206 mm (resp. 14 à 196 mm) à
  l'ordonnée `PosY`.
- **`Photo(sPhoto, PosX, PosY)`** [portée : nécessaire] [nature : GUI]. `Try Me.Image(…, 30, 20)` :
  une image illisible est ignorée silencieusement (l'appelant a déjà testé `Image.Load`).

### En-têtes de colonnes (`Level1`, `Level2`, `Level7`, `Level7bis`, `Level7M`, `Level9`, `Level9bis`, `Level11`, `Level13`, `Level13R`, `Level13V`, `Level1MO`, `Level2TC`)

[portée : nécessaire, sauf `Level2TC` (code mort) ; `Level9`/`Level9bis` n'ont que l'appelant
mort `EdArt2`] [nature : GUI]. Police Helvetica 9 (8 pour `Level13*`), y = 16 mm, abscisse de
départ propre à chaque édition (2, 4, 10, 12, 22 ou 34 mm), puis une `Cell` par colonne,
bordée, centrée et remplie (`True, 0, "C", True`). Seules les largeurs et les libellés changent.
`Level1MO` lit en plus le libellé de taxe de la société (`Start.LocalSettings["/Soc<XX>/Taxe"]`,
ex. « TVA »).

### Lignes de détail (`Level3`, `Level3bis`, `Level4`, `Level6`, `Level6bis`, `Level6M`, `Level8`, `Level8bis`, `Level3TC`, `Level12`, `Level14`, `Level14V`, `Level2MO`)

[portée : nécessaire, sauf `Level3bis`/`Level3TC` (code mort) ; `Level8`/`Level8bis` n'ont que
l'appelant mort `EdArt2`] [nature : GUI]. Police Helvetica 8 (6 pour `Level14*`), y = `PosY`,
hauteur 5 mm, cellules sans bordure ni fond, alignées à gauche pour le texte et à droite pour
les montants ; mêmes abscisses et largeurs que l'en-tête correspondant (le gabarit ne vérifie pas
cette cohérence). `Level2MO` tronque l'intitulé à 45 caractères (`Left$`) ; les autres méthodes
impriment tel quel (troncature faite par l'appelant).

⚠️ **`Level6bis`** (ligne 202) appelle `SetFont("Hel8vetica", , 8)` : `PdfWriter.SetFont` lève
`Error.Raise("Undefined font: hel8vetica")` pour toute famille absente des polices standard
(vérifié avec `gbx3` sur `PdfWriter` isolé). Le mode « photo » du tarif interne s'arrête donc sur
une erreur non interceptée dès le premier article : `EdArt3` (case `Phot` visible,
`EdArt3.class:715` et `:727`) et `EdArt1` (case `Phot` invisible, branche inaccessible). Anomalie
CARTICLES-A01. Faute de frappe présente depuis le premier commit du dépôt (`5d9a8696`).

### Totaux et divers

- **`Level5(Totpa, Totpmp, PosY)`** [portée : nécessaire] [nature : GUI] : trois cellules d'en-tête
  (« Total Stock », « Total PA », « Total PMP ») à x = 110, y = `PosY + 10`, puis les deux valeurs
  à x = 138, y = `PosY + 20`. Les valeurs sont décalées de 2 mm à gauche par rapport aux en-têtes
  « Total PA »/« Total PMP » (140 et 170 mm) et la cellule « Total Stock » n'a pas de valeur
  (cosmétique).
- **`Level10(Pvcons, Lg, PosY)`** [portée : nécessaire] [nature : GUI] : libellé « Prix de vente
  TTC conseillé » aligné à droite sur `Lg` mm puis valeur sur 17 mm. Ne fixe pas la police : elle
  hérite de la ligne précédente (`Level6` : 8 points).
- **`EnteteTC(sEntete)`** [code mort] : variante d'`Entete` à x = 2.

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (couleur du thème, lue une fois dans `_new`).
- `Start.LocalSettings["/Soc" & Start.Societe & "/Taxe"]` (libellé de la taxe, `Level1MO`).
- `User.Name`, `Date(Now)` (pied de page) : valeurs volatiles à masquer dans les tests.
- Aucun accès SQL, aucune table.

## Propositions d'amélioration

### Réécriture / refactorisation

- Les 26 méthodes `LevelN` suivent deux schémas uniques (en-tête bordé/rempli/centré ; ligne sans
  bordure). Deux helpers génériques, placés dans la base commune proposée ci-dessous,
  ramèneraient chacune à un appel :
  `EnteteColonnes(x, y, taille, largeurs As Float[], libelles As String[])` et
  `LigneColonnes(x, y, h, taille, largeurs As Float[], valeurs As String[], alignements As String)`.
  La suite des `Cell` émise est identique (même flux PDF). `Level6bis` n'est traité qu'après la
  décision sur CARTICLES-A01 (sinon il faut conserver la police erronée).
- Supprimer `_free` (vide) et les membres `R`/`G`/`B` (variables locales suffisent).

### Commonalisation avec d'autres fichiers

- **Base commune des gabarits PDF** (`PdfLaurux`, classe intermédiaire proposée par PDFWRITER-011, `Inherits PdfWriter`, les
  sous-classes passant de `Inherits PdfWriter` à `Inherits PdfLaurux`). Relevé sur les 23
  sous-classes de `PdfWriter` (20 dans `.src/Reports`, plus `Cfacture`, `Cticket` de la caisse et
  `CLcr`) :
  - **Couleur du thème** : `R = Start.R`, `G = Start.G`, `B = Start.B` recopié dans 20
    constructeurs (dont ce fichier, [Chistoriques](../Chistoriques.class/architecture.md),
    [Cstocks](../Cstocks.class/architecture.md), [Cclients](../Cclients.class/architecture.md),
    [Cmat](../Cmat.class/architecture.md), [Cetiquettes](../Cetiquettes.class/architecture.md),
    [Htickets](../Htickets.class/architecture.md)) → `CouleurTheme()` (`SetFillColor(Start.R,
    Start.G, Start.B)`), appelée là où chaque gabarit l'appelle aujourd'hui (dans `_new` ou dans
    ses en-têtes : l'emplacement des opérateurs de couleur dans le flux doit rester le même).
  - **Pied de page** : 23 copies (19 classes) du texte « Page n/{nb} - date - Impression demandée par … »
    (`Footer` ici, dans `Chistoriques`, `Cmat`, `Htickets`, [Cbordereaux](../Cbordereaux.class/architecture.md) ;
    `BasPage`/`BasPageP` dans `Cstocks`, `Cclients`, [Cbalances](../Cbalances.class/architecture.md),
    [Ccompta](../Ccompta.class/architecture.md), [Cbilan](../Cbilan.class/architecture.md),
    [Cresultat](../Cresultat.class/architecture.md), [Csig](../Csig.class/architecture.md),
    [Cecheancier](../Cecheancier.class/architecture.md), [Clivre](../Clivre.class/architecture.md),
    [Cdocuments](../Cdocuments.class/architecture.md), [Cdocuments2](../Cdocuments2.class/architecture.md),
    [Cdocuments3](../Cdocuments3.class/architecture.md)) → `PiedDePage(largeur As Float,
    Optional dy As Float = -10)` ; les noms publics `Footer`/`BasPage`/`BasPageP` restent (appelés
    par les écrans) et délèguent. Ne **pas** nommer la méthode commune `Footer` : `PdfWriter`
    en déclare déjà une (`Sub`), surchargée ici en `Function` (comme dans `Chistoriques`, `Cmat`,
    `Htickets`, `Cbordereaux`). Règles Gambas vérifiées par le lot PdfWriter : une sous-classe
    appelle un membre hérité par `Me.X` ; un membre `Private` de `PdfLaurux` serait invisible
    des sous-classes (erreur à l'exécution seulement) : les helpers doivent être `Public`.
  - **Titre de page** : `AddPage` + titre plein sur 206 mm (`Entete` de `Carticles`, `Cmat`,
    `Chistoriques`, `Cstocks`, `Cclients`…) → `TitrePage(titre, x, largeur, style, taille)`.
    Ne pas la nommer `Entete` : `Htickets.Entete()` n'a pas de paramètre (risque de conflit de
    signature en surcharge, à vérifier avec `gbc3`).
  - **Traits** : `Ligne`/`Ligne2` (ici et dans `Cmat`), `Lines`/`LinesP` (`Chistoriques`,
    `Cstocks`, `Cclients`, `Cbilan`, `Csig`, `Cdocuments*`) → `Trait(y, x1, x2, Optional
    epaisseur)`.
  - **`NewPage`** (`Cetiquettes`, `Clivre`) et **`Logo*`** ([Creleve](../Creleve.class/architecture.md),
    `Clivre`, `Cdocuments`, `Cbordereaux` : lecture de `/Soc<XX>/glogo` et `/Soc<XX>/Logo`, puis
    `Image`) → `LogoSociete(x, y, l, h, cle)` ; **`Level0*`** de période (`Cbalances`, `Ccompta`,
    `Cecheancier`, `Level0F` de `Chistoriques`) → `BandeauPeriode(x, y, largeur, texte)`.
  - Helpers de colonnes `EnteteColonnes`/`LigneColonnes` (ci-dessus), utiles à tous les gabarits.
  - `Static Public Function FormatAligne(valeur, nbdec) As String` : idiome « espace final si
    deux décimales » (`If Len(x) - InStr(x, ",") = 2 Then x &= " "`, environ 15 copies dans
    `EdArt1`, `EdArt3`, `EdStk`, `EdRup`, `EdMat`, `ImpDepots`), proposé par
    [EdArt1](../../Gestion/Impressions/EdArt1.class/architecture.md) (EDART1-007). Fonction de
    calcul pure, testable en gb.test ; placée en `Static` dans la base, elle est accessible comme
    `Carticles.FormatAligne` pour les éditions d'articles.
- **`EnteteTarif(sTitre, bPhoto, bMarge)`** dans `Carticles` : le bloc `Entete` + choix
  `Level7`/`Level7bis`/`Level7M` est écrit 2 fois dans `EdArt1` et 2 fois dans `EdArt3`
  (EDART1-006, proposé par [EdArt1](../../Gestion/Impressions/EdArt1.class/architecture.md)).
- `Cmat` est un sous-ensemble textuel de `Carticles` (`_new`, `_free`, `Entete`, `Footer`,
  `Ligne`, `Ligne2` identiques) : avec la base commune, il ne garde que ses deux `Level`.

### Réduction de portée

- Aucune : toutes les méthodes vivantes ont un appelant externe. Les méthodes sans appelant
  (`Level3bis`, `EnteteTC`, `Level2TC`, `Level3TC`) sont supprimées (code mort) plutôt que
  rendues privées.

### Séparation traitement / GUI

- Sans objet : la classe ne fait que du rendu. Le formatage des valeurs (nombre de décimales,
  alignement) est fait par les appelants ; `FormatAligne` le rapatrie dans une fonction pure.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
