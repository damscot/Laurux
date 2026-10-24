# Condition — Architecture

> Source : `.src/Utils/Condition.class` · Auteur : Fabien Bodard

## Vue d'ensemble

Structure de données (4 membres `Public`, aucune méthode) décrivant **une** condition de
[`Conditions`](../Conditions.class/architecture.md) : `{Table}` (jamais renseigné), `{Field}`,
`CompareMode` (constantes `Conditions.IsEqual`…), `Value`.

**Fonctionnellement morte** : seul `Conditions` l'utilise, lui-même jamais exécuté (voir
`Conditions`). Nécessaire à la compilation tant que `Conditions` existe.

Nature : **donnée**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CompareMode` | var | Public |  | Integer | 9 |
| `Value` | var | Public |  | Variant | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
_Aucune fonction._
<!-- /AUTO:fonctions -->

## Description des fonctions

- Aucune fonction. Les membres `{Table}` et `{Field}` sont écrits entre accolades car `Table` et
  `Field` sont des mots réservés / noms de classes Gambas.
- `{Table}` : jamais lu ni écrit (`Conditions.Add` a l'affectation commentée) [portée : code mort].
- `{Field}`, `CompareMode`, `Value` : écrits par `Conditions.Add`, lus par `Conditions.Compute`
  [portée : nécessaire].

## État global utilisé

- Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer avec `Conditions` (voir CONDITIONS-001), sinon supprimer `{Table}`.

### Commonalisation avec d'autres fichiers

- Sans objet.

### Réduction de portée

- Sans objet (structure publique utilisée par `Conditions`).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
