# Glcr — Architecture

> Source : `.src/Gestion/Lcr/Glcr.class`

## Vue d'ensemble

Écran **« Impression / suppression LCR »** (menu Gestion › LCR, `Fmenu.Menuis_Click`). Il affiche
dans une `ColumnView` (`ColLcr`) les LCR de `Fiches_Lcr` filtrées selon trois critères :

- écartées : toutes (`T1`) / écartées (`E1`) / non écartées (`E2`) ;
- attribution : toutes (`T2`) / attribuées (`A1`, avec banque `BQ` et code entrée `Entree`) /
  non attribuées (`A2`) ;
- échéance : case `cd1` qui affiche le panneau des dates `Ech1`/`Ech2`.

Deux actions : **imprimer** la liste affichée (PDF `~/Lcr.pdf` via [`CLcr`](../CLcr.class/architecture.md))
et **supprimer** toutes les LCR affichées.

Les sept boutons radio forment le groupe `Btn` : seul `btn_click` est levé. L'écran appelle
`Utils.Observers(Me)` (rejouable) ; la grille `ColLcr` n'a pas de handler `ColLcr_Click`
(`replay_missing`).

Nature : écran **mixte** ; toute la sélection SQL est dans `Deb` (CC 39, maximum du lot LCR).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Dte1` | var | Private |  | Integer | 3 |
| `rBq` | var | Private |  | Result | 4 |
| `Tri` | var | Private |  | String | 5 |
| `CoulB` | var | Private |  | Integer | 6 |
| `CoulF` | var | Private |  | Integer | 7 |
| `Fnt` | var | Private |  | String | 8 |
| `CoulZns` | var | Private |  | Integer | 9 |
| `CoulZnaf` | var | Private |  | Integer | 10 |
| `Coulfc` | var | Private |  | Integer | 11 |
| `Coulfond` | var | Private |  | New String[] | 12 |
| `PosY` | var | Private |  | Integer | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 15-36 | Public | 2 | 19 | 0 | méthode spéciale |
| `Form_Open` | 38-76 | Public | 6 | 37 | 0 | handler GUI |
| `Deb` | 81-153 | Public | 39 | 68 | 0 | portée réductible ? |
| `btn_click` | 155-176 | Public | 5 | 20 | 0 | handler GUI |
| `CheckBox1_Click` | 178-186 | Public | 2 | 7 | 0 | portée réductible ? |
| `A1_Click` | 188-195 | Public | 2 | 6 | 0 | portée réductible ? |
| `A2_Click` | 197-204 | Public | 2 | 6 | 0 | portée réductible ? |
| `T2_Click` | 206-213 | Public | 2 | 6 | 0 | portée réductible ? |
| `cd1_Click` | 215-219 | Public | 1 | 3 | 0 | handler GUI |
| `Button9_Click` | 221-281 | Public | 14 | 56 | 0 | handler GUI |
| `Level2` | 284-305 | Public | 1 | 20 | 0 | portée réductible ? |
| `Level3` | 308-321 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level4` | 324-336 | Public | 1 | 11 | 0 | portée réductible ? |
| `BQ_Change` | 338-342 | Public | 1 | 3 | 0 | handler GUI |
| `Entree_Change` | 344-348 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 353-372 | Public | 4 | 17 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI] : couleurs du thème (`/Coul/Znaff`,
  `/Coul/Znss`, `/Coul/Focus`, `/Coul/Fnets`), `Utils.Observers(Me)`, fond de fenêtre selon
  `/Soc<XX>/Coul_fen`, musique, type date de `Ech1`/`Ech2`, `Chainage` des deux dates, centrage.
  `CoulZns`, `CoulZnaf`, `Coulfc` sont calculés mais jamais utilisés ; `rResult` local inutilisé.
- **`Form_Open()`** [portée : nécessaire (événement)] [nature : mixte] : remplit `BQ` avec
  `SELECT * FROM " & Cbase.Table("TabBanques")` **sous `Try`** ; la clé `TabBanques` n'existe pas
  dans `Cbase` (CBASE-A01) → SQL `SELECT * FROM  ` invalide, erreur avalée, **liste des banques
  toujours vide**. Puis 9 colonnes (titres « E », « B », « C » = écartée, banque, code entrée) et
  `Deb()`.

### Sélection (`Deb`, CC 39)

- **`Deb()`** [portée : réductible] [nature : mixte, la construction de la requête est extractible].
  Arbre de `If` imbriqués sur `t1`, `t2`, `a1`, `a2`, `cd1`, `E1`, puis remplissage de `ColLcr`
  (`Add(lind, lind)` puis `Item[0..9]`). Tables : `Fiches_Lcr` (nom en dur). Défauts relevés :
  - toutes les requêtes filtrent `bordereau <> 1` : la colonne contient le **numéro** de bordereau
    (attribué par `Preparation`), donc seules les LCR du bordereau n° 1 sont exclues (héritage
    probable d'un ancien drapeau 0/1, à confirmer) ;
  - `andand` (l. 101, 121, 125) : SQL invalide → `Catch` → `Message.Error` ;
  - l. 111, 120, 121 : `",1")` est **dans** la chaîne SQL ; `&1` n'est pas substitué → SQL invalide ;
  - dates d'échéance concaténées sans guillemets (`datech >= 2026-10-25`, format `LDate.D`) :
    MySQL évalue une soustraction, le filtre par échéance ne fonctionne pas ;
  - l. 116 `If t2.value Not cd1.value` : Gambas l'évalue comme `Not cd1.value` (vérifié avec
    `gbc3`/`gbx3` sur un projet jetable) ; dans cette branche `cd1` est vrai → branche
    inatteignable ;
  - `ColLcr.Item[9]` est écrit alors que la vue n'a que 9 colonnes (0 à 8) : comportement de
    `ColumnView` à confirmer en phase 2 (la suppression `Button2_Click` relit `Item[9]`) ;
  - le cas « attribuées + toutes écartées + sans échéance » ne remplit pas la liste si `A1` est
    coché avant le choix d'une banque (`btn_click` n'appelle pas `Deb`).

### Événements de filtre

- **`btn_click()`** [portée : nécessaire (événement du groupe `Btn`)] [nature : GUI] : affiche ou
  masque `BQ`/`HBox4` selon `A1`/`A2`/`T2`, force `E2` quand `A1` est choisi, puis `Deb()` sauf si
  `A1` (on attend `BQ_Change`).
- **`A1_Click`, `A2_Click`, `T2_Click`** : handlers nominaux de contrôles du groupe `Btn`, **jamais
  levés** (`handlers_inactifs`) → code mort.
- **`CheckBox1_Click()`** : aucun contrôle `CheckBox1` dans `Glcr.form` (`unused`) → code mort
  (copie de `Preparation.CheckBox1_Click`).
- **`cd1_Click()`** [événement] : affiche `Panel2` (dates) ; ne le masque jamais et ne relance pas
  `Deb`.
- **`BQ_Change()`**, **`Entree_Change()`** [événements] : `Deb()`.

### Impression

- **`Button9_Click()`** [portée : nécessaire (événement)] [nature : mixte] : titre `liste` selon les
  radios (vide si `cd1` est coché, et une combinaison peut écraser l'autre), PDF `~/Lcr.pdf` :
  `Entete`, `Level1A`, puis une ligne `Level2A` par élément de `ColLcr` (montant déjà formaté,
  adresses vides). Les arguments sont **décalés** : `Item[6]` (« * » si écartée) → écartée,
  `Item[7]` (banque) → colonne « Code acpt », `Item[8]` (code entrée) → colonne « Banque ».
  `iLcr` et `mTotal` sont calculés mais jamais imprimés. Saut de page à 268 mm. Aucun PDF n'est
  produit si la liste est vide (pas de message). `Shell "cd …"` inutile.

### Suppression

- **`Button2_Click()`** [portée : nécessaire (événement)] [nature : mixte] : après confirmation,
  `DELETE FROM Fiches_Lcr WHERE lind = Item[9]` pour chaque ligne affichée, puis `Form_Open()`
  (qui **ré-ajoute** les banques dans `BQ` sans `Clear` — sans effet tant que la liste est vide,
  A01). Aucun contrôle de l'appartenance à un bordereau : des LCR d'un bordereau non envoyé peuvent
  être supprimées (bordereau incohérent dans `Bordrx`). Liste vide : `MoveFirst` puis accès à
  `Item` → `Catch`.

### Code mort (impression `Draw` de l'ancienne version)

- **`Level2()`**, **`Level3(...)`**, **`Level4(...)`** : impression `Draw` (gb.qt) sans appelant,
  remplacée par `CLcr`.

### Boutons sans handler

- `Button1` (« Doc HTML ») et `Button4` (« Quitter ») n'ont **aucun** handler dans la classe : les
  deux boutons sont inopérants (la fenêtre se ferme seulement par le gestionnaire de fenêtres).

## État global utilisé

- `Start.LocalSettings` : `/Coul/*`, `/Soc<XX>/Coul_fen` ; `Start.Societe`, `Start.Musique`.
- `Utils.db`, `Utils.convBool`, `Utils.Cdate_Aff`, `Utils.cpoint`, `Utils.FColr`,
  `Utils.Observers`, `Cbase.Table("TabBanques")` (clé absente).
- `Visualiseur.Prog` (affichage du PDF), `Music`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb` : remplacer l'arbre de `If` par la construction d'une clause `WHERE` à partir de fragments
  (écartée, attribution, banque, code entrée, échéance) — **après** décision sur les anomalies
  A02-A04, sinon il faudrait reproduire à l'identique des SQL invalides.
- Utiliser `ColLcr.Item.Key` (clé = `lind`) à la place de la colonne `Item[9]` hors bornes, en lecture
  et en suppression (comportement identique si `Item[9]` fonctionne, à confirmer en phase 2).

### Commonalisation avec d'autres fichiers

- Remplissage d'une `ComboBox` avec « code - nom » des banques : même code dans
  [`Attribution.Form_Open`](../Attribution.class/architecture.md),
  [`Preparation.Form_Open`](../Preparation.class/architecture.md) → fonction partagée (par ex.
  `Banque.Liste(combo)` statique ou module LCR commun créé en phase 3).
- Initialisation des couleurs (`Utils.FColr` × 4 + `Coul_fen`) : identique dans les 5 écrans LCR et
  de nombreux écrans du projet (voir les commonalisations « Couleurs /Coul/* » des lots
  précédents).
- Impression d'une liste de LCR en PDF : même boucle dans `Attribution.Imp_Lcr`,
  `Preparation.Imp_Lcr`, `Lcr.Imp_Lcr` (source différente : `ColLcr` ici, `Fiches_Lcr` ailleurs).

### Réduction de portée

- `Deb` → `Private` (aucun appelant externe ; couvert par les replays de filtres).
- Les handlers d'événements restent `Public`.

### Séparation traitement / GUI

- Extraire `RequeteLcr(ecartees, attribution, banque, entree, ech1, ech2) As Result` de `Deb`
  (sans accès aux contrôles), `Deb` gardant le remplissage de la grille.
- Extraire la suppression `SupprimeLcr(linds As String[])` de `Button2_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Lcr.bordereau` (`varchar(35)`) et `banque` (`varchar(35)`) contiennent des entiers : les
  typer en `INT` avec index rendrait les filtres `bordereau = 0` / `banque = n` fiables.
- Clé étrangère `Fiches_Lcr.bordereau` → `Fiches_Bordereaux.bordereau` (suppression contrôlée).
