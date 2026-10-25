# EdinvT — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class`

## Vue d'ensemble

**Classe morte** (couple `EdinvT.class` + `EdinvT.form`) : aucun appelant dans `.src` (`grep -rn EdinvT`
hors du fichier : aucun résultat ; pas de nom en chaîne pour `Object.New`/`Class.Load`). Les menus
85 et 99 de `Fmenu` ouvrent `New Edinv("F")` / `New Edinv("T")`.

C'est une ancienne édition de l'inventaire tournant **sans regroupement par famille** (38 % de lignes communes avec [Edinv](../../Fin-annee/Edinv.class/architecture.md)) : toutes les lignes comptées de `Fiches_InvT`, valorisation PA/PMP, total général, PDF `~/tmp/InventaireT.pdf`. Elle contient en plus `Level1`, `Level2`, `Level3` (dessin `Draw` de l'ancienne impression), jamais appelées même en interne.

La suppression du couple `.class` + `.form` est une **anomalie** soumise à validation
(EDINVT-A01), conformément au PLAN ; aucun rework de fond n'est proposé sur du code inatteignable.

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
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-59 | Public | 6 | 21 | 0 | méthode spéciale |
| `Button1_Click` | 61-142 | Public | 10 | 79 | 0 | handler GUI |
| `Level1` | 145-164 | Public | 1 | 18 | 0 | portée réductible ? |
| `Level2` | 167-179 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level3` | 182-200 | Public | 1 | 17 | 0 | portée réductible ? |
| `button2_Click` | 202-207 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 209-213 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions (`_New`, `Button1_Click`, `Level1`, `Level2`, `Level3`, `button2_Click`, `Button4_Click`) sont inatteignables. Leur comportement, s'il était appelé, est celui
décrit pour [Edinv](../../Fin-annee/Edinv.class/architecture.md) (lecture seule de la table d'inventaire, `Fiches_Art`, sans familles ;
PDF `Cstocks`), avec les mêmes défauts (articles sans `Available`, test `If Not Error And If` correct ici (`And If` court-circuite)).
[portée : sans objet — code mort] [nature : mixte (`_New`, `Button1_Click`), GUI (autres)].

## État global utilisé

- Sans objet à l'exécution (classe jamais instanciée) ; statiquement : `Utils`, `Cstocks`,
  `Visualiseur`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : suppression proposée en anomalie.

### Commonalisation avec d'autres fichiers

- Déjà réalisée historiquement par [Edinv](../../Fin-annee/Edinv.class/architecture.md) (`_New(choix)`).

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
