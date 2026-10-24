# ReplayObserver — Architecture

> Source : `.src/Utils/ReplayObserver.class`

## Vue d'ensemble

`ReplayObserver` est la moitié GUI du mécanisme **log/replay** de Laurux :

- **Capture** (partie instance) : un `ReplayObserver` est créé pour chaque contrôle intéressant d'une
  fenêtre par `Utils.Recursive_Observers` (`Utils.module:869`) et stocké dans `Utils.ROArray`. Il pose
  un `Observer` (gb, sans interception : `New Observer(hCont, False)`) et transmet les événements
  `Click`, `KeyPress`, `MouseWheel`, `MouseUp`, `MouseDown`, `Close`, `GotFocus` à
  `Utils.db.GUI_Event`, qui écrit une ligne `GUI` dans le log (voir
  [`DB_Connection`](../DB_Connection.class/architecture.md#format-du-log-référence-pour-la-phase-2)).
  `Source` (`Variant[]`, porté par `Observer.Tag`) est la hiérarchie fenêtre → conteneurs → contrôle.
- **Rejeu** (partie statique) : `Start.module` lit les lignes `*;GUI;*` du fichier `--logfile` (option
  `-r`) et un `Timer` appelle `ReplayObserver.Replay_Event` pour chaque ligne
  (`Start.ReplayTimer_Timer`). `Replay_Event` retrouve la fenêtre et le contrôle, programme le délai
  jusqu'à l'événement suivant (écart entre les horodatages, plafonné) et rejoue l'action (`Click`,
  `Keypress`, `Focus`, `Close`).

C'est la pièce centrale du type de test `replay` de la phase 2 : sa fidélité conditionne la
reproductibilité des scénarios GUI.

Nature globale : **GUI** (manipulation de contrôles par réflexion `Object.GetProperty`,
`Object.Call`, propriétés `Variant`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$hObserver` | var | Private |  | Observer | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-10 | Public | 1 | 4 | 0 | méthode spéciale |
| `Observer_Click` | 12-42 | Public | 13 | 25 | 0 | handler GUI |
| `Observer_Keypress` | 44-57 | Public | 7 | 11 | 0 | handler GUI |
| `Observer_MouseWheel` | 59-72 | Public | 3 | 10 | 0 | handler GUI |
| `Observer_MouseUp` | 73-89 | Public | 2 | 6 | 0 | handler GUI |
| `Observer_MouseDown` | 91-105 | Public | 2 | 6 | 0 | handler GUI |
| `Observer_Close` | 107-111 | Public | 1 | 3 | 0 | handler GUI |
| `Observer_GotFocus` | 113-120 | Public | 3 | 5 | 0 | handler GUI |
| `Object` | 123-127 | Public | 1 | 3 | 0 | portée réductible ? |
| `Source` | 129-133 | Public | 1 | 3 | 0 | portée réductible ? |
| `Replay_Click` | 136-191 | Public Static | 17 | 51 | 0 | portée réductible ? |
| `Replay_Keypress` | 193-212 | Public Static | 6 | 17 | 0 | portée réductible ? |
| `Replay_Close` | 214-218 | Public Static | 1 | 3 | 0 | portée réductible ? |
| `Replay_Focus` | 221-227 | Public Static | 2 | 5 | 0 | portée réductible ? |
| `Replay_Event` | 229-359 | Public Static | 26 | 108 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Capture (instance)

- **`_new(hCont, Source)`** [portée : nécessaire] : `Observer` sur `hCont`, événements nommés
  `Observer_*` ; `Source` dans `Tag`.
- **`Observer_Click`** (CC 13) [nature : GUI] : journalise seulement si le contrôle a le focus, n'a pas
  de propriété `HasFocus` (erreur du `Try`) ou est un `TabStrip`. Valeur selon la classe :
  `CheckBox` → `Value` ; `ListBox`, `ComboBox`, `TabStrip` → `Index` ; `ListView`, `ColumnView`,
  `TreeView` → `Key` ; `GridView` → `Row x Column` ; sinon `"True"`. Le test de classe est fait par
  nom (`Object.Class(...).Name`) : une sous-classe (contrôle utilisateur héritant de `GridView`…) tombe
  dans le cas par défaut.
- **`Observer_Keypress`** (CC 7) : si focus, `Key.Text` pour les touches imprimables de `Space` à `z`
  sans modificateur, sinon `Key.Code` (entier). ⚠️ Les caractères au-delà de `z` (accents, `{`, `|`,
  `~`) et les majuscules avec Maj (si `Key.Normal` est faux) sont journalisés par code ; le rejeu ne
  sait rejouer que BackSpace, Delete, Return et Tab parmi les codes.
- **`Observer_MouseWheel`** : journalise « … unsupported » (non rejoué). Variable `Value` inutilisée.
- **`Observer_MouseUp`** : `Click` vide pour un `Label` uniquement (bloc commenté conservé).
- **`Observer_MouseDown`** : `Click` vide pour un `ToolButton` uniquement (bloc commenté conservé).
- **`Observer_Close(Index)`** : `Close` avec l'index (onglet de `TabStrip`) ou 0.
- **`Observer_GotFocus`** : `Focus` pour `TextBox`/`TextArea`.
- **`Object()`**, **`Source()`** [portée : réductible, **code mort** : aucun appelant] : accesseurs.

### Rejeu (statique)

- **`Replay_Event(hReplayTimer, Lastev, Action)`** (CC 26) [portée : nécessaire, `Start.module:397`]
  [nature : mixte ; extractible : analyse de la ligne de log].
  1. **Analyse** : `Split(Action, ";")` ; le champ 0 est la date, découpée en `MM/JJ/AAAA HH:MM:SS.mmm`
     (ordre mois/jour **figé**, dépendance au format de `$(now)` de gb.logging, à confirmer selon la
     locale) ; une date sans millisecondes provoque une erreur d'indice. Le **dernier** champ est
     découpé par `#` : `act[0]` = `<Act>=<valeur>@<contrôle>`, `act[1]` = fenêtre, `act[2..n-2]` =
     chemin des contrôles. ⚠️ Une valeur contenant `;`, `#`, `@` ou `=` casse l'analyse (ex. frappe de
     la touche `;`).
  2. **Fenêtre** : si aucune fenêtre active, recherche par nom dans `Windows` ; sinon la fenêtre active
     doit porter le nom attendu, faute de quoi l'application **quitte** (`Quit`), sauf pour `Close`
     (renvoie `Null`).
  3. **Contrôle** : descente niveau par niveau dans `ctx.Children`, puis dans `ctx.Menus` si besoin.
     Recherche limitée aux **enfants directs** ; un niveau introuvable laisse `ctx` inchangé et le
     rejeu échoue (`Return Null`, « probablement une mauvaise idée » selon le commentaire).
  4. **Délai** : `DateDiff(Lastev, when, ms)` ; 1 000 ms en cas d'erreur ou si > 20 000 ms ; le timer
     est relancé avec délai + 10 ms.
  5. **Action** : `Replay_Keypress`, `Replay_Click`, `Replay_Focus`, `Replay_Close` ; les autres
     (`MouseWheel`) sont ignorés. Renvoie la date de l'événement.
  Sorties `Print` sur la console (traces de rejeu).
- **`Replay_Click(ctx, eve, val)`** (CC 17) [portée : réductible] : selon la classe : `CheckBox.Value =
  CInt(val)` ; `Button`/`Menu` `.Value = True` (déclenche le clic) ; `GridView` positionne
  `Row`/`Column` puis `Object.Call(ctx.Window, ctx.Name & "_Click")` (contournement : suppose que la
  fenêtre est la classe qui gère l'événement, faux pour un contrôle dans un `UserControl` ou un
  groupe d'événements `Group`) ; `TreeView.MoveTo` ; `ColumnView` sélection par clé + `_Click` ;
  `ListView` : **rien** ; `ListBox` index + `_Click` ; `ComboBox`/`TabStrip` index ; `Label` :
  focus, déplacement de la souris et clic simulé par `xdotool` (X11, synchrone) ou `ydotool click`
  (Wayland, syntaxe `left--down` douteuse et `Shell` asynchrone) ; sinon `Value = (val = "True")`.
- **`Replay_Keypress(ctx, eve, val)`** [portée : réductible] : caractère unique tel quel, sinon code
  BackSpace/Delete/Return/Tab converti en `[BackSpace]`… ; autre code : message console et **chaîne
  vide envoyée**. ⚠️ Appelle `Utils.De.SendKeys` (méthode héritée de `Desktop`) et non
  `DB_Desktop.SendKey` : le rejeu clavier ignore le routage Wayland. `CInt(val)` lève une erreur si
  `val` est vide.
- **`Replay_Close`** : `ctx.Close()`. **`Replay_Focus`** : `SetFocus` si nécessaire.

## État global utilisé

- `Utils.db.GUI_Event` (capture), `Utils.de` (`wayland`, `SendKeys`), `Windows`,
  `Application.ActiveWindow`, `Mouse`, `Key`.
- `Start.module` : `Evens`, `Evc`, `Evl`, `Ev`, `hReplayTimer` (pilotage du rejeu, hors de ce fichier).
- Commandes externes : `xdotool`, `ydotool`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire l'analyse de ligne de `Replay_Event` dans une fonction **pure**
  `AnalyseLigne(Action) As Collection` (date, action, valeur, fenêtre, chemin) : testable en gb.test
  sur des lignes de log réelles, CC de `Replay_Event` 26 → ≤ 12.
- Remplacer les chaînes de `If Object.Class(...).Name = "…"` par un `Select Case` sur le nom de classe
  calculé une fois (`Observer_Click`, `Replay_Click`) : même comportement, lisibilité.
- Supprimer les blocs commentés de `Observer_MouseUp`/`MouseDown` et les variables `Value` inutilisées.

### Commonalisation avec d'autres fichiers

- Le format de ligne est produit par [`DB_Connection.GUI_Event`](../DB_Connection.class/architecture.md)
  et relu ici et par [`DB_Log`](../DB_Log.class/architecture.md) : énumération partagée des positions
  (DB_CONNECTION-013) et une fonction de découpage commune.
- Les clics simulés (`xdotool`/`ydotool`) relèvent de [`DB_Desktop`](../DB_Desktop.class/architecture.md).
- `Utils.Recursive_Observers` ([`Utils.module`](../Utils.module/architecture.md)) répète 13 fois le même
  bloc `New ReplayObserver` + `ROArray.Add` : à factoriser côté `Utils` (liste des classes observées).

### Réduction de portée

- `Object`, `Source` : code mort (suppression).
- `Replay_Click`, `Replay_Keypress`, `Replay_Close`, `Replay_Focus` → `Static Private` (appelés
  seulement par `Replay_Event`, vérifié par grep).

### Séparation traitement / GUI

- `AnalyseLigne` (pure) ; `Replay_Event` garde la recherche de contrôles, le timer et les actions.

### Rejeu des clics de grilles et listes : `Object.Raise` plutôt qu'`Object.Call`

`Replay_Click` appelle `<Contrôle>_Click` par son nom pour les GridView, ColumnView et ListBox, car
changer la sélection par programme ne lève pas `Click`. Essais sous Gambas 3.19 :

| Cas | Résultat |
|---|---|
| Handler `Private`, événement levé par `Raise` ou `Object.Raise` | jamais appelé (Gambas exige des handlers `Public`) |
| `Object.Call` d'une méthode `Private` (de l'extérieur ou via `Me`) | « Unknown symbol » |
| `Object.Raise(ListBox, "Click")`, handlers `Public` | handler appelé, celui du groupe si le contrôle est groupé, `Last` correct |

Une callback générique `Object.Call(Me, sNom)` dans chaque classe GUI ne permettrait donc pas
d'atteindre des méthodes `Private`. Elle exigerait une table de dispatch explicite dans ~313 classes.
`Object.Raise(ctx, "Click")` reproduit au contraire le vrai chemin de l'événement : voir
REPLAYOBSERVER-A06, classée en anomalie à valider car elle change le résultat des replays.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base. Un format de log structuré (champs quotés) fiabiliserait le
  rejeu ; c'est un changement de format de fichier, à traiter avec `DB_Connection`.
