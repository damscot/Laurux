# Ttarfioul — Architecture

> Source : `.src/Gestion/option/Ttarfioul.class` · Formulaire : `Ttarfioul.form`

## Vue d'ensemble

`Ttarfioul` est l'écran des **tarifs dégressifs du fioul/GNR pour les particuliers** (option
carburants, `pp`) : pour un article, une marge de zone (`Fiches_tarpp.margez`), un supplément
« petites quantités » (`supqs`) et un barème par tranches de quantité (`Fiches_ligtarpp` : bornes
`binf`/`bsup`, marge HT de tranche `marht`, prix calculés `normht` et `supht`). Tables créées par
`modfichier.fichiercarbu` et **absentes de `db_control.csv`**.

Ouvert par `menuopt` (`Tfioul_click`, auto-instance `.Show`, choix de l'article par `Textcode` ou
`TriArticles`) et par `artopt.Buttontar_Click` (`New Ttarfioul(win, $numart)` : `win` devient le
`Parent` de la `Form`, `$numart` le paramètre optionnel `num` ; code verrouillé).

Règle métier telle que le code l'applique :

- `TableView1` (saisie) : tranches (borne inf., borne sup., marge HT, marge TTC) ; saisir la marge
  HT recalcule la TTC (× (1 + TVA)) et inversement ; une ligne est ajoutée quand on clique la
  dernière cellule ;
- `Button2_Click` (« calcul ») remplit `TableView2` : pour chaque tranche, **prix normal HT =
  marge de tranche + prix de revient article (`Textrev`, `art_prvt`) + marge de zone**, **prix
  « sup » HT = normal + supplément** ; TTC = HT × (1 + TVA de l'article) ;
- bornes affichées en litres : stockées divisées par 1 000 si l'unité de l'article est `M3` ou
  `Tonne` (`$icoef`) ;
- `Button3_Click` (« enregistrer ») : supprime puis réécrit `Fiches_tarpp` et `Fiches_ligtarpp`
  dans une transaction, à partir de `TableView2` (bornes relues dans le libellé `binf-bsup`) et
  des marges de `TableView1`.

Nature globale : **GUI + calcul + SQL**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 3 |
| `Bval` | var | Public |  | String | 4 |
| `$iCoulFoc` | var | Private |  | Integer | 6 |
| `$iCoulZns` | var | Private |  | Integer | 7 |
| `$sFrmt` | var | Private |  | New String[] | 8 |
| `$tedition` | var | Private |  | TextBox | 9 |
| `$resart` | var | Private |  | Result | 11 |
| `$restva` | var | Private |  | Result | 12 |
| `$ftva` | var | Private |  | Float | 13 |
| `$icoef` | var | Private |  | Integer | 14 |
| `$sdec` | var | Private |  | String | 15 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 17-66 | Public | 2 | 42 | 0 | méthode spéciale |
| `cmpt_gotfocus` | 68-73 | Public | 3 | 4 | 0 | handler GUI |
| `cmpt_lostfocus` | 75-87 | Public | 6 | 11 | 0 | handler GUI |
| `cmpt_keypress` | 89-95 | Public | 3 | 5 | 0 | handler GUI |
| `Textcode_GotFocus` | 96-100 | Public | 2 | 3 | 0 | handler GUI |
| `Textcode_LostFocus` | 102-129 | Public | 8 | 25 | 0 | handler GUI |
| `tableview1_Click` | 131-142 | Public | 3 | 11 | 0 | handler GUI |
| `tableview1_Save` | 144-165 | Public | 4 | 19 | 0 | handler GUI |
| `tableview2_Click` | 167-176 | Public | 2 | 9 | 0 | handler GUI |
| `tableview2_Save` | 178-192 | Public | 3 | 11 | 0 | handler GUI |
| `button1_Click` | 194-207 | Public | 2 | 11 | 0 | handler GUI |
| `affiche` | 209-254 | Private | 4 | 42 | 0 |  |
| `Button2_Click` | 256-286 | Public | 8 | 28 | 0 | handler GUI |
| `Button3_Click` | 288-328 | Public | 10 | 35 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Optional num)`** [portée : nécessaire] [nature : GUI]. `Utils.Observers(Me)` ; couleurs
  lues dans **`Settings["/Coul/…"]`** (et non `Start.LocalSettings` : ignore l'option `-c`, à
  confirmer) ; observateurs `cmpt` ; colonnes des deux tables. Si `num` : code verrouillé,
  `Textcode_LostFocus()` puis `affiche` (appelé deux fois).
- **`cmpt_gotfocus`**, **`cmpt_lostfocus`**, **`cmpt_keypress`**, **`Textcode_GotFocus`**
  [handlers] [nature : GUI]. Virgule/point, contrôle numérique (ballon « Cette zone doit être
  numérique »), Entrée → zone suivante.
- **`Textcode_LostFocus()`** [handler] [nature : mixte]. `SELECT * FROM Fiches_Art WHERE art_code =
  &1` (ballon « article inconnu ») ; désignation, prix de revient ; `SELECT * FROM Fiches_Tvaav
  WHERE code_tva = &1` → `$ftva` (inchangé si TVA absente) ; `$icoef` selon `art_vol` ; `affiche`.
- **`tableview1_Click`**, **`tableview2_Click`** [handlers] [nature : GUI]. Passent la cellule en
  édition ; ⚠️ `New TextBox(TableView) As "txb"` est aussitôt remplacé par `Editor` : un `TextBox`
  orphelin est créé à chaque clic (aucun gestionnaire `txb_*`).
- **`tableview1_Save(Row, Column, Value)`** [handler] [nature : mixte]. Refuse un non-nombre ;
  bornes au format `"0"` ; marge HT ↔ TTC.
- **`tableview2_Save(...)`** [handler] [nature : mixte]. HT ↔ TTC pour les colonnes normal/sup.
- **`button1_Click()`** [handler] [nature : GUI]. `TriArticles(…, Me)` ; ⚠️ remet
  `Variables.Bsel` à `False` au lieu de `Me.Bsel` (écrit par `TriArticles`) : après une première
  sélection, une recherche annulée reprend l'ancien `Bval`.
- **`affiche()`** [privée] [nature : mixte]. `SELECT * FROM Fiches_tarpp WHERE code = &1` et
  `… Fiches_ligtarpp WHERE code = &1` (sans `ORDER BY ligne`) ; remplit les deux tables avec une
  ligne vide en plus ; sinon vide l'écran.
- **`Button2_Click()`** (CC 8) [handler] [nature : mixte, extractible : calcul des prix]. Calcul
  décrit plus haut ; ignore les lignes de `TableView1` dont la borne inf. est vide.
- **`Button3_Click()`** (CC 10) [handler] [nature : mixte]. `Begin` ; `DELETE` des deux tables ;
  `Create9` de l'en-tête ; boucle `While i < tableview2.Rows.Max` ⚠️ qui **ignore la dernière
  ligne** de `TableView2` (après « calcul », toutes les lignes sont pleines : la dernière tranche
  n'est pas enregistrée, à confirmer) ; recherche de la marge de tranche dans `TableView1` par
  comparaison des bornes (boucle `Repeat` qui lit `tableview1[0, 0]` même si la table est vide) ;
  `Commit`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Utils.ObsGotf/ObsLstf`, `Settings`,
  `Variables.Bsel` (à tort).
- Tables : `Fiches_tarpp`, `Fiches_ligtarpp` (créées par `modfichier`), `Fiches_Art`,
  `Fiches_Tvaav`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` : fonction privée `PrixTranche(marge_tranche, prv, marge_zone, sup, tva)`
  (calcul pur) ; `Button3_Click` : séparation lecture des grilles / écriture SQL.
- `Cbase.Table("TabArt")`, `Cbase.Table("TabTvav")` (SQL identique).
- Supprimer la création du `TextBox` orphelin (`$tedition` reçoit directement `Editor`) : aucun
  effet visible attendu (à confirmer en replay).

### Commonalisation avec d'autres fichiers

- Conversion HT ↔ TTC répétée 6 fois : helper commun avec les écrans de tarifs (`GesTar`,
  `TarTypeCli`).
- Édition de cellule de `TableView` par `Editor` : même idiome que `Famille`, `Articles`, `Txmo`
  (notes transverses).

### Réduction de portée

Aucune : handlers, ou `Bsel`/`Bval` écrits par `TriArticles` via `Object.SetProperty`.

### Séparation traitement / GUI

`PrixTranche` et une fonction d'enregistrement prenant des tableaux de valeurs.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_tarpp`/`Fiches_ligtarpp` dans `db_control.csv` ; contrainte `binf < bsup`.
- Ne pas stocker `normht`/`supht` (dérivés de `marht`, du prix de revient et des marges) ou
  stocker la date de calcul.
