# MvtDepots — Architecture

> Source : `.src/Gestion/Depots/MvtDepots.class`

## Vue d'ensemble

Écran de **transfert de stock entre dépôts** : dépôt de départ (`Code`), dépôt d'arrivée
(`Code2`), date (`Datej`), puis saisie article par article (`Cart`, `Qte`) ; chaque validation
(`Button3`) met à jour immédiatement :
- le stock de la fiche article (`Fiches_Art.art_qte`) si l'un des deux dépôts est le magasin `01`
  (`Maj_QteArt`) ;
- le stock du dépôt d'arrivée (`Maj_Qtearr`) et du dépôt de départ (`Maj_Qtedep`) dans
  `Fiches_StkDepots` ;
- l'historique `Fiches_Sdepots` : une sortie `S` du départ et une entrée `E` de l'arrivée
  (`Maj_Sdepots`), relu par [Edsdepots](../Edsdepots.class/architecture.md) et par
  `Cstock.module:98` (recalcul du stock du dépôt `01`).

La grille `Colrcp` ne fait que récapituler la saisie (avec cumul des doublons). Ouvert par
`Fmenu.class:2158` (`MvtDepots.Show()`). Écran voisin : [Sdepots](../Sdepots.class/architecture.md)
(sorties manuelles d'un dépôt ; 205 lignes communes).

Contrôles : `Code`, `Code2` (liste `Coldep` par `ToggleButton2`/`ToggleButton3` ou F2),
`Cart`/`Qte` (groupe `Dep`, tags 1-2), `ToggleButton1` (articles : `TriArticles` pour le dépôt
`01`, sinon liste `Coldepa` du stock du dépôt), `Datej` + `DateChooser1`, `Button3`
(valider la ligne), `Button1` (fermer). Les verrous `LOCK TABLES` ne sont posés que table par table.

Nature : **mixte** (mises à jour de stock dans des fonctions qui lisent les contrôles).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 3 |
| `Bval` | var | Public |  | String | 4 |
| `B` | var | Public |  | Boolean | 6 |
| `Decm` | var | Private |  | String | 7 |
| `Org` | var | Private |  | String | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 10-38 | Public | 1 | 27 | 0 | méthode spéciale |
| `Button1_Click` | 40-44 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton2_Click` | 47-58 | Public | 2 | 10 | 0 | handler GUI |
| `ToggleButton3_Click` | 60-71 | Public | 2 | 10 | 0 | handler GUI |
| `aff_Depot` | 73-87 | Public | 3 | 12 | 0 | portée réductible ? |
| `Coldep_Click` | 89-114 | Public | 4 | 24 | 0 | handler GUI |
| `Code_KeyPress` | 116-128 | Public | 5 | 11 | 0 | handler GUI |
| `Code2_KeyPress` | 130-149 | Public | 7 | 18 | 0 | handler GUI |
| `Code_GotFocus` | 151-155 | Public | 2 | 3 | 0 | handler GUI |
| `Code_LostFocus` | 157-161 | Public | 2 | 3 | 0 | handler GUI |
| `Cman` | 163-178 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button2_Click` | 182-184 | Public | 1 | 2 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 188-229 | Public | 8 | 39 | 0 | handler GUI |
| `Coldepa_Click` | 231-238 | Public | 1 | 6 | 0 | handler GUI |
| `art_man` | 243-295 | Public | 9 | 50 | 0 | portée réductible ? |
| `Dep_KeyPress` | 297-323 | Public | 11 | 24 | 0 | handler GUI |
| `button3_KeyPress` | 325-329 | Public | 3 | 3 | 0 | handler GUI |
| `Button3_Click` | 331-352 | Public | 7 | 20 | 0 | handler GUI |
| `Maj_Colrcp` | 354-386 | Public | 9 | 30 | 0 | portée réductible ? |
| `Maj_QteArt` | 391-416 | Public | 6 | 23 | 0 | portée réductible ? |
| `Maj_Qtedep` | 421-448 | Public | 4 | 22 | 0 | portée réductible ? |
| `Maj_Qtearr` | 453-478 | Public | 5 | 23 | 0 | portée réductible ? |
| `Maj_Sdepots` | 483-493 | Public | 1 | 8 | 0 | portée réductible ? |
| `DateChooser1_Activate` | 497-502 | Public | 1 | 4 | 0 | handler GUI |
| `Datej_DblClick` | 504-512 | Public | 2 | 7 | 0 | handler GUI |
| `Datej_keypress` | 514-525 | Public | 3 | 9 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Choix des dépôts

- **`_new()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers`, colonnes de `Coldep`,
  `Coldepa`, `Colrcp`, date du jour, focus.
- **`ToggleButton2_Click()` / `ToggleButton3_Click()`** [handlers] : `Org` = 1 (départ) ou 2
  (arrivée), bascule de la liste des dépôts.
- **`aff_Depot()`** [portée : réductible] [nature : mixte] : `SELECT * FROM <TabDepots> order by code`.
- **`Coldep_Click()`** [handler] : dépôt choisi → départ ou arrivée (refus si arrivée = départ).
  Rejoué par `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`Code_KeyPress()`** [handler] : F2 → liste ; Entrée/Tab → `Cman("1")`.
- **`Code2_KeyPress()`** [handler] : F2 → liste ; Entrée/Tab → refus si identique au départ, sinon
  `Cman("2")`.
- **`Code_GotFocus()` / `Code_LostFocus()`** [handlers] : `Utils.ObsGotf`/`ObsLstf`.
- **`Cman(Orgn)`** [portée : réductible] [nature : mixte] : relit le dépôt **`Code.Text`** dans
  les deux cas (ligne 167) : pour l'arrivée, `Libelle3` reçoit le libellé du **dépôt de départ**
  (anomalie A02).

### Choix de l'article

- **`ToggleButton1_Click()`** [handler] : dépôt `01` → `TriArticles` (retour par `Bsel`/`Bval`,
  écrits par `Object.SetProperty`) puis `Art_Man` ; autre dépôt → liste `Coldepa` (`<TabArt> Left
  join <TabStkDepots> … where coded = &1`). Variable locale `Tab` inutilisée.
- **`Coldepa_Click()`** [handler] : article choisi → `art_man`. Rejoué par `ReplayObserver`
  (`replay_dynamic`) : **reste `Public`**.
- **`art_man()`** [portée : réductible] [nature : mixte] : dépôt `01` → recherche par `art_code`
  puis `art_cfour` ; les recherches par `art_cbarre` et `art_refcentrale` sont **inatteignables**
  (elles sont dans la branche « trouvé par code » où `Not rarts.Available` est toujours faux,
  anomalie A03). Autre dépôt → article présent dans le stock du dépôt, par **`db.Exec`** (classe
  `DB` de gb.db, connexion courante, hors `Utils.db` : pas de journalisation ni de traduction
  SQLite, ligne 277). Positionne `b` (vrai = **échec**) et `Decm` (décimales).
- **`Dep_KeyPress()`** [handler du groupe `Dep`] (CC 11) : Entrée sur l'article → `Art_Man`, sur
  la quantité → focus Valider ; F2 → liste d'articles ; Échap → ferme la liste.

### Validation d'une ligne

- **`button3_KeyPress()`** [handler] : Entrée/Retour → `Button3_Click`.
- **`Button3_Click()`** [handler] [nature : mixte] : si le dépôt de départ est saisi :
  `Maj_Colrcp`, puis si `b` est vrai : `Maj_QteArt` (si l'un des dépôts est `01`), `Maj_QteArr`,
  `Maj_Qtedep`, `Maj_Sdepots` ; vide la saisie. `Maj_Colrcp` remet `b` à vrai en cas de succès,
  si bien qu'un article **introuvable** (`b` vrai après `art_man`) est **quand même transféré**
  (anomalie A04). Le dépôt d'arrivée et la quantité ne sont pas contrôlés.
- **`Maj_Colrcp()`** [portée : réductible] [nature : GUI] : ajoute la ligne à `Colrcp` (clé = code
  article) ; si la clé existe (`Catch`), parcourt la grille et propose « Cumuler » (quantité
  additionnée, `b` vrai) ou « Abandonner » (`b` faux).
- **`Maj_QteArt()`** [portée : réductible] [nature : calcul + GUI] : `LOCK TABLES <TabArt>` ; si
  l'article est stocké, `art_qte` −quantité (départ `01`) ou +quantité (arrivée `01`).
- **`Maj_Qtedep()`** [portée : réductible] [nature : calcul + GUI] : `LOCK TABLES <TabStkDepots>` ;
  si la ligne de stock du départ existe : `UPDATE qte = qte − quantité` **puis `DELETE` de cette
  même ligne** (lignes 436-438 : le `If qtec > 0` est commenté mais pas le `DELETE`) : le stock du
  dépôt de départ est **supprimé à chaque transfert** (anomalie A01) ; sinon `INSERT` d'une ligne à
  −quantité (y compris pour le dépôt `01`, dont le stock réel est dans `Fiches_Art`).
- **`Maj_Qtearr()`** [portée : réductible] [nature : calcul + GUI] : ligne de stock de l'arrivée
  augmentée (supprimée si ≤ 0) ou créée.
- **`Maj_Sdepots()`** [portée : réductible] [nature : calcul + GUI] : `LOCK TABLES <TabSdepots>`,
  deux `INSERT` (sortie du départ, entrée de l'arrivée, commentaire « Mvt du dépôt X vers dépôt Y »).
- **`Button2_Click()`** [portée : réductible] : **vide** et sans bouton `Button2` dans le `.form` :
  jamais appelée (`unused`, code mort).
- **`Button1_Click()`** [handler] : ferme.

### Date

- **`DateChooser1_Activate()`**, **`Datej_DblClick()`**, **`Datej_keypress()`** [handlers] :
  calendrier (double-clic ou F2).

## État global utilisé

- `Utils.db`, **classe `DB`** (`db.Exec`), `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`,
  `Utils.Cdec`, `Utils.cpoint`, `Utils.Cdate_Dbase`, `Cbase.Table` (`TabDepots`, `TabArt`,
  `TabStkDepots`, `TabSdepots`) ; `Start.son`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Button2_Click`, la variable `Tab` de `ToggleButton1_Click`.
- `Utils.db.Exec` au lieu de `db.Exec` (SQL identique sous MySQL ; journalisé et traduit SQLite) :
  changement de comportement en SQLite et dans le log → anomalie A05.
- Remplacer le drapeau `b` à double sens par deux booléens explicites (`$bArticleOk`, `$bLigneOk`)
  : changement de comportement (A04).

### Commonalisation avec d'autres fichiers

- [Sdepots](../Sdepots.class/architecture.md) : `aff_Depot`, `Cman`, `Coldepa`/`ToggleButton`,
  `art_man` (version « dépôt »), `Dep_KeyPress`, `Maj_Colrcp`, `Maj_Qtedep` quasi identiques
  (205 lignes communes) ; [ImpDepots](../ImpDepots.class/architecture.md) partage la liste des
  dépôts → module `Depot` (liste, libellé, stock d'un article, mouvement de stock), proposé dans
  [Depots](../Depots.class/architecture.md).
- Recherche d'article (code, code fournisseur, code-barres, référence centrale) : fonction commune
  avec [FpromoArt](../../Tables/FpromoArt.class/architecture.md) et `Facture.Art_man`.
- Mise à jour de `art_qte` sous verrou : même logique dans `Cstock`, `DB_Connection.Lockstock`,
  `Validinv`, `Stockmvt` (notes transverses : commonalisation « stock »).

### Réduction de portée

`aff_Depot`, `Cman`, `art_man`, `Maj_Colrcp`, `Maj_QteArt`, `Maj_Qtedep`, `Maj_Qtearr`,
`Maj_Sdepots`, et la variable `B` → `Private` ; `Button2_Click` supprimée. `Bsel`/`Bval` restent
`Public` (`TriArticles`).

### Séparation traitement / GUI

`TransfereArticle(sDep, sArr, sArt, fQte, sDate)` sans accès aux contrôles, regroupant les quatre
mises à jour, appelée par `Button3_Click` (comportement actuel conservé, `DELETE` compris, tant que
A01 n'est pas validée).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stock du magasin dans `Fiches_StkDepots` comme les autres dépôts (aujourd'hui `Fiches_Art.art_qte`).
- `Fiches_Sdepots.code` char(2) (codes de dépôt plus longs tronqués) ; `qte` char(10) → décimal.
- Transaction (InnoDB) au lieu de `LOCK TABLES` successifs.
