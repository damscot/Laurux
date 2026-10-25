# EdStk — Architecture

> Source : `.src/Gestion/Impressions/EdStk.class` · Formulaire : `.src/Gestion/Impressions/EdStk.form`

## Vue d'ensemble

`EdStk` est l'écran d'**impression du stock**, chiffré ou non (menu Gestion > … > Stock,
`Fmenu.Menu102_Click` → `EdStk.Show`, auto-instance non modale). Plages article `Art`–`Art2`,
famille `Fam`–`Fam2` (`TextBox`), fournisseur `Four`–`Four2` ; type d'édition `Ch1` (chiffré,
défaut) / `Ch2` (non chiffré) ; code imprimé `Ch3` (code article, défaut), `Ch4` (code fournisseur),
`Ch5` (code-barre), `Ch6` (code équivalent) ; tri `RadioButton1..4` (code, famille, fournisseur,
désignation). **Imprimer** produit `~/tmp/rStock.pdf` avec `Carticles` (`Level1`/`Level3` chiffré,
`Level2`/`Level4` non chiffré, `Level5` totaux) puis `Visualiseur.Prog`.

Seuls les articles **stockés** (`art_stocke = 1`) sont listés. La quantité est `Fiches_Art.art_qte`
**telle quelle** : l'édition ne recalcule pas le stock. En chiffré, chaque ligne porte le total
au prix d'achat (`art_paht × art_qte`) et au PMP (`art_pmp × art_qte`), et un pied « Total Stock »
cumule les deux.

C'est une variante d'[`EdArt1`](../EdArt1.class/architecture.md) (64 % de lignes communes, 21 des 23
fonctions homonymes) : mêmes listes famille/fournisseur et même sélection d'article, sans
contrôle de saisie (`art_man` absent), avec coloration du focus par observateurs
(`Utils.ObsGotf`/`ObsLstf`) et un `Catch` global dans l'impression.

### Place dans les sources de mouvements de stock

Par rapport au tableau de [Stockmvt/architecture.md](../../Stockmvt.class/architecture.md#sources-de-mouvements-de-stock--comparaison-avec-les-autres-calculs) :
`EdStk` ne lit **aucune** source de mouvement (BL, factures, réceptions, tickets, dépôts,
inventaires). Il imprime la ligne « Stock théorique » (`art_qte`), c'est-à-dire le résultat
maintenu par `DB_Connection.Lockstock` (réceptions), `Cstock.Calc_stock` (recalcul) et `Validinv`
(inventaire). Le stock par dépôt (`Fiches_Sdepots`) n'est pas pris en compte. Toute divergence
entre ces calculs (STOCKMVT-A05) se retrouve donc telle quelle dans l'édition ; la valorisation
utilise le dernier prix d'achat `art_paht` et `art_pmp`, sans date de valorisation.

Nature globale : **GUI** ; calcul de valorisation et SQL dans `Button2_Click` (CC 27).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `Tab` | var | Private |  | String | 28 |
| `son` | var | Private |  | Integer | 29 |
| `Nbd` | var | Private |  | String | 30 |
| `Nbdec` | var | Private |  | String | 31 |
| `PosY` | var | Private |  | Integer | 32 |
| `PosX` | var | Private |  | Integer | 33 |
| `Code` | var | Private |  | String | 34 |
| `Intitule` | var | Private |  | String | 35 |
| `Fami` | var | Private |  | String | 36 |
| `Fourn` | var | Private |  | String | 37 |
| `Pbht` | var | Private |  | String | 38 |
| `Rem` | var | Private |  | String | 39 |
| `Paht` | var | Private |  | String | 40 |
| `Qte` | var | Private |  | String | 41 |
| `Totpa` | var | Private |  | String | 42 |
| `Totpmp` | var | Private |  | String | 43 |
| `Bsel` | var | Public |  | Boolean | 45 |
| `Bval` | var | Public |  | String | 46 |
| `Origine` | var | Private |  | String | 48 |
| `b` | var | Private |  | Integer | 49 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 51-66 | Public | 1 | 13 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 68-73 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 75-80 | Public | 1 | 4 | 0 | handler GUI |
| `SelectionArt` | 83-105 | Public | 4 | 20 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 110-142 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam_KeyPress` | 147-161 | Public | 5 | 13 | 0 | handler GUI |
| `ToggleButton4_Click` | 166-198 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam2_KeyPress` | 203-217 | Public | 5 | 13 | 0 | handler GUI |
| `ToggleButton5_Click` | 222-254 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour_KeyPress` | 259-273 | Public | 5 | 13 | 0 | handler GUI |
| `ToggleButton6_Click` | 278-310 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour2_KeyPress` | 315-329 | Public | 5 | 13 | 0 | handler GUI |
| `Colfam_Click` | 334-342 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 347-355 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 360-368 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 373-380 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 382-398 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 400-407 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 409-445 | Public | 10 | 29 | 0 | handler GUI |
| `Cmpt_GotFocus` | 450-455 | Public | 2 | 3 | 0 | handler GUI |
| `Cmpt_LostFocus` | 457-461 | Public | 2 | 3 | 0 | handler GUI |
| `Button2_Click` | 463-586 | Public | 27 | 120 | 0 | portée réductible ? |
| `Button1_Click` | 588-592 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et sélection

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)`, son,
  centrage, plages par défaut (`00000`–`ZZZZZ`, familles `00000`–`ZZZZZ`, fournisseurs
  `40100001`–`40199999`), focus sur `Art`.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `Origine` = `"1"`/`"2"`, puis `SelectionArt`.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. `Tab = "Fiches_Art"` (sans effet),
  `New TriArticles(…, Me)` modal ; si `Bsel`, copie `Bval` dans `Art`/`Art2` (`Bsel` jamais remis à
  faux, comme `EdArt1`).

### Listes de choix

- **`ToggleButton3_Click()` … `ToggleButton6_Click()`** [portée : nécessaire (handler)]
  [nature : mixte]. Listes `Colfam`/`Colfam2` (`SELECT * FROM Fiches_Fam order by code_fam`) et
  `Colfour`/`Colfour2` (`SELECT * FROM Fiches_Four order by fo_code`), noms en dur, en-tête « Code ».
  Pour `Colfam` le `SetFocus` est commenté (l. 136) : la liste s'ouvre sans prendre le focus.
- **`Colfam_KeyPress()` … `Colfour2_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI].
  Entrée/Retour → `<Liste>_Click` ; Échap **ou F1** → ferme et vide (F1 n'ouvre pas l'aide ici).
- **`Colfam_Click()` … `Colfour2_Click()`** [portée : nécessaire (handler, rejeu dynamique)]
  [nature : GUI].

### Navigation et boutons

- **`Btn_Click()`** (tag 1 inatteignable, 2 impression, 3 suppression du PDF et fermeture),
  **`Btn_KeyPress()`** (impression pour toute touche sur `Button2`) [portée : nécessaire (handlers)]
  [nature : GUI].
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI] (CC 10). Entrée/Retour/Tab :
  champ suivant selon le tag (1 → `Art2`, …, 6 → `Button2`). Ni F1 ni F2 (contrairement à
  `EdArt1`).
- **`Cmpt_GotFocus()` / `Cmpt_LostFocus()`** [portée : nécessaire (handlers)] [nature : GUI].
  `Try Utils.ObsGotf(Last)` / `Try Utils.ObsLstf(Last)` (couleur du champ actif).
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Edtar")` (même
  page d'aide que les tarifs).

### Impression

- **`Button2_Click()`** [portée : réductible (`Button2` dans le groupe `btn`)] [nature : mixte]
  (CC 27).
  1. `Totpa = Totpmp = "0"`, `Shell "cd ~"` (sans effet), `New CArticles`, `Entete` « Impression du
     stock chiffré au <date> » + `Level1`, ou « Impression du stock non chiffré » + `Level2`.
  2. Une des 4 requêtes `SELECT * FROM Fiches_Art WHERE` plages article/famille/fournisseur
     `and art_stocke = &7` (7ᵉ paramètre = 1), tri `lpad(art_code,15,' ')`, `art_fam`, `art_four` ou
     `art_design` (le 4ᵉ cas est un `Else` : tri par désignation par défaut).
  3. Par article : code imprimé selon `Ch3..Ch6` (repli sur `art_code` si vide ou `Null`) ;
     désignation tronquée à 38 car. ; `Try pbht = Format$(art_pbht, nbdec)` avec `Print code` sur la
     sortie standard en cas d'erreur (trace de débogage) ; remise `"0.00"` ; quantité formatée par
     `Utils.CDec(art_dec, art_qte)` ; `Thtpa = paht × qte` et `Thtpmp = pmp × qte` (Float stockés dans
     des `String`) ; cumuls `Totpa`/`Totpmp` **reformatés à 2 décimales à chaque ligne** ;
     `Level3` (chiffré) ou `Level4` ; pas de 5 mm.
  4. Saut de page à `PosY >= 270` (sans `Footer`). Après la boucle, en chiffré : nouvelle page si
     `PosY >= 250`, puis `Level5(Totpa, Totpmp)`.
  5. `Output`, `Visualiseur.Prog`. Aucun article : son + message. `Catch` : son +
     `Message.Error(Error.Text & " " & Error.Where)`, curseur restauré.
  ⚠️ `Footer` n'est **jamais** appelé : pas de pied « Page n/{nb} » (contrairement à `EdArt1`).
  ⚠️ Les membres `Code`, `Intitule`, `Fami`, `Fourn`, `Pbht`, `Rem`, `Paht`, `Qte`, `Totpa`,
  `Totpmp`, `Nbd`, `Nbdec` ne servent qu'ici : ce sont des variables locales déguisées ; `Pbht`
  garde la valeur de l'article précédent si le `Format$` échoue. Variables mortes : `Dte`, `PosX`.
  Partie extractible : `ValoriseLigne(paht, pmp, qte, nbdec)` et le cumul (calcul pur).

## État global utilisé

- `Start.Musique`, `Start.Son`.
- `Utils.db.Exec`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`, `Utils.Find_nbdec`,
  `Utils.cpoint`, `Utils.CDec`.
- `Visualiseur.Prog`, `Doc.Open`.
- `Bsel`/`Bval` : `Public`, écrits par `TriArticles`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Transformer les 12 membres de travail de l'impression en variables locales de `Button2_Click`
  (aucun autre usage, vérifié par grep).
- Extraire `ValoriseLigne` et `CumulStock` (calculs purs, testables en gb.test) en conservant
  exactement l'arrondi actuel (cumul reformaté à 2 décimales à chaque ligne).
- Supprimer `Print code`, `Dte`, `PosX`, `Shell "cd …"`, le `With utils` (remplacer `.cpoint` par
  `Utils.cpoint`) et le `Case 1` inatteignable de `Btn_Click`.
- Factoriser l'en-tête (`Entete` + `Level1`/`Level2`, écrit 3 fois) dans une procédure locale.

### Commonalisation avec d'autres fichiers

- Listes famille/fournisseur, `SelectionArt` et requête d'articles par plages : socle `EdSelection`
  décrit dans [EdArt1/architecture.md](../EdArt1.class/architecture.md#commonalisation-avec-dautres-fichiers)
  (`SelectArticles(bornes, iTri, bStocke)` couvre la condition `art_stocke = 1`).
- Coloration du focus par `ObsGotf`/`ObsLstf` (comme `Edart4`) alors qu'`EdArt1`, `EdArt3`,
  `EdRup`, `EdMat`, `Edmo` utilisent `SetEditColor` : deux mécanismes pour le même rendu.
- Valorisation du stock : la même formule (`qte × paht`, `qte × pmp`) existe dans les éditions
  d'inventaire (`Edinv`, `Edinv1`, hors lot) ; à rapprocher en phase 3.

### Réduction de portée

- `SelectionArt`, `Button2_Click` : sans appelant externe (seul `Fmenu.class:1129`) → `Private`.
- Handlers (`ToggleButton*`, `Col*`, `Btn_*`, `Cmpt_*`, `Button1_Click`) : `Public`.

### Séparation traitement / GUI

- `Button2_Click` : `SelectArticlesStockes(…) As Result` + `ValoriseLigne`/`CumulStock` purs ; le
  handler lit les contrôles (`Ch1..Ch6`, `RadioButton*`) et pilote le PDF.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker le stock par dépôt et la date de valorisation permettrait une édition « stock au
  <date> » cohérente avec `Stockmvt`, au lieu de la seule photographie `art_qte`.
- Index `Fiches_Art(art_stocke, art_fam, art_four)` pour la sélection.
