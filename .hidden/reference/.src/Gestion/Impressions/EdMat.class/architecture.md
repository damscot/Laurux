# EdMat — Architecture

> Source : `.src/Gestion/Impressions/EdMat.class` · Formulaire : `.src/Gestion/Impressions/EdMat.form`

## Vue d'ensemble

`EdMat` est l'écran d'**impression de la liste des matériels** (menu « Matériels »,
`Fmenu.Menu289_Click` → `EdMat.Show()`). Un matériel est une fiche `Fiches_Materiels`
(`Cbase.Table("TabMat")`) identifiée par `mat_code` (code article) + `mat_serie` (n° de série),
créée à la réception et vendue par la facturation (voir le tableau des tables `*M` de
[Materiel/architecture.md](../../Tables/Materiel.class/architecture.md)). `EdMat` ne lit **que**
`Fiches_Materiels` et `Fiches_Marques` : ni les bons/factures d'entretien (`Fiches_BlM`,
`Fiches_HistoFacM`) ni les commentaires de réparation (`Fiches_EntMat`, `Fiches_HisentMat`).

Paramètres : plages matériel `Mat`–`Mat2` (code article), propriétaire `Cli`–`Cli2` (client
`411…`), marque `Marque`–`Marque2` (intitulé de marque, comme l'écrit `Materiel.ColMarque_Click`),
type `Type`–`Type2` (**ignoré**) ; cases `Vendus` (matériels vendus) et `Vendus2` (en stock), toutes
deux cochées par défaut ; tri `RadioButton1..4` (code, propriétaire, marque, n° de série, défaut
n° de série). **Imprimer** produit `~/tmp/Tarif2.pdf` (nom hérité d'`EdArt2`) avec `Cmat`
(`.src/Reports/Cmat.class`, PdfWriter : `Level1`, `Level2`).

Nature globale : **GUI**, SQL et PDF dans `Button2_Click` (CC 35).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 12 |
| `Tab` | var | Private |  | String | 13 |
| `son` | var | Private |  | Integer | 14 |
| `PosY` | var | Private |  | Integer | 15 |
| `PosX` | var | Private |  | Integer | 16 |
| `CodeMat` | var | Public |  | String | 17 |
| `CClient` | var | Public |  | String | 18 |
| `Bsel` | var | Public |  | Boolean | 19 |
| `Bval` | var | Public |  | String | 20 |
| `Origine` | var | Private |  | String | 21 |
| `b` | var | Private |  | Integer | 22 |
| `Tri` | var | Private |  | String | 23 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 25-39 | Public | 1 | 13 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 41-46 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 48-53 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton3_Click` | 58-63 | Public | 1 | 4 | 0 | handler GUI |
| `SelectionProp` | 66-93 | Public | 4 | 25 | 0 | portée réductible ? |
| `ToggleButton4_Click` | 95-100 | Public | 1 | 4 | 0 | handler GUI |
| `ColMarque_KeyPress` | 105-125 | Public | 6 | 17 | 0 | handler GUI |
| `SelectionMat` | 128-158 | Public | 4 | 28 | 0 | portée réductible ? |
| `Mat_man` | 163-189 | Public | 6 | 24 | 0 | portée réductible ? |
| `ToggleButton5_Click` | 195-200 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton6_Click` | 202-207 | Public | 1 | 4 | 0 | handler GUI |
| `Aff_Marques` | 209-248 | Public | 6 | 37 | 0 | portée réductible ? |
| `ColMarque_Click` | 250-264 | Public | 2 | 13 | 0 | handler GUI |
| `Btn_Click` | 266-282 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 284-291 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 293-370 | Public | 20 | 69 | 0 | handler GUI |
| `Cmpt_GotFocus` | 375-381 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 383-491 | Public | 35 | 106 | 0 | portée réductible ? |
| `Button1_Click` | 493-497 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et sélection

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers(Me)`, son,
  centrage ; plages par défaut `00000`–`ZZZZZ`, `41100001`–`41199999`,
  `AAAAAAAAAAAA`–`ZZZZZZZZZZZZ` ; focus sur `Mat`. `Origine` vaut `"EdMat"` à la déclaration.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `Origine` puis `SelectionMat`.
- **`SelectionMat()`** [portée : réductible] [nature : GUI]. `New TriMat(True, "", "mat_code",
  "EdMat")` modal ; `TriMat` écrit **directement** `EdMat.Bsel` et `EdMat.CodeMat` sur
  l'auto-instance (`TriMat.class:381-382`, `Case "EdMat"`) ; si `Bsel`, `Mat`/`Mat2` ← `CodeMat`.
  `Tab`, `sel`, `Tri` affectés sans utilité.
- **`ToggleButton3_Click()` / `ToggleButton4_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `Origine` puis `SelectionProp`.
- **`SelectionProp()`** [portée : réductible] [nature : GUI]. `TriCpt` client modal ; si `Bsel`,
  `Cli`/`Cli2` ← **`CClient`**. ⚠️ `TriCpt` renseigne `Bval` (`Object.SetProperty(…, "Bval")`),
  jamais `CClient` : le champ reçoit une chaîne vide (EDMAT-A01).
- **`Mat_man()`** [portée : réductible] [nature : mixte]. Cherche `Mat.Text` dans `TabMat` sur
  `mat_code`, `mat_cfour`, `mat_cbarre`, puis **`mat_refcentrale`, colonne absente** de
  `Fiches_Materiels` (`db_control.csv`) : un code introuvable par les 3 premières requêtes provoque
  une erreur SQL propagée par `DB_Connection.Exec` (`Error.Propagate`), sans `Catch` ici (EDMAT-A02).

### Marques

- **`ToggleButton5_Click()` / `ToggleButton6_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. `Origine` puis `Aff_Marques`.
- **`Aff_Marques()`** [portée : réductible] [nature : mixte]. Bascule `ColMarque` (position selon
  `Origine`) : `SELECT * FROM Fiches_Marques order by code` (en dur), colonnes code / intitulé.
- **`ColMarque_Click()`** [portée : nécessaire (handler, rejeu dynamique)] [nature : GUI].
  `Marque`/`Marque2` ← intitulé (`Item[1]`), focus suivant (`Type` pour la 2ᵉ marque).
- **`ColMarque_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée → clic, F1 aide,
  Échap/F2 fermeture.

### Navigation et boutons

- **`Btn_Click()`**, **`Btn_KeyPress()`** (impression pour toute touche), **`Cmpt_GotFocus()`**
  (`SetEditColor`), **`Button1_Click()`** (`Doc.Open("Edtar")`) [portée : nécessaire (handlers)]
  [nature : GUI].
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler)] [nature : mixte] (CC 20). Tags 1-2 →
  `Mat_man` (tag 2 contrôle `Mat.Text`), 3 à 6 → champ suivant, F1, F2 (listes 1 à 6). Les tags 7 et
  8 (`Type`, `Type2`) ne sont pas traités, et les boutons `ToggleButton7`/`ToggleButton8` du `.form`
  n'ont **aucun handler** (filtre par type non implémenté).

### Impression

- **`Button2_Click()`** [portée : réductible (`Button2` dans le groupe `btn`)] [nature : mixte]
  (CC 35). Si ni `Vendus` ni `Vendus2` : message « Votre demande n'est pas cohérente ». Sinon titre
  selon les cases (« vendus », « en stock », « tous »), `Cmat.Level1`, tri `$tri` selon
  `RadioButton1..4`, puis :
  - vendus seuls : `mat_code`, `mat_cli`, `mat_marque` dans les plages (pas de test de `mat_vendu`) ;
  - stock seul : `mat_cli IS NULL` et `mat_vendu = &7 OR mat_vendu = &8` (`Matstocke`,
    `Matstocke2` = `False`, `False`), plages matériel et marque ;
  - les deux : union des deux conditions précédentes (sans `mat_vendu`).
  Paramètres en trop passés à `Exec` (`&3`, `&4`, `&7`, `&8`, `$Tri` inutilisés selon le cas). Par
  matériel : `Cmat.Level2` (code, désignation 36 car., marque, type, série, propriétaire, PV HT, PV
  TTC), pas de 5 mm, saut à 283 mm avec le titre « Liste des marériels » (faute de frappe, titre
  différent de la 1ʳᵉ page). `Gpvcons`, `Nbpage`, `dte`, `fami`, `four3`, `tva`, `PosX` inutilisés.

## État global utilisé

- `Start.Musique`, `Start.Son`, `Start.Societe`, `Start.LocalSettings` (`/Soc<XX>/Pvcons`, lu sans
  usage).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.Find_nbdec`,
  `Cbase.Table("TabMat")`, `Visualiseur.Prog`, `Doc.Open`.
- `Bsel`, `Bval`, `CodeMat` : `Public`, écrits par `TriCpt` et `TriMat` (auto-instance).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les variables mortes (`Gpvcons`, `Nbpage`, `dte`, `fami`, `four3`, `tva`, `sel`, `Tri`,
  `Tab` dans `SelectionMat`, `PosX`), le `Shell "cd …"`, le `Case 1` inatteignable de `Btn_Click`.
- Les 3 requêtes de `Button2_Click` : une fonction `SelectMateriels(bVendus, bStock, tri)` qui
  garde **exactement** les mêmes textes SQL.

### Commonalisation avec d'autres fichiers

- `Mat_man` ≈ `art_man` d'`EdArt1` (même structure de 4 requêtes) : un helper paramétré
  `ChercheCode(table, colonnes[], code)` du socle `EdSelection`
  ([EdArt1/architecture.md](../EdArt1.class/architecture.md#commonalisation-avec-dautres-fichiers)),
  sous réserve de l'anomalie A02 (colonne inexistante).
- Liste des marques : même `ColMarque` dans [`Materiel`](../../Tables/Materiel.class/architecture.md)
  (`Aff_Marques`/`ColMarque_Click`).

### Réduction de portée

- `SelectionProp`, `SelectionMat`, `Mat_man`, `Aff_Marques`, `Button2_Click` : sans appelant
  externe → `Private`.
- `CClient` : jamais écrit hors de la classe (grep) → `Private` possible, mais la correction de
  l'anomalie A01 le remplace par `Bval` (à traiter ensemble).
- `CodeMat`, `Bsel`, `Bval` : **restent `Public`** (`TriMat.class:381-382`, `TriCpt`).

### Séparation traitement / GUI

- `Button2_Click` : `SelectMateriels` (SQL) + `LigneMateriel(r) As String[]` (formatage).
- `Mat_man` : recherche pure, message dans l'appelant.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `mat_marque` stocke l'intitulé de la marque et non son code : une clé vers `Fiches_Marques`
  rendrait les plages de marques fiables.
- Ajouter `mat_refcentrale` à `Fiches_Materiels` si la recherche par référence centrale est voulue.
