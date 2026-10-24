# Conditions — Architecture

> Source : `.src/Utils/Conditions.class` · Auteur : Fabien Bodard

## Vue d'ensemble

Classe de **mise en forme conditionnelle** pour la grille `RichDataGrid` : une liste de
[`Condition`](../Condition.class/architecture.md) (champ, opérateur, valeur) combinées par **ET**,
évaluée sur la ligne courante d'un `Result`. `Value` renvoie `IfTrue` ou `IfFalse` selon le résultat
de la dernière évaluation (dans `RichDataGrid`, `IfTrue` porte un `CFormat`).

**Fonctionnellement morte** : le seul utilisateur est `RichDataGrid.Grid_Data`
(`RichDataGrid.class:128-164`), qui parcourt `$aCondFormats` ; ce tableau n'est alimenté que par la
propriété `RichDataGrid.CondFormats`, qu'aucun fichier n'affecte (`grep -rn CondFormats .src`). Le
seul client de `RichDataGrid` (`Gestion/Tables/Remisec.class`) ne l'utilise pas. La classe reste
toutefois **nécessaire à la compilation** (type référencé par `RichDataGrid`).

Nature globale : **calcul pur**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `IsEqual` | const | Public |  |  | 7 |
| `IsDifferent` | const | Public |  |  | 8 |
| `IsInferior` | const | Public |  |  | 9 |
| `IsInferiorOrEqual` | const | Public |  |  | 10 |
| `IsSuperior` | const | Public |  |  | 11 |
| `IsSuperiorOrEqual` | const | Public |  |  | 12 |
| `EstEgale` | const | Public |  |  | 15 |
| `EstDifferent` | const | Public |  |  | 16 |
| `EstInferieur` | const | Public |  |  | 17 |
| `EstInferieurOuEgale` | const | Public |  |  | 18 |
| `EstSuperieur` | const | Public |  |  | 19 |
| `EstSuperieurOuEgale` | const | Public |  |  | 20 |
| `Ressemble` | const | Public |  |  | 21 |
| `$vIfTrue` | var | Private |  | Variant | 23 |
| `$vIfFalse` | var | Private |  | Variant | 24 |
| `$vValue` | var | Private |  | Variant | 25 |
| `aConditions` | var | Private |  | New Object[] | 27 |
| `IfTrue` | property | Public |  | Variant | 29 |
| `IfFalse` | property | Public |  | Variant | 30 |
| `Value` | property | Public |  | Variant | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-39 | Public | 1 | 5 | 0 | méthode spéciale |
| `Add` | 41-51 | Public | 1 | 7 | 0 |  |
| `Clear` | 53-57 | Public | 1 | 3 | 0 | portée réductible ? |
| `Compute` | 59-91 | Public | 13 | 28 | 1 |  |
| `IfTrue_Read` | 93-97 | Private | 1 | 3 | 0 |  |
| `IfTrue_Write` | 99-103 | Private | 1 | 3 | 0 |  |
| `IfFalse_Read` | 105-109 | Private | 1 | 3 | 0 |  |
| `IfFalse_Write` | 111-115 | Private | 1 | 3 | 0 |  |
| `Value_Read` | 117-121 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **Constantes** : deux jeux équivalents, anglais (`IsEqual`…`{Like}`) et français
  (`EstEgale`…`Ressemble`), valeurs 1 à 7.
- **`_New(sField, CompareMode, Value, [vIfTrue], [vIfFalse])`** [portée : nécessaire (spéciale)]
  [nature : calcul]. Ajoute une première condition et mémorise les deux valeurs de sortie.
- **`Add(sField, CompareMode, Value)`** [portée : réductible (appelé seulement par `_New`)] [calcul].
  Crée une `Condition` (le champ `Table` reste vide, affectation commentée) et l'ajoute à la liste.
- **`Clear()`** [portée : réductible (aucun appelant)] [calcul]. Vide la liste.
- **`Compute(hResult As Result) As Boolean`** [portée : nécessaire (`RichDataGrid:162`)] [calcul].
  Liste vide → `False`. Pour chaque condition, compare `hResult[Field]` à `Value` selon l'opérateur
  (`=`, `<>`, `<`, `<=`, `>`, `>=`, `Like`) et cumule par `And`. Un opérateur inconnu réutilise le
  résultat `sb` de la condition précédente (ou `False`). Met `$vValue` à `IfTrue`/`IfFalse`. Toute
  erreur (champ inexistant, types incomparables) → `Catch` → `False` **sans** mettre à jour `Value`.
- **Propriétés `IfTrue`, `IfFalse` (lecture/écriture), `Value` (lecture)** [nécessaire : `Value` lue
  par `RichDataGrid:164` ; `IfTrue`/`IfFalse` réductibles] [calcul].

## État global utilisé

- Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Select Case hCondition.CompareMode` au lieu de la chaîne `Else If` (CC identique, lisibilité).
- Un seul jeu de constantes (les deux jeux sont publics : vérifier qu'aucun n'est utilisé —
  `grep -rn "Conditions\.\(Is\|Est\|Ressemble\)" .src` ne renvoie rien).

### Commonalisation avec d'autres fichiers

- Ensemble mort `RichDataGrid.CondFormats` + `Conditions` + `Condition` : à supprimer **ensemble**
  (voir [`RichDataGrid`](../RichDataGrid.class/architecture.md)), ou à conserver ensemble.

### Réduction de portée

- `Add`, `Clear`, `IfTrue`, `IfFalse`, constantes : aucun usage externe.

### Séparation traitement / GUI

- Sans objet (calcul pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
