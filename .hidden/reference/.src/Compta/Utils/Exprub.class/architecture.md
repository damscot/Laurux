# Exprub — Architecture

> Source : `.src/Compta/Utils/Exprub.class`

## Vue d'ensemble

`Exprub` est un utilitaire d'**export du paramétrage des éditions comptables** (rubriques du
bilan, du compte de résultat et des SIG) vers deux fichiers texte du répertoire personnel :

- `~/Bcr.txt` : une ligne par rubrique de `Fiches_Rubriques`,
  `numrub;intitule;type;detail;num;` ;
- `~/Bcrcpt.txt` : une ligne par plage de `Fiches_RubCompt` des rubriques de type `L`,
  `numrub;compte1;compte2;amortissement;`.

Ces fichiers sont relus par l'import de [Rubresult](../Rubresult.class/architecture.md)
(`BcrSelect_Activate`). La classe n'a pas de formulaire ; sa seule méthode `run` est `Static` et
lancée depuis l'écran « Appel programme » ([Prgm](../../../Communs/Prgm.class/architecture.md),
nom `Exprub`).

Nature : **traitement** (lecture SQL + écriture de fichiers) encadré de deux messages GUI.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab1Rslt` | var | Private | oui | Result | 8 |
| `hfil` | var | Private | oui | File | 9 |
| `hfil2` | var | Private | oui | File | 10 |
| `Tab3Rslt` | var | Private | oui | Result | 11 |
| `Tab1` | var | Private | oui | String | 12 |
| `Tab3` | var | Private | oui | String | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 15-60 | Public Static | 9 | 42 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** [portée : nécessaire (appelée par `Prgm`)] [nature : mixte].
  1. `Message.Warning` listant les deux fichiers qui vont être écrasés ; « NON » (bouton 2) →
     sortie sans effet.
  2. Ouvre `~/Bcr.txt` et `~/Bcrcpt.txt` en écriture (`For Write Create` : fichiers tronqués).
  3. `SELECT * FROM Fiches_Rubriques order by numrub` ; pour chaque rubrique, écrit la ligne
     `Bcr.txt` ; si le type est `L`, `SELECT * FROM Fiches_RubCompt WHERE numrub = &1 order by
     numrub` (tri sans effet, une seule valeur de `numrub`) et écrit une ligne par plage. L'ordre
     des plages d'une rubrique est donc celui du moteur (clé primaire `numrub, compte1` sous
     MySQL/InnoDB).
  4. Ferme les fichiers et `Message.Info("Traitement terminé !")`.
  Valeurs `NULL` : converties en chaîne vide par l'affectation à une variable `String`.
  `amortissement` est écrit tel que converti en `String` par Gambas : `T` ou chaîne vide pour un
  booléen lu sous MySQL, probablement `1`/`0` sous SQLite (à confirmer). Aucun échappement du
  séparateur : un intitulé contenant `;` produit une ligne illisible à l'import.
  Les plages rattachées à une rubrique d'un autre type que `L` ne sont pas exportées (aucune dans
  `Laurux01.sql`, vérifié : les 364 plages appartiennent à des rubriques `L`).
  Partie extractible : tout sauf les deux messages.

SQL émis : deux `SELECT` (1 + une requête par rubrique `L`, 157 dans `Laurux01.sql`), aucune
écriture en base.

## État global utilisé

- `Utils.db`, `User.Home`.
- Six variables `Static` de classe (`Tab1Rslt`, `Tab3Rslt`, `hfil`, `hfil2`, `Tab1`, `Tab3`)
  utilisées seulement dans `run` : de simples variables locales suffisent.

## Propositions d'amélioration

### Réécriture / refactorisation

- Variables locales au lieu des `Static` de classe.
- Une seule requête `SELECT … FROM Fiches_RubCompt c JOIN Fiches_Rubriques r ON … WHERE r.type =
  'L' ORDER BY c.numrub, c.compte1` éviterait la requête par rubrique, mais l'ordre des lignes de
  `Bcrcpt.txt` doit rester identique (à valider sur MySQL et SQLite) ; changement facultatif.

### Commonalisation avec d'autres fichiers

- Réunir l'export (`Exprub.run`) et l'import (`Rubresult.BcrSelect_Activate`) dans un même
  module de paramétrage (`Exporte(sRep)`, `Importe(sRep)`) avec la description du format en un seul
  endroit ; `run` reste le point d'entrée appelé par `Prgm`.
- Clés `Cbase` `TabRubriques`/`TabRubCompt` (avec [Rubcompt](../Rubcompt.class/architecture.md)).

### Réduction de portée

- `run` est appelée par `Prgm` : portée nécessaire.

### Séparation traitement / GUI

- `Exporte(sRep As String)` sans message (testable en gb.test) ; `run` garde l'avertissement,
  le choix du répertoire `User.Home` et le message final.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe ne fait que lire. Un format d'échange avec échappement (CSV RFC 4180) serait
  un changement de format de fichier, pas de schéma.
