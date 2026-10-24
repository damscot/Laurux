# DataButtonList — Architecture

> Source : `.src/Utils/DataButtonList.class`

## Vue d'ensemble

`DataButtonList` (auteur Fabien Bodard) est un composant générique « bouton bascule + liste
déroulante liée à une table » : il s'attache à un `ToggleButton` existant (passé au constructeur),
ouvre au clic une fenêtre sans bordure contenant une `ColumnView` remplie par
`DB.Find(Table, Filter)`, et expose la valeur du champ `DataField` de la ligne choisie (`Value`,
événement `Change`). Sans table, il lève `Input(cview)` pour que l'appelant remplisse la liste.

**La classe n'a aucun appelant** : `grep -rni 'DataButtonList' .src` (classes, modules, `.form`)
ne trouve que le fichier lui-même. C'est du **code mort**, importé avec
[`RichDataGrid`](../RichDataGrid.class/architecture.md) et [`CFormat`](../CFormat.class/architecture.md),
qui eux sont utilisés.

Nature : GUI + lecture de base via `DB.Find` (connexion courante de gb.db, et non `Utils.db`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$hForm` | var | Private |  | Form | 8 |
| `$htvw` | var | Private |  | ColumnView | 9 |
| `$hbtnObs` | var | Private |  | Observer | 10 |
| `$hObsWin` | var | Private |  | Observer | 11 |
| `$sTable` | var | Private |  | String | 12 |
| `$sFilter` | var | Private |  | String | 13 |
| `$aDisplay` | var | Private |  | New String[] | 14 |
| `$aFields` | var | Private |  | New String[] | 15 |
| `$hResult` | var | Private |  | Result | 16 |
| `$hButton` | var | Private |  | ToggleButton | 17 |
| `$aColumnsWidth` | var | Private |  | New Integer[] | 18 |
| `$iTotalWidth` | var | Private |  | Integer | 19 |
| `$vValue` | var | Private |  | Variant | 21 |
| `$vDataField` | var | Private |  | Variant | 22 |
| `$iDisposition` | var | Private |  | Integer | 23 |
| `Filter` | property | Public |  | String | 25 |
| `Fields` | property | Public |  | String[] | 26 |
| `Display` | property | Public |  | String[] | 27 |
| `DataField` | property | Public |  | Variant | 28 |
| `Table` | property | Public |  | String | 30 |
| `Picture` | property | Public |  | Picture | 31 |
| `Tag` | property | Public |  | Variant | 32 |
| `Header` | property | Public |  | Boolean | 33 |
| `Value` | property | Public |  | Variant | 35 |
| `Disposition` | property | Public |  | Integer | 36 |
| `Result` | property | Public |  | Result | 37 |
| `ColumnView` | property | Public |  | ColumnView | 38 |
| `ColumnsWidth` | property | Public |  | Integer[] | 39 |
| `Change` | event | Public |  |  | 43 |
| `Input` | event | Public |  |  | 44 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 46-90 | Public | 2 | 27 | 0 | méthode spéciale |
| `Toggle` | 92-98 | Public | 1 | 5 | 0 | portée réductible ? |
| `tglb_Click` | 100-125 | Public | 6 | 21 | 0 | handler GUI |
| `LoadValues` | 127-181 | Private | 13 | 38 | 0 |  |
| `GridView_Data` | 183-188 | Public | 1 | 4 | 0 | handler GUI |
| `Form_DeACtivate` | 190-195 | Public | 1 | 4 | 0 | handler GUI |
| `Filter_Read` | 197-201 | Private | 1 | 3 | 0 |  |
| `Filter_Write` | 203-207 | Private | 1 | 3 | 0 |  |
| `Table_Read` | 209-213 | Private | 1 | 3 | 0 |  |
| `Table_Write` | 215-219 | Private | 1 | 3 | 0 |  |
| `Fields_Read` | 221-225 | Private | 1 | 3 | 0 |  |
| `Fields_Write` | 227-231 | Private | 1 | 3 | 0 |  |
| `Picture_Read` | 233-237 | Private | 1 | 3 | 0 |  |
| `Picture_Write` | 239-243 | Private | 1 | 3 | 0 |  |
| `Tag_Read` | 245-249 | Private | 1 | 3 | 0 |  |
| `Tag_Write` | 251-255 | Private | 1 | 3 | 0 |  |
| `Display_Read` | 257-261 | Private | 1 | 3 | 0 |  |
| `Display_Write` | 263-267 | Private | 1 | 3 | 0 |  |
| `Header_Read` | 269-273 | Private | 1 | 3 | 0 |  |
| `Header_Write` | 275-279 | Private | 1 | 3 | 0 |  |
| `ColumnView_KeyPress` | 293-298 | Public | 4 | 4 | 0 | handler GUI |
| `ColumnView_Click` | 300-307 | Public | 1 | 5 | 0 | handler GUI |
| `ColumnView_Select` | 309-327 | Public | 3 | 9 | 0 | handler GUI |
| `Value_Read` | 329-333 | Private | 1 | 3 | 0 |  |
| `DataField_Read` | 335-339 | Private | 1 | 3 | 0 |  |
| `DataField_Write` | 341-345 | Private | 1 | 3 | 0 |  |
| `ColumnView_MouseMove` | 347-353 | Public | 2 | 4 | 0 | handler GUI |
| `tglb_KeyPress` | 355-363 | Public | 4 | 7 | 0 | handler GUI |
| `Disposition_Read` | 365-369 | Private | 1 | 3 | 0 |  |
| `Disposition_Write` | 371-375 | Private | 1 | 3 | 0 |  |
| `_Get` | 377-381 | Public | 2 | 3 | 0 | méthode spéciale |
| `ObsWin_Move` | 383-398 | Public | 6 | 14 | 0 | handler GUI |
| `ObsWin_Close` | 400-404 | Public | 2 | 3 | 0 | handler GUI |
| `Result_Read` | 406-410 | Private | 1 | 3 | 0 |  |
| `ColumnView_Read` | 412-416 | Private | 1 | 3 | 0 |  |
| `ColumnsWidth_Read` | 418-422 | Private | 1 | 3 | 0 |  |
| `ColumnsWidth_Write` | 424-428 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions sont du code mort (aucune instance n'est créée).

### Construction et affichage

- **`_New(hButon)`** : crée deux `Observer` (bouton `As "tglb"`, fenêtre du bouton `As "ObsWin"`),
  une `Form` sans bordure attachée `As "Form"`, un `Panel` et une `ColumnView` `As "ColumnView"`
  (fond selon `/Soc<XX>/Coul_fen`). [nature : GUI]
- **`Toggle()`** : force le bouton enfoncé et ouvre la liste. [GUI] (`deps.py` : réductible)
- **`tglb_Click()`** : si le bouton est enfoncé, charge les valeurs (`LoadValues`) et positionne
  la fenêtre selon `Disposition` (`Align.Left/Right/Top/Bottom`), sinon la masque. [GUI]
- **`LoadValues()`** [privé] : remplit la `ColumnView` depuis `DB.Find($sTable, $sFilter)`
  (une colonne par champ + une colonne de 3 px), applique les largeurs, calcule la largeur de la
  fenêtre. Lève `Error.Raise` en anglais si aucun champ. [mixte]
- **`ObsWin_Move()` / `ObsWin_Close()`** : suit le déplacement de la fenêtre parente (même code de
  positionnement que `tglb_Click`, dupliqué) / ferme la liste. [GUI]

### Sélection

- **`ColumnView_Select()`** : lit `DataField` dans la `ColumnView` (sans table) ou dans le
  `Result` (`MoveTo(Val(Key))`). **`ColumnView_Click()`** : sélection + `Raise Change` + fermeture.
  **`ColumnView_KeyPress()`**, **`tglb_KeyPress()`** : Échap ferme, Entrée valide ou ouvre.
  **`ColumnView_MouseMove()`** : sélection au survol. **`Form_DeACtivate()`** : relâche le bouton
  et ferme. **`GridView_Data()`** : reliquat d'une version `GridView` (jamais déclenché, aucun
  objet `As "GridView"`). **`_Get(id)`** : valeur de la colonne `id` de la ligne courante.

### Propriétés

`Filter`, `Table`, `Fields`, `Display`, `DataField`, `Picture`, `Tag`, `Header`, `Disposition`,
`ColumnsWidth` (lecture/écriture) ; `Value`, `Result`, `ColumnView` (lecture). Accesseurs
triviaux, sauf ⚠️ `Tag_Write` qui écrase `$hButton` par la valeur au lieu d'écrire
`$hButton.Tag` (défaut latent). ⚠️ `ColumnView_Read` est à la fois l'accesseur de la propriété
`ColumnView` et un nom de handler potentiel du groupe d'événements `"ColumnView"`.

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/Coul_fen"]`.
- `DB.Find` : connexion courante gb.db (`DB.Current`), sans passer par `Utils.db`
  (pas de réécriture SQLite ni de journalisation).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : la classe doit être **supprimée**.

### Commonalisation avec d'autres fichiers

- Même famille que [`RichDataGrid`](../RichDataGrid.class/architecture.md) (propriétés
  `Table`/`Fields`/`Display`/`Filter`/`DataField`/`Value` identiques). Si un composant de liste
  liée à une table est un jour nécessaire, il faudra repartir de `RichDataGrid` ou de la fenêtre de
  recherche de [`TextReg`](../TextReg.class/architecture.md) plutôt que de cette classe.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (code mort).
