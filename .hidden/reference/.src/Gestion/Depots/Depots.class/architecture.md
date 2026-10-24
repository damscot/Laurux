# Depots — Architecture

> Source : `.src/Gestion/Depots/Depots.class`

## Vue d'ensemble

Écran de la **table des dépôts de stock** (`Fiches_Depots` : `code` char(8) clé primaire,
`libelle` varchar(35), adresse `adr1`, `adr2`, `cp`, `ville` ; `Laurux01.sql` : `01` Magasin,
`02` Dépôt 1). Le dépôt `01` est le magasin, dont le stock est celui de la fiche article
(`Fiches_Art.art_qte`) ; les autres dépôts ont leur stock dans `Fiches_StkDepots` et leurs
mouvements dans `Fiches_Sdepots` (voir [MvtDepots](../MvtDepots.class/architecture.md),
[Sdepots](../Sdepots.class/architecture.md)). Ouvert par `Fmenu.class:2152` (`Depots.Show()`).
Les dépôts sont aussi lus par `Fcaisses`, `Famille`, `Articles`, `Facture`.

Copie du squelette « grille filtrable » de [Cpostaux](../../Tables/Cpostaux.class/architecture.md)
(similarité 0,59 ; 0,66 avec [Marques](../../Tables/Marques.class/architecture.md)) : grille
`Coldepot` sur `Utils.Base`/`Utils.rs1`, en-têtes filtres `CP` (code) et `BD` (libellé), zones du
groupe `Cpost` (1 code, 2 libellé, 3-4 adresse, 5 code postal `Cp2`, 6 ville), boutons **non
groupés** (`Button1` enregistrer, `Button3` supprimer, `Button2` quitter, `Button4` aide).

Nature : **GUI** avec SQL dans les handlers (`Cbase.Table` sauf pour la copie des articles).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `son` | var | Private |  | Integer | 29 |
| `CpTable` | var | Private |  | New String[3] | 30 |
| `Tri` | var | Private |  | String | 31 |
| `sel` | var | Private |  | String | 32 |
| `Dbl` | var | Private |  | String | 33 |
<!-- /AUTO:declarations -->

Remarque : `Tab`, `son`, `CpTable`, `Tri`, `sel`, `Dbl` (lignes 28-33, sans mot-clé, donc
`Private`) ne figurent pas dans le tableau généré ; `Tab` est affecté mais jamais lu.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-46 | Public | 1 | 9 | 0 | méthode spéciale |
| `Form_Open` | 48-56 | Public | 1 | 7 | 0 | handler GUI |
| `Coldepot_Data` | 58-67 | Public | 3 | 8 | 0 | handler GUI |
| `Tris` | 69-77 | Public | 1 | 7 | 0 | portée réductible ? |
| `Deb2` | 79-83 | Public | 1 | 3 | 0 | portée réductible ? |
| `Deb3` | 85-89 | Public | 1 | 3 | 0 | portée réductible ? |
| `Refresh` | 91-96 | Public | 1 | 4 | 0 | portée réductible ? |
| `Maj_Zones` | 98-115 | Public | 2 | 15 | 0 | portée réductible ? |
| `Cleanchamps` | 117-126 | Public | 1 | 8 | 0 | portée réductible ? |
| `Cpost_GotFocus` | 128-132 | Public | 1 | 3 | 0 | handler GUI |
| `Cpost_KeyPress` | 134-183 | Public | 13 | 40 | 0 | handler GUI |
| `Btn_KeyPress` | 185-194 | Public | 2 | 6 | 0 | portée réductible ? |
| `Code_GotFocus` | 196-200 | Public | 1 | 3 | 0 | portée réductible ? |
| `Libelle_GotFocus` | 202-206 | Public | 1 | 3 | 0 | portée réductible ? |
| `Code_LostFocus` | 208-212 | Public | 1 | 2 | 0 | portée réductible ? |
| `button1_KeyPress` | 214-218 | Public | 3 | 3 | 0 | handler GUI |
| `Button1_Click` | 220-249 | Public | 6 | 27 | 0 | handler GUI |
| `Button3_Click` | 251-273 | Public | 7 | 21 | 0 | handler GUI |
| `Cpman` | 275-285 | Public | 2 | 8 | 0 | portée réductible ? |
| `ChkCp` | 287-295 | Public | 7 | 7 | 0 | portée réductible ? |
| `CP_GotFocus` | 297-306 | Public | 1 | 8 | 0 | handler GUI |
| `CP_Dblclick` | 308-317 | Public | 1 | 8 | 0 | handler GUI |
| `CP_KeyPress` | 319-331 | Public | 4 | 11 | 0 | handler GUI |
| `BD_GotFocus` | 333-342 | Public | 1 | 8 | 0 | handler GUI |
| `BD_DblClick` | 344-353 | Public | 1 | 8 | 0 | handler GUI |
| `BD_KeyPress` | 355-367 | Public | 4 | 11 | 0 | handler GUI |
| `Ref` | 369-376 | Public | 1 | 6 | 0 | portée réductible ? |
| `Dbclk` | 378-388 | Public | 2 | 9 | 0 | portée réductible ? |
| `Coldepot_Click` | 390-397 | Public | 1 | 6 | 0 | handler GUI |
| `Button2_Click` | 399-403 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 405-409 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste filtrable

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers`, `Music.Load`, en-têtes,
  `Code_Gotfocus()`, focus.
- **`Form_Open()`** [handler] [nature : mixte] : `Tri = "cp"` (sans effet), `Tris`,
  `Utils.Base(Coldepot, "select * from <TabDepots> order by code")`.
- **`Coldepot_Data(Row, Column)`** [handler] : affichage depuis `Utils.rs1`.
- **`Tris()`** [portée : réductible] : 2 colonnes.
- **`Deb2()` / `Deb3()`** [portée : réductible] [nature : mixte] : filtre `like "<sel>%"` concaténé,
  tri croissant/décroissant.
- **`CP_GotFocus()`, `CP_Dblclick()`, `CP_KeyPress()`, `BD_GotFocus()`, `BD_DblClick()`,
  `BD_KeyPress()`** [handlers] : filtre et tri par en-têtes (voir Cpostaux).
- **`Ref()`**, **`Dbclk()`** [portée : réductible] : réinitialisation et bascule du tri.
- **`Refresh()`** [portée : réductible] : `Form_Open` puis `Cleanchamps`.
- **`Coldepot_Click()`** [handler] : `CleanChamps`, `Maj_Zones`, en-têtes rétablis. Rejoué par
  `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : relit le dépôt de la ligne courante
  (`SELECT … WHERE code = &1`) et remplit les 6 zones ; `Catch` muet.
- **`Cleanchamps()`** [portée : réductible] : vide les zones, mais `cp.Clear` (ligne 123) vide
  l'**en-tête filtre `CP`** (Gambas est insensible à la casse) au lieu de la zone `Cp2` du code
  postal (anomalie A03).

### Saisie

- **`Cpost_GotFocus()`** [handler du groupe `Cpost`] : `Utils.SetEditColor`.
- **`Cpost_KeyPress()`** [handler du groupe `Cpost`] (CC 13, max du fichier) : navigation entre les
  6 zones (code → `Code_LostFocus`, vide), `ChkCp` (chiffres seulement) sur le code, F1 → aide.
- **`Code_GotFocus()`, `Libelle_GotFocus()`** [portée : réductible] : fond vert ; pseudo-handlers
  (contrôles groupés `Cpost`) ; `Libelle_GotFocus` n'est appelé que par `Cpman`, lui-même mort.
- **`Code_LostFocus()`** [portée : réductible] : pseudo-handler **vide** (`Cpman` commenté).
- **`Cpman()`** [portée : réductible] : relecture du libellé ; **jamais appelée** (`unused`, code mort).
- **`ChkCp()`** [portée : réductible] : filtre numérique.
- **`Btn_KeyPress()`** [portée : réductible] : handler d'un groupe `Btn` **absent** du `.form` :
  jamais levé, **code mort** (`unused`).

### Enregistrement et suppression

- **`button1_KeyPress()`** [handler] : Entrée/Retour sur Enregistrer → `Button1_Click`.
- **`Button1_Click()`** [handler] [nature : mixte] : `SELECT`, puis `UPdate … SET code = &1, …
  WHERE code = &1` ou `INSERT` ; pour un **nouveau** dépôt, question « copier les produits du
  dépôt 01 » : en réalité, **un `INSERT` par article** de `Fiches_Art` (tous les articles, stockés
  ou non) dans `Fiches_StkDepots` avec une quantité 0 (table nommée en dur), puis
  `Message.Info`. `Refresh`.
- **`Button3_Click()`** [handler] [nature : mixte] : refuse si la **ligne sélectionnée** commence
  par `01` ; deux confirmations ; supprime le dépôt, son stock (`<TabStkDepots>`, `coded`) et ses
  mouvements (`<TabSdepots>`, `code`) de la ligne sélectionnée (pas du code saisi), sans
  transaction ; `Me.Visible = True` sans effet ; `Catch` muet.
- **`Button2_Click()`** [handler] : ferme. **`Button4_Click()`** [handler] : `Doc.Open("Depots")`.

## État global utilisé

- `Utils.db`, `Utils.Base`, **`Utils.rs1`**, `Utils.Observers`, `Utils.SetEditColor`,
  `Utils.ObsGotf` ; `Cbase.Table` (`TabDepots`, `TabStkDepots`, `TabSdepots`) ; `Start.Son`,
  `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Cpman`, `Btn_KeyPress`, `Libelle_GotFocus`, `Code_LostFocus` (et son appel),
  `Tab`, `Tri = "cp"`, `Me.Visible = True`.
- Initialisation du stock d'un nouveau dépôt en une requête
  `INSERT INTO <TabStkDepots> (coded, codea, qte) SELECT &1, art_code, 0 FROM <TabArt>` (SQL
  modifié, dump identique), avec `Cbase.Table`.
- `UPdate` sans réécriture de la clé.

### Commonalisation avec d'autres fichiers

- Socle « grille filtrable » avec [Cpostaux](../../Tables/Cpostaux.class/architecture.md) et
  [Marques](../../Tables/Marques.class/architecture.md) (164 et 169 lignes communes).
- Liste et relecture des dépôts (`aff_Depot`, `Cman`) dupliquées dans
  [MvtDepots](../MvtDepots.class/architecture.md), [Sdepots](../Sdepots.class/architecture.md),
  [ImpDepots](../ImpDepots.class/architecture.md), `Fcaisses`, `Famille` → module `Depot`
  (`Liste(bSauf01)`, `Libelle(sCode)`).

### Réduction de portée

`Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`, `Cleanchamps`, `Code_GotFocus`, `Libelle_GotFocus`,
`Code_LostFocus`, `ChkCp`, `Ref`, `Dbclk` → `Private` ; `Cpman`, `Btn_KeyPress` supprimés.

### Séparation traitement / GUI

`EnregistreDepot(...)`, `InitStockDepot(sCode)`, `SupprimeDepot(sCode)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Sdepots.code` char(2) alors que `Fiches_Depots.code` est char(8) et la saisie accepte
  5 caractères : un code de dépôt de plus de 2 caractères est tronqué dans l'historique.
- `libelle` varchar(35) pour une saisie de 50 caractères.
- Clés étrangères `Fiches_StkDepots.coded` et `Fiches_Sdepots.code` → `Fiches_Depots.code` (cascade).
