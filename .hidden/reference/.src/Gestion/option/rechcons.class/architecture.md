# rechcons — Architecture

> Source : `.src/Gestion/option/rechcons.class` · Formulaire : `rechcons.form`

## Vue d'ensemble

`rechcons` est la **fenêtre de recherche d'un code de consigne** (`Fiches_consigne`) : grille
`GridView1` (code, nom, contenant, prix) filtrable par code (`Textcode`) ou libellé (`Texlib`) ;
la ligne activée lève l'événement `trouver(code)` puis ferme la fenêtre. Le paramètre `choix`
limite la liste à un type (`P` palette, `C` caisse, `B` bouteille) ou affiche tout (`"T"`).

Appelants : [`Tconsigne`](../Tconsigne.class/architecture.md) (`bar1_recherche`, mode `"T"`) et
`facopt` (`facopt.class:362-365`, événement `rechcons_trouver`).

Nature globale : **GUI + SQL** (lecture seule).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `trouver` | event | Public |  |  | 3 |
| `$rescons` | var | Private |  | Result | 5 |
| `$schoix` | var | Private |  | String | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-31 | Public | 3 | 23 | 0 | méthode spéciale |
| `GridView1_Data` | 33-55 | Public | 8 | 21 | 0 | handler GUI |
| `GridView1_Activate` | 57-62 | Public | 1 | 4 | 0 | handler GUI |
| `Textcode_Change` | 64-73 | Public | 2 | 8 | 0 | handler GUI |
| `Texlib_Change` | 75-84 | Public | 2 | 8 | 0 | handler GUI |
| `rechcons_KeyPress` | 86-90 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_Click` | 92-96 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(choix)`** [portée : nécessaire] [nature : mixte]. Mémorise `$schoix` (et `Me.Tag`),
  colonnes de la grille, puis `SELECT * FROM Fiches_consigne` (mode `"T"`) ou `… WHERE type = &1`.
  Le bloc `If $rescons.Available Then … Endif` du mode `"T"` est vide. Fixe `Rows.Count`.
- **`GridView1_Data(Row, Column)`** [handler] [nature : GUI]. `MoveTo(Row)` ; libellé du type
  (`P` Palette, `C` Caisse, `B` Bouteille ; rien pour un autre type) ; prix `"0.00"` aligné à droite.
- **`GridView1_Activate()`** [handler] [nature : GUI]. `Raise trouver(code)`, `Me.Close`.
- **`Textcode_Change()`**, **`Texlib_Change()`** [handlers] [nature : mixte]. Requête `LIKE
  '%texte%'` sur le code ou le libellé (et le type si `choix <> "T"`) à chaque frappe ;
  rafraîchit `Rows.Count`. Les deux filtres ne se cumulent pas (le dernier modifié l'emporte).
- **`rechcons_KeyPress()`** [nature : GUI] — **jamais levé** (`unused` confirmé) : le formulaire
  lève ses événements sous le nom `Form`, pas `rechcons` ; s'il l'était, toute touche fermerait la
  fenêtre. Code mort.
- **`Button1_Click()`** [handler] : `Me.Close`.

## État global utilisé

- `Utils.db.Exec`. Table `Fiches_consigne` (créée par `modfichier.fichierboisson`, absente de
  `db_control.csv`).
- **Pas d'`Utils.Observers(Me)`** : la fenêtre n'est pas journalisée ni rejouable.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Textcode_Change`/`Texlib_Change` et `_new` : une fonction privée `Filtrer(colonne, texte)`
  construisant les 6 variantes de requête (SQL identique).

### Commonalisation avec d'autres fichiers

- Fenêtre « liste filtrable + événement de sélection » : même modèle que
  [`rechtipp`](../rechtipp.class/architecture.md), `rechtour` et la grille filtrable relevée dans
  les notes transverses (~30 écrans).

### Réduction de portée

`rechcons_KeyPress` est signalé réductible et inutilisé : suppression (code mort) plutôt que
réduction.

### Séparation traitement / GUI

`Filtrer` renvoie le `Result` sans toucher à la grille.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_consigne(type)` (table petite : gain négligeable).
