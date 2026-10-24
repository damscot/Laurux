# Calcstock — Architecture

> Source : `.src/Utils/Calcstock.class`

## Vue d'ensemble

`Calcstock` est l'**écran de recalcul des stocks** (menu Gestion, `Fmenu.class:1642`,
`Calcstock.ShowModal`). Quatre boutons radio publics (`#Public = True` dans le `.form`) choisissent
le traitement :

| Bouton | Libellé | Action |
|---|---|---|
| `Cbx` (coché par défaut) | Pour un produit | `Cstock.Calc_stock(TextBox1, "")` |
| `Cbx2` | Pour des casiers | `Cstock.Calc_stock(TextBox2, TextBox3)` (bornes de casiers) |
| `Cbx3` | Pour tous les produits | `Cstock.Calc_stock("", "")` |
| `Cbx4` | Remise à zéro des produits non stockés | `UPDATE art_qte = 0 WHERE art_stocke = 0` |

Avant tout traitement, trois **pré-conditions** sont vérifiées : aucune caisse connectée
(`Fiches_Caisses.connecte`), aucun ticket en attente de Z (`Fiches_EntTickets1..9` vides), moulinage
fait (`Fiches_EntTicketz` vide).

Le calcul est délégué au module [`Cstock`](../Cstock.module/architecture.md), qui relit lui-même
`Calcstock.Cbx` et `Calcstock.Cbx2` (couplage circulaire).

Nature : **mixte** (pré-conditions SQL et remise à zéro dans le handler).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 27 |
| `Bval` | var | Public |  | String | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-39 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button3_Click` | 41-45 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 50-111 | Public | 15 | 56 | 0 | handler GUI |
| `Cbx_Click` | 113-130 | Public | 2 | 12 | 0 | handler GUI |
| `Cbx2_Click` | 132-148 | Public | 2 | 12 | 0 | handler GUI |
| `Cbx3_Click` | 150-162 | Public | 2 | 11 | 0 | handler GUI |
| `Button4_Click` | 164-168 | Public | 1 | 3 | 0 | handler GUI |
| `SelectionArt` | 173-183 | Public | 2 | 8 | 0 | portée réductible ? |
| `Art_man` | 188-211 | Public | 5 | 21 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Music.Load`, centrage,
  `Utils.Observers`. Également exécuté quand `Cstock` est appelé depuis `Validinv` (instance
  automatique cachée créée par l'accès à `Calcstock.Cbx`).
- **`Button3_Click()`** [handler] : fermeture.
- **`Button2_Click()`** (CC 15, max du fichier) [portée : nécessaire, handler] [nature : mixte].
  1. `SELECT * FROM Fiches_Caisses` : si une caisse a `connecte = "1"`, message et arrêt. Le message
     concatène le code sans espace (« …numéro 1est connectée »).
  2. Pour `i = 1..9`, si `Fiches_EntTickets<i>` existe (`Utils.db.Tables.Exist`) et contient une
     ligne : « le ticket Z n'est pas tiré ».
  3. `Fiches_EntTicketz` non vide : « le moulinage n'est pas fait ».
  4. Selon le bouton coché, appel de `Cstock.Calc_stock` ou remise à zéro (`LOCK`/`UPDATE`/`UNLOCK`
     sur `Cbase.Table("TabArt")`, paramètres `"0"`, `"0"`).
  5. Son, curseur `Mouse.Pointing` (au lieu de `Mouse.Default`), « Traitement terminé », vidage de
     `TextBox1`.
  ⚠️ Le message « Traitement terminé » s'affiche aussi quand les bornes de casiers manquent (après
  le message « saisir les deux bornes ») et quand l'article saisi est vide (aucun article recalculé).
  Tables en dur (`Fiches_Caisses`, `Fiches_EntTickets*`, `Fiches_EntTicketz`).
- **`Cbx_Click()`, `Cbx2_Click()`, `Cbx3_Click()`** [portée : nécessaire, handlers des boutons radio]
  [nature : GUI]. Affichent/masquent les zones de saisie. Pas de `Cbx4_Click` : passer de `Cbx`/`Cbx2`
  à `Cbx4` laisse les zones affichées.
- **`Button4_Click()`** [handler] → `SelectionArt`.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. `TriArticles(True, True, "art_code", "",
  "Fournisseur", Null, False, False, Me)` ; retour par `Bsel`/`Bval` (écrits via
  `Object.SetProperty`).
- **`Art_man()`** [portée : réductible] [nature : mixte] — **code mort** : jamais appelée (aucun
  handler `TextBox1_*`, aucun appel, grep). Vérifiait l'existence de l'article saisi.

## État global utilisé

- `Start.Musique`, `Start.son`, `Utils.db` (`Exec`, `Tables.Exist`), `Utils.Observers`,
  `Cbase.Table("TabArt")`.
- Les contrôles `Cbx`..`Cbx4` sont publics et lus par `Cstock` (et donc indirectement par
  `Validinv`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire les pré-conditions dans une fonction `ControleCaisses() As String` (message d'erreur ou
  vide) sans contrôle GUI, réutilisable par d'autres traitements de stock.
- Passer à `Cstock.Calc_stock` un paramètre de mode (voir CSTOCK-003) au lieu de laisser le module
  relire les boutons.

### Commonalisation avec d'autres fichiers

- Les pré-conditions « caisse connectée / ticket Z / moulinage » sont à rechercher dans les autres
  traitements de stock et de clôture (`Validinv`, `Moulinage`, `FCloture`) : candidat à une fonction
  commune (phase 3, à confirmer par grep de `connecte`).
- `Art_man`/`SelectionArt` : même idiome que `Changefam`/`Changefour` (lecture d'article et appel de
  `TriArticles`).

### Réduction de portée

- `SelectionArt` → `Private` ; `Art_man` → suppression.
- **À conserver** : `Bsel`/`Bval` (écrits par `TriArticles` via `Object.SetProperty`) ; `Cbx*_Click`
  (handlers, faux positifs de `deps.py`).

### Séparation traitement / GUI

- `ControleCaisses()` et `RazNonStockes()` (le `LOCK`/`UPDATE`/`UNLOCK` du cas `Cbx4`) sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les tables `Fiches_EntTickets1..9` (une par caisse) testées une à une : une table unique avec une
  colonne caisse simplifierait le contrôle (une requête).
