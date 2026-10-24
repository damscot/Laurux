# LLog — Architecture

> Source : `.src/Utils/LLog.class`

## Vue d'ensemble

`LLog` hérite de `ComplexLogger` (gb.logging) : c'est le **logger de débogage par module**. Une
instance est créée à la demande par `Utils.Log(Obj, sMessage, level)` (`Utils.module:1663`) pour
chaque nom de classe appelante et rangée dans `Start.LLogColl` (Collection indexée par nom).

Chaque instance écrit :
- sur la console (handler 0, `LLog.console`) au niveau `Start.ConsoleLogLevel` ;
- dans `~/tmp/Debug/<Module>.log` (handler 1, `LLog.file`, rotation à 64 Ko) au niveau
  `Start.FileLogLevel` ;
- et relaie chaque message vers le journal applicatif de
  [`DB_Connection`](../DB_Connection.class/architecture.md) (`Log_Event`, type `Log`).

Les niveaux viennent de l'option `-d console,fichier` (`Start.module:91-92`, défaut `3,3` = Info) ;
l'activation par défaut dépend de la présence de `-d`. La fenêtre
[`DB_Log`](../DB_Log.class/architecture.md) permet de changer l'activation et les niveaux à chaud.

Le niveau spécial `MessageBox` (7) ouvre un `Message.Error` pour le message, ou pour **tous** les
messages du module si un handler est réglé sur ce niveau.

Nature globale : **calcul** (journalisation), avec un couplage GUI (`Message.Error`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `console` | enum | Public | oui |  | 5 |
| `file` | enum | Public | oui |  | 5 |
| `Critical` | const | Public |  |  | 7 |
| `Error` | const | Public |  |  | 8 |
| `Warning` | const | Public |  |  | 9 |
| `Info` | const | Public |  |  | 10 |
| `Debug` | const | Public |  |  | 11 |
| `Notice` | const | Public |  |  | 12 |
| `Verbose` | const | Public |  |  | 13 |
| `MessageBox` | const | Public |  |  | 14 |
| `Max` | const | Public |  |  | 15 |
| `MLevel` | var | Private |  | Integer | 17 |
| `Fileh` | var | Private |  | FileHandler | 18 |
| `LogName` | var | Private |  | String | 19 |
| `LogLevelName` | var | Private |  | String[] | 20 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 23-41 | Public | 4 | 14 | 0 | méthode spéciale |
| `Log` | 43-61 | Public | 6 | 15 | 0 | portée réductible ? |
| `Level_Id` | 63-67 | Public | 1 | 3 | 0 | portée réductible ? |
| `Level_Name` | 69-79 | Public | 3 | 8 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Name, Enabling, MinLevel)`** [portée : nécessaire, `Utils.module:1680`] [nature : calcul].
  Crée `~/tmp/Debug`, **supprime** le fichier `<Name>.log` existant, ajoute un `FileHandler` avec
  rotation à 64 Ko, fixe l'activation, les niveaux des handlers 0 (console) et 1 (fichier) et le
  format `[$(now)] [$(levelname)-$(levelno)] [<Name>] $(message)`. Suppose que le handler 0 est le
  handler console créé par défaut par `ComplexLogger` (à confirmer dans gb.logging).
  `Start.module:94-98` supprime déjà tous les `*.log` de `~/tmp/Debug` au démarrage.
- **`Log(sMessage, iLevel = MLevel)`** (CC 6) [portée : nécessaire, appelée par `Utils.Log` via
  `Start.LLogColl[Name].Log`, invisible pour `deps.py`] [nature : mixte ; extractible : préfixe de
  backtrace]. Sort si inactif ; préfixe le message par la backtrace (cadres 2 à n-3, joints par `,`) ;
  `Super.Log` ; `Message.Error` si `iLevel` ou un handler vaut `MessageBox` ; puis
  `Utils.db.Log_Event(bts & ";[" & LogName & "]" & sMessage, iLevel)`.
  ⚠️ `bt.Extract(2, bt.Length - 4)` : longueur négative si la pile a moins de 6 cadres (erreur ou
  comportement à confirmer). ⚠️ `LogLevelName[iLevel]` n'est pas borné (contrairement à
  `Level_Name`) : niveau hors 0–8 → erreur d'indice dans le `Message.Error`. ⚠️ Les niveaux 5 à 7
  (`Notice`, `Verbose`, `MessageBox`) sont transmis tels quels au logger de `DB_Connection`, qui suit
  l'échelle de gb.logging (comportement de filtrage à confirmer).
- **`Level_Id(sLevel)`** [portée : nécessaire, `DB_Log.class:273,280`] : indice du libellé ou -1.
- **`Level_Name(iLevel)`** [portée : nécessaire, `DB_Log.class:255,257`] : libellé, indice borné à
  `[Critical, Max]`.

## État global utilisé

- `Start.ConsoleLogLevel`, `Start.FileLogLevel` (lus à la construction seulement).
- `Utils.db.Log_Event`.
- Fichiers `~/tmp/Debug/<Module>.log`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire la construction du préfixe de backtrace dans `BacktraceTexte(iSkip) As String` (pure),
  protégée contre les piles courtes **à comportement identique** dès que la pile a au moins 6 cadres.
- Remplacer les constantes `Critical…Verbose` par des références à `Logger.*` quand elles coïncident
  (les commentaires indiquent l'équivalence) : documentation, aucun changement de valeur.

### Commonalisation avec d'autres fichiers

- [`DB_Connection.Start`](../DB_Connection.class/architecture.md) crée aussi `~/tmp/Debug` et un
  `FileHandler` ; un helper `Utils.DebugDir()` commun éviterait la duplication du chemin (3 endroits
  avec `Start.module`).
- `Utils.Log` ([`Utils.module`](../Utils.module/architecture.md)) est la seule fabrique : la logique
  « créer si absent puis journaliser » pourrait devenir une méthode statique `LLog.Get(Name)`
  (changement d'API limité à `Utils.Log`).

### Réduction de portée

- Aucune : `Level_Id`/`Level_Name` sont utilisés par `DB_Log` à travers `Start.LLogColl` (faux positif
  de `deps.py`) ; les constantes sont utilisées par `Start`, `DB_Log`.

### Séparation traitement / GUI

- `Log` : isoler le test « doit ouvrir une boîte » (`DoitAfficher(iLevel) As Boolean`) du
  `Message.Error`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
