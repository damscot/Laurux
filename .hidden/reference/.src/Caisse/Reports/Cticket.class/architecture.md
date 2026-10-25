# Cticket — Architecture

> Source : `.src/Caisse/Reports/Cticket.class`

## Vue d'ensemble

`Cticket` est une **ébauche abandonnée** de gabarit PDF pour le ticket de caisse
(`Inherits PdfWriter`), importée avec la caisse Laurux-Pos (commit `f442d721`, 2018) et jamais
modifiée depuis. Le fichier porte deux en-têtes (« Gambas class file » puis « Gambas module file »).
Le ticket PDF est en réalité produit par [`Cfacture`](../Cfacture.class/architecture.md).

**Classe jamais référencée** (signal `jamais_reference` de `deps.py`, confirmé) : aucun
`New Cticket`, aucune variable typée `Cticket`, nom absent des chaînes (`Class.Load`,
`Object.New`), des `.form`/`.report` et de `.project`. Pas de `.form` associé : sa suppression est
un rework [code mort].

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-9 | Public | 1 | 2 | 0 | méthode spéciale |
| `_free` | 11-13 | Public | 1 | 2 | 0 | méthode spéciale |
| `newPage` | 15-19 | Public | 1 | 3 | 0 | portée réductible ? |
| `Entete2` | 22-29 | Public | 1 | 6 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()` / `_free()`** [portée : nécessaire (spéciale)] [nature : GUI] : vides.
- **`newPage()`** [réductible → code mort] [GUI] : `Me.AddPage` (signal `unused` confirmé).
- **`Entete2(Ent, PosX, PosY)`** [réductible → code mort] [GUI] : appelle `Me.seto`, **membre
  inexistant** de `PdfWriter` (la compilation passe, l'appel lèverait une erreur à l'exécution),
  puis écrit `Ent` en Helvetica gras 12 (signal `unused` confirmé).

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le fichier (CTICKET-001).

### Commonalisation avec d'autres fichiers

- Sans objet : [`Cfacture`](../Cfacture.class/architecture.md) assure déjà le rôle prévu.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
