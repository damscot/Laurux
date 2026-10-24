# SaiTableau — Architecture

> Source : `.src/Utils/SaiTableau.class`

## Vue d'ensemble

`SaiTableau` est un **composant de grille de saisie** construit dynamiquement : une suite de lignes
[`Sailig`](../Sailig.class/architecture.md) (une ligne = un `Panel` horizontal de contrôles décrits
par des `ObjProp`) dans une `ScrollView`, avec en option un panneau de choix (3 boutons radio
MO / Articles / Articles en stock), un bandeau d'aide (`tuto`), une ligne d'en-tête et une ligne de
totaux (deux `Sailig` en lecture seule).

Il gère la navigation et l'édition au clavier relayées par les événements des lignes
(`RetLigne`, `SupLig`, `InsLig`, `Haut`, `Bas`, `GotFocus`, `LostFocus`) : retour à la ligne avec
création automatique, insertion, suppression avec confirmation, déplacement Alt+↑/↓, alternance des
couleurs de fond (`Background = &FFEFDF` une ligne sur deux).

Il est **hérité** par `Achat` (`.src/Gestion/Entrées/Achat.class:3`, qui redéfinit `ajout`,
`Delete`, `ligne_RetLigne`, `ligne_InsLig`, `ligne_Suplig`) et instancié par `Parametre`, `GesTar`
(3 tableaux de tarifs) et `Achat` (tableaux `mat` et `rec`). Il est énumérable (`For Each lg In
tableau`, via `_next`).

Les événements des contrôles d'une ligne sont rattachés à l'instance (`Object.Attach(obj, Me,
Utils.Accent(obj.Name))`) : une classe héritière reçoit ainsi `<NomControle>_<Evenement>`.

Nature globale : **GUI** (aucun SQL) ; seul `Utils.Option()` est lu.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `ligne` | var | Public |  | New Sailig[] | 3 |
| `ind` | var | Public |  | Integer | 4 |
| `opt` | var | Public |  | String | 5 |
| `VisibleTuto` | var | Public |  | Boolean | 7 |
| `VisibleEntete` | var | Public |  | Boolean | 8 |
| `VisibleTot` | var | Public |  | Boolean | 9 |
| `VisibleChoi` | var | Public |  | Boolean | 10 |
| `total` | var | Public |  | SaiLig | 12 |
| `entete` | var | Public |  | SaiLig | 13 |
| `pchoix` | var | Public |  | Panel | 15 |
| `mo` | var | Public |  | RadioButton | 16 |
| `art` | var | Public |  | RadioButton | 17 |
| `artstk` | var | Public |  | RadioButton | 18 |
| `tuto` | var | Public |  | Label | 19 |
| `Pentete` | var | Public |  | ScrollView | 20 |
| `Tableau` | var | Public |  | ScrollView | 21 |
| `Ptot` | var | Public |  | ScrollView | 22 |
| `$prop` | var | Public |  | New ObjProp[] | 24 |
| `$parent` | var | Public |  | Control | 25 |
| `$tag` | var | Private |  | Variant | 27 |
| `Background` | const | Private |  |  | 29 |
| `Tag` | property | Public |  | Variant | 31 |
| `ajou` | event | Public |  |  | 33 |
| `gotfocus` | event | Public |  |  | 34 |
| `lostfocus` | event | Public |  |  | 35 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 37-49 | Public | 2 | 11 | 0 | méthode spéciale |
| `_next` | 51-61 | Public | 3 | 9 | 0 | méthode spéciale |
| `show` | 63-136 | Public | 7 | 67 | 3 |  |
| `Pentete_Scroll` | 138-142 | Public | 1 | 3 | 0 | portée réductible ? |
| `ajout` | 144-158 | Public | 2 | 12 | 3 |  |
| `Delete` | 160-174 | Public | 3 | 12 | 2 |  |
| `Extract` | 176-193 | Public | 4 | 15 | 0 | portée réductible ? |
| `Netoyage` | 195-210 | Public | 4 | 13 | 4 |  |
| `cretableau` | 212-221 | Private | 1 | 8 | 0 |  |
| `evenement` | 224-234 | Private | 2 | 8 | 0 |  |
| `ligne_RetLigne` | 236-246 | Public | 4 | 9 | 0 | handler GUI |
| `ligne_gotfocus` | 248-254 | Public | 1 | 5 | 0 | handler GUI |
| `ligne_lostfocus` | 256-260 | Public | 1 | 3 | 0 | handler GUI |
| `ligne_SupLig` | 262-284 | Public | 9 | 20 | 1 | handler GUI |
| `ligne_InsLig` | 286-305 | Public | 7 | 16 | 1 | handler GUI |
| `ligne_Haut` | 307-330 | Public | 7 | 21 | 0 | handler GUI |
| `ligne_Bas` | 332-355 | Public | 7 | 21 | 0 | handler GUI |
| `Tag_Read` | 357-361 | Private | 1 | 3 | 0 |  |
| `Tag_Write` | 363-367 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(prop, parent)`** [portée : nécessaire (spéciale)] [nature : GUI]. Mémorise la description
  des colonnes (`$prop`), lit `opt = Utils.Option()` (option de licence B/T/N/P, utilisée par
  `Achat`) ; si `parent` est `Null`, crée une `Window` 800×400 (jamais affichée par la classe).
- **`show()`** [portée : nécessaire] [nature : GUI]. Construit, selon les drapeaux `Visible*`
  (à positionner **avant** l'appel) : panneau de choix (`RadioButton1..3`, événements traités par
  l'héritier `Achat`), bandeau d'aide (texte en dur), en-tête (`Sailig` en `lecture`, un `TextReg`
  centré par colonne), zone de lignes (`cretableau`), totaux (`Sailig` de `Label` alignés à droite).
- **`cretableau()`** [privé] [nature : GUI]. Crée la `ScrollView` `tableau` (`As "tableau"`).
- **`evenement(lg)`** [privé] [nature : GUI]. Rattache tous les contrôles de la ligne à `Me`
  (nom d'événement = nom du contrôle sans accents), ainsi que `lg.prx` (`LPrix`, événements
  `LPrix_*`) et `lg.txl` (`LTaxe`, `Ltaxe_*`). Appels dynamiques (`Object.Attach`).

### Gestion des lignes

- **`ajout(etat)`** [portée : nécessaire, redéfini par `Achat`] [nature : GUI]. Crée une `Sailig`
  (`As "ligne"`), lui affecte `Ind`, l'ajoute, colore les lignes impaires, lève `ajou` et donne le
  focus à la première colonne.
- **`Delete()`** [portée : nécessaire] [nature : GUI]. Détache et détruit toutes les lignes, vide
  `ligne`, détruit puis recrée la `ScrollView`.
- **`Extract(i)`** [portée : réductible] [nature : GUI]. Supprime la ligne `i`, renumérote, déplace
  le focus. Ne recalcule pas l'alternance des couleurs (contrairement à `ligne_SupLig`).
- **`Netoyage(nom)`** [portée : nécessaire] [nature : GUI]. Supprime les lignes dont le contrôle
  `nom` est vide (utilisé par `Achat`, `GesTar`, `Parametre`, `commande1`).
- **`_next()`** [portée : nécessaire (spéciale)] [nature : calcul]. Énumération de `ligne`.

### Gestionnaires d'événements des lignes (`ligne_*`)

- **`ligne_RetLigne(etat)`** : sur la dernière ligne, en écriture et si `Dernier` est défini,
  crée une ligne ; sinon passe à la ligne suivante. `Stop Event`.
- **`ligne_gotfocus(Value)`** : met à jour `ind`, relaie `gotfocus`, fait défiler la zone.
- **`ligne_lostfocus(Value)`** : relaie `lostfocus`.
- **`ligne_SupLig(etat)`** (CC 9, max du fichier) : confirmation, suppression, recoloriage et
  renumérotation, recréation d'une ligne si le tableau devient vide.
- **`ligne_InsLig(etat)`** : insère une ligne avant la ligne courante (réordonne les `Panel` via
  `Previous`/`Next`). ⚠️ La `Sailig` est créée par la déclaration `Dim ls As New SaiLig(…)`
  **avant** le test `etat = ecriture` : en lecture, un panneau orphelin est ajouté au tableau. La
  ligne insérée ne lève pas `ajou` (l'héritier ne l'initialise pas) et pas de `Stop Event`.
- **`ligne_Haut(etat)` / `ligne_Bas(etat)`** : échangent la ligne courante avec la précédente /
  suivante (panneaux, `Ind`, couleurs). Code symétrique dupliqué.
Tous sont [portée : nécessaire (handlers d'événement, redéfinis par `Achat`)] [nature : GUI].

- **`Pentete_Scroll()`** [portée : nécessaire (nom de handler)] [nature : GUI] — **code mort** :
  `Pentete` est créé sans nom d'événement (`New ScrollView($parent)` sans `As`), l'événement n'est
  donc jamais reçu ; la synchronisation du défilement de l'en-tête n'existe pas.
- **`Tag_Read/Tag_Write`** [privé] : propriété libre `Tag`.

## État global utilisé

- `Utils.Option()` (option de licence), `Utils.Accent()` (nom d'événement sans accents).
- Aucune variable globale ; mais **19 variables `Public`** (dont `$prop`, `$parent` préfixées `$`
  bien que publiques, lues par `Parametre` et `Achat`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `ligne_Haut`/`ligne_Bas` → helper privé `Echange(i, j)` ; recoloriage → helper `Recolorie(depuis)`
  partagé avec `ligne_SupLig`, `ligne_InsLig`, `ajout`.
- Construction des `ObjProp` d'en-tête et de totaux : deux boucles quasi identiques dans `show`.
- Le texte du bandeau d'aide gagnerait à être une constante documentée.

### Commonalisation avec d'autres fichiers

- `Achat` redéfinit `ajout`, `Delete`, `ligne_RetLigne`, `ligne_InsLig`, `ligne_Suplig` : vérifier en
  phase 3 ce qui peut remonter dans la classe de base (ex. appel de `Super`).
- Le patron « observer de tous les contrôles » existe aussi dans `Calc.SetObservers` et
  `Utils.Observers` : à rapprocher (voir [`Calc`](../Calc.class/architecture.md)).

### Réduction de portée

- Réductibles (aucun usage externe ni dans les héritiers, grep) : `Extract`, `entete`, `total`,
  `pchoix`, `tuto`, `Pentete`, `Ptot`.
- **À conserver** (faux positifs `deps.py`, usages via `Me.` dans l'héritier `Achat` ou via instance) :
  `opt` (`Achat:65…`), `mo`/`art`/`artstk` (`Achat:268-269,488-491`), `Tableau`
  (`commande1:1034`), `$prop` (`Parametre:167-170`), `$parent` (`Achat:64,69,81`).

### Séparation traitement / GUI

- Sans objet (composant purement graphique). La logique de réordonnancement (indices, couleurs)
  peut être isolée dans des helpers sans contrôle pour être testée.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
