# Epurfour — Architecture

> Source : `.src/Utils/Epurfour.class`

## Vue d'ensemble

Script de maintenance **statique** qui **efface la référence fournisseur** (`art_cfour = ""`) de
**tous** les articles, **sans confirmation**. Lancé par « Appel programme » (`Prgm`, programme
`Epurfour`).

Nature globale : **mixte** (SQL + `Message.Warning`).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 3-17 | Public Static | 3 | 12 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (`Static Public`) [portée : nécessaire (`Prgm.class:67`)] [nature : mixte].
  `SELECT * FROM TabArt`, puis un `UPdate TabArt SET art_cfour = "" WHERE art_code = &2` par
  article ; « Traitement terminé » seulement s'il y a des articles. Aucune question préalable, aucun
  curseur d'attente.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabArt")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Une seule requête `UPdate TabArt SET art_cfour = &1` (même résultat en base ; log SQL différent).

### Commonalisation avec d'autres fichiers

- Même boucle « un `UPDATE` par article » que [`Papmp`](../Papmp.class/architecture.md) (88 % des
  lignes d'`Epurfour` communes) ; regroupement possible dans un module `Maintenance` (voir `Papmp`).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ViderRefFournisseurs()` sans message ; `run` affiche le message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
