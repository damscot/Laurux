# RenAN — Architecture

> Source : `.src/Compta/Utils/RenAN.class`

## Vue d'ensemble

Classe statique (pas de `.form`) de **renumérotation des écritures d'à-nouveaux** : toutes les
lignes « Report a nouveau » reçoivent le numéro 1. Lancée par `Prgm` (`RenAN`, `Prgm.class:74`)
sans confirmation ni transaction (PRGM-A02).

Elle opère sur **`Fiches_Mvtoc`**, table **absente** de `db_control.csv`, de `Cbase` et de tout
autre source (grep `Mvtoc` : seule occurrence) : sur une base actuelle, la première requête
échoue et `Utils.db.Exec` affiche l'erreur SQL (PRGM-A06). Le script est donc **inopérant**.

Nature : **traitement SQL** (message de fin).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 5-19 | Public Static | 3 | 12 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (Static, CC 3) [portée : nécessaire — `Prgm.class:74`] [nature : traitement +
  message] : `SELECT * FROM Fiches_Mvtoc WHERE libelle = 'Report a nouveau' ORDER BY numero`, puis
  pour chaque ligne `Update Fiches_Mvtoc SET numero = 1, numerodef = 1 WHERE compte = <compte>
  AND numero = <numero>` ; `Message.Info("TRAITEMENT TERMINÉ")` (non extrait pour l'i18n). Si la
  table existait, toutes les écritures d'à-nouveaux fusionneraient en une seule écriture n° 1.

## État global utilisé

- `Utils.db` ; table `Fiches_Mvtoc` (inexistante).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : script à retirer (anomalie A01).

### Commonalisation avec d'autres fichiers

- Sans objet. La génération des à-nouveaux est faite par la clôture (`Compta/Clotures/`).

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
