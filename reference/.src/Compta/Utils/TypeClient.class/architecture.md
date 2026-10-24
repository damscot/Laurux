# TypeClient — Architecture

> Source : `.src/Compta/Utils/TypeClient.class`

## Vue d'ensemble

**Contrôle graphique réutilisable** (`Export`, `Inherits TreeView`) qui liste les **types de
clients** (`Fiches_Typec` : `code`, `libelle`) et expose, par la propriété en lecture `where`, un
fragment SQL `cli_typec IN('A','B',…)` construit à partir de la sélection (mode
`Select.Multiple` réglé dans les `.form`). Il est posé dans les formulaires `Balance`,
`EdNjustifiees` et `EdNlettrees` (contrôle `TypeClient1`) et passé en paramètre à
`BalanceM.Imprime` : les états de balance et de comptes non lettrés / non justifiés peuvent ainsi
être filtrés par type de client.

Nature : **mixte** (chargement SQL dans le constructeur d'un contrôle ; `where` est un calcul pur
sur la sélection).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `where` | property | Public |  | String | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-20 | Public | 3 | 9 | 0 | méthode spéciale |
| `where_Read` | 22-36 | Private | 3 | 12 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** (CC 3) [constructeur, appelé à la création du contrôle par le `.form`]
  [nature : mixte] : `SELECT * FROM Fiches_Typec` (nom en dur ; clé `Cbase` `TabTypec` existante),
  un élément `Add(code, libelle)` par type, dans l'ordre de la base (pas d'`ORDER BY`).
  `Utils.db` doit donc être connecté avant l'ouverture du formulaire hôte.
- **`where_Read()`** [Private, propriété `where`] [nature : calcul] : `""` si rien n'est
  sélectionné ; sinon `cli_typec IN(` + `Utils.db.Subst("&1,", clé)` par élément sélectionné
  (valeurs correctement quotées) + `)`. Le fragment suppose une jointure avec `Fiches_Cli`
  (colonne `cli_typec`), faite par les appelants.

## État global utilisé

- `Utils.db` (`Exec`, `Subst`) ; table `Fiches_Typec`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabTypec")` ; `SELECT code, libelle` au lieu de `SELECT *` (même résultat).
- `If Not res.Available Then Return` déjà implicite ; rien d'autre à simplifier (classe courte).

### Commonalisation avec d'autres fichiers

- La construction `col IN(&1,&2,…)` à partir d'une liste se retrouve ailleurs (par ex. sélection
  multiple de `TriGen`, voir notes transverses) : helper `Utils.SqlIn(sColonne, aValeurs)`.

### Réduction de portée

- Sans objet (`where` est utilisée par 4 fichiers ; `_new` est le constructeur).

### Séparation traitement / GUI

- Extraire la construction du fragment dans une fonction statique pure
  `Static Public Function WhereTypes(aCodes As String[]) As String`, testable sans interface,
  appelée par `where_Read` avec la sélection.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (table de référence de quelques lignes).
