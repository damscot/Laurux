# rechtipp — Architecture

> Source : `.src/Gestion/option/rechtipp.class` · Formulaire : `rechtipp.form`

## Vue d'ensemble

`rechtipp` est la **fenêtre de choix d'une région TICPE/TIPP** (option fioul/carburants, table
`Fiches_region` créée par `modfichier.fichiercarbu`, absente de `db_control.csv`). La TICPE
régionale est modulée par région : `Fiches_region` contient pour chaque région (`code`) un taux
général (`cart = '0'`) et, éventuellement, des taux par article (`cart` = code article).

- mode `"N"` : liste des régions générales (`cart = '0'`), colonnes « N° Reg. », « Région » ;
- mode `"T"` : liste des lignes par article (`cart <> '0'`), avec code et désignation de l'article.

La ligne activée lève `trouve(code région)`. Appelants : `FClient` (`Buttr1`, `Buttr2`, code TIPP
du client `cli_tipp` et de l'adresse de livraison) et `Facture` (`Buttr1_Click`, code TIPP de la
ligne, `tipp_ligbl`). Ces colonnes (`cli_tipp`, `tipp_ligbl`, `Fiches_AdrlivC.tipp`) sont ajoutées
à l'exécution par `modfichier.fichiercarbu` et **absentes de `db_control.csv`**. Le mode `"T"`
n'est utilisé par aucun appelant (tous passent `"N"`).

Nature globale : **GUI + SQL** (lecture seule).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$schoix` | var | Private |  | String | 3 |
| `$res` | var | Private |  | Result | 4 |
| `trouve` | event | Public |  |  | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-38 | Public | 4 | 28 | 0 | méthode spéciale |
| `GridView1_Data` | 40-57 | Public | 5 | 15 | 0 | handler GUI |
| `GridView1_KeyPress` | 59-65 | Public | 2 | 5 | 0 | handler GUI |
| `GridView1_Activate` | 67-72 | Public | 1 | 4 | 0 | handler GUI |
| `Button1_Click` | 74-78 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(choix)`** [portée : nécessaire] [nature : mixte]. Colonnes selon le mode ; `SELECT * FROM
  Fiches_region WHERE cart <> '0'` (`T`) ou `WHERE cart = '0'` (autre) ; `Rows.Count` si résultat.
- **`GridView1_Data(Row, Column)`** [handler] [nature : mixte]. Code, libellé, article ; colonne 3 :
  `SELECT * FROM Fiches_Art WHERE art_code = &1` **à chaque cellule affichée**, sans test
  `Available` (article supprimé → erreur, mode `T` seulement). Écrit dans `GridView1[row,
  col].Text` au lieu de `GridView1.Data.Text` (fonctionne, mais style différent de `rechcons`).
- **`GridView1_KeyPress()`** [handler] [nature : GUI]. Échap → `Button1_Click`.
- **`GridView1_Activate()`** [handler] [nature : GUI]. `Raise trouve(code)`, `Me.Close`.
- **`Button1_Click()`** [handler] : `Me.Close`.

## État global utilisé

- `Utils.db.Exec`. Tables `Fiches_region`, `Fiches_Art`.
- **Pas d'`Utils.Observers(Me)`** : non journalisée.

## Propositions d'amélioration

### Réécriture / refactorisation

- Mode `"T"` : jointure `Fiches_region LEFT JOIN Fiches_Art` dans `_new` au lieu d'une requête par
  cellule (SQL modifié, aucune écriture : résultat affiché identique, à prouver par T02).

### Commonalisation avec d'autres fichiers

- Même modèle que [`rechcons`](../rechcons.class/architecture.md) et `rechtour` (liste + événement).

### Réduction de portée

Aucune (handlers et `_new`).

### Séparation traitement / GUI

Lecture de la désignation d'article dans une fonction privée.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Séparer les taux généraux par région et les taux par article (aujourd'hui `cart = '0'`
  sentinelle dans la clé primaire `(code, cart)`).
- Intégrer `Fiches_region` et les colonnes `cli_tipp`, `tipp_ligbl`, `tipp_ligfac` dans
  `db_control.csv`.
