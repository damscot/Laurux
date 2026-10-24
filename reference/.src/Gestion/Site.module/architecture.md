# Site — Architecture

> Source : `.src/Gestion/Site.module`

## Vue d'ensemble

`Site` est un module de 14 lignes qui déclare une **seconde connexion** `ServeurB` (objet
`Connection` de gb.db) et une procédure `connect_site` qui recopie dans cette connexion les
paramètres de la section `[dbase]` de `Laurux.conf` (type, nom préfixé, login, mot de passe
déchiffré, hôte, port). La connexion n'est **jamais ouverte** (`ServeurB.Open` n'existe nulle part).

C'est un vestige de l'ancienne passerelle « site » (boutique Thelia, renommée « Serveur » au commit
`5165796d`) : ni `ServeurB` ni `connect_site` ne sont référencés ailleurs dans le projet. Le module est
**du code mort**.

Attention à l'homonymie : `Fsoc.class:355-356` (`Site.SetFocus`, `Site.Select`) vise le contrôle
`TextBox` nommé `Site` du formulaire `Fsoc.form:221` (le contrôle masque le module dans la portée du
formulaire), et non ce module.

Nature globale : **traitement** (paramétrage d'une connexion), sans GUI ni SQL.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `ServeurB` | var | Public | oui | New Connection | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `connect_site` | 5-14 | Public | 1 | 8 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`connect_site()`** [portée : réductible — aucun appelant, code mort] [nature : calcul].
  Affecte `ServeurB.type`, `Name` (`/dbase/Prefixe` & `/dbase/Name`), `Login`, `Password`
  (`hexdblKey.crypt("de", /dbase/Password, "Laurux")`), `Host` et `Port`. Aucun `Open` : aucun effet
  observable. Contrairement à `Utils.glb` (qui alimente `Utils.db`), le tunnel SSH
  (`/dbase/Con-ssh` → hôte `127.0.0.1` et port local) et le cas SQLite ne sont pas gérés : la
  connexion serait de toute façon incorrecte en mode tunnel.

## État global utilisé

- `Start.LocalSettings["/dbase/type|Prefixe|Name|Login|Password|Host|Port"]` (lecture).
- `hexdblKey.crypt` (déchiffrement du mot de passe).
- `ServeurB` : globale `Public` du module (singleton), jamais lue.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : le module est à supprimer (SITE-001).

### Commonalisation avec d'autres fichiers

- La recopie des paramètres `[dbase]` vers une `Connection` existe aussi dans
  [`Utils.glb`](../../Utils/Utils.module/architecture.md) (`Utils.module:93-101`) et dans
  [`LauruxConf`](../../Communs/LauruxConf.class/architecture.md) (l. 228, 323). Si une seconde
  connexion devenait nécessaire, un helper commun `Utils.ParamConnexion(hCon As Connection)` serait
  à créer ; sans usage, la suppression suffit.

### Réduction de portée

- Sans objet (suppression du module).

### Séparation traitement / GUI

- Sans objet (pas de GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : le module n'accède pas à la base.
