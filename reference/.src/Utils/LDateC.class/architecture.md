# LDateC — Architecture

> Source : `.src/Utils/LDateC.class` · Formulaire : `.src/Utils/LDateC.form` (un `DateChooser1`).

## Vue d'ensemble

`LDateC` est la **boîte de dialogue modale de sélection de date** associée à `LDate` (le
commentaire `'Property Read Select As LDate` dans `LDate.class:36` montre l'intention initiale).
Elle n'est appelée que par `TextReg` (touche F2 ou bouton sur un champ date / date-heure) via
l'auto-instance : `LDateC.Select(dte).L` / `.LT`.

Nature globale : **GUI**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `LCloseOnChange` | var | Private |  | Boolean | 5 |
| `Escape` | var | Private |  | Boolean | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Select` | 14-33 | Public | 3 | 17 | 1 |  |
| `DateChooser1_Change` | 36-40 | Public | 2 | 3 | 0 | handler GUI |
| `DateChooser1_Activate` | 42-46 | Public | 1 | 3 | 0 | handler GUI |
| `DateChooser1_Cancel` | 48-53 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Select(mydate, mode, update, CloseOnChange)`** [portée : nécessaire] [nature : GUI].
  Initialise le titre et `DateChooser1` (valeur `mydate.G`, mode par défaut
  `DateChooser.DateTime`), mémorise `CloseOnChange`, affiche la fenêtre en modal. Au retour :
  - annulation (`Escape`) → renvoie `mydate` inchangé ;
  - `update = True` (défaut) → **modifie** `mydate.G` (ce qui lève `LDate.change`, observé par
    `TextReg.dte_change`) et renvoie `mydate` ;
  - sinon → renvoie une nouvelle `LDate`.
  Le paramètre `CloseOnChange` n'est pas déclaré `Optional` alors qu'il suit des paramètres
  optionnels ; tous les appelants l'omettent (le compilateur l'accepte : à confirmer qu'il prend la
  valeur `False`).
  ⚠️ `TextReg` ne passe jamais `mode` : pour un champ **date seule** (`EstDate`), le sélecteur
  s'ouvre aussi en mode date-heure (cosmétique).
- **`DateChooser1_Change()`** [nature : GUI] : ferme si `CloseOnChange`.
- **`DateChooser1_Activate()`** [nature : GUI] : ferme (double-clic / Entrée).
- **`DateChooser1_Cancel()`** [nature : GUI] : `Escape = True` puis ferme.

`Escape` et `LCloseOnChange` sont des membres d'instance. La fenêtre étant utilisée via son
auto-instance, `Escape` resterait à `True` après une annulation si l'auto-instance survivait à la
fermeture ; une fenêtre non persistante est détruite par `Close`, donc l'état repart à zéro à
l'appel suivant (à confirmer par un test manuel : annuler puis rouvrir et valider).

## État global utilisé

- Aucun (`Create Static` explicite, redondant pour une `Form` qui a déjà une auto-instance).

## Propositions d'amélioration

### Réécriture / refactorisation

- Réinitialiser explicitement `Escape = False` au début de `Select` : sans effet si l'hypothèse
  ci-dessus est vérifiée, et protège contre une fenêtre persistante.
- Supprimer le constructeur commenté (l. 9-11) et la variable `newdate` intermédiaire.

### Commonalisation avec d'autres fichiers

- [`Agenda`](../Agenda.class/architecture.md) et `Moulinage` utilisent directement des
  `DateChooser` ; pas de factorisation utile (écrans différents).

### Réduction de portée

- Aucune : `Select` est appelé par `TextReg` ; les handlers sont intouchables.

### Séparation traitement / GUI

- Sans objet (classe purement GUI ; la seule « logique » est le choix de l'objet renvoyé).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
