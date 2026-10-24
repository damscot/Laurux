# Sailig — Architecture

> Source : `.src/Utils/Sailig.class`

## Vue d'ensemble

`Sailig` est une **ligne de saisie** de la grille [`SaiTableau`](../SaiTableau.class/architecture.md) :
un `Panel` horizontal (`Panel1`) dans lequel sont créés les contrôles décrits par un tableau
d'`ObjProp` (`TextReg`, `Label`, `Button`, `TextLabel`, `CheckBox`, `ComboBox`, `TextBox`). Les
contrôles sont rangés par nom dans la collection `MonControle` et chaînés pour la navigation au
clavier par un objet `chainage` (`chain`).

La ligne porte aussi des objets métier associés : un prix `prx` (`LPrix`), une taxe `txl` (`LTaxe`),
un arrondi et une liste libre `AutresObj` (tarifs, consignes… gérés par `Achat`/`GesTar`).

Elle traduit le clavier en événements de haut niveau (`RetLigne`, `SupLig`, `InsLig`, `Haut`, `Bas`,
`ctrl`, `alt`) selon son état (`lecture`, `ecriture`, `reception`) et relaie `GotFocus`/`LostFocus`
de n'importe quel contrôle via un `Observer` de groupe (`groupe_*`).

Nature : **GUI** (aucun SQL).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `chain` | var | Public |  | New Chainage(Null) | 3 |
| `valide` | var | Public |  | Boolean | 4 |
| `MonControle` | var | Public |  | New Collection | 5 |
| `Panel1` | var | Public |  | Panel | 6 |
| `prx` | var | Public |  | New LPrix | 7 |
| `txl` | var | Public |  | New LTaxe | 8 |
| `arrondi` | var | Public |  | Variant | 9 |
| `Ind` | var | Public |  | Integer | 10 |
| `AutresObj` | var | Public |  | Variant[] | 11 |
| `$coul` | var | Private |  | Integer | 13 |
| `$Height` | var | Private |  | Integer | 14 |
| `$prop` | var | Private |  | ObjProp[] | 15 |
| `$etat` | var | Private |  | Integer | 16 |
| `$dernier` | var | Private |  | String | 17 |
| `$tag` | var | Private |  | Variant | 18 |
| `RetLigne` | event | Public |  |  | 20 |
| `SupLig` | event | Public |  |  | 21 |
| `InsLig` | event | Public |  |  | 22 |
| `Haut` | event | Public |  |  | 23 |
| `Bas` | event | Public |  |  | 24 |
| `GotFocus` | event | Public |  |  | 25 |
| `LostFocus` | event | Public |  |  | 26 |
| `ctrl` | event | Public |  |  | 27 |
| `alt` | event | Public |  |  | 28 |
| `Background` | property | Public |  | Integer | 30 |
| `X` | property | Public |  | Integer | 31 |
| `Y` | property | Public |  | Integer | 32 |
| `Dernier` | property | Public |  | String | 33 |
| `Tag` | property | Public |  | Variant | 34 |
| `lecture` | enum | Public | oui |  | 36 |
| `ecriture` | enum | Public | oui |  | 36 |
| `reception` | enum | Public | oui |  | 36 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 39-90 | Public | 15 | 47 | 0 | méthode spéciale |
| `Delete` | 92-118 | Public | 13 | 24 | 2 |  |
| `groupe_lostfocus` | 120-125 | Public | 1 | 4 | 0 | handler GUI |
| `groupe_gotfocus` | 127-131 | Public | 1 | 3 | 0 | handler GUI |
| `groupe_keypress` | 133-198 | Public | 27 | 57 | 0 | handler GUI |
| `Background_Read` | 200-204 | Private | 1 | 3 | 0 |  |
| `Background_Write` | 206-216 | Private | 2 | 8 | 0 |  |
| `X_Read` | 218-222 | Private | 1 | 3 | 0 |  |
| `X_Write` | 224-228 | Private | 1 | 3 | 0 |  |
| `Y_Read` | 230-234 | Private | 1 | 3 | 0 |  |
| `Y_Write` | 236-240 | Private | 1 | 3 | 0 |  |
| `Dernier_Read` | 242-246 | Private | 1 | 3 | 0 |  |
| `Dernier_Write` | 248-252 | Private | 1 | 3 | 0 |  |
| `Tag_Read` | 254-258 | Private | 1 | 3 | 0 |  |
| `Tag_Write` | 260-264 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(prop, parent, etat)`** (CC 13) [portée : nécessaire (spéciale)] [nature : GUI]. Crée
  `Panel1` (hauteur = police + 4, largeur du parent), puis pour chaque `ObjProp` le contrôle
  correspondant, un `Observer` « groupe » (sauf `Label`), l'enregistrement dans `chain` (TextBox,
  TextReg, ComboBox), la désactivation en `lecture`, le nom, l'application des propriétés
  (`obj.AppProp`) et l'expansion si taille nulle. `$dernier` = nom du dernier contrôle. Focus sur le
  premier contrôle si la ligne est éditable.
  ⚠️ Cas `ObjProp.TextBox` : `chain.add(clas)` passe un objet seul alors que `chainage.add` attend un
  `Object[]` (les autres cas passent `[clas]`). Cas jamais utilisé dans le projet (aucun
  `ObjProp.TextBox` hors de cette classe, grep) : à confirmer (erreur de type probable).
  Variable locale `obs` réaffectée : les observers ne sont gardés vivants que par leur rattachement
  au contrôle.
- **`Delete()`** [portée : nécessaire] [nature : GUI]. Vide `chain`, détache `prx`/`txl`, détruit
  `AutresObj` (`Try Delete`, `Try Clear`), les contrôles et le panneau. Appelé par `SaiTableau`,
  `Achat`, `GesTar`.
- **`groupe_lostfocus()`** [portée : nécessaire, handler] [nature : GUI]. Met `valide = False` (« la
  ligne a été modifiée ») et lève `LostFocus(Me)`. ⚠️ `valide` passe à `False` à chaque perte de
  focus, même sans modification réelle (le commentaire de déclaration dit « lorsque le contenu
  change »).
- **`groupe_gotfocus()`** [portée : nécessaire, handler] : lève `GotFocus(Me)`.
- **`groupe_keypress()`** (CC 27, max du fichier) [portée : nécessaire, handler] [nature : GUI].
  Ctrl+touche → `ctrl(code)` ; Alt+touche → `alt(code)` (si traité, fin) ; puis :
  Entrée/Retour (Ctrl ou sur le dernier contrôle) → `RetLigne` ; Tab sur le dernier → `RetLigne` ;
  Inser → `InsLig` ; Suppr → `SupLig` (en écriture) ; Alt+↑/↓ → `Haut`/`Bas` ; ↓ sur le dernier →
  `RetLigne`. `Stop Event` si l'événement a été traité. Les événements `ctrl`/`alt` ne sont traités
  par aucune classe du projet (grep `_ctrl`/`_alt`).
- **Propriétés** (accesseurs privés) : `Background` (applique la couleur à tous les contrôles et au
  panneau), `X`/`Y` (position de `Panel1`), `Dernier` (nom du contrôle qui déclenche le retour à la
  ligne), `Tag`.

## État global utilisé

- Aucun état global. Dépend des classes `ObjProp`, `chainage`, `TextReg`, `LPrix`, `LTaxe`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : remplacer le `Select Case` par une table type → (classe, observé ?, chaîné ?) ; corriger
  l'incohérence `chain.add(clas)` uniquement via l'anomalie (comportement potentiellement différent).
- `groupe_keypress` : extraire `RetLigneSiDernier()` (trois blocs identiques
  `If Last.name = $dernier Then ok = Raise RetLigne…`).

### Commonalisation avec d'autres fichiers

- `prx`/`txl`/`arrondi` sont manipulés par `Achat` et `GesTar` avec la même logique de calcul de prix
  ligne : voir [`LPrix`](../LPrix.class/architecture.md) pour une méthode commune.

### Réduction de portée

- `arrondi` signalé réductible par `deps.py` : **faux positif** (`Achat.class:227`,
  `Me.ligne[Me.ind].arrondi = …`). Aucune réduction proposée : tous les membres publics sont lus par
  `SaiTableau`, `Achat`, `GesTar`, `Parametre` ou `VarMajTar` (`valide`, `chain`, `AutresObj`,
  `MonControle`, `prx`, `Ind`, `Tag`).

### Séparation traitement / GUI

- Sans objet (composant graphique). La décision « quelle touche → quel événement » peut devenir une
  fonction pure `ActionTouche(code, ctrl, alt, estDernier, etat) As Integer` testable sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
