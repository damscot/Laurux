# EntreeItem — Architecture

> Source : `.src/Gestion/Lcr/EntreeItem.module`

## Vue d'ensemble

Module utilitaire de 24 lignes : il traduit un **code entrée** LCR (`Fiches_Lcr.codeentree`,
`Fiches_Bordereaux.codeentree`, entier de 1 à 5) en libellé affichable, identique aux entrées des
listes déroulantes `Entree`/`Entree2`/`Entree3` de `Preparation.form` et `Entree` de `Glcr.form`
(listes codées en dur dans les `.form`). Le code entrée correspond au « code opération » de la
remise LCR transmise à la banque (escompte, escompte en valeur, encaissement…), repris en position
fixe dans l'en-tête du fichier bancaire généré par [`Bordrx`](../Bordrx.class/architecture.md).

Nature : **calcul pur**, sans état ni accès à la base.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `item` | 3-24 | Public | 6 | 14 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`item(sentree As String) As String`** [portée : nécessaire, appelée par
  `Preparation.Maj_Zones` l. 562] [nature : calcul]. `Select Case` sur la chaîne comparée à des
  entiers (`Case 1`… `Case 5`) : Gambas convertit la chaîne, donc `"1"` donne
  `"1- Escompte"`. Toute autre valeur (`"0"`, `""`, `"6"`) ne correspond à aucun `Case` et la
  fonction se termine sans `Return` : elle renvoie la chaîne vide (comportement à figer par test).
  Une valeur non numérique (`"x"`) provoquerait une conversion en échec : à confirmer en phase 2
  (erreur « Type mismatch » probable).

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer le `Select Case` par un tableau constant de libellés indexé par `Val(sentree)`
  (bornes vérifiées), même résultat pour 1 à 5 et `""` sinon.
- Typer le paramètre en `Integer` n'est pas possible sans modifier l'appelant (qui passe le texte
  d'une cellule de grille) : on conserve `String`.

### Commonalisation avec d'autres fichiers

- Les mêmes 5 libellés sont codés en dur dans les `List` de `Preparation.form` (3 fois) et de
  `Glcr.form`. Les `.form` étant intouchables, la commonalisation se limite à documenter la
  correspondance ; un remplissage dynamique des listes depuis ce module serait possible plus tard
  (hors périmètre, changement de `.form`).
- [`Bordrx.Button3_Click`](../Bordrx.class/architecture.md) relit le code entrée (`Left$(…, 1)`)
  pour décider de l'écriture des enregistrements d'adresse (code > 4) : une constante partagée
  (`EntreeItem.DAILLY = 5`) rendrait ce test lisible.

### Réduction de portée

- Aucune : `item` est appelée depuis `Preparation`.

### Séparation traitement / GUI

- Sans objet (calcul pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table de référence `Fiches_CodesEntree` (code, libellé) remplacerait les listes codées en dur
  du module et des `.form`.
