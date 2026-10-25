# rechtour — Architecture

> Source : `.src/Gestion/option/rechtour.class`

## Vue d'ensemble

Petite fenêtre modale de **recherche d'une tournée** : une `GridView` (`GridView1`, colonnes
« N° » et « Tournée ») alimentée par `SELECT * FROM Fiches_tourne`, et un bouton de fermeture.
La sélection est renvoyée à l'appelant par l'événement **`trouve(cle As String)`** :
- double-clic / Entrée sur une ligne (`GridView1_Activate`) → `trouve(code)` puis fermeture ;
- touche Suppr (`GridView1_KeyPress`) → `trouve(" ")` (une **espace**, convention d'effacement)
  puis fermeture ;
- Échap ou `Button1` → fermeture sans événement.

Appelants (vérifiés par `grep`) : quatre ouvertures modales, chacune avec son propre nom
d'événement :

| Appelant | Ligne | Nom d'événement | Handler |
|---|---|---|---|
| [Facture](../../Facturation/Facture.class/architecture.md) `Butto1_Click` | `Facture.class:12197` | `to1` | `to1_trouve` (`Facture.class:12202`) |
| [Facturefm](../../Facturation/Facturefm.class/architecture.md) `Buttour_Click` | `Facturefm.class:750` | `tourne` | `tourne_trouve` (`Facturefm.class:755`) |
| [FClient](../../Tables/FClient.class/architecture.md) (2 boutons) | `FClient.class:3299`, `:3347` | `Butto1`, `Butto2` | `butto1_trouve`, `butto2_trouve` (`FClient.class:3304`, `:3352`) |

Nature : **GUI** avec une requête dans le constructeur.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$res` | var | Private |  | Result | 3 |
| `trouve` | event | Public |  |  | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-22 | Public | 2 | 13 | 0 | méthode spéciale |
| `GridView1_Data` | 24-36 | Public | 3 | 11 | 0 | handler GUI |
| `GridView1_Activate` | 38-43 | Public | 1 | 4 | 0 | handler GUI |
| `GridView1_KeyPress` | 45-53 | Public | 3 | 7 | 0 | handler GUI |
| `Button1_Click` | 54-58 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] : configure les deux colonnes
  (largeurs 150/280, centrées), mode de sélection simple, puis
  `$res = Utils.db.Exec("SELECT * FROM Fiches_tourne")` (**sans `ORDER BY`**, alors que
  [Ttourne](../Ttourne.class/architecture.md) trie par `code`) et fixe `Rows.Count`. Table nommée
  en dur : il n'existe pas de clé `Cbase` pour `Fiches_tourne`. Partie extractible : la requête.
- **`GridView1_Data(Row, Column)`** [handler] [nature : GUI] : affichage paresseux
  (`$res.MoveTo(row)` puis `code`/`tourne`), alignement forcé à gauche (l'alignement centré du
  constructeur n'a donc pas d'effet sur les cellules). Variable locale `res` déclarée et inutilisée.
- **`GridView1_Activate()`** [handler] [nature : GUI] : `Raise trouve(GridView1[GridView1.Row, 0].Text)`
  puis `Me.Close`.
- **`GridView1_KeyPress()`** [handler] [nature : GUI] : Échap ferme ; Suppr lève `trouve(" ")`
  puis ferme. Les appelants doivent traiter l'espace comme « aucune tournée » (à vérifier dans
  chaque handler `*_trouve`, documentés dans leurs propres fichiers).
- **`Button1_Click()`** [handler] [nature : GUI] : ferme la fenêtre.

## État global utilisé

- `Utils.db.Exec` uniquement. **Pas d'appel à `Utils.Observers(Me)`** : la fenêtre n'est pas
  journalisée, donc les choix qui y sont faits ne sont pas rejouables (voir test.md).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la variable locale `res` inutilisée de `GridView1_Data`.
- Lecture de la liste des tournées : la même requête existe trois fois dans
  [Ttourne](../Ttourne.class/architecture.md) (avec `ORDER BY code`). Une fonction commune
  `ListeTournees() As Result` (voir commonalisation) éviterait la divergence de tri, mais
  l'ajout d'un `ORDER BY` ici change l'ordre affiché : c'est l'anomalie RECHTOUR-A01.

### Commonalisation avec d'autres fichiers

- **Liste de choix code/libellé en `GridView` + événement `trouve`** : même idiome que les autres
  fenêtres `rech*` du lot option ([rechcons](../rechcons.class/architecture.md),
  [rechtipp](../rechtipp.class/architecture.md)) ; un composant générique « liste de recherche »
  (table, colonnes, événement de retour) remplacerait ces copies. À arrêter en phase 3 après
  comparaison des trois fichiers.
- Accès à `Fiches_tourne` partagé avec [Ttourne](../Ttourne.class/architecture.md) : ajout d'une
  clé `Cbase.Table("TabTourne")` (SQL identique) utilisable par les deux fichiers.

### Réduction de portée

Rien à réduire : toutes les méthodes sont des handlers ou le constructeur (doivent rester `Public`).

### Séparation traitement / GUI

La seule requête est dans `_new` ; l'extraire dans `ListeTournees()` (voir ci-dessus) suffit.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce fichier (`Fiches_tourne` : `code` char(15) clé primaire, `tourne` char(50)).
