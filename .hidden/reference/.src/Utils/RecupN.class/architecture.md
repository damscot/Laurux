# RecupN — Architecture

> Source : `.src/Utils/RecupN.class`

## Vue d'ensemble

Script de **réparation ponctuelle** « récupération des écritures N-1 si clôture intempestive » :
recopie les écritures de `Fiches_Mvt1` (exercice précédent) portant les numéros **1 à 424** (valeur
**en dur**, propre à une base donnée) dans `Fiches_Mvt`, en les renumérotant à la suite du dernier
numéro existant. Lancé par « Appel programme » (`Prgm`, programme `RecupN`).

**Dangereux** : aucune confirmation, aucune transaction, non idempotent (chaque exécution duplique les
écritures). Nature globale : **calcul (SQL)** + `Message.Info`.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 5-30 | Public Static | 4 | 23 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (`Static Public`) [portée : nécessaire (`Prgm.class:64`)] [nature : mixte].
  1. `SELECT * FROM Fiches_Mvt ORDER BY numero` (toute la table), `MoveLast`, `Numecr = numero + 1`.
     Table vide : `MoveLast`/lecture sur résultat vide → erreur (non testée).
  2. Pour `Numdef` de 1 à 424 : `SELECT * FROM Fiches_Mvt1 WHERE numero = &1` et, pour chaque ligne,
     `INSERT INTO Fiches_Mvt` de 19 colonnes (`jour`, `numero` = `Numecr`, `compte`, `intitule`,
     `dte`, `numdoc`, `numlot`, `libelle`, `montantd`, `montantc`, `validee`, `provisoire`,
     `tresorerie`, `lettree` = 0, `cloturee`, `pointee`, `numcol` = **variable jamais affectée**
     (vide), `collectif`, `numerodef` = 0). `Numecr` est incrémenté à chaque `Numdef`, même sans
     écriture source (trous de numérotation).
  3. `Message.Info("TRAITEMENT TERMINÉ")`.
  Tables en dur `Fiches_Mvt`, `Fiches_Mvt1` (pas de `Cbase.Table`). Les 8 colonnes non listées
  (`datee`, `dateech`, `nrlv`, `dteval`, `relance`, `export`, `control`, `lind`) prennent leur valeur
  par défaut : `control` (somme de contrôle chaînée calculée par `Sha1Calc`, à confirmer) n'est pas
  recalculée, les dates de saisie et d'échéance sont perdues.

## État global utilisé

- `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Si le script est conservé : paramètres (exercice source, plage de numéros) demandés à l'utilisateur,
  confirmation, transaction `Utils.db.Begin/Commit/Rollback`, `Cbase.Table`.

### Commonalisation avec d'autres fichiers

- La copie d'écritures entre `Fiches_Mvt*` existe aussi dans la clôture (`Compta/Clotures/`) et les
  scripts `RenMvt`/`RecupDech` de `Prgm` : à rapprocher lors de la documentation du lot `Compta`.

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Sortir le `Message.Info` vers `Prgm`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les 6 tables `Fiches_Mvt…Mvt5` de structure identique imposent ce genre de copies : une table unique
  avec une colonne « exercice » les supprimerait.
