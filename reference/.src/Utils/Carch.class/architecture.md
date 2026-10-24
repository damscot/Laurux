# Carch — Architecture

> Source : `.src/Utils/Carch.class` · Form : `Carch.form`

## Vue d'ensemble

Fenêtre de **réglage des couleurs des archives** : factures (`/Coul/Facts`) et avoirs
(`/Coul/Avs`).

Ces trois fenêtres ([`Cprod`](../Cprod.class/architecture.md), [`Cmo`](../Cmo.class/architecture.md),
[`Carch`](../Carch.class/architecture.md)) sont des copies d'un même modèle : un `TextBox`/`TextLabel`
coloré et un libellé `&HRRGGBB&` par couleur, un double-clic (groupe d'événements `Coul`) qui ouvre
un panneau `Pcol` contenant un `ColorChooser` (`dlgColor`), puis deux boutons (groupe `Btn`,
`Tag` 1 = valider et enregistrer dans `Start.LocalSettings`, `Tag` 2 = fermer). Elles sont
**remplacées** par [`SetColors`](../SetColors.class/architecture.md) (`Fmenu.class:1527`), dont le
`.form` gère les mêmes clés `/Coul/...` par la propriété `Tag` des contrôles.

Seul appelant : `Fmenu.Menu156_Click` (`Fmenu.class:1417`). Or `Menu156` est le menu **parent**
« Etiquettes » (`Fmenu.form:352`, avec sous-menus) : l'événement `Click` d'un menu qui a des enfants
n'est normalement pas levé, la fenêtre est donc probablement **inatteignable** (à confirmer en
lançant l'application). Le libellé du menu ne correspond de toute façon pas à cette fenêtre.

Nature globale : **GUI** (réglages locaux, aucun accès base).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `sColor` | var | Private |  | String | 28 |
| `Value` | var | Private |  | String | 29 |
| `Factures` | var | Private |  | String | 30 |
| `Avoirs` | var | Private |  | String | 31 |
| `B` | var | Private |  | Integer | 32 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 37-50 | Public | 3 | 11 | 0 | méthode spéciale |
| `Coul_Dblclick` | 52-66 | Public | 3 | 13 | 0 | handler GUI |
| `btnOK_Click` | 68-82 | Public | 3 | 13 | 0 | handler GUI |
| `btnRetour_Click` | 84-88 | Public | 1 | 3 | 0 | handler GUI |
| `Btn_Click` | 90-102 | Public | 3 | 10 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre, lit chaque clé
  `/Coul/...` (défaut `"&HF9F9BD&"`), l'affiche dans le libellé `…2` et en fond du contrôle
  (`Val(chaîne)` → couleur).
- **`Coul_Dblclick()`** [portée : nécessaire (handler du groupe `Coul`)] [nature : GUI]. Affiche
  `Pcol`, initialise `dlgColor.SelectedColor` selon `Last.Tag`, mémorise l'indice dans `B`.
- **`btnOK_Click()`** [handler] [GUI]. Calcule `Value = "&H" & Hex$(couleur, 6) & "&"`, cache
  `Pcol`, met à jour le libellé et le fond du contrôle d'indice `B` (sans enregistrer).
- **`btnRetour_Click()`** [handler] [GUI]. Cache `Pcol`.
- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : mixte]. `Tag` 1 :
  écrit les libellés dans `Start.LocalSettings` puis ferme ; `Tag` 2 : ferme.

## État global utilisé

- `Start.LocalSettings` : `/Coul/Facts`, `/Coul/Avs` (lues ailleurs par `Start.module:127` et les écrans d'archives).
- Membres non préfixés `sColor` (affecté, jamais lu), `Value`, `B` et une chaîne par couleur.

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet si la fenêtre est supprimée (voir rework).

### Commonalisation avec d'autres fichiers

- 21 lignes normalisées communes entre chaque paire `Cprod`/`Cmo`/`Carch` (53 % de `Cmo` et
  de `Carch`). Si une fenêtre est conservée, la logique « clé de réglage dans le `Tag` du contrôle »
  de `SetColors` est le modèle à suivre (une seule fonction pour N couleurs).

### Réduction de portée

- `Coul_Dblclick` et `Btn_Click` sont signalés « réductibles » par deps.py : **faux positif**, ce
  sont des handlers de groupes d'événements déclarés dans le `.form` (intouchables).

### Séparation traitement / GUI

- Sans objet (réglages d'affichage).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
