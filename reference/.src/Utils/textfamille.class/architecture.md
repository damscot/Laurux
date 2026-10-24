# textfamille — Architecture

> Source : `.src/Utils/textfamille.class`

## Vue d'ensemble

`textfamille` est un **contrôle utilisateur de saisie d'un code famille** découpé par niveaux.
Il hérite de `ScrollView`, est exporté (`Export`) pour être utilisable dans les `.form`, et crée
une `TextBox` par niveau d'après les points de rupture `ipr` de la société
(`Start.LocalSettings["/Soc<XX>/ipr"]`, même paramètre que [`Trifam`](../Trifam.class/architecture.md)) :
largeur et longueur maximale de chaque zone = longueur du niveau.

La propriété `text` concatène les zones (complétées par des espaces à la longueur du niveau) puis
supprime les espaces de début et de fin ; l'écriture redécoupe la valeur par niveau.

Il est placé dans 8 formulaires : `Changefam` (4 contrôles), `Articles`, `EdArt1` (2), `Movr`,
`Famille`, `CoefTypeC`, `Remisec`, `Remisecli`.

Nature : **GUI** (aucun SQL).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$ipr` | var | Private |  | Integer[] | 6 |
| `$texfam` | var | Private |  | TextBox[] | 7 |
| `text` | property | Public |  | String | 9 |
| `LostFocus` | event | Public |  |  | 10 |
| `KeyPress` | event | Public |  |  | 11 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 14-44 | Public | 7 | 27 | 0 | méthode spéciale |
| `codefam_gotfocus` | 47-53 | Public | 1 | 5 | 0 | handler GUI |
| `codefam_lostfocus` | 55-61 | Public | 1 | 5 | 0 | handler GUI |
| `codefam_keypress` | 63-88 | Public | 7 | 23 | 0 | handler GUI |
| `setfocus` | 90-95 | Public | 1 | 3 | 8 |  |
| `Select` | 97-101 | Public | 1 | 3 | 8 |  |
| `Clear` | 103-111 | Public | 2 | 6 | 7 |  |
| `text_Read` | 113-135 | Private | 4 | 17 | 0 |  |
| `text_Write` | 137-150 | Private | 3 | 11 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** (CC 7) [portée : nécessaire (spéciale)] [nature : GUI]. Disposition horizontale ;
  lecture d'`ipr` (sans `Try` sur l'affectation, `Try` seulement sur `.Count`) ; si absent ou vide :
  `Message.Error("Veuillez vérifier le paramétrage des familles dans les préférences")` puis
  **`Quit`**. Création des `TextBox` (`As "codefam"`, police `Serif,-1`, largeur `12 × longueur
  + 10`). Les deux dernières lignes (`haut = Height / 3 ; If ScrollHeight > haut Then Height =
  haut × 3`) n'ont aucun effet (la hauteur est réaffectée à sa propre valeur) : code mort.
- **`codefam_gotfocus()` / `codefam_lostfocus()`** [portée : nécessaire, handlers] [nature : GUI].
  Fond jaune pâle à l'entrée, couleur standard à la sortie, désélection, puis
  `Raise GotFocus()` / `Raise LostFocus()` (événement hérité de `Control` pour `GotFocus`, déclaré
  dans la classe pour `LostFocus` et `KeyPress`).
- **`codefam_keypress()`** [portée : nécessaire, handler] [nature : GUI]. Entrée/Retour/Tab : sur la
  dernière zone, lève `KeyPress` et stoppe l'événement ; sinon recherche l'indice de la zone
  courante, lève `KeyPress` et, si l'appelant n'a pas stoppé l'événement, passe à la zone
  suivante. L'appelant voit donc un `KeyPress` **à chaque zone** (dans `Changefam`, le handler de
  groupe `Cmpt_KeyPress` est donc appelé à chaque changement de niveau).
- **`setfocus()`** [portée : nécessaire — `Changefam`, `Articles`…] : focus sur la première zone
  (masque `Control.SetFocus`).
- **`Select()`** [portée : nécessaire — `Famille.class:418`, `Changefam`] : sélectionne la première
  zone uniquement.
- **`Clear()`** [portée : nécessaire — `Changefam.class:144,180`] : vide toutes les zones. Signalé
  « réductible » par `deps.py` à tort (appel sur un contrôle de formulaire).
- **`text_Read()`** [privé] : concaténation par niveau + `Trim$`. ⚠️ Si le premier niveau est vide
  et un niveau suivant rempli, le `Trim$` supprime les espaces de tête et décale le code
  (à confirmer : cas de saisie incohérent). Variable `Byte` pour les longueurs (limite 255,
  suffisante).
- **`text_Write(Value)`** [privé] : `Left`/`Mid` par niveau.

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/ipr"]`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le calcul de hauteur sans effet.
- Calcul de la longueur d'un niveau (`ipr[i] − ipr[i−1]`, ou `ipr[0]`) répété 3 fois : helper
  privé `Longueur(i)`.

### Commonalisation avec d'autres fichiers

- Lecture et validation d'`ipr` identiques à `Trifam._new` (même `Message.Error` à un libellé près,
  même `Quit`) : fonction commune (voir TRIFAM-004).

### Réduction de portée

- Aucune : `Clear`, `setfocus`, `Select`, `text` sont appelés sur les contrôles des formulaires
  (faux positif de `deps.py` pour `Clear`).

### Séparation traitement / GUI

- La conversion code ↔ zones (`text_Read`/`text_Write`) peut devenir deux fonctions pures
  `Decoupe(code, ipr) As String[]` / `Assemble(zones, ipr) As String`, testables sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `Trifam` : une hiérarchie de familles explicite en base rendrait le paramètre local `ipr`
  inutile.
