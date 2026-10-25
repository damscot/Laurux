# Tchauffeur — Architecture

> Source : `.src/Gestion/option/Tchauffeur.class`

## Vue d'ensemble

Ébauche d'écran **« Fiche chauffeurs »** (`Tchauffeur.form` : zones `TextBox1` à `TextBox7` pour
code, nom, prénom, date d'entrée, adresse, code postal, ville ; un panneau `Panel3` pour la barre
d'actions). Le fichier ne contient que la création de la barre `Barselection("111111110", panel3)`
et un handler vide.

Constat vérifié par `grep -rn` sur `.src/` :
- **aucun appelant** : ni `Tchauffeur.Show`, ni `New Tchauffeur` dans le projet (la seule
  occurrence du mot « chauffeur » hors de ce couple est le titre du `.form`) ;
- **aucune table** : il n'existe pas de table des chauffeurs (ni dans `db_control.csv`, ni dans
  `modfichier.module`) ;
- la barre est créée avec le nom d'événement `bar1`, mais **aucun handler `bar1_*`** n'existe :
  les boutons de la barre ne déclenchent rien (seul l'affichage Valider/Annuler de
  `Barselection` fonctionne).

C'est donc un **couple `.class` + `.form` mort**, vestige d'une option « livraison/tournées »
inachevée (voir [Ttourne](../Ttourne.class/architecture.md) et
[rechtour](../rechtour.class/architecture.md), qui, eux, sont raccordés).

Nature : **GUI** (aucun traitement).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `bs` | var | Private |  | Barselection | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 5-9 | Public | 1 | 3 | 0 | méthode spéciale |
| `TextBox7_KeyPress` | 11-15 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : GUI] : `bs = New Barselection("111111110",
  panel3) As "bar1"` : affiche les boutons premier, précédent, création, modification,
  suppression, suivant, dernier et sortie (pas de recherche). Aucun handler `bar1_*` n'est défini,
  donc les événements levés par la barre sont perdus.
- **`TextBox7_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI] : vide.

## État global utilisé

Aucun (pas de `Utils.db`, pas de `Utils.Observers`, pas de `Start.*`).

## Propositions d'amélioration

### Réécriture / refactorisation

Aucune : le fichier n'a pas de logique. La seule décision utile est la suppression du couple
(anomalie TCHAUFFEUR-A01, soumise à validation) ou son achèvement (hors périmètre du rework).

### Commonalisation avec d'autres fichiers

Si l'écran devait être achevé, il suivrait le cycle `Barselection` commun à
[Ttourne](../Ttourne.class/architecture.md), [Tregion](../Tregion.class/architecture.md),
[Tregie](../Tregie.class/architecture.md), [Tconsigne](../Tconsigne.class/architecture.md) et
[Mreglement](../../Tables/Mreglement.class/architecture.md) (`Begin` → `Create9`/`Edit` →
`Commit`/`Rollback`), et non le socle « table code/libellé » à observateurs de
[Centrales](../../Tables/Centrales.class/architecture.md) (7 champs, pas une simple paire
code/libellé).

### Réduction de portée

Rien à réduire : `_new` et `TextBox7_KeyPress` doivent rester `Public` (constructeur et handler).

### Séparation traitement / GUI

Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table `Fiches_Chauffeurs` (code, nom, prénom, date d'entrée, adresse) serait nécessaire pour
  achever l'écran ; elle pourrait être rattachée aux tournées (`Fiches_tourne`).
