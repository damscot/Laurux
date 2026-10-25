# Positions — Architecture

> Source : `.src/Caisse/Positions.class`

## Vue d'ensemble

Classe de deux lignes qui déclare une énumération publique `{Left}, {Right}, Top, Bottom,
Background` (suivie d'un commentaire « Gambas module file » collé). Importée avec Laurux-Pos
(commit `f442d721`, 2018) et jamais utilisée.

**Classe jamais référencée** (signal `jamais_reference` de `deps.py`, confirmé) : aucun
`Positions.` dans le projet (le seul « Positions » trouvé est un commentaire de
`PdfWriter.class:1542`), aucune chaîne, aucun `.form`. Pas de `.form` associé : sa suppression
est un rework [code mort].

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `{Left}` | enum | Public | oui |  | 3 |
| `{Right}` | enum | Public | oui |  | 3 |
| `Top` | enum | Public | oui |  | 3 |
| `Bottom` | enum | Public | oui |  | 3 |
| `Background` | enum | Public | oui |  | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
_Aucune fonction._
<!-- /AUTO:fonctions -->

## Description des fonctions

Aucune fonction.

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le fichier (POSITIONS-001).

### Commonalisation avec d'autres fichiers

- Sans objet ; les positions d'alignement natives sont `Align.*` (Gambas).

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
