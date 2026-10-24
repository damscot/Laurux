# chainage — Architecture

> Source : `.src/Utils/chainage.class`

## Vue d'ensemble

Classe utilitaire de **chaînage de la saisie** : elle reçoit une liste ordonnée de contrôles et, via
un `Observer` (groupe d'événements `saisie`) posé sur chacun :
- colore le contrôle qui prend le focus et restaure sa couleur à la sortie (`Utils.ObsGotf` /
  `Utils.ObsLstf`) ;
- fait passer au contrôle **suivant** sur Bas/Entrée/Retour/Tab et au **précédent** sur Haut/Maj+Tab,
  avec bouclage en fin de liste ; Alt/Ctrl désactivent la navigation.

Utilisée par environ 30 écrans (saisie de paramètres, achats, règlements, inventaires, LCR…) ;
`Sailig` en embarque une par ligne de saisie (`Public chain As New Chainage(Null)`). Instanciée par `New Chainage([...])` (le nom de
classe est résolu sans tenir compte de la casse).

Nature globale : **GUI** (navigation clavier), avec une partie de gestion de liste extractible.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$text` | var | Private |  | Object[] | 3 |
| `$obs` | var | Private |  | Observer | 4 |
| `$coul` | var | Private |  | Integer | 5 |
| `tableaux` | property | Public |  | Object[] | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-19 | Public | 3 | 8 | 0 | méthode spéciale |
| `saisie_gotfocus` | 21-26 | Public | 2 | 3 | 0 | handler GUI |
| `saisie_lostfocus` | 28-32 | Public | 2 | 3 | 0 | handler GUI |
| `saisie_keypress` | 34-65 | Public | 13 | 25 | 0 | handler GUI |
| `recherche` | 67-78 | Private | 3 | 8 | 0 |  |
| `add` | 80-89 | Public | 2 | 7 | 6 |  |
| `addintercale` | 91-98 | Public | 2 | 5 | 0 | portée réductible ? |
| `modif` | 100-107 | Public | 1 | 5 | 0 | portée réductible ? |
| `sup` | 109-116 | Public | 2 | 5 | 3 |  |
| `tableaux_Read` | 118-122 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et gestion de la liste

- **`_new(value As Object[])`** [portée : nécessaire (spéciale)] [nature : GUI]. Mémorise la liste
  (**même référence**, pas de copie) ou une liste vide ; crée `New Observer(contrôle, True) As
  "saisie"` pour chaque élément (`After = True` : événements reçus après ceux du contrôle). `$obs` est
  écrasé à chaque tour (les observateurs restent attachés aux contrôles).
- **`add(value As Object[])`** [nécessaire : `Sailig`, `SaiReg`, `Achat`, `artopt`, `menuopt`,
  `TriGen`] [GUI]. Ajoute les contrôles en fin de liste et crée l'observateur **sans** `After`
  (événements reçus **avant** ceux du contrôle) : comportement différent de `_new` (à confirmer :
  effet sur `Stop Event`).
- **`addintercale(text, value)`** [portée : réductible — aucun appelant, vérifié par grep] [calcul].
  Insère `value` **avant** `text` dans la liste, sans observateur.
- **`modif(anc, nouv)`** [portée : réductible — aucun appelant] [calcul]. ⚠️ `Dim i As Object` reçoit
  l'entier renvoyé par `recherche` : erreur de type à l'exécution (code mort et bogué).
- **`sup(value, [nb = 1])`** [nécessaire : `Achat`, `GesTar`, `commande1`] [calcul]. Retire `nb`
  éléments à partir de `value` ; l'observateur reste attaché (le contrôle garde la coloration de
  focus, mais `recherche` renvoie -1 et la navigation l'ignore).
- **`tableaux`** (propriété en lecture) [nécessaire : `Sailig:96` (`.Clear`), `Achat:415/478`
  (`.Extract`)] : expose la liste **interne**, modifiée directement par les appelants.
- **`recherche(text) As Integer`** (privée) [calcul]. Recherche linéaire par identité ; ⚠️ sur une liste
  vide, `$text[0]` est lu avant le test de fin (`Repeat … Until`) → erreur hors bornes.

### Événements (groupe `saisie`)

- **`saisie_gotfocus()`** [GUI]. `Try $coul = Utils.ObsGotf(Last)` : mémorise la couleur d'origine
  (une seule variable `$coul` pour toute la liste).
- **`saisie_lostfocus()`** [GUI]. `Try Utils.ObsLstf(Last, $coul)`.
- **`saisie_keypress()`** [GUI]. Navigation décrite ci-dessus ; `Try $text[i].Select` sélectionne le
  texte ; `Stop Event` seulement pour Tab et Maj+Tab (Entrée et flèches continuent vers le contrôle).

## État global utilisé

- `Utils.ObsGotf`, `Utils.ObsLstf` (couleurs `/Coul/Focus`, `/Coul/Znss`), `Key`, `Last`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `recherche` : remplacer la boucle par `$text.Find(text)` (renvoie -1 si absent, gère la liste vide) —
  comportement identique pour les listes non vides.
- Supprimer `modif` et `addintercale` (aucun appelant).
- Remplacer `$obs` (membre inutile) par une variable locale.

### Commonalisation avec d'autres fichiers

- La coloration de focus est aussi posée par `Utils.Observers(Me)` sur tous les contrôles d'une
  fenêtre (`Utils.module:1011`). Un écran qui utilise les deux reçoit deux fois `GotFocus`/`LostFocus`
  (effets à confirmer). À traiter lors de la documentation de `Utils.module`.
- [`Sailig`](../Sailig.class/architecture.md) encapsule un `chainage` par ligne : la manipulation directe de `tableaux` depuis `Achat` pourrait
  passer par des méthodes de `chainage` (`Vider()`, `Retirer(i)`).

### Réduction de portée

- `addintercale`, `modif` : aucun appelant → suppression (plutôt que `Private`).
- `tableaux` : utilisé en externe, à conserver.

### Séparation traitement / GUI

- La gestion de liste (`recherche`, calcul de l'indice suivant/précédent avec bouclage) peut être
  isolée dans des fonctions privées pures `Suivant(i)`, `Precedent(i)` appelées par `saisie_keypress`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
