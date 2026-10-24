# Cdoc — Architecture

> Source : `.src/Utils/Cdoc.class` · Formulaire : `.src/Utils/Cdoc.form`

## Vue d'ensemble

`Cdoc` est un **ancien écran de paramétrage des couleurs des documents** (en-tête : Jacky
Tripoteau, 29/11/2007). Il affiche cinq pastilles (`Prf` proforma, `Cmd` commande, `Dv` devis,
`Bl` bon de livraison, `Fct` facture) avec leur code couleur, permet de les modifier par un
`ColorChooser` (panneau `Pcol`) et enregistre les valeurs dans `Laurux.conf`
(`/Coul/Prf`, `/Coul/Cmde`, `/Coul/Devis`, `/Coul/Bl`, `/Coul/Fac`).

⚠️ **Aucun fichier du projet n'ouvre `Cdoc`** (vérifié par `grep -rni "cdoc"` sur `.src`, formulaires
compris) : l'écran est inaccessible. Ses fonctions sont reprises par `SetColors` (mêmes clés, sauf
la facture pour laquelle `SetColors`, `Start`, `TriFac`, `TriFac2`, `Carch` et `Archives` utilisent
`/Coul/Facts` et non `/Coul/Fac`).

Nature globale : **GUI**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `sColor` | var | Private |  | String | 28 |
| `Value` | var | Private |  | String | 29 |
| `Proform` | var | Private |  | String | 30 |
| `Commande` | var | Private |  | String | 31 |
| `Devis` | var | Private |  | String | 32 |
| `Bon` | var | Private |  | String | 33 |
| `Facture` | var | Private |  | String | 34 |
| `B` | var | Private |  | Integer | 35 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 40-68 | Public | 6 | 23 | 0 | méthode spéciale |
| `Coul_Dblclick` | 70-96 | Public | 6 | 25 | 0 | handler GUI |
| `Coul_Mousedown` | 98-110 | Public | 4 | 9 | 0 | handler GUI |
| `btnOK_Click` | 112-135 | Public | 6 | 22 | 0 | handler GUI |
| `btnRetour_Click` | 137-141 | Public | 1 | 3 | 0 | handler GUI |
| `Btn_Click` | 143-157 | Public | 3 | 13 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Centre la fenêtre et, pour
  chacune des cinq clés, lit la valeur (défaut `&HF9F9BD&`), l'affiche dans le libellé `*2` et
  colore la pastille (`Val(couleur)`). Cinq blocs identiques.
- **`Coul_Dblclick()`** [portée : nécessaire, handler du groupe `Coul`] [nature : GUI]. Affiche le
  panneau de choix, initialise le `ColorChooser` avec la couleur de la pastille cliquée
  (`Last.Tag` 1 à 5) et mémorise l'indice dans `B`.
- **`Coul_Mousedown()`** [portée : nécessaire, handler du groupe `Coul`] [nature : GUI]. Clic
  droit sur la pastille proforma seulement (`Tag = 1`) : choix d'une police appliquée à `Prf`
  (jamais enregistrée).
- **`btnOK_Click()`** [nature : GUI] : convertit la couleur choisie en `&HRRGGBB&` (`Hex$(…, 6)`)
  et met à jour le libellé et la pastille de l'indice `B`. `sColor` est affecté mais inutilisé.
- **`btnRetour_Click()`** [nature : GUI] : masque le panneau.
- **`Btn_Click()`** [portée : nécessaire, handler du groupe `Btn`] [nature : GUI]. `Tag = 1` :
  enregistre les cinq clés et ferme ; `Tag = 2` : ferme sans enregistrer.

## État global utilisé

- `Start.LocalSettings["/Coul/Prf" | "/Coul/Cmde" | "/Coul/Devis" | "/Coul/Bl" | "/Coul/Fac"]`
  (lecture et écriture).

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet tant que l'écran est inaccessible : aucun rework de code n'est proposé au-delà de la
  documentation (effort sans bénéfice).

### Commonalisation avec d'autres fichiers

- Doublon fonctionnel de `SetColors` (édition des couleurs) et, pour la lecture, de
  [`LCoul`](../LCoul.class/architecture.md), `Start.module` et `Cprod` : la décision de
  suppression de `Cdoc` relève de l'utilisateur (voir rework.md).

### Réduction de portée

- `Coul_Dblclick`, `Coul_Mousedown`, `Btn_Click` sont signalés « réductibles » par `deps.py` : ce
  sont des handlers de **groupes d'événements** (`Coul`, `Btn` dans le `.form`) : faux positif,
  portée à conserver.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
