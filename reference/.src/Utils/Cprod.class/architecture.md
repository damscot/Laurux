# Cprod — Architecture

> Source : `.src/Utils/Cprod.class` · Form : `Cprod.form`

## Vue d'ensemble

Fenêtre de **réglage des couleurs des produits** : stocké (`/Coul/Stk`), non stocké
(`/Coul/Nstk`), épuisé (`/Coul/Eps`), suspendu (`/Coul/Spd`).

Ces trois fenêtres ([`Cprod`](../Cprod.class/architecture.md), [`Cmo`](../Cmo.class/architecture.md),
[`Carch`](../Carch.class/architecture.md)) sont des copies d'un même modèle : un `TextBox`/`TextLabel`
coloré et un libellé `&HRRGGBB&` par couleur, un double-clic (groupe d'événements `Coul`) qui ouvre
un panneau `Pcol` contenant un `ColorChooser` (`dlgColor`), puis deux boutons (groupe `Btn`,
`Tag` 1 = valider et enregistrer dans `Start.LocalSettings`, `Tag` 2 = fermer). Elles sont
**remplacées** par [`SetColors`](../SetColors.class/architecture.md) (`Fmenu.class:1527`), dont le
`.form` gère les mêmes clés `/Coul/...` par la propriété `Tag` des contrôles.

**Code mort** : aucun appelant (`grep -rniw cprod .src` → ce fichier seulement).

Nature globale : **GUI** (réglages locaux, aucun accès base).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `sColor` | var | Private |  | String | 28 |
| `Value` | var | Private |  | String | 29 |
| `Stocke` | var | Private |  | String | 30 |
| `Nstocke` | var | Private |  | String | 31 |
| `Epuise` | var | Private |  | String | 32 |
| `Suspendu` | var | Private |  | String | 33 |
| `B` | var | Private |  | Integer | 34 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 39-63 | Public | 5 | 20 | 0 | méthode spéciale |
| `Coul_Dblclick` | 65-91 | Public | 6 | 25 | 0 | handler GUI |
| `btnOK_Click` | 93-114 | Public | 5 | 19 | 0 | handler GUI |
| `btnRetour_Click` | 116-120 | Public | 1 | 3 | 0 | handler GUI |
| `Btn_Click` | 122-136 | Public | 3 | 12 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre, lit chaque clé
  `/Coul/...` (défaut `"&HF9F9BD&"`), l'affiche dans le libellé `…2` et en fond du contrôle
  (`Val(chaîne)` → couleur). Charge aussi la musique (`Music.Load`), jamais jouée.
- **`Coul_Dblclick()`** [portée : nécessaire (handler du groupe `Coul`)] [nature : GUI]. Affiche
  `Pcol`, initialise `dlgColor.SelectedColor` selon `Last.Tag`, mémorise l'indice dans `B`.
  ⚠️ `Case 5` (l.85-88) : `Val(Facture)` utilise le **nom de la classe** `Facture` (aucune variable de ce
  nom ici) ; aucun contrôle n'a `Tag = 5` dans `Cprod.form`, la branche est inatteignable.
- **`btnOK_Click()`** [handler] [GUI]. Calcule `Value = "&H" & Hex$(couleur, 6) & "&"`, cache
  `Pcol`, met à jour le libellé et le fond du contrôle d'indice `B` (sans enregistrer).
- **`btnRetour_Click()`** [handler] [GUI]. Cache `Pcol`.
- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : mixte]. `Tag` 1 :
  écrit les libellés dans `Start.LocalSettings` puis ferme ; `Tag` 2 : ferme.

## État global utilisé

- `Start.LocalSettings` : `/Coul/Stk`, `/Coul/Nstk`, `/Coul/Eps`, `/Coul/Spd` (lues ailleurs par `Start.module:127-131` et `LCoul`), `Start.Musique`.
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
