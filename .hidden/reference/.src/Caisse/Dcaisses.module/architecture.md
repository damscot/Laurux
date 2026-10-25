# Dcaisses — Architecture

> Source : `.src/Caisse/Dcaisses.module`

## Vue d'ensemble

Module d'une seule fonction, `TestCai(Cai)`, qui lit le fichier de verrou `~/Caisse<Cai>.lock`
et renvoie sa première ligne (le vendeur connecté sur la caisse). C'est l'ancêtre de
[`TestCaisses.TestCai`](../TestCaisses.module/architecture.md), qui l'a remplacé (contrôle du
vendeur sur les caisses 1 à 10). Le fichier contient deux en-têtes (« class file » puis
« module file »).

**Module jamais référencé** (signal `jamais_reference` de `deps.py`, confirmé) : aucun
`Dcaisses.` dans le projet, nom absent des chaînes. Pas de `.form` : sa suppression est un
rework [code mort].

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `TestCai` | 3-19 | Public | 3 | 14 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`TestCai(Cai As String) As String`** [portée : réductible → code mort] [nature : calcul] :
  si `User.home & "/Caisse" & Cai & ".lock"` existe, lit la première ligne et la renvoie, sinon
  `""`. Effet de bord : lecture de fichier uniquement. Signal `unused` confirmé (les appels
  `TestCai` d'`Ouverture` portent sur `TestCaisses`, `Ouverture.class:132` et `200`).

## État global utilisé

- `User.home` (répertoire des verrous de caisse).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le module (DCAISSES-001).

### Commonalisation avec d'autres fichiers

- La lecture d'un verrou de caisse est à regrouper avec `TestCaisses` et l'écriture d'`Ouverture`
  (voir TESTCAISSES-004) ; `Dcaisses` n'y contribue pas puisqu'il est mort.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet (pas d'interface).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
