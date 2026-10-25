# barselection — Architecture

> Source : `.src/Gestion/option/barselection.class`

## Vue d'ensemble

`Barselection` est une **barre d'actions de saisie de table** construite par code dans un
conteneur fourni par l'écran appelant : `New Barselection(choix, conteneur) As "bar1"`. La chaîne
`choix` (9 caractères, `"0"` = bouton masqué, tout autre caractère ou caractère absent = visible)
choisit les boutons : premier, précédent, création, modification, suppression, suivant, dernier,
sortie, recherche (dans cet ordre).

**Cycle partagé** par six écrans ([`Mreglement`](../../Tables/Mreglement.class/architecture.md)
`"001110010"`, `Tconsigne` et `Ttourne` `"111111111"`, `Tregie`, `Tregion`, `Tchauffeur`
`"111111110"`) :

1. mode navigation : boutons ; un clic lève `premier`, `precedent`, `suivant`, `dernier`,
   `quitter` ou `recherche` ;
2. création / modification / suppression : la barre est **remplacée** (`efface`) par un libellé
   (« Création », « Modification », « Suppression ? ») et deux boutons Annuler/Valider, puis
   l'événement `creer`, `modif` ou `suprimer` est levé (l'appelant ouvre en général une
   transaction et prépare `Create9`/`Edit`/`Delete`) ;
3. Annuler/Valider lèvent `annule(creer, modif)` / `valide(creer, modif)` (suppression :
   `False, False`) ; si l'appelant fait `Stop Event`, la barre reste en mode validation, sinon elle
   est reconstruite et les drapeaux remis à faux.

`estcreer`/`estmodif` exposent le mode en cours. La classe est déclarée `Export`.

Nature globale : **GUI**, sans SQL.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$bcreer` | var | Private |  | Boolean | 5 |
| `$bmodif` | var | Private |  | Boolean | 6 |
| `$schoix` | var | Private |  | String | 7 |
| `$oobj` | var | Private |  | Object | 8 |
| `estcreer` | property | Public |  | Boolean | 10 |
| `estmodif` | property | Public |  | Boolean | 11 |
| `precedent` | event | Public |  |  | 13 |
| `suivant` | event | Public |  |  | 14 |
| `premier` | event | Public |  |  | 15 |
| `dernier` | event | Public |  |  | 16 |
| `creer` | event | Public |  |  | 17 |
| `suprimer` | event | Public |  |  | 18 |
| `modif` | event | Public |  |  | 19 |
| `recherche` | event | Public |  |  | 20 |
| `quitter` | event | Public |  |  | 21 |
| `valide` | event | Public |  |  | 22 |
| `annule` | event | Public |  |  | 23 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 25-32 | Public | 1 | 5 | 0 | méthode spéciale |
| `affichechoix` | 34-93 | Private | 10 | 48 | 0 |  |
| `visible` | 95-103 | Private | 2 | 7 | 0 |  |
| `butpref` | 105-111 | Private | 1 | 6 | 0 |  |
| `afficheval` | 113-146 | Private | 4 | 30 | 0 |  |
| `efface` | 148-159 | Private | 2 | 9 | 0 |  |
| `bout_click` | 161-190 | Public | 10 | 27 | 0 | handler GUI |
| `butval_Click` | 192-211 | Public | 5 | 17 | 0 | handler GUI |
| `estcreer_Read` | 213-217 | Private | 1 | 3 | 0 |  |
| `estmodif_Read` | 219-223 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(choix, obj)`** [portée : nécessaire] [GUI] : mémorise et `affichechoix`.
- **`affichechoix(choix, obj)`** [Private] [GUI] (CC 10). Neuf blocs identiques : bouton du
  groupe `"bout"`, icône, `butpref(bouton, rang, infobulle)`.
- **`visible(c)`** [Private] [calcul]. Faux seulement pour `"0"`.
- **`butpref(bt, i, s)`** [Private] [GUI]. `AutoResize`, `Expand`, `Tag = rang`, infobulle.
- **`afficheval()`** [Private] [GUI]. Lit `Last.Tag` (bouton cliqué), `efface`, libellé selon le
  rang, boutons du groupe `"butval"` (`Tag` 1 = annuler/`Cancel`, 2 = valider/`Default`).
- **`efface()`** [Private] [GUI]. Détruit **tous** les enfants du conteneur reçu (l'appelant doit
  dédier un conteneur à la barre).
- **`bout_click`** [handler, reste `Public`] [GUI]. Selon `Last.Tag` : lève l'événement ; pour 3,
  4, 5 passe d'abord en mode validation (`$bcreer`/`$bmodif` à vrai pour 3/4).
- **`butval_Click`** [handler] [GUI]. Lève `annule` ou `valide` ; si non annulé par l'appelant,
  reconstruit la barre. La barre passe en mode validation **avant** de lever `creer`/`modif`/
  `suprimer`, dont la valeur de retour est ignorée : un appelant qui refuse l'action (ex.
  `Mreglement.bar1_modif` sans ligne sélectionnée, MREGLEMENT-A02) laisse la barre en mode
  validation (A01).
- **`estcreer_Read`, `estmodif_Read`** [Private (propriétés publiques)] : drapeaux du mode.

## État global utilisé

Aucun (icônes `icon:/medium/…` et `Icones/next_frame.png`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `affichechoix` : tableau `[icône, infobulle]` indexé par le rang et une boucle sur la chaîne
  `choix` (même ordre de création des boutons).

### Commonalisation avec d'autres fichiers

- Le cycle `Begin` → `Create9`/`Edit` → `Commit`/`Rollback` est réécrit dans chaque écran
  appelant (`Mreglement`, `Tconsigne`, `Tregie`, `Tregion`, `Ttourne`) : MREGLEMENT-006 propose de
  le factoriser, dans `Barselection` ou un helper commun ; à décider avec les écrans du lot option.

### Réduction de portée

Aucune. `Export` peut être retiré si Laurux n'est pas utilisé comme bibliothèque (vérifier
`gba3` et l'absence de projet consommateur) : laissé en l'état.

### Séparation traitement / GUI

Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
