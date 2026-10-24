# RichDataGrid — Architecture

> Source : `.src/Utils/RichDataGrid.class`

## Vue d'ensemble

`RichDataGrid` (auteur Fabien Bodard) **enrichit un `GridView` existant** en grille liée à une
table : il s'y attache par `Object.Attach($hGrid, Me, "Grid")`, exécute
`SELECT * FROM <Table> [WHERE <Filter>] ORDER BY …`, fournit les cellules à la demande
(`Grid_Data`), applique des formats par colonne (`ColFormats`, objets
[`CFormat`](../CFormat.class/architecture.md)) et des formats conditionnels (`CondFormats`, objets
`Conditions`), trie au clic sur l'en-tête et propose une recherche « commence par » dans une
`TextBox` superposée (clic droit sur une colonne). La valeur du champ `DataField` de la ligne
sélectionnée est exposée par `Value` et les événements `Select` / `Activate`.

Unique utilisateur : `Gestion/Tables/Remisec.class` (remises par type de client), qui l'instancie
sur son `GridView` `Tabtypec` avec le **même nom d'événement** (`New RichDataGrid(Tabtypec) As
"Tabtypec"`).

Nature : mixte (SQL + affichage). ⚠️ Le SQL passe par `db.Exec`, c'est-à-dire la classe statique
`DB` de gb.db (connexion courante), et **non** par `Utils.db` : pas de réécriture SQLite, pas de
journalisation `Exec_SQL`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$hGrid` | var | Private |  | GridView | 8 |
| `$sTable` | var | Private |  | String | 10 |
| `$sFilter` | var | Private |  | String | 11 |
| `$aDisplay` | var | Private |  | New String[] | 12 |
| `$aFields` | var | Private |  | New String[] | 13 |
| `$hResult` | var | Private |  | Result | 14 |
| `$vValue` | var | Private |  | Variant | 16 |
| `$sDataField` | var | Private |  | String | 17 |
| `$Desc` | var | Private |  | Boolean | 20 |
| `$aCondFormats` | var | Private |  | New Object[] | 22 |
| `$oFormatDefaut` | var | Private |  | New CFormat | 23 |
| `$oColFormat` | var | Private |  | New Object[] | 24 |
| `$sOrder` | var | Private |  | String | 26 |
| `$htxtbSearch` | var | Private |  | TextBox | 27 |
| `$bHeadersModified` | var | Private |  | Boolean | 28 |
| `Filter` | property | Public |  | String | 30 |
| `Fields` | property | Public |  | String[] | 31 |
| `Display` | property | Public |  | String[] | 32 |
| `DataField` | property | Public |  | String | 33 |
| `Table` | property | Public |  | String | 35 |
| `Tag` | property | Public |  | Variant | 36 |
| `Header` | property | Public |  | Integer | 37 |
| `Value` | property | Public |  | Variant | 38 |
| `Result` | property | Public |  | Result | 39 |
| `CondFormats` | property | Public |  | Object[] | 41 |
| `ColFormats` | property | Public |  | Object[] | 42 |
| `Grid` | property | Public |  | GridView | 44 |
| `Select` | event | Public |  |  | 46 |
| `Activate` | event | Public |  |  | 47 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 49-68 | Public | 1 | 15 | 0 | méthode spéciale |
| `MakeGridHeaders` | 70-93 | Private | 4 | 15 | 0 |  |
| `Refresh` | 95-124 | Public | 7 | 22 | 1 |  |
| `Grid_Data` | 126-186 | Public | 24 | 34 | 0 | handler GUI |
| `Grid_ColumnClick` | 188-194 | Public | 2 | 5 | 0 | handler GUI |
| `Filter_Read` | 196-200 | Private | 1 | 3 | 0 |  |
| `Filter_Write` | 202-206 | Private | 1 | 3 | 0 |  |
| `Table_Read` | 208-212 | Private | 1 | 3 | 0 |  |
| `Table_Write` | 214-218 | Private | 1 | 3 | 0 |  |
| `Fields_Read` | 220-224 | Private | 1 | 3 | 0 |  |
| `Fields_Write` | 226-232 | Private | 1 | 4 | 0 |  |
| `Tag_Read` | 234-238 | Private | 1 | 3 | 0 |  |
| `Tag_Write` | 240-244 | Private | 1 | 3 | 0 |  |
| `Display_Read` | 246-250 | Private | 1 | 3 | 0 |  |
| `Display_Write` | 252-258 | Private | 1 | 4 | 0 |  |
| `Header_Read` | 260-264 | Private | 1 | 3 | 0 |  |
| `Header_Write` | 266-271 | Private | 1 | 3 | 0 |  |
| `Value_Read` | 273-277 | Private | 1 | 3 | 0 |  |
| `DataField_Read` | 279-283 | Private | 1 | 3 | 0 |  |
| `DataField_Write` | 285-289 | Private | 1 | 3 | 0 |  |
| `Result_Read` | 291-295 | Private | 1 | 3 | 0 |  |
| `CondFormats_Read` | 297-301 | Private | 1 | 3 | 0 |  |
| `CondFormats_Write` | 303-307 | Private | 1 | 3 | 0 |  |
| `Grid_Select` | 309-316 | Public | 2 | 6 | 0 | handler GUI |
| `ColFormats_Read` | 318-322 | Private | 1 | 3 | 0 |  |
| `ColFormats_Write` | 324-328 | Private | 1 | 3 | 0 |  |
| `Grid_Read` | 330-334 | Private | 1 | 3 | 0 |  |
| `txtSearch_KeyPress` | 336-356 | Public | 5 | 13 | 0 | handler GUI |
| `txtSearch_LostFocus` | 358-362 | Public | 1 | 3 | 0 | handler GUI |
| `txtSearch_Change` | 364-368 | Public | 1 | 3 | 0 | handler GUI |
| `Grid_Activate` | 370-377 | Public | 2 | 6 | 0 | handler GUI |
| `Grid_MouseUp` | 379-389 | Public | 3 | 9 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et chargement

- **`_New(hGrid)`** [portée : nécessaire] [GUI]. Attache la grille (événements `Grid_*`), mode de
  sélection simple, crée la `TextBox` de recherche cachée `As "txtSearch"` sur le parent de la
  grille, initialise `$oFormatDefaut` (jamais relu ensuite : code mort).
- **`MakeGridHeaders()`** [privé] [GUI]. Nombre de colonnes = nombre de champs ; titre = `Display`
  ou nom du champ ; largeur = `ColFormats[i].Width` (sans test de -1).
- **`Refresh()`** [portée : nécessaire, `Remisec:76,283,316`] [mixte, CC 7]. Vide la grille, fixe
  l'ordre par défaut sur le premier champ, compose le filtre (`Filter` + recherche
  `champ LIKE '<texte>%'`), exécute `db.Exec("SELECT * FROM " & Table & …)`, dimensionne les
  lignes, dessine les en-têtes si nécessaire. Toute erreur est **silencieusement ignorée**
  (`Catch` vide). ⚠️ Le texte recherché est concaténé dans le SQL (une apostrophe rend la requête
  invalide, erreur masquée). Variable `sFind` toujours vide.

### Affichage

- **`Grid_Data(Row, Column)`** [handler] [mixte, CC 24, max du fichier]. Se positionne sur la
  ligne du `Result`, applique le `CFormat` de la colonne (alignement, fond, texte, police, marge,
  format), puis chaque condition vraie (`Conditions.Compute`), et écrit le texte : `Format$` si la
  valeur est numérique et qu'un format existe, texte brut sinon ; cas particulier codé en dur pour
  la colonne `datebl` (`Utils.Cdate_Aff`).
  ⚠️ Les conditions utilisent `hFormat.BackColor`/`ForeColor`, propriétés **inexistantes** de
  `CFormat` (reliquat Gambas 2) : erreur dès qu'une condition s'applique (non utilisé par
  `Remisec`). ⚠️ Ligne 179 : `A Or B And C` est évalué `A Or (B And C)` : un Float est formaté même
  sans format.
- **`Grid_ColumnClick(Column)`** [handler] [mixte]. Inverse l'ordre et trie sur la colonne,
  `Refresh`.
- **`Grid_MouseUp()`** [handler] [GUI]. Clic droit : place la `TextBox` de recherche sur la
  colonne, la vide si la colonne change, lui donne le focus.
- **`txtSearch_KeyPress()`** [handler] [GUI]. Échap masque et vide ; seuls les caractères
  `a-z à é ç è 0-9 espace _-.()[]&~@*%` sont acceptés (Retour arrière/Suppr autorisés).
  **`txtSearch_Change()`** : `Refresh`. **`txtSearch_LostFocus()`** : masque.

### Sélection

- **`Grid_Select()`** / **`Grid_Activate()`** [handlers] [mixte]. Lisent `DataField` sur la ligne
  courante dans `$vValue` et lèvent `Select` / `Activate` ; erreurs ignorées (`Catch`).

### Propriétés

`Filter`, `Table`, `Fields`, `Display`, `DataField`, `CondFormats`, `ColFormats`, `Header`, `Tag`
(lecture/écriture), `Value`, `Result`, `Grid` (lecture). Accesseurs triviaux sauf :
⚠️ `Tag_Write` écrit `$hGrid.table` (propriété inexistante) au lieu de `$hGrid.Tag` ;
`Fields_Write`/`Display_Write` forcent le redessin des en-têtes. `Grid_Read` est l'accesseur de la
propriété `Grid` ; son nom coïncide avec le préfixe d'événements `Grid` (pas d'événement `Read` sur
`GridView`, donc sans effet — à confirmer).

## Événements gérés / levés

- Gérés : `Grid_Data`, `Grid_ColumnClick`, `Grid_Select`, `Grid_Activate`, `Grid_MouseUp`,
  `txtSearch_KeyPress`, `txtSearch_Change`, `txtSearch_LostFocus`.
- Levés : `Select`, `Activate`. `Remisec` reçoit `Select` dans `Tabtypec_Select` (ligne 108) ;
  il n'a pas de handler `Tabtypec_Activate`. Comme `Object.Attach` détourne les événements du
  `GridView` vers `RichDataGrid`, `Tabtypec_Select` n'est appelé que via `Raise Select`.

## État global utilisé

- Classe `DB` (gb.db, connexion courante) ; `Utils.Cdate_Aff`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser l'application d'un format (colonne et conditions) dans un helper privé
  `AppliqueFormat(hFormat, bConditionnel)` en conservant les deux variantes actuelles
  (CC 24 → ≤ 10).
- Supprimer le code mort : `$oFormatDefaut` et son initialisation, `sFind`, blocs commentés
  `[GB2:…]` et anciennes propriétés commentées.
- Rendre le cas `datebl` paramétrable (format de colonne « date ») : à faire seulement si un
  second utilisateur apparaît.

### Commonalisation avec d'autres fichiers

- [`DataButtonList`](../DataButtonList.class/architecture.md) partage le même modèle de propriétés
  (`Table`/`Fields`/`Display`/`Filter`/`DataField`/`Value`) mais est mort : rien à commonaliser.
- Recherche « commence par » : même besoin que la fenêtre de recherche de
  [`TextReg`](../TextReg.class/architecture.md) (`affgrd`, `LIKE &1` paramétré) ; un helper commun
  `Utils.LikeFiltre(champ, texte, mode)` renvoyant un fragment `Utils.db.Subst` servirait aux deux.
- Application d'un `CFormat` : voir `CFormat.Applique` (CFORMAT-004) ; ici la cible est
  `GridView.Data`, la sémantique (`-1` = ne rien faire) diffère de `SetColors` : à vérifier avant
  de partager.

### Réduction de portée

- Aucune possible sans risque : `Refresh` est utilisé par `Remisec`, les handlers sont
  intouchables. Les propriétés non utilisées par `Remisec` (`Filter`, `Header`, `Tag`, `Result`,
  `Grid`, `CondFormats`) sont l'API du composant ; les supprimer serait du code mort à arbitrer
  avec l'utilisateur.

### Séparation traitement / GUI

- `Refresh` : extraire la construction de la requête dans une fonction pure
  `Requete(table, filtre, recherche, champ, ordre) As String` (testable en gb.test), l'exécution et
  le dessin restant dans `Refresh`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `SELECT *` relu à chaque frappe de recherche : sur une grosse table, un index sur le champ
  recherché et une limite de lignes seraient nécessaires (sans objet pour `Fiches_RemTypec`).
