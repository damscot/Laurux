# HistoCom — Architecture

> Source : `.src/Utils/HistoCom.class`

## Vue d'ensemble

Script de **réparation ponctuelle** (bogue de la version 3.16) : pour les lignes de commentaire
(`typel_ligfac = "C"`) de l'historique des factures (`Fiches_HistoLigfac`), déplace le texte de
`libel_ligfac` vers `com_ligfac` et vide `libel_ligfac`. Lancé par « Appel programme » (`Prgm`,
programme `HistoCom`, qui affiche ensuite « Traitement terminé »).

Nature globale : **calcul (SQL)**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 5-18 | Public Static | 4 | 11 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (`Static Public`) [portée : nécessaire (`Prgm.class:107`)] [nature : calcul].
  `SELECT * FROM TabHisLigFac WHERE typel_ligfac = &1` (`"C"`) puis, pour chaque ligne dont le libellé
  n'est pas vide, `UPdate … SET com_ligfac = libellé, libel_ligfac = "" WHERE num_ligfac = &3 AND
  numlig_ligfac = &4`. Seul usage de `Do … Loop Until` du lot (au lieu de `Repeat … Until`).
  Idempotent : au second passage, les libellés sont vides et ignorés (`IsNull("")` est vrai en Gambas).
  ⚠️ Un commentaire déjà présent dans `com_ligfac` est **écrasé** par le libellé.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabHisLigFac")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Repeat … Until` (idiome du dépôt).
- Script lié à une migration de 2016 (3.16) : sa place serait `LauruxMaj` ; il peut être retiré de
  `Prgm` si l'utilisateur confirme qu'aucune base en production n'en a encore besoin (voir anomalie).

### Commonalisation avec d'autres fichiers

- Regroupement possible des scripts `run` dans un module `Maintenance` (voir
  [`Papmp`](../Papmp.class/architecture.md)).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Déjà sans GUI (le message est affiché par `Prgm`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
