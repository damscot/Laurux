# Mmysql — Architecture

> Source : `.src/Utils/Mmysql.module`

## Vue d'ensemble

Petit module d'**administration du serveur MySQL local par shell**, utilisé par les écrans de
sauvegarde ([FSauve](../../Communs/FSauve.class/architecture.md)) et de restauration
([FRestore](../../Communs/FRestore.class/architecture.md)) : redémarrage du service et test du mot de
passe via `mysqladmin processlist`. Il repose sur des outils d'élévation de privilèges obsolètes
(`gksu`, `kdesu`) et sur le script SysV `/etc/init.d/mysql`.

Nature : **système** (shell), sans SQL via `Utils.db`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Envr` | var | Private | oui | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Init` | 5-18 | Public | 4 | 12 | 2 |  |
| `Process_List` | 20-36 | Public | 7 | 14 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Init()`** [portée : nécessaire] [nature : système]. Choisit `kdesu ` si `KDE_FULL_SESSION`, sinon
  `gksu ` (aussi par défaut), puis exécute `<envr>sudo -S /etc/init.d/mysql stop` et `start`
  (synchrones). Effet de bord : la variable de module `Envr` reste positionnée (elle n'est jamais
  remise à zéro, mais n'est utilisée qu'ici). Appelants : `FSauve:130`, `FRestore:222` (bouton de
  redémarrage du serveur). ⚠️ `gksu` n'existe plus sur les distributions récentes et les systèmes
  `systemd` n'ont pas forcément `/etc/init.d/mysql` ; `sudo -S` attend un mot de passe sur l'entrée
  standard, qui n'est pas fournie.
- **`Process_List(lg As Integer) As Integer`** [portée : nécessaire] [nature : système]. Lance
  `gksu 'mysqladmin -h <hôte> -u <login> -p<mdp> processlist' > ~/tmp/resultat 2>&1`, relit le fichier,
  et compte les lignes non vides qui ne commencent pas par `Warning` à partir de `lg` (paramètre
  utilisé comme accumulateur ; les appelants passent 0). Si une ligne contient `incorrecte`, renvoie
  0. Les appelants (`FSauve:59`, `FRestore:117`) interprètent 0 comme « mot de passe invalide ».
  ⚠️ Le test repose sur un message d'erreur **en français** : avec `mysqladmin` en anglais
  (`Access denied…`), un mot de passe invalide donne un nombre de lignes > 0 et passe le contrôle
  (MMYSQL-A01). Le répertoire `~/tmp` doit exister. Le mot de passe apparaît dans `ps`.

## État global utilisé

- `Start.LocalSettings["/dbase/Host"]`, `Utils.db.Login`, `Utils.db.Password`.
- `Application.Env` (`KDE_FULL_SESSION`, `GNOME_DESKTOP_SESSION_ID`), `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Init` : la branche `GNOME_DESKTOP_SESSION_ID` est équivalente au défaut (`gksu`) ; simplifiable
  en `Envr = IIf(KDE, "kdesu ", "gksu ")` sans changement.
- `Process_List` : lire la sortie par `Shell … To sortie` plutôt que par un fichier temporaire dans
  `~/tmp` (même résultat, plus de dépendance au répertoire).

### Commonalisation avec d'autres fichiers

- Ligne de commande `mysql -h -u -p` dupliquée dans [Utils](../Utils.module/architecture.md)
  (`Fill_DataBase`, `Clear_DataBase`, `Create_DataBase`, `ControlTunnel`) et dans `FRestore:68`
  (`show variables like version`) : helper unique proposé en UTILS-014.

### Réduction de portée

- Les deux fonctions ont des appelants externes. `Envr` est déjà `Private`.

### Séparation traitement / GUI

- Sans objet (pas de GUI) ; le choix de l'outil d'élévation (`Init`) est séparable du lancement.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès au schéma). Le test de mot de passe pourrait être une simple connexion
  `Connection.Open` au lieu d'un `mysqladmin` sous `gksu`.
