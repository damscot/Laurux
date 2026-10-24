# DB_Desktop — Architecture

> Source : `.src/Utils/DB_Desktop.class`

## Vue d'ensemble

`DB_Desktop` hérite de `Desktop` (gb.desktop) et sert à **simuler des frappes clavier** de façon
compatible X11 et Wayland. Une seule instance existe : `Utils.de` (`Public de As New DB_Desktop`,
`Utils.module:10`), créée au chargement du module `Utils`.

- Sous X11 : `SendKey` délègue à `Desktop.SendKeys` (xdotool/XTest).
- Sous Wayland : `SendKey` lance `ydotool key <nom>` pour les touches spéciales de `correspondance`,
  `ydotool type <texte>` sinon. Au démarrage, si `ydotool` n'est pas installé (test `apt list`), un
  `Message.Info` invite à lancer `wayland.sh`.

Le préfixe `DB_` est trompeur : la classe n'a aucun rapport avec la base de données.

Nature globale : **mixte** (appels système + `Message.Info`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `wayland` | var | Public |  | Boolean | 5 |
| `correspondance` | var | Public |  | Collection | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-21 | Public | 2 | 10 | 0 | méthode spéciale |
| `SendKey` | 23-35 | Public | 3 | 11 | 1 |  |
| `ydotool` | 37-46 | Private | 2 | 7 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : mixte]. `Shell "echo $XDG_SESSION_TYPE" To txt` (un
  processus shell pour lire une variable d'environnement, disponible directement par
  `Application.Env["XDG_SESSION_TYPE"]`). Si la valeur contient `wayland` : `wayland = True` et
  `ydotool()`. Exécuté au démarrage de l'application, y compris en mode test et replay.
- **`SendKey(value)`** [portée : nécessaire, `TextReg.class:103`] [nature : calcul (appel système)].
  ⚠️ Sous Wayland, `Shell "ydotool type " & value` : la valeur n'est **pas quotée** (espaces,
  caractères spéciaux du shell interprétés : injection possible si la valeur provient d'une saisie) ;
  `Shell` sans `Wait` est **asynchrone**, l'ordre de plusieurs frappes successives n'est pas garanti
  et la frappe peut arriver après la suite du traitement. La syntaxe `ydotool key Enter` dépend de la
  version de ydotool (les versions récentes attendent des codes `28:1 28:0`, à confirmer).
- **`ydotool()`** [portée : Private] [nature : mixte] : `apt list --installed | grep ydotool`
  (spécifique Debian/Ubuntu, lent) ; `Message.Info` si absent. Sur une distribution sans `apt`, le
  message s'affiche à chaque démarrage sous Wayland.

## État global utilisé

- Variable d'environnement `XDG_SESSION_TYPE` (via un shell).
- Commandes externes : `ydotool`, `apt`, `grep`.
- `wayland` (Public) lu par `ReplayObserver.Replay_Click` ; `correspondance` (Public) utilisé seulement
  en interne.

## Propositions d'amélioration

### Réécriture / refactorisation

- Lire `Application.Env["XDG_SESSION_TYPE"]` au lieu de lancer un shell (même résultat, sans
  processus) : changement interne sans effet visible.
- Tester la présence de `ydotool` par `System.Find("ydotool")` au lieu de `apt list` : effet visible
  sur les distributions sans `apt` (le message ne s'afficherait plus à tort) → classé en anomalie A02.
- Quoter l'argument de `ydotool type` (`Shell$(value)`) et attendre la fin de la commande (`Wait`) :
  changement de comportement (ordre et synchronisme des frappes) → anomalie A01.

### Commonalisation avec d'autres fichiers

- [`ReplayObserver.Replay_Keypress`](../ReplayObserver.class/architecture.md) et
  [`TextReg`](../TextReg.class/architecture.md) (ligne 186) appellent directement `Desktop.SendKeys`
  (méthode héritée) au lieu de `SendKey` : sous Wayland, ces frappes ne passent pas par ydotool. Les
  faire passer par `SendKey` unifierait le comportement (changement visible sous Wayland, voir
  REPLAYOBSERVER-A02).
- Les clics simulés de `ReplayObserver.Replay_Click` (`xdotool`/`ydotool click`) pourraient rejoindre
  `DB_Desktop` (`SendClick()`), qui deviendrait la seule classe d'entrées simulées.

### Réduction de portée

- `correspondance` → `Private` (aucun usage externe, vérifié par grep).
- `wayland` : conservé `Public` (lu par `ReplayObserver`), ou exposé en propriété lecture seule.

### Séparation traitement / GUI

- `ydotool()` : séparer la détection (`YdotoolPresent() As Boolean`) du `Message.Info`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
