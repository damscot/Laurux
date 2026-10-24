# Cpostaux — Architecture

> Source : `.src/Gestion/Tables/Cpostaux.class`

## Vue d'ensemble

Écran de la **table des codes postaux** (`Fiches_Cpostaux` : `lind` auto-incrémenté clé primaire,
`cp` char(5), `burdist` char(35) bureau distributeur ; table vide dans `Laurux01.sql`, alimentée
par `Impcpostaux` et par `Enrgcp.Ecp` lors de la saisie des tiers). Ouvert par
`Fmenu.class:1739` (`Cpostaux.Show()`). La table est lue par `FClient`, `FFournisseur`, `Facture`,
`Fsoc`, `FClientcarte`, `Tricp` et `Dup`.

Squelette **« grille filtrable »** partagé avec [Marques](../Marques.class/architecture.md)
(similarité 0,70) et [Depots](../../Depots/Depots.class/architecture.md) (0,59) :
- une `GridView` `Colcpost` alimentée par `Utils.Base` (résultat global `Utils.rs1`) et
  `Colcpost_Data` (affichage paresseux) ;
- deux `TextBox` d'en-tête `CP` et `BD` servant de **filtres** : chaque frappe complète la
  variable `sel` et relance `Deb2` (`… where <Tri> like "<sel>%" order by <Tri>`) ; le double-clic
  inverse le tri (`Dbclk` → `Deb3`, `Desc`) ;
- zones de saisie `Cpostal` (5 chiffres) et `Burdist` (50 caractères pour une colonne de 35) du
  groupe `Cpost` ; boutons du groupe `Btn` (1 supprimer = `Button3`, 2 enregistrer = `Button1`,
  3 quitter = `Button2`), aide `Button4` ;
- une `ColumnView` `Colcp` (masquée) pour choisir parmi plusieurs bureaux d'un même code.

Cet idiome `Deb2`/`Deb3`/`Dbclk`/`Ref` est présent dans une trentaine d'écrans (`Tricp`,
`TriBl`, `TriFac`, `FClient`, `Materiel`, `Movr`…).

Nature : **GUI** avec SQL dans les handlers ; table nommée en dur (`Fiches_Cpostaux`) alors que
`Cbase.Table("TabCpostaux")` existe.

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

Remarque : les variables de module `Tab`, `son`, `CpTable`, `Tri`, `sel`, `Dbl` (lignes 28-33,
déclarées sans mot-clé, donc `Private`) ne figurent pas dans le tableau généré.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-46 | Public | 1 | 9 | 0 | méthode spéciale |
| `cpoint` | 48-52 | Public | 1 | 3 | 0 | portée réductible ? |
| `Form_Open` | 54-64 | Public | 1 | 8 | 0 | handler GUI |
| `Colcpost_Data` | 66-76 | Public | 3 | 9 | 0 | handler GUI |
| `Tris` | 78-88 | Public | 1 | 9 | 0 | portée réductible ? |
| `Deb2` | 90-95 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 97-102 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 104-110 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Zones` | 112-122 | Public | 2 | 9 | 0 | portée réductible ? |
| `Cleanchamps` | 124-129 | Public | 1 | 4 | 0 | portée réductible ? |
| `Cpost_GotFocus` | 131-135 | Public | 1 | 3 | 0 | handler GUI |
| `Cpost_KeyPress` | 137-167 | Public | 8 | 26 | 0 | handler GUI |
| `Btn_KeyPress` | 169-178 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 180-195 | Public | 4 | 10 | 0 | handler GUI |
| `Cpostal_GotFocus` | 197-201 | Public | 1 | 3 | 0 | portée réductible ? |
| `Burdist_GotFocus` | 203-207 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpostal_LostFocus` | 209-213 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_Click` | 215-235 | Public | 3 | 18 | 0 | portée réductible ? |
| `Button3_Click` | 237-252 | Public | 4 | 13 | 0 | portée réductible ? |
| `Cpman` | 254-273 | Public | 3 | 17 | 0 | portée réductible ? |
| `aff_cp` | 275-295 | Public | 3 | 18 | 0 | portée réductible ? |
| `ChkCp` | 297-305 | Public | 7 | 7 | 0 | portée réductible ? |
| `CP_GotFocus` | 307-316 | Public | 1 | 8 | 0 | handler GUI |
| `CP_Dblclick` | 318-327 | Public | 1 | 8 | 0 | handler GUI |
| `CP_KeyPress` | 329-341 | Public | 4 | 11 | 0 | handler GUI |
| `BD_GotFocus` | 343-352 | Public | 1 | 8 | 0 | handler GUI |
| `BD_DblClick` | 354-363 | Public | 1 | 8 | 0 | handler GUI |
| `BD_KeyPress` | 365-377 | Public | 4 | 11 | 0 | handler GUI |
| `Ref` | 379-386 | Public | 1 | 6 | 0 | portée réductible ? |
| `Dbclk` | 388-398 | Public | 2 | 9 | 0 | portée réductible ? |
| `Colcpost_Click` | 400-407 | Public | 1 | 6 | 0 | handler GUI |
| `Button4_Click` | 409-413 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 415-420 | Public | 1 | 4 | 0 | handler GUI |
| `Colcp_Click` | 422-430 | Public | 1 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste filtrable

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers`, `Music.Load`, libellés
  d'en-tête, `Cpostal_Gotfocus()`, focus code.
- **`Form_Open()`** [handler] [nature : mixte] : `Tab`, `Tri = "cp"`, `Tris`, `Deb2`.
- **`Colcpost_Data(Row, Column)`** [handler] [nature : GUI] : se positionne sur `Utils.rs1` et
  affiche la colonne `cp`/`burdist`/`lind` ; `CpTable` est réaffecté à chaque cellule.
- **`Tris()`** [portée : réductible] : 4 colonnes (la 3e, `lind`, en largeur 1).
- **`Deb2()` / `Deb3()`** [portée : réductible] [nature : mixte] : `Utils.Base(Colcpost, …)` avec
  `Tri` et `sel` **concaténés** entre guillemets doubles (un `"` tapé dans le filtre casse la
  requête) ; ordre croissant ou décroissant.
- **`CP_GotFocus()`, `BD_GotFocus()`** [handlers] : réinitialisent `sel`, `Ref`, choisissent la
  colonne de tri, `Deb2`.
- **`CP_Dblclick()`, `BD_DblClick()`** [handlers] : idem puis `Dbclk` (bascule du sens).
- **`CP_KeyPress()`, `BD_KeyPress()`** [handlers] : ajoutent `Key.Text` à `sel` (ou retirent un
  caractère sur Retour arrière) et relancent `Deb2`.
- **`Ref()`** [portée : réductible] : `Tab`, `Tri = "cp"`, `CleanChamps`, `Tris`.
- **`Dbclk()`** [portée : réductible] : alterne `Deb3`/`Deb2` selon `Dbl`.
- **`Refresh()`** [portée : réductible] : `Form_Open` (le filtre `sel` en cours est conservé) et
  vide les zones.
- **`Colcpost_Click()`** [handler] : `CleanChamps`, `Maj_Zones`, en-têtes rétablis. Rejoué par
  `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`Maj_Zones()`** [portée : réductible] : ligne courante de la grille → zones ; `Catch` muet.
- **`Cleanchamps()`** [portée : réductible] : vide les zones.

### Saisie

- **`Cpost_GotFocus()`** [handler du groupe `Cpost`] : `Utils.SetEditColor`.
- **`Cpost_KeyPress()`** [handler du groupe `Cpost`] : Entrée/Tab sur le code → `Cpostal_LostFocus`
  (recherche), focus bureau ; sur le bureau → retour au code ; autre touche sur le code → `ChkCp`
  (chiffres seulement) ; F1 → aide.
- **`Cpostal_GotFocus()`, `Burdist_GotFocus()`** [portée : réductible] : fond vert `&HAAFF7F&`.
  **Pseudo-handlers** : `Cpostal`/`Burdist` étant dans le groupe `Cpost`, Gambas ne les lève
  jamais ; ils ne sont appelés que par le code.
- **`Cpostal_LostFocus()`** [portée : réductible] : pseudo-handler, appelle `Cpman` (la recherche
  n'a donc lieu qu'au clavier, pas lors d'une perte de focus à la souris).
- **`Cpman()`** [portée : réductible] [nature : mixte] : `SELECT … where cp = &1` ; 1 résultat →
  bureau recopié ; plusieurs → `aff_cp` ; aucun → bureau vidé.
- **`aff_cp()`** [portée : réductible] [nature : mixte] : affiche `Colcp` et `Button5`, liste les
  bureaux du code (`order by cp, burdist`).
- **`Colcp_Click()`** [handler] : recopie l'élément choisi (`Colcp.Item`) et masque la liste.
  Rejoué par `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.
- **`Button5_Click()`** [handler] : masque la liste `Colcp`.
- **`ChkCp()`** [portée : réductible] : bloque toute touche non numérique (hors Retour arrière,
  Tab, Suppr, Entrée).

### Enregistrement et suppression

- **`Btn_Click()`** [handler du groupe `Btn`] : 1 `Button3_Click`, 2 `Button1_Click`, 3 fermeture.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : toute touche sur Enregistrer enregistre.
- **`Button1_Click()`** [portée : réductible] [nature : mixte] — enregistrement :
  `SELECT … WHERE cp = &1 and burdist = &2` ; si le couple existe,
  `UPdate … SET cp = &1, burdist = &2 WHERE cp = &2` : le `WHERE` compare **le code postal au
  bureau** (ligne 225), l'UPDATE ne touche donc rien ; sinon `INSERT`. Effet réel : « insérer le
  couple s'il n'existe pas », identique à `Enrgcp.Ecp`. Modifier le bureau d'un code crée une
  nouvelle ligne et laisse l'ancienne. Pseudo-handler.
- **`Button3_Click()`** [portée : réductible] [nature : mixte] — suppression : son, confirmation,
  `DELETE … WHERE lind = &1` avec le `lind` de la **ligne sélectionnée** de la grille (et non du
  code saisi). Pseudo-handler.
- **`Button4_Click()`** [handler] : `Doc.Open("Cpostaux")`.

### Code mort

- **`cpoint(mtt)`** [portée : réductible] : copie locale de `Utils.cpoint` (sans gestion de `Null`
  ni `LTrim$`), **jamais appelée** (`unused`).

## État global utilisé

- `Utils.db`, **`Utils.rs1`** (résultat partagé, écrit par `Utils.Base`, lu par `Colcpost_Data`),
  `Utils.Base`, `Utils.Observers`, `Utils.SetEditColor` ; `Start.Son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `cpoint` et l'UPDATE inopérant (remplacé par l'appel de `Enrgcp.Ecp`, même SQL utile ;
  SQL modifié : un UPDATE sans effet en moins, dump identique).
- `Cbase.Table("TabCpostaux")` ; `CpTable` initialisé une fois (dans `_New`).

### Commonalisation avec d'autres fichiers

- **Socle « grille filtrable »** avec [Marques](../Marques.class/architecture.md) (183 lignes
  communes sur 286/240) et [Depots](../../Depots/Depots.class/architecture.md) (164 lignes
  communes) : `Tris`, `Deb2`/`Deb3`, `Dbclk`, `Ref`, `CP_*`/`BD_*`, `ChkCp`, `Colxxx_Data`. Une
  classe utilitaire `FiltreGrille` (grille, table, colonnes, colonne de tri) porterait `sel`, `Tri`,
  `Dbl` et les requêtes ; les handlers des formulaires deviennent des appels d'une ligne. Même
  idiome dans `Tricp` (sur la même table, avec pagination), `Materiel`, `Movr`, `FClient`…
- `ChkCp` : filtre « chiffres seulement » dupliqué (Marques, Depots, Facture, FClient…) → helper
  commun `Utils.ToucheNumerique()`.
- `cpoint` : 6 copies locales recensées dans le projet (voir notes transverses) → `Utils.cpoint`.
- `Button1_Click` = [Enrgcp.Ecp](../../../Utils/Enrgcp.module/architecture.md).

### Réduction de portée

`cpoint` (supprimée), `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`, `Cleanchamps`,
`Cpostal_GotFocus`, `Burdist_GotFocus`, `Cpostal_LostFocus`, `Button1_Click`, `Button3_Click`,
`Cpman`, `aff_cp`, `ChkCp`, `Ref`, `Dbclk` → `Private` (aucun appelant externe).

### Séparation traitement / GUI

`EnregistreCp(sCp, sBureau)` (= `Enrgcp.Ecp`), `SupprimeCp(iLind)`, `BureauxDuCp(sCp) As Result`
sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique `(cp, burdist)` et index sur `burdist` (filtre `like`).
- `burdist` char(35) alors que la saisie accepte 50 caractères.
