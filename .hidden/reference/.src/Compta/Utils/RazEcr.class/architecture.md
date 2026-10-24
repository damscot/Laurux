# RazEcr — Architecture

> Source : `.src/Compta/Utils/RazEcr.class` · Formulaire : `.src/Compta/Utils/RazEcr.form`

## Vue d'ensemble

Formulaire **vide de fonction** : boutons « Lancer » et « Quitter ». `Lancer` appelle `Raz()`,
dont tout le corps est **commenté** (ancien `DELETE FROM Fiches_Mvt WHERE left(dte,4) = '2011'`).
Ouvert uniquement par `Prgm` (nom `RazEcr`, `Prgm.class:78`). Le couple `.class` + `.form` est
**mort fonctionnellement** : il ne fait rien.

Nature : **GUI** (aucun traitement actif).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-5 | Public | 1 | 2 | 0 | méthode spéciale |
| `Raz` | 7-13 | Public | 1 | 2 | 0 | portée réductible ? |
| `Button2_Click` | 15-19 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 21-25 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [constructeur] : vide.
- **`Raz()`** [portée : réductible — aucun appelant externe] : corps entièrement commenté ; ne
  fait rien.
- **`Button2_Click()`** [handler] : ferme.
- **`Button1_Click()`** [handler] : appelle `Raz()` (sans effet).

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : couple à supprimer (anomalie A01).

### Commonalisation avec d'autres fichiers

- Sans objet.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
