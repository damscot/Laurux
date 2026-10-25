# ImageButton — Architecture

> Source : `.src/Caisse/ImageButton.class`

## Vue d'ensemble

`ImageButton` est le **contrôle graphique des touches de la caisse tactile** : un `UserControl`
exporté (`Export`, `Inherits UserControl`) qui dessine lui-même un bouton arrondi en dégradé
(via [`MyStyle.DrawButton`](../MyStyle.class/architecture.md)), une image semi-transparente
centrée et un texte blanc centré. Il lève un seul événement, `Click`.

Utilisateurs (vérifiés par `grep`) :
- [`Caisse`](../Caisse.class/architecture.md) : 35 contrôles `ImageButton` du groupe `Clav2`
  dans `Caisse.form` (touches de familles), et des touches de sous-familles créées par code
  (`New (ImageButton, hpan) As "Clav3"`, `Caisse.class:8673`) ;
- [`Attrib`](../Attrib.class/architecture.md) : 35 contrôles dans `Attrib.form` et création
  dynamique identique (`Attrib.class:278`), écran d'attribution des touches.
Le texte, la couleur (`BackGround`) et l'image (`Picture`) viennent de la table des touches
(`Cbase.Table("TabTouches")`, lue par ces écrans, pas par `ImageButton`).

Propriétés exposées à l'EDI : `_Properties = "*,Picture,Text, Background{Color}"`,
événement par défaut `Click`. La propriété `BackGround` (casse différente) **masque**
`Control.Background` : elle ne change que la couleur passée à `DrawButton`, `Me.Background`
garde sa valeur initiale.

Nature : **GUI** pure (dessin et événements), sans SQL ni état global.

⚠️ Rejeu : `Utils.Recursive_Observers` n'attache d'observateur qu'aux classes natives listées
(`Button`, `Panel`, `Label`…) ; un `UserControl` `ImageButton` n'est pas observé, donc les
touches de la caisse ne sont **pas journalisées** (voir test.md).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `_Properties` | const | Public |  |  | 5 |
| `_DefaultEvent` | const | Public |  |  | 6 |
| `$hView` | var | Private |  | DrawingArea | 7 |
| `Picture` | property | Public |  | Picture | 8 |
| `Position` | property | Public |  | Integer | 9 |
| `$iPosition` | var | Private |  | Integer | 10 |
| `$bHover` | var | Private |  | Boolean | 11 |
| `$bFocus` | var | Private |  | Boolean | 12 |
| `$bMouseDown` | var | Private |  | Boolean | 13 |
| `Text` | property | Public |  | String | 14 |
| `$sText` | var | Private |  | String | 15 |
| `$hPicture` | var | Private |  | Picture | 16 |
| `$htmpPic` | var | Private |  | Picture | 17 |
| `$iBackground` | var | Private |  | Integer | 18 |
| `BackGround` | property | Public |  | Integer | 19 |
| `Click` | event | Public |  |  | 21 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 23-29 | Public | 1 | 5 | 0 | méthode spéciale |
| `View_Enter` | 31-36 | Public | 1 | 4 | 0 | handler GUI |
| `View_Leave` | 38-43 | Public | 1 | 4 | 0 | handler GUI |
| `View_GotFocus` | 45-50 | Public | 1 | 4 | 0 | handler GUI |
| `View_LostFocus` | 52-57 | Public | 1 | 4 | 0 | handler GUI |
| `View_MouseDown` | 59-64 | Public | 1 | 4 | 0 | handler GUI |
| `View_MouseUp` | 66-72 | Public | 1 | 5 | 0 | handler GUI |
| `Position_Read` | 74-79 | Private | 1 | 4 | 0 |  |
| `Position_Write` | 81-86 | Private | 1 | 4 | 0 |  |
| `View_Draw` | 88-124 | Public | 7 | 28 | 0 | handler GUI |
| `Picture_Read` | 126-130 | Private | 1 | 3 | 0 |  |
| `Picture_Write` | 132-139 | Private | 1 | 4 | 0 |  |
| `Text_Read` | 141-145 | Private | 1 | 3 | 0 |  |
| `Text_Write` | 147-151 | Private | 1 | 3 | 0 |  |
| `BackGround_Read` | 153-157 | Private | 1 | 3 | 0 |  |
| `BackGround_Write` | 159-163 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et événements de la zone de dessin

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : crée la `DrawingArea` `$hView`
  (observateur `"View"`), focalisable, et la déclare comme `Proxy` du contrôle.
- **`View_Enter` / `View_Leave`** [nécessaires, handlers] : survol (`$bHover`) puis
  `Refresh`.
- **`View_GotFocus` / `View_LostFocus`** [handlers] : focus (`$bFocus`) puis `Refresh`.
- **`View_MouseDown`** [handler] : `$bMouseDown = True`, `Refresh`.
- **`View_MouseUp`** [handler] : `$bMouseDown = False`, `Refresh`, puis **`Raise Click`**, même si
  le pointeur a quitté le bouton avant le relâchement (IMAGEBUTTON-A01). Aucune activation au
  clavier (Espace/Entrée) malgré `Focus = True`.
- **`View_Draw`** [handler] (CC 7) : calcule le drapeau (`Hovered` + `HasFocus` + `Disabled`),
  dessine le fond par `MyStyle.DrawButton(0, 0, w, h, $bMouseDown, drapeau, $iBackground)`, puis
  l'image `$htmpPic` centrée (décalée d'un pixel si enfoncé) avec `Draw.Picture` (API `Draw`
  mêlée à `Paint`), puis le texte en blanc avec contour gris au survol. Le décalage `iX`/`iY`
  n'est appliqué au texte que de -1.

### Propriétés (privées)

| Propriété | Lecture | Écriture |
|---|---|---|
| `Picture` | `$hPicture` | `$hPicture = v` ; `$htmpPic = v.Image.Opacity(0.7).Picture` (erreur si `v` est `Null`, absorbée par le `Try` des appelants) ; pas de `Refresh` |
| `Text` | `$sText` | `$sText = v` ; pas de `Refresh` (les appelants font `.Refresh`) |
| `BackGround` | `$iBackground` | `$iBackground = v` ; pas de `Refresh` |
| `Position` | `$iPosition` (le `$hView.Refresh` après `Return` est inatteignable) | `$iPosition = v`, `Refresh` |

`Position` n'est utilisée nulle part (ni `.Position` sur un `ImageButton`, ni dans les `.form`,
ni dans `_Properties`) : code mort non signalé par `deps.py` (propriétés jamais utilisées : limite
connue).

## État global utilisé

- `MyStyle` (constantes `Hovered`, `HasFocus`, `Disabled` et `DrawButton`).
- `Color.White`, `Color.Gray`, `Color.ButtonForeground` (thème).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la propriété `Position` (`$iPosition`, `Position_Read`, `Position_Write`) et les
  lignes commentées de `View_Draw` et `Picture_Write`.
- `View_Draw` : remplacer `Draw.Picture` par `Paint.DrawPicture` (même rendu à vérifier par
  capture : sinon, laisser en l'état).

### Commonalisation avec d'autres fichiers

- `MyStyle` n'a qu'un utilisateur (`ImageButton`) : l'intégrer comme méthode privée
  (voir MYSTYLE-003) réduirait le nombre de classes sans changer le rendu.

### Réduction de portée

- Aucune : les méthodes publiques sont des handlers (`View_*`, levés via l'observateur
  `"View"`) ou la méthode spéciale `_new`, qui doivent rester `Public`.

### Séparation traitement / GUI

- Sans objet (contrôle graphique). Le calcul du drapeau d'état pourrait être une fonction pure
  `Etat(bHover, bFocus, bEnabled) As Integer`, gain marginal.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
