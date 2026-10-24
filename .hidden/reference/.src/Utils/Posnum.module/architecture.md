# Posnum — Architecture

> Source : `.src/Utils/Posnum.module`

## Vue d'ensemble

Module d'une fonction qui convertit un rang 1-20 en adjectif ordinal français (« premier »,
« deuxième »…). **Aucun appel** dans le projet (grep `Posnum`) : module mort.

Nature : **calcul pur**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Pos` | 6-73 | Public | 21 | 45 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Pos(Qte As String) As String`** [code mort] [nature : calcul]. `Select Case Qte` comparé à des
  entiers 1 à 20 (conversion implicite de la chaîne) ; renvoie l'ordinal, ou la chaîne d'entrée
  inchangée hors de 1-20. Orthographe non normalisée pour 17-19 (`dixseptième`, `dixhuitième`,
  `dixneuvième`, sans trait d'union). Le paramètre est réaffecté comme variable de travail.

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet : suppression proposée.

### Commonalisation avec d'autres fichiers

- Aucune fonction équivalente trouvée dans le projet.

### Réduction de portée

- Module entier supprimable (aucun appelant, aucun appel dynamique par nom trouvé).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
