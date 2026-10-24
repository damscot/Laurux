# Recup — Architecture

> Source : `.src/Utils/Recup.module`

## Vue d'ensemble

Deux fonctions d'identification de l'utilisateur système : nom du groupe principal (`Group`, via
`getent`) et nom de l'utilisateur (`Utilisateur`, simple enveloppe de `User.Name`).

Nature : **système**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Group` | 4-23 | Public | 3 | 17 | 0 | portée réductible ? |
| `Utilisateur` | 25-29 | Public | 1 | 3 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Group() As String`** [code mort : aucun appelant] [nature : système]. `Shell "getent group " &
  User.Group & " > ~/tmp/group 2>&1" Wait`, ouvre le fichier puis lit la première ligne et renvoie le
  texte avant le premier `:`. ⚠️ Si le fichier n'existe pas (`~/tmp` absent), `hFile` est `Null` et
  `Line Input` lève une erreur ; `File.Load` dans `Lig` est inutile (écrasé) ; le fichier n'est
  jamais fermé ni supprimé. `User.Group` renvoie déjà vraisemblablement le nom du groupe (à
  confirmer), ce qui rendrait l'appel à `getent` redondant.
- **`Utilisateur() As String`** [portée : nécessaire] [nature : calcul]. Renvoie `User.Name`.
  Appelant unique : `FRestore.class:67`.

## État global utilisé

- `User.Group`, `User.Name`, `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Group` (mort). `Utilisateur` pourrait être remplacé par `User.Name` chez l'appelant.

### Commonalisation avec d'autres fichiers

- Les autres écrans utilisent directement `User.Name` (par exemple `AffRdv`, `Caisse.Dupli`) : aucune
  raison de conserver une enveloppe.

### Réduction de portée

- `Group` : suppression. `Utilisateur` : suppression possible en remplaçant l'appel de `FRestore`.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
