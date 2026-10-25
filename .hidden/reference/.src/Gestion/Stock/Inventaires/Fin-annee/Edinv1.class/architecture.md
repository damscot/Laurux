# Edinv1 — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class`

## Vue d'ensemble

**Classe morte** (couple `Edinv1.class` + `Edinv1.form`) : aucun appelant dans `.src` (`grep -rn Edinv1`
hors du fichier : aucun résultat ; pas de nom en chaîne pour `Object.New`/`Class.Load`). Les menus
85 et 99 de `Fmenu` ouvrent `New Edinv("F")` / `New Edinv("T")`.

C'est une copie à 87 % d'[Edinv](../Edinv.class/architecture.md) dans sa version non paramétrée : même parcours de l'arbre `Trifam` (`TriArticles`, `sautpage`), sur `Fiches_Inv` seulement, aide ouverte par `xdg-open Ecrans/Edinv.html` au lieu de `Doc.Open`.

La suppression du couple `.class` + `.form` est une **anomalie** soumise à validation
(EDINV1-A01), conformément au PLAN ; aucun rework de fond n'est proposé sur du code inatteignable.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `Decm` | var | Private |  | Integer | 29 |
| `nbd` | var | Private |  | String | 30 |
| `nbdec` | var | Private |  | String | 31 |
| `PosY` | var | Private |  | Integer | 32 |
| `Coulfond` | var | Private |  | New String[] | 33 |
| `pdf` | var | Private |  | Cstocks | 34 |
| `$familles` | var | Private |  | Trifam | 35 |
| `Nbpage` | var | Private |  | Integer | 36 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 38-65 | Public | 5 | 24 | 0 | méthode spéciale |
| `TriArticles` | 67-125 | Private | 15 | 56 | 0 |  |
| `sautpage` | 127-134 | Private | 1 | 7 | 0 |  |
| `Button1_Click` | 136-166 | Public | 2 | 22 | 0 | handler GUI |
| `button2_Click` | 168-173 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 175-179 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions (`_New`, `TriArticles`, `sautpage`, `Button1_Click`, `button2_Click`, `Button4_Click`) sont inatteignables. Leur comportement, s'il était appelé, est celui
décrit pour [Edinv](../Edinv.class/architecture.md) (lecture seule de la table d'inventaire, `Fiches_Art`, `Fiches_Fam` ;
PDF `Cstocks`), avec les mêmes défauts (articles sans `Available`, trace `Print` l. 81).
[portée : sans objet — code mort] [nature : mixte (`_New`, `Button1_Click`), GUI (autres)].

## État global utilisé

- Sans objet à l'exécution (classe jamais instanciée) ; statiquement : `Utils`, `Cstocks`,
  `Visualiseur`, `Trifam`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : suppression proposée en anomalie.

### Commonalisation avec d'autres fichiers

- Déjà réalisée historiquement par [Edinv](../Edinv.class/architecture.md) (`_New(choix)`).

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
