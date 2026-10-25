# TriBl — Architecture

> Source : `.src/Affichages/TriBl.class`

## Vue d'ensemble

`TriBl` était l'écran de la caisse permettant de **rattacher des bons de livraison non facturés**
(`Fiches_Bl`, `type = "B"`, `imp = 0`) d'un client au ticket en cours, en écrivant directement
`Fiches_Bl.numtick` à chaque clic. Il était ouvert par `Caisse` (`New Tribl(Bval, numero_tk)`).

**Classe morte** : son unique appel a été supprimé par le commit `7101bb39` (13/10/2022,
« Modification Reglement BL/Facture en caisse ») qui l'a remplacée par
[`TriFacture`](../TriFacture.class/architecture.md). Vérification :

- `grep -rnw -i "TriBl" .src` ne trouve que la variable locale `Tribl` (chaîne de tri) de
  `Facture.class` (lignes 35, 518, 1244…), sans rapport avec la classe ;
- aucune chaîne `"TriBl"` (pas de `Class.Load`/`Object.New`) ; `deps.py` : `jamais_reference` ;
- `git log -S "New TriBl"` : dernière apparition supprimée par `7101bb39`.

La suppression du couple `TriBl.class` + `TriBl.form` est une **anomalie** (TRIBL-A01), soumise à
validation. Les défauts décrits ci-dessous sont **latents** tant que la classe n'est pas appelée.

Nature : **GUI** avec écritures SQL immédiates.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `NbEnreg` | var | Private |  | Integer | 3 |
| `Clitable` | var | Private |  | New String[9] | 4 |
| `Dbl` | var | Private |  | Boolean | 5 |
| `Tri` | var | Private |  | String | 6 |
| `sel` | var | Private |  | String | 7 |
| `lg` | var | Private |  | Integer | 8 |
| `Clicode` | var | Private |  | String | 9 |
| `Ntk` | var | Private |  | String | 10 |
<!-- /AUTO:declarations -->

| Variable | Usage |
|---|---|
| `Clitable` | noms de colonnes (`numbl`, `datebl`, `totalttc`, `numtick`), rempli à chaque cellule ; déclaré `[9]`, 4 utilisés ; sans mot-clé donc `Private` |
| `Dbl`, `Tri`, `sel` | ordre inversé, colonne de tri (toujours `numbl`), filtre ; sans mot-clé donc `Private` |
| `NbEnreg`, `lg` | pagination |
| `Clicode`, `Ntk` | code client et numéro de ticket |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 13-33 | Public | 2 | 18 | 0 | méthode spéciale |
| `Tris` | 36-46 | Public | 1 | 9 | 0 | portée réductible ? |
| `Colcli_Data` | 51-68 | Public | 3 | 15 | 0 | handler GUI |
| `Select_Bl` | 70-84 | Public | 14 | 15 | 0 | portée réductible ? |
| `Compute_Total_Bl` | 86-98 | Public | 3 | 11 | 0 | portée réductible ? |
| `colcli_Click` | 101-103 | Public | 1 | 3 | 0 | handler GUI |
| `ColCli_KeyPress` | 105-129 | Public | 11 | 22 | 0 | handler GUI |
| `ColCli_MouseWheel` | 131-140 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 142-152 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 154-162 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 164-172 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 174-182 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 184-193 | Public | 3 | 8 | 0 | portée réductible ? |
| `Deb3` | 195-203 | Public | 1 | 6 | 0 | portée réductible ? |
| `Deb4` | 205-213 | Public | 1 | 6 | 0 | portée réductible ? |
| `Dbclk` | 215-225 | Public | 2 | 9 | 0 | portée réductible ? |
| `C1_Click` | 227-231 | Public | 1 | 3 | 0 | handler GUI |
| `C1_Dblclick` | 233-237 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Click` | 239-243 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Dblclick` | 245-249 | Public | 1 | 3 | 0 | handler GUI |
| `C1_KeyPress` | 252-265 | Public | 5 | 12 | 0 | handler GUI |
| `N1_KeyPress` | 267-284 | Public | 6 | 14 | 0 | handler GUI |
| `C1_GotFocus` | 286-291 | Public | 2 | 4 | 0 | handler GUI |
| `C1_LostFocus` | 293-297 | Public | 2 | 3 | 0 | handler GUI |
| `N1_GotFocus` | 299-304 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 306-310 | Public | 2 | 3 | 0 | handler GUI |
| `ChkInput` | 312-321 | Public | 2 | 8 | 0 | portée réductible ? |
| `ClavInput` | 323-328 | Public | 1 | 4 | 0 | portée réductible ? |
| `ClavInput2` | 330-335 | Public | 1 | 4 | 0 | portée réductible ? |
| `Valider_Click` | 338-342 | Public | 1 | 3 | 0 | handler GUI |
| `Annuler_Click` | 344-350 | Public | 2 | 4 | 0 | handler GUI |
| `CheckBox1_Click` | 352-363 | Public | 3 | 12 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(ccode, numtick)`** [portée : nécessaire (constructeur)] [nature : GUI] :
  `Utils.Observers(Me)`, grille de 4 colonnes, titres, `Deb3`, total initial
  (`Compute_Total_Bl`).
- **`Tris()`** [portée : réductible] : largeurs des colonnes.
- **`Colcli_Data(Row, Column)`** [handler] [nature : GUI] : valeur de `Utils.rs2` ; calcule `Frmt` et
  `Frmt2` (deux lectures de couleurs **jamais utilisées**).
- **`Select_Bl(Nbl, Row, force_select, force_unselect)`** [portée : réductible] [nature : mixte] :
  relit le BL (`SELECT * FROM TabBl WHERE numbl = &1`), puis bascule (ou force) son rattachement :
  `UPDATE TabBl SET numtick = NULL|Ntk WHERE numbl = &2` (paramétré) et met à jour la cellule et le
  total affiché. Le retrait soustrait `Val(colcli[Row, 2].Text)` sans `Utils.cpoint` alors que l'ajout
  l'utilise (incohérence).
- **`Compute_Total_Bl(Nbtk) As String`** [portée : réductible] [nature : calcul] : somme de
  `totalttc` des BL du ticket (`SELECT * … WHERE numtick = &1`, paramétré), en `String`.
- **`colcli_Click()`** [handler, rejoué par `Object.Call`] : `Select_Bl` de la ligne.
  **`ColCli_KeyPress()`** : Entrée = clic, pagination, Échap/F2 = fermeture.
- **`ColCli_MouseWheel`, `Descendre_Click`, `Remonter_Click`, `Descendre_KeyPress`,
  `Remonter_KeyPress`, `Deplacement`** : pagination (`Deplacement` réductible).
- **`Deb3()` / `Deb4()`** [portée : réductible] [nature : mixte] : requête des BL, ordre `ASC`/`DESC`,
  puis `colcli.Clear()` et `Refresh`. **SQL concaténé** (voir ci-dessous).
- **`Dbclk()`** [réductible] : alterne `Deb4`/`Deb3`.
- **`C1_Click`, `C1_Dblclick`, `N1_Click`, `N1_Dblclick`** : appellent `Dbclk`. `C1`/`N1` sont des
  `TextBox` : `Click` n'est pas un événement de `TextBox`, ces méthodes ne sont appelées que par
  `*_GotFocus` et `*_KeyPress`.
- **`C1_KeyPress`, `N1_KeyPress`** : `ChkInput`, Échap/F2, navigation. **`C1_GotFocus`,
  `N1_GotFocus`, `C1_LostFocus`, `N1_LostFocus`** : couleur de focus (`Utils.ObsGotf`/`ObsLstf`) et
  bascule d'ordre.
- **`ChkInput()`** [réductible] : refuse `"` et `&` (`Stop Event`), sinon `sel = Utils.Obstch(sel)`
  et `Deb3`. `Tri` ne change jamais : le filtre porte toujours sur `numbl`, même depuis `N1` (date).
- **`ClavInput()`, `ClavInput2()`** : **jamais appelées** (`unused`, vérifié par `grep`) — reliquats
  du clavier virtuel de `Tricartes`/`TriclientsD`.
- **`Valider_Click()`** : ferme (les rattachements sont déjà écrits). **`Annuler_Click()`** :
  `UPDATE TabBl SET numtick = NULL WHERE numtick = &2` puis ferme (détache **tous** les BL du ticket,
  y compris ceux rattachés avant l'ouverture).
- **`CheckBox1_Click()`** : force la sélection ou la désélection de toutes les lignes **de la page**
  (variable locale `lg` qui masque le membre `lg`).

### SQL par concaténation (relevé exhaustif)

| Ligne | Fonction | Valeur concaténée | Effet |
|---|---|---|---|
| 199 | `Deb3` | `Tri` (colonne), `"%" & sel & "%"` (motif entre guillemets doubles) | `ChkInput` bloque `"` et `&` mais pas `\`, `%`, `_` |
| 199 | `Deb3` | `cdclibl = " & Clicode` **sans guillemets** | `cdclibl` est un `varchar(8)` : comparaison numérique en MySQL ; code client non numérique → erreur SQL (colonne inconnue) |
| 199 | `Deb3` | `numtick = " & Ntk` **sans guillemets** | `numtick` est un `char(7)` ; ticket vide → erreur de syntaxe |
| 199 | `Deb3` | `limit " & NbEnreg & ", " & lg` | entiers internes (sans risque) |
| 209 | `Deb4` | mêmes quatre concaténations, ordre `DESC` | idem |

Les autres requêtes (`Select_Bl`, `Compute_Total_Bl`, `Annuler_Click`) sont paramétrées (`&1`, `&2`).

## État global utilisé

- `Utils.rs2`, `Utils.Base2`, `Utils.Fcolr`, `Utils.cpoint`, `Utils.Obstch`, `Utils.ObsGotf`,
  `Utils.ObsLstf`, `Utils.Observers` ; `Start.LocalSettings["/Coul/Fnets"]`, `["/Coul/Znaff"]`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Recommandation principale : **supprimer la classe et son `.form`** (TRIBL-A01). Les étapes de
  rework ci-dessous ne s'appliquent que si l'utilisateur refuse la suppression.

### Commonalisation avec d'autres fichiers

- 177 lignes communes avec [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md)
  (ratio 0,61, `dup.py`) : pagination, `ChkInput`, `ClavInput*`, `Colcli_Data` ; même famille que
  `TriclientsD`. Si la classe est conservée : `PaginationListe` et `ChkInput` communs.
- Fonctionnellement remplacée par `TriFacture` (sélection en mémoire, écriture par l'appelant).

### Réduction de portée

- `Tris`, `Select_Bl`, `Compute_Total_Bl`, `Deplacement`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput`,
  `ClavInput`, `ClavInput2` : aucun appelant externe (sans objet si la classe est supprimée).

### Séparation traitement / GUI

- `Select_Bl` mélange lecture, écriture et affichage : sans objet si suppression.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Sans objet (classe morte). Voir `TriFacture` pour le rattachement ticket ↔ documents.
