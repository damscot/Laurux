# EdArt3 — Architecture

> Source : `.src/Gestion/Impressions/EdArt3.class` · Formulaire : `.src/Gestion/Impressions/EdArt3.form`

## Vue d'ensemble

`EdArt3` est l'écran d'**impression du tarif par type client** (menu Gestion > Impression des
tables > Tarif > « Type client (coeff "T") », `Fmenu.Menu297_Click` → `EdArt3.ShowModal`).
C'est une copie d'[`EdArt1`](../EdArt1.class/architecture.md) (91 % de lignes communes, mêmes 23
fonctions) à laquelle s'ajoutent la saisie d'un **type client** (`Cdt`, liste `Coltype`,
`Quitte_Cdt`) et la lecture du coefficient par famille dans `Fiches_CoeffTypec`
(`Cbase.Table("TabCtcli")`). L'option marge (`Mg`) d'`EdArt1` n'existe pas ; la case `Phot` est
**visible** (mode photo utilisable).

L'impression produit `~/tmp/Tarif1.pdf` (**même fichier qu'`EdArt1`**) avec `Carticles`
(`Level7`/`Level7bis`, `Level6`/`Level6bis`, `Level10`). Par article, le coefficient du type client
pour la famille de l'article remplace `art_coef` dans la colonne « coefficient ». ⚠️ Le prix de
vente calculé avec ce coefficient est **aussitôt écrasé** par `art_pvht` (ligne 697) : le tarif
imprimé montre le coefficient du type client mais le prix de vente HT de base (anomalie
EDART3-A01).

Nature globale : **GUI**, traitement SQL + PDF dans `Button2_Click` (CC 30).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `PosX` | var | Private |  | Integer | 32 |
| `Coulfond` | var | Private |  | New String[] | 33 |
| `Phot_art` | var | Private |  | String | 34 |
| `Bsel` | var | Public |  | Boolean | 36 |
| `Bval` | var | Public |  | String | 37 |
| `Origine` | var | Private |  | String | 39 |
| `b` | var | Private |  | Integer | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-61 | Public | 1 | 17 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 63-68 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 70-75 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton3_Click` | 80-112 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam_KeyPress` | 117-137 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 142-174 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam2_KeyPress` | 179-199 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton5_Click` | 204-236 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour_KeyPress` | 241-261 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton6_Click` | 266-298 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour2_KeyPress` | 303-323 | Public | 6 | 17 | 0 | handler GUI |
| `SelectionArt` | 326-347 | Public | 4 | 19 | 0 | portée réductible ? |
| `art_man` | 352-378 | Public | 6 | 24 | 0 | portée réductible ? |
| `Colfam_Click` | 383-391 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 396-404 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 409-417 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 422-429 | Public | 1 | 6 | 0 | handler GUI |
| `ToggleButton7_Click` | 431-458 | Public | 4 | 25 | 0 | handler GUI |
| `Coltype_Click` | 460-467 | Public | 1 | 6 | 0 | handler GUI |
| `Quitte_Cdt` | 472-498 | Public | 4 | 24 | 0 | portée réductible ? |
| `cdt_KeyPress` | 500-506 | Public | 5 | 5 | 0 | handler GUI |
| `Btn_Click` | 508-524 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 526-533 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 535-613 | Public | 20 | 69 | 0 | handler GUI |
| `Cmpt_GotFocus` | 618-624 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 626-763 | Public | 30 | 135 | 0 | portée réductible ? |
| `Button1_Click` | 765-769 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions communes avec `EdArt1` ont le **même comportement** (voir
[EdArt1/architecture.md](../EdArt1.class/architecture.md#description-des-fonctions)) ; seules les
différences sont détaillées.

### Initialisation, listes, sélection d'article (identiques à `EdArt1`)

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI] : identique à `EdArt1._New`
  (`Frmt`, `Coulfond` lus et inutilisés).
- **`ToggleButton3_Click()` … `ToggleButton6_Click()`** [portée : nécessaire (handler)]
  [nature : mixte] : listes `Colfam`, `Colfam2` (`Fiches_Fam`), `Colfour`, `Colfour2`
  (`Fiches_Four`), noms en dur. Différence : pas de `Raise` (la liste peut rester derrière d'autres
  contrôles).
- **`Colfam_KeyPress()`, `Colfam2_KeyPress()`, `Colfour_KeyPress()`, `Colfour2_KeyPress()`**
  [portée : nécessaire (handler)] [nature : GUI] : identiques (même incohérence focus/sélection pour
  `Colfam2` l. 194-195 et `Colfour2` l. 318-319).
- **`Colfam_Click()`, `Colfam2_Click()`, `Colfour_Click()`, `Colfour2_Click()`** [portée :
  nécessaire (handler, rejeu dynamique)] [nature : GUI].
- **`ToggleButton1_Click()`, `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : GUI] ; **`SelectionArt()`** [portée : réductible] [nature : GUI] (`Bsel` jamais remis à
  faux) ; **`art_man()`** [portée : réductible] [nature : mixte] (4 requêtes `TabArt`).
- **`Btn_Click()`**, **`Btn_KeyPress()`**, **`Cmpt_KeyPress()`** (CC 20, tag 2 qui contrôle
  `Art.Text`, l. 552), **`Cmpt_GotFocus()`**, **`Button1_Click()`** (`Doc.Open("Edtar")`) [portée :
  nécessaire (handlers)] [nature : GUI].

### Type client (spécifique)

- **`ToggleButton7_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Bascule la liste
  `Coltype` : `SELECT * FROM Fiches_Typec` (`Cbase.Table("TabTypec")`, **sans `ORDER BY`**),
  colonnes code / libellé, sélection de la première ligne. Pas de `Coltype_KeyPress` : Échap ne
  ferme pas la liste.
- **`Coltype_Click()`** [portée : nécessaire (handler, rejeu dynamique)] [nature : GUI]. Copie le
  code dans `Cdt`, ferme la liste, appelle `Quitte_Cdt`.
- **`Quitte_Cdt()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Typec WHERE
  code = &1` (nom en dur dans `Tab`). Inconnu : `Stop Event`, son, `Balloon.Warning`, focus sur
  `Cdt`. Connu : `LibelType` ← libellé, puis `SELECT * FROM Fiches_CoeffTypec WHERE coder = &1` ;
  aucun coefficient : `Message.Warning("Aucun tarif n'a été saisit pour ce type client !")` et
  effacement de `Cdt`/`LibelType`. Partie extractible : `TypeClientValide(code) As Integer`
  (0 inconnu, 1 sans coefficient, 2 valide) et le libellé.
- **`cdt_KeyPress()`** [portée : nécessaire (handler, `Cdt` hors groupe)] [nature : GUI].
  Entrée/Retour/Tab sur un `Cdt` non vide → `Quitte_Cdt`. ⚠️ Un type saisi puis validé directement
  par **Imprimer** (sans Entrée) n'est pas contrôlé.

### Impression

- **`Button2_Click()`** [portée : réductible (`Button2` dans le groupe `btn`)] [nature : mixte]
  (CC 30). Si `Cdt` est vide : `Message.Warning("Veuillez saisir un type client SVP !")`. Sinon,
  même déroulement qu'`EdArt1.Button2_Click` sans l'option marge : titre « Impression du tarif par
  type client au <date>. Type = <code> <libellé> », les 4 mêmes requêtes `Fiches_Art` (en dur), puis
  par article :
  - `coef = Format$(art_coef, "0.000")` (format différent d'`EdArt1` : `"00.000"`) ;
  - `SELECT * FROM Fiches_CoeffTypec WHERE coder = &1 AND codef = &2` (**une requête par article**) ;
    si trouvé : `coef = coeff` (brut, non formaté) et `pvht = art_prvt × coeff` ;
  - ⚠️ `pvht = Format$(art_pvht, nbdec)` **écrase** le prix calculé (EDART3-A01) ;
  - colonne « prix d'achat » de `Level6` = `art_paht` (et non `art_prvt` comme dans `EdArt1`).
  Mode photo : si `art_photo` est renseigné mais que `Image.Load(Photart/<photo>)` échoue, l'article
  n'est **pas imprimé du tout** (EDART3-A06).
  Saut de page à 283 mm avec le titre « Impression du tarif **interne** » (EDART3-A02).
  `Me.Mouse` remis à `Pointing` seulement dans la branche « type saisi ».

## État global utilisé

- `Start.Musique`, `Start.Son`, `Start.Societe`, `Start.LocalSettings` (`/Soc<XX>/Photart`,
  `/Soc<XX>/Pvcons`, `/Coul/Fnets`).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.FColr`, `Utils.Coulfd`, `Utils.SetEditColor`,
  `Utils.Find_nbdec`, `Utils.cpoint`, `Cbase.Table` (`TabArt`, `TabTypec`, `TabCtcli`).
- `Visualiseur.Prog`, `Doc.Open`, `Balloon`.
- `Bsel`/`Bval` : `Public`, écrits par `TriArticles`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Charger les coefficients du type client **une fois** (`SELECT codef, coeff FROM
  Fiches_CoeffTypec WHERE coder = &1` → `Collection` par famille) au lieu d'une requête par
  article : SQL modifié, résultat imprimé identique (le replay compare le texte PDF ; les lignes
  `Exec_SQL` diffèrent).
- Supprimer le calcul mort `pvht = art_prvt × coeff` **seulement** si l'anomalie A01 est refusée ;
  sinon la correction consiste à ne plus l'écraser.
- Mêmes nettoyages qu'`EdArt1` (code mort `Frmt`, `Coulfond`, `Nbpage`, `dte`, `PosX`, `Shell`,
  `Case 1` de `Btn_Click`).

### Commonalisation avec d'autres fichiers

- Socle `EdSelection` (listes, `ChercheArticle`, `SelectArticles`) et procédure commune
  `ImprimeTarif(titre, typeClient)` avec `EdArt1` : voir le tableau de duplication dans
  [EdArt1/architecture.md](../EdArt1.class/architecture.md#commonalisation-avec-dautres-fichiers).
- Liste et contrôle du type client : même besoin dans [`Edart4`](../Edart4.class/architecture.md)
  (`Buttypc_Click`, `Fiches_Typec` en dur) et dans [`TarArt`](../../../Utils/TarArt.class/architecture.md)
  (lecture de `Fiches_CoeffTypec`) : une fonction `CoefTypeClient(typec, famille) As Float`
  partagée éviterait trois lectures différentes du même tarif.

### Réduction de portée

- `SelectionArt`, `art_man`, `Quitte_Cdt`, `Button2_Click` : aucun appelant externe (seul
  `Fmenu.class:2304` `EdArt3.ShowModal`) → `Private`.
- Handlers, dont `Coltype_Click` (rejeu dynamique), restent `Public`.

### Séparation traitement / GUI

- `Quitte_Cdt` : `TypeClientValide(code)` pur SQL, messages et focus dans l'appelant.
- `Button2_Click` : comme `EdArt1` (`SelectArticles`, `LigneTarif`), plus `CoefTypeClient`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `Fiches_CoeffTypec(coder, codef)` (lecture par article).
- Le coefficient par type client et famille pourrait être appliqué en SQL par jointure
  `Fiches_Art LEFT JOIN Fiches_CoeffTypec ON codef = art_fam AND coder = &1`.
