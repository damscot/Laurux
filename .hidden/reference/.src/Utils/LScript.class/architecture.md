# LScript — Architecture

> Source : `.src/Utils/LScript.class`

## Vue d'ensemble

`LScript` encapsule le **lancement d'un programme externe** (script de numérisation, `convert`,
`xsane`…) avec ses arguments, soit par un shell (`Shell … Wait`), soit directement (`Exec … Wait`).
Il est utilisé par [`LGed`](../LGed.class/architecture.md) (GED : numérisation multipage et
conversion en PDF), qui enchaîne plusieurs `LScript` avec `LScript.RunA`.

La classe est `Create Static` + `Inherits Array`, comme [`LPrix`](../LPrix.class/architecture.md) :
l'appel `LScript(prog, args, shell)` passe par `_call` sur l'auto-instance et renvoie une nouvelle
instance. L'héritage d'`Array` n'est pas utilisé.

Deux programmes spéciaux servent au diagnostic : `"debug"` affiche les arguments dans une boîte
`Message.Info`, `"debug2"` les imprime sur la console ; aucun programme n'est lancé.

Elle possède un `Internal_Test` (harnais `./Laurux -t`, forcé au chargement par
`Start.Start_Test`, `Start.module:483`), **sans aucune assertion** : il lance des commandes réelles et
imprime leurs codes de retour. À convertir en gb.test (phase 2).

Nature globale : **calcul** (exécution de processus), avec un couplage GUI (`Message.Info` en mode
`debug`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$prog` | var | Private |  | String | 6 |
| `$arguments` | var | Private |  | String[] | 7 |
| `$runinshell` | var | Private |  | Boolean | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 11-17 | Public | 1 | 5 | 0 | méthode spéciale |
| `_call` | 19-26 | Public | 1 | 5 | 0 | méthode spéciale |
| `Run` | 28-60 | Public | 8 | 26 | 1 |  |
| `RunA` | 62-72 | Public | 3 | 7 | 1 |  |
| `Show` | 75-86 | Private | 2 | 9 | 0 |  |
| `Internal_Test` | 90-134 | Public | 5 | 31 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Program, Arguments, RunInShell)`** [portée : nécessaire] [nature : calcul] : mémorise
  programme, arguments (le tableau passé est **conservé par référence**, non copié) et mode.
- **`_call(Prog, Argu, RuSh)`** [portée : nécessaire, `LGed.class` via `LScript(...)` et
  `Internal_Test`] : fabrique `New LScript(...)`. Contrairement à `LPrix._call`, les paramètres sont
  bien transmis.
- **`Run()`** (CC 8) [portée : nécessaire, `LGed.class:881-928`] [nature : mixte ; GUI limitée au mode
  `debug`]. Journalise via `Utils.Log` ; modes `debug`/`debug2` ; sinon **insère `$prog` en tête de
  `$arguments`** puis :
  - mode shell : `Shell $arguments.Join(" ") Wait` — aucun quotage : un argument contenant un espace
    (chemin `~/…` avec espace, nom de périphérique de numérisation) est coupé, et les caractères
    spéciaux sont interprétés par le shell (redirections `>`/`>>` utilisées volontairement par `LGed`) ;
  - mode exec : `Exec $arguments Wait` (pas de shell, arguments transmis tels quels).
  Renvoie 1 si `Shell`/`Exec` lève une erreur (programme introuvable en mode exec), 0 sinon.
  ⚠️ Le **code de sortie** du programme n'est pas testé : `/bin/false` renvoie 0 (succès).
  ⚠️ Effet de bord : `$arguments` est modifié ; un second `Run()` sur la même instance insère le
  programme une deuxième fois, et le tableau de l'appelant est lui aussi modifié.
- **`RunA(Als)`** [portée : nécessaire, `LGed.class:881`] : exécute la liste dans l'ordre, s'arrête et
  renvoie 1 au premier échec. Méthode d'instance appelée sur la classe (auto-instance statique).
- **`Show(MessageBox)`** [Private] [nature : GUI] : affiche les arguments (boîte ou console). Fonction
  déclarée sans type de retour (`Function` sans `As`).
- **`Internal_Test(Test_List)`** [portée : nécessaire, harnais `Start.Start_Test` par réflexion] :
  convention `list`/`all`/nom de classe ; exécute un script configuré
  (`/Soc<XX>/scanbatch`, éventuellement vide : la commande lancée devient alors ` -m scanbatch …`),
  `bash -c echo`, `debug2`, `RunA`, `/bin/faaalse` (introuvable), `/bin/false`, `/bin/true`, et
  imprime les codes. `err` n'est jamais incrémenté : renvoie toujours `True`. Variables `r` et `tx`
  (`LTaxe`) inutilisées.

## État global utilisé

- `Utils.Log` (journalisation par module via [`LLog`](../LLog.class/architecture.md)).
- `Start.LocalSettings["/Soc<XX>/scanbatch"]` (dans `Internal_Test` seulement).
- Processus externes arbitraires.

## Propositions d'amélioration

### Réécriture / refactorisation

- Construire la ligne de commande dans une variable locale (`[$prog].Insert($arguments)`) au lieu de
  modifier `$arguments` : comportement identique pour un seul `Run()` par instance (seul usage actuel
  dans `LGed`) ; le cas du second `Run()` relève de l'anomalie A02.
- Supprimer `Inherits Array` (inutilisé, vérifié par grep : aucun accès indexé sur un `LScript`).

### Commonalisation avec d'autres fichiers

- `Create Static` + `_call` + `Inherits Array` inutilisé : même idiome que
  [`LPrix`](../LPrix.class/architecture.md) et [`LTaxe`](../LTaxe.class/architecture.md).
- Le projet lance des commandes externes à de nombreux endroits par `Shell` direct (ex.
  [`DB_Desktop`](../DB_Desktop.class/architecture.md), [`Fsoc`](../../Communs/Fsoc.class/architecture.md),
  [`Utils.Mkdir_p`](../Utils.module/architecture.md)) : `LScript` pourrait devenir le point unique
  d'exécution journalisée, avec quotage par `Shell$()` (changement de comportement à valider au cas
  par cas, hors rework autonome).

### Réduction de portée

- Aucune : `_call`, `Run`, `RunA` sont utilisés par `LGed` ; `Internal_Test` par le harnais.

### Séparation traitement / GUI

- Mode `debug` : la boîte `Message.Info` est dans `Show` (privée) ; extraire `TexteArguments()` pur.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
