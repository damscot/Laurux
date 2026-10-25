# Cfacture — Architecture

> Source : `.src/Caisse/Reports/Cfacture.class`

## Vue d'ensemble

`Cfacture` est le **gabarit PDF des éditions de la caisse** : ticket « Défaut A4 / Défaut 80 mm »,
facture de caisse et livre de caisse. La classe hérite de `PdfWriter` (méthodes `SetXY`, `SetFont`,
`Cell`, `Line`, `Image`…) et n'expose que des primitives de mise en page : chaque méthode publique
positionne le curseur, choisit une police et écrit une ou plusieurs cellules. Elle n'accède **pas**
à la base : tout le contenu (en-tête société, lignes, totaux) est fourni par l'appelant.

Deux appelants :
- [`Caisse`](../../Caisse.class/architecture.md) : `Defaut_Tk` (ticket, `Caisse.class:5206`) et
  `Defaut_Facture` (facture, `Caisse.class:6620`) ;
- [`Moulinage`](../../Moulinage.class/architecture.md) : `Livre_caisse` (`Moulinage.class:106`).

Mise à l'échelle : le constructeur lit le format de page de `PdfWriter` (`GetFormat()`) et fixe
trois rapports par rapport à l'A4 (`$xratio`, `$yratio`, `$fratio`) appliqués à toutes les
coordonnées et tailles de police.

| Format | `$xratio` | `$yratio` | `$fratio` | Remarque |
|---|---|---|---|---|
| `a3` | 2 | 2 | 1,5 | |
| `80mm` | 0,65 | 1,0 | 0,72 | marges 100/100 (`SetMargins`) |
| `a4` | 1 | 1 | 1 | |
| `a5` | 0,7 | 0,7 | 0,7 | |
| `letter` | 1 | 0,95 | 0,9 | |
| `legal` | 1 | 0,95 | 1,2 | |
| autre (`dymoc`, `dymog`) | — | — | — | `Error.Raise` (message cassé, voir CFACTURE-A02) |

Le choix « A4 ou non » des tailles de police se fait de **deux façons différentes** selon les
méthodes : par un paramètre `Ba4` (`Entete`, `Entete2`, `Entete3`, `Level3`, `Logo2`) ou par la
lecture de `Caisse.Ba4` (`Level2T`, `Level1`, `Level1T`, `Com`, `Level2F`, `Level4`). Or `Caisse`
est instancié par `New Caisse` (`Cmenu.class:253`) : `Caisse.Ba4` lit le membre de
**l'auto-instance** du formulaire, jamais affecté, donc toujours `False` (anomalie CFACTURE-A01).

Nature globale : **GUI d'impression** (production PDF), sans SQL.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
| `$xratio` | var | Private |  | Float | 7 |
| `$yratio` | var | Private |  | Float | 8 |
| `$fratio` | var | Private |  | Float | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 11-47 | Public | 7 | 34 | 0 | méthode spéciale |
| `_free` | 49-51 | Public | 1 | 2 | 0 | méthode spéciale |
| `newPage` | 53-57 | Public | 1 | 3 | 2 |  |
| `Entete` | 60-70 | Public | 2 | 9 | 2 |  |
| `Entete2` | 73-83 | Public | 2 | 9 | 1 |  |
| `Entete3` | 86-97 | Public | 2 | 10 | 1 |  |
| `Lines` | 100-106 | Public | 1 | 5 | 1 |  |
| `Lines2` | 109-115 | Public | 1 | 5 | 2 |  |
| `Level2T` | 118-132 | Public | 2 | 13 | 1 |  |
| `Level1` | 135-166 | Public | 8 | 30 | 2 |  |
| `Level1T` | 169-192 | Public | 5 | 21 | 0 | portée réductible ? |
| `Level2` | 194-202 | Public | 1 | 7 | 1 |  |
| `Level2E` | 205-214 | Public | 1 | 8 | 1 |  |
| `Level3` | 217-227 | Public | 2 | 9 | 1 |  |
| `Com` | 230-241 | Public | 2 | 9 | 1 |  |
| `Level2F` | 244-258 | Public | 2 | 13 | 1 |  |
| `Level4` | 261-284 | Public | 4 | 22 | 1 |  |
| `Logo2` | 286-307 | Public | 7 | 19 | 1 |  |
| `Logo` | 309-338 | Public | 7 | 27 | 0 | portée réductible ? |
| `BasPage` | 341-347 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Cycle de vie

- **`_new()`** [portée : nécessaire (spéciale)] [nature : calcul]. Copie les couleurs du thème
  (`Start.R/G/B`) dans `R`, `G`, `B` (membres privés implicites, utilisés par `SetFillColor` des
  en-têtes de tableau), puis remplit les rapports selon `Me.GetFormat()` (tableau ci-dessus). Les
  paramètres de `New Cfacture("P", "mm", "A4")` sont consommés par `PdfWriter._new`.
  ⚠️ Ligne 44 : `Error.Raise("… " & form)` : `form` n'est déclaré nulle part dans la classe et se
  résout en la classe `Form` ; le message prévu n'est pas produit (à confirmer en phase 2). Branche
  atteinte seulement pour `dymoc`/`dymog`, formats qu'aucun appelant n'utilise.
- **`_free()`** : vide — code mort.
- **`newPage()`** [portée : nécessaire] [nature : GUI] : alias de `AddPage()` (Caisse, Moulinage
  16 fois).

### En-têtes

- **`Entete(Ent, PosX, PosY, Bold, Ba4)`** [nécessaire] [GUI] : texte en Helvetica normal 10
  (A4) ou 9, cellule 40 × 8. ⚠️ Le paramètre `Bold` est **ignoré** (Moulinage passe `1`, Caisse
  `""`). `PosX`/`PosY` sont typés `String` et convertis implicitement par la multiplication.
  Utilisé par Caisse (ligne 9 de l'en-tête, en-tête facture) et Moulinage (30 appels).
- **`Entete2(Ent, PosX, PosY, Fonte, Ba4)`** [nécessaire] [GUI] : idem avec style `Fonte`
  (`"B"` ou `""`) et taille 12 (A4) ou 9. En-tête société du ticket et de la facture (Caisse).
- **`Entete3(Ent, PosY, Bold, Ba4)`** [nécessaire] [GUI] : adresse client du bon de caisse, en
  X = 60 ; style `Bold`, taille 12 ou 9. `SetXY` dupliqué dans les deux branches.
- **`Level3(Ent, PosY, Ba4)`** [nécessaire] [GUI] : titre gras (12 ou 10) du livre de caisse
  (Moulinage).
- **`Com(Comm, PosY)`** [nécessaire] [GUI] : commentaire (taille 8 ou 7 selon `Caisse.Ba4`) :
  « Bon de caisse… », numéro de carte (Caisse).

### Tableaux

- **`Level2T(PosX, PosY)`** [nécessaire] [GUI] : en-tête de colonnes du ticket (Code 18,
  Intitulé 54, Prix 12, Qte 8), fond `R/G/B`, police 9 ou 8 selon `Caisse.Ba4`.
- **`Level1(Code, Intitule, prix, qte, PosX, PosY, Typel)`** [nécessaire] [GUI] (CC 8, max du
  fichier) : ligne de ticket. Code tronqué à `Round($fratio * 13)` caractères ; intitulé tronqué à
  `40 × $fratio` (si `Caisse.Ba4`) ou `34 × $fratio`, sauf `Typel = "K"` (commentaire : pleine
  largeur, sans prix ni quantité). Les branches `Typel = "TA"` et « autre » sont **identiques**.
  Utilisé par Caisse (`Defaut_Tk`) et Moulinage (12 appels, `Typel = ""`).
- **`Level1T(…)`** [réductible → code mort] : variante « ticket défaut » jamais appelée (signal
  `unused` de `deps.py`, confirmé par `grep` : les `pdf.Level1T(Posy)` de `Traites` et `Lcr` portent
  sur `Ccompta`). Mêmes branches identiques que `Level1` ; `SetXY(4, …)` sans rapport.
- **`Level2E(PosY)` / `Level2(Intitule, prix, qte, PosY)`** [nécessaire] [GUI] : en-tête et lignes
  du livre de caisse (Intitulé 80, Prix 12, Qte 12), Moulinage uniquement.
- **`Level2F(PosY)` / `Level4(Code, Intitule, prix, qte, PosY)`** [nécessaire] [GUI] : en-tête et
  lignes de la facture de caisse. Les deux branches `If Caisse.Ba4` de choix de police sont
  **identiques** (taille 8) ; seule la troncature de l'intitulé (40 ou 28) dépend de `Caisse.Ba4`.
- **`Lines(PosY)` / `Lines2(PosY)`** [nécessaire] [GUI] : trait horizontal de 0 à 210 (resp. 110)
  × `$xratio`. Le `SetXY` qui précède `Line` est sans effet sur le tracé.

### Logo et pied de page

- **`Logo2(type, Ba4)`** [nécessaire] [GUI] : si `/Soc<XX>/caisse/logo` est vrai, lit le chemin
  `/Soc<XX>/caisse/ilogo` et place l'image en (92, 2, 20 × 18) pour une facture A4, sinon en
  (40, 2, 30 × 17). Coordonnées **non mises à l'échelle**. Un fichier absent ou d'un type autre
  que JPG/PNG lève une erreur dans `PdfWriter.Image` (lignes 1355/1364), non interceptée ici ;
  `Caisse.Defaut_Tk` n'a pas de `Catch` (CFACTURE-A03). C'est la version **utilisée** (Caisse
  5242 et 6711).
- **`Logo()`** [réductible → code mort] : ancienne version fondée sur `/Soc<XX>/glogo` et
  `/Soc<XX>/Logo` (logo société de la gestion), jamais appelée (signal `unused` confirmé :
  `Bordereaux.class:153` appelle `Cbordereaux.Logo`). Calcul de ratio entier (`iFormat As
  Integer`) et test `If Not Error` placé après plusieurs instructions : défauts sans objet puisque
  la fonction est morte. Copie quasi identique de `Creleve.Logo` (`Creleve.class:163`).
- **`BasPage()`** [nécessaire] [GUI] : `Function` sans type de retour ; pied de page « Page n/{nb}
  - date heure - Impression demandée par <User.Name> ». Moulinage uniquement (16 appels). Proche de
  `Ccompta.BasPage` (`Ccompta.class:31`) mais différent (largeur 190, date sans heure, couleur).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` : couleurs du thème (fond des en-têtes de tableau).
- `Start.LocalSettings["/Soc<XX>/caisse/logo"]`, `["/Soc<XX>/caisse/ilogo"]` (`Logo2`),
  `["/Soc<XX>/glogo"]`, `["/Soc<XX>/Logo"]` (`Logo`, mort), `Start.Societe`.
- `Caisse.Ba4` : **auto-instance** du formulaire `Caisse` (voir vue d'ensemble). Lire ce membre
  crée l'auto-instance s'il n'existe pas encore (chargement du formulaire, sans `Form_Open`),
  y compris quand `Moulinage.Livre_caisse` est lancé depuis l'écran Moulinage (à confirmer).
- `User.Name`, `Now` (`BasPage`).
- **Pas d'accès à `Fiches_Societes`** : l'en-tête société est préparé par l'appelant
  (`Caisse.Entete.Text`, `Entetet`, `$iSpc`). La proposition `Utils.LitSociete` est sans objet
  pour cette classe.

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `Taille(bA4 As Boolean, iA4 As Integer, iAutre As Integer) As Integer` renvoyant
  `Round($fratio * …)` : remplace les 11 blocs `If … SetFont … Else … SetFont … Endif`.
- Fusionner les branches identiques (`Typel = "TA"` de `Level1`/`Level1T`, `If Caisse.Ba4` de
  `Level2F`/`Level4`, `SetXY` d'`Entete3`) : sortie PDF identique.
- `Lines`/`Lines2` → un helper privé `Trait(PosY, largeur)`.
- Supprimer `Logo`, `Level1T` et `_free` (code mort).

### Commonalisation avec d'autres fichiers

- `newPage`, `BasPage`, `Logo` existent sous des formes voisines dans la plupart des 23 classes
  `Inherits PdfWriter` (`Ccompta`, `Creleve`, `Cdocuments`, `Cbordereaux`…). Une classe
  intermédiaire (ou des méthodes paramétrées dans `PdfWriter`) est à étudier au lot Reports ;
  les textes diffèrent légèrement, donc **pas** de fusion sans tests de caractérisation PDF.
- La table des rapports par format n'existe que dans `Cfacture` (pas de duplication).

### Réduction de portée

- `Level1T`, `Logo` : aucun appelant ; ils sont supprimés (CFACTURE-002) plutôt que rendus
  `Private`. Les autres méthodes publiques ont toutes un appelant externe.

### Séparation traitement / GUI

- Sans objet : classe de rendu pure, aucun calcul métier ni SQL. Seul couplage à corriger :
  la lecture de `Caisse.Ba4` (dépendance vers un formulaire), qui relève de l'anomalie A01.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
