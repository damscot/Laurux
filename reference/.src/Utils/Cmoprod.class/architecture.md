# Cmoprod — Architecture

> Source : `.src/Utils/Cmoprod.class`

## Vue d'ensemble

Structure de données de 6 membres `Public` (`Name`, `C`, `CM`, `I`, `Q` en `String`, `ID` en
`Integer`), sans méthode ni commentaire. Le nom évoque la main d'œuvre et les produits
(« Cmo » / « prod ») ; son usage d'origine est inconnu (à confirmer).

**Code mort** : aucune référence dans le projet (`grep -rniw cmoprod .src` → aucun résultat hors de
ce fichier, y compris dans les chaînes et les `.form`).

Nature : **donnée**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Name` | var | Public |  | String | 3 |
| `C` | var | Public |  | String | 4 |
| `CM` | var | Public |  | String | 5 |
| `I` | var | Public |  | String | 6 |
| `Q` | var | Public |  | String | 7 |
| `ID` | var | Public |  | Integer | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
_Aucune fonction._
<!-- /AUTO:fonctions -->

## Description des fonctions

- Aucune fonction.

## État global utilisé

- Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le fichier.

### Commonalisation avec d'autres fichiers

- Sans objet.

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
