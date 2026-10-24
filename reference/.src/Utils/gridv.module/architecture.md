# gridv — Architecture

> Source : `.src/Utils/gridv.module`

## Vue d'ensemble

Module contenant une seule fonction, `ajoustat`, qui ajoute un onglet « Statistiques » à un
`TabStrip` et y dessine un `GridView` vide au format du tableau comparatif annuel (12 mois +
TOTAL, 4 exercices × C.A / Quantité / Marge), sans calcul ni gestion d'événement.

**Le module n'a aucun appelant** : `grep -rni 'gridv\.\|ajoustat' .src` ne trouve que sa
définition (l'occurrence `'affiche gridv` de `Tregie.class:127` est un commentaire). Introduit par
le commit `d5bea4ab` « Ajout gridvi & gridv », il a été remplacé par la classe
[`gridvi`](../gridvi.class/architecture.md). C'est du **code mort**.

Nature : GUI + lecture de `Fiches_Parametres`.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `ajoustat` | 3-69 | Public | 10 | 56 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`ajoustat(TabStrip1) As GridView`** [portée : sans objet, code mort] [nature : GUI + SQL].
  Ajoute un onglet, crée un `GridView` (sans nom d'événement), lit `Fiches_Parametres`
  (`SELECT * FROM Fiches_Parametres`, renvoie `Null` si vide), dessine 12 en-têtes (boucle
  **identique** à `gridvi.affent`, 25 lignes) et les 12 libellés de mois + TOTAL (10 lignes
  identiques à `gridvi._new`), remet l'onglet 0 actif et renvoie la grille. La variable locale
  `$grdv` utilise le préfixe `$` réservé aux membres privés.

## État global utilisé

- `Utils.db`, `Utils.mois`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : le module doit être **supprimé**.

### Commonalisation avec d'autres fichiers

- 35 lignes identiques à [`gridvi`](../gridvi.class/architecture.md) (`affent` + libellés de mois),
  également présentes dans [`gridvi2`](../gridvi2.class/architecture.md). Suppression conjointe
  avec `gridvi2`.

### Réduction de portée

- Sans objet (suppression ; `deps.py` signale `ajoustat` comme réductible, ce qui est exact
  puisqu'il n'a aucun appelant).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (code mort).
