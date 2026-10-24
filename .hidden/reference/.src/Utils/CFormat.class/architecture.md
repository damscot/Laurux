# CFormat — Architecture

> Source : `.src/Utils/CFormat.class`

## Vue d'ensemble

`CFormat` (auteur Fabien Bodard) est un **objet valeur « format d'affichage »** : fond, texte,
alignement, police, marge interne, largeur, hauteur et format numérique. Une valeur `-1` (ou `Null`
pour la police et le format) signifie « non défini ».

Il se **sérialise** en chaîne `"Background: &HRRGGBB&; Foreground: …; Font: …; Alignment: Left; …"`
(`ToString`) et se **désérialise** par l'opérateur de classe `CFormat["…"]` (méthode statique
`_Get`). C'est le format de stockage des couleurs d'écran dans `Laurux.conf` (section `/Coul/…`,
écrit par [`SetColors`](../SetColors.class/architecture.md)) et des touches de caisse
(`/Soc<XX>/caisse/<tag>`, écrit par `Attrib`), ainsi que des formats de colonnes de
[`RichDataGrid`](../RichDataGrid.class/architecture.md) (`Remisec`).

Nature : **calcul pur** (aucun accès à la base ni aux contrôles), mais dépendant de `gb.gui`
(`Font`, `Classes["Align"]`). Seul effet de bord : `Print` sur la sortie standard en cas de format
invalide.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$iBackground` | var | Private |  | Integer | 7 |
| `$oFont` | var | Private |  | Font | 8 |
| `$iAlignment` | var | Private |  | Integer | 9 |
| `$iForeground` | var | Private |  | Integer | 10 |
| `$iPadding` | var | Private |  | Integer | 11 |
| `$iWidth` | var | Private |  | Integer | 12 |
| `$iHeight` | var | Private |  | Integer | 13 |
| `$sFormat` | var | Private |  | String | 14 |
| `Background` | property | Public |  | Integer | 16 |
| `Foreground` | property | Public |  | Integer | 17 |
| `Alignment` | property | Public |  | Integer | 18 |
| `Font` | property | Public |  | Font | 19 |
| `Padding` | property | Public |  | Integer | 20 |
| `Width` | property | Public |  | Integer | 21 |
| `Height` | property | Public |  | Integer | 22 |
| `Format` | property | Public |  | String | 23 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_Get` | 25-61 | Public Static | 13 | 34 | 3 | méthode spéciale |
| `ToString` | 63-86 | Public | 18 | 20 | 1 |  |
| `Background_Read` | 88-92 | Private | 1 | 3 | 0 |  |
| `Background_Write` | 94-98 | Private | 1 | 3 | 0 |  |
| `Foreground_Read` | 100-104 | Private | 1 | 3 | 0 |  |
| `Foreground_Write` | 106-110 | Private | 1 | 3 | 0 |  |
| `Alignment_Read` | 112-116 | Private | 1 | 3 | 0 |  |
| `Alignment_Write` | 118-122 | Private | 1 | 3 | 0 |  |
| `Font_Read` | 124-128 | Private | 1 | 3 | 0 |  |
| `Font_Write` | 130-134 | Private | 1 | 3 | 0 |  |
| `Padding_Read` | 136-140 | Private | 1 | 3 | 0 |  |
| `Padding_Write` | 142-146 | Private | 1 | 3 | 0 |  |
| `Copy` | 148-156 | Public | 1 | 5 | 0 | portée réductible ? |
| `Width_Read` | 158-162 | Private | 1 | 3 | 0 |  |
| `Width_Write` | 164-168 | Private | 1 | 3 | 0 |  |
| `Height_Read` | 170-174 | Private | 1 | 3 | 0 |  |
| `Height_Write` | 176-180 | Private | 1 | 3 | 0 |  |
| `Format_Read` | 182-186 | Private | 1 | 3 | 0 |  |
| `Format_Write` | 188-192 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_Get(sFormat) As CFormat`** [Static, portée : nécessaire] [nature : calcul, CC 13].
  Supprime le `;` final, passe **toute la chaîne en minuscules**, découpe sur `;` puis chaque
  élément par `Scan(s, "*: *")` et affecte la propriété correspondante : `background`/`foreground`
  (`Val`, accepte `&HRRGGBB&` et le décimal), `font` (`Font[…]`), `padding`, `width`, `height`
  (`Val`), `alignment` (`Classes["Align"][nom].Value` sous `Try`), `format`.
  Clé inconnue : `Print "Error: Bad Format String"`. Toute erreur (ex. élément sans `": "`, qui
  rend `spl[0]` invalide) est rattrapée par `Catch` : message imprimé et objet partiellement rempli
  renvoyé. Une chaîne vide ou `Null` renvoie un format entièrement « non défini ».
  ⚠️ `format` est affecté par `Val(spl[1])` : un format `"0.000"` devient le nombre 0, puis la
  chaîne `"0"` (anomalie, utilisée par `Remisec`).
  ⚠️ Le passage en minuscules s'applique aussi au nom de police et au nom d'alignement :
  `Classes["Align"]["left"]` dépend de l'insensibilité à la casse de la recherche de symbole
  (à confirmer par test).
- **`ToString() As String`** [portée : nécessaire] [nature : calcul, CC 18, max du fichier].
  Concatène les éléments définis : couleurs en `&H` + 6 chiffres hexadécimaux, police par
  `Font.ToString()`, alignement par recherche inverse dans les constantes de `Align`.
  ⚠️ Si aucune constante ne correspond, la boucle se termine sur le dernier symbole et c'est ce nom
  qui est écrit. Utilisé par `SetColors.Coul_DblClick` pour enregistrer la configuration.
- **`Copy() As CFormat`** [portée : réductible — **code mort**, aucun appelant] : copie par
  aller-retour `CFormat[Me.ToString()]` (perd le format numérique, cf. `_Get`). Le `New CFormat`
  de la déclaration est inutile.
- **Accesseurs** `Background`, `Foreground`, `Alignment`, `Font`, `Padding`, `Width`, `Height`,
  `Format` (`*_Read`/`*_Write`, privés) : lecture/écriture directe des membres `$i…`/`$o…`/`$s…`,
  sans validation.

## État global utilisé

- Aucun état Laurux. Dépend de `gb.gui` (`Font`, classe `Align` via `Classes[]`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `ToString` : helper privé `Defini(v As Integer) As Boolean` pour les 6 tests
  `Not (IsNull(x) Or x = -1)` (CC 18 → ≤ 8).
- Recherche de l'alignement (nom ↔ valeur) factorisée dans deux helpers privés partagés par `_Get`
  et `ToString`, avec un comportement identique (dernier symbole si aucune correspondance).
- Supprimer `Copy` (code mort) et les `New` inutiles (`Dim spl As New String[]`,
  `Dim hFormat As New CFormat` de `Copy`).

### Commonalisation avec d'autres fichiers

- **Application d'un `CFormat` à un contrôle** : le même bloc (fond/texte avec repli
  `Color.TextBackground`/`TextForeground`, alignement avec repli `Align.Left`, police) est répété
  dans [`SetColors`](../SetColors.class/architecture.md) (`Coul_DblClick`, `InitTxtB`),
  [`FSetFormat`](../FSetFormat.class/architecture.md) (`Form_Open`), `Attrib.Clav2_Dblclick`
  (lignes 129-135 et 355-361) et [`RichDataGrid`](../RichDataGrid.class/architecture.md)
  (`Grid_Data`, deux fois). Proposition : une méthode `Public Sub Applique(hCtrl As Object)` dans
  `CFormat` reprenant exactement la sémantique de `SetColors.InitTxtB`.
- Les valeurs par défaut des couleurs (`"Background: &HDDDDDD&; "`…) sont écrites en dur dans
  `Start.module` (lignes 132-149), `Fmenu.class` (lignes 437-450) et `SetColors.Button2_Click` :
  candidates à des constantes communes (voir SetColors).

### Réduction de portée

- `Copy` : aucun appelant (vérifié par `grep '\.Copy()'`) → suppression plutôt que `Private`.
- `_Get` et `ToString` sont nécessaires.

### Séparation traitement / GUI

- Le seul couplage hors calcul est le `Print` des erreurs ; il est conservé tel quel (sortie
  standard, pas de boîte de dialogue).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base. Les formats sont stockés dans `Laurux.conf`.
