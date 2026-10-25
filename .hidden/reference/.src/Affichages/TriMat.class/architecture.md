# TriMat — Architecture

> Source : `.src/Affichages/TriMat.class`

## Vue d'ensemble

`TriMat` est la **fenêtre modale de sélection d'un matériel** (`Fiches_Materiels` : code,
désignation, propriétaire/numéro de série/marque/type, PV HT, PV TTC, quantité). La grille
`ColMat` est paginée manuellement sur `Utils.rs2`. Les en-têtes `CO` (code), `IT` (intitulé) et
`CB1` (`ComboBox` : Propriétaire, Numéro série, Marque, Type) servent de filtres et de sélecteurs
de tri ; trois boutons radio filtrent tous / vendus / en stock (`mat_vendu`).

### Signature et protocole de retour

```gambas
Public Sub _new(Barticle As Boolean, B2article As Boolean, $Tri As String, Org As String)
```

Seul appelant : `EdMat.SelectionMat` (`EdMat.class:136`) —
`New TriMat(True, "", Tri, "EdMat")` avec `Tri = "mat_code"`. `Barticle` et `B2article` sont
mémorisés et **jamais lus** (`""` converti en `False` pour `B2article`). Le tri initial `$Tri`
est aussitôt remplacé par `mat_design`, car `_new` finit par `It_GotFocus()`.

Retour : pour `Org = "EdMat"`, `ColMat_Click` écrit `EdMat.Bsel = True` et `EdMat.CodeMat =
<code>` sur l'**auto-instance** d'`EdMat` (correct : `EdMat` n'est ouvert que par `EdMat.Show()`
depuis `Fmenu:2254`). Aucune remise à zéro : `EdMat.Bsel` n'est jamais remis à `False`
(`EdMat` ne le fait pas non plus), donc après une première sélection, une annulation réapplique
l'ancien matériel (TRIMAT-A02). `EdMat.Bsel` et `EdMat.CodeMat` doivent rester `Public`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Mattable` | var | Private |  | New String[7] | 3 |
| `Dbl` | var | Private |  | Boolean | 4 |
| `sel` | var | Private |  | String | 5 |
| `Tri` | var | Private |  | String | 6 |
| `Bart` | var | Private |  | Boolean | 7 |
| `B2art` | var | Private |  | Boolean | 8 |
| `$Org` | var | Private |  | String | 9 |
| `NbEnreg` | var | Private |  | Integer | 10 |
| `lg` | var | Private |  | Integer | 11 |
| `chkfocus` | var | Private |  | Boolean | 12 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-33 | Public | 2 | 17 | 0 | méthode spéciale |
| `CO_click` | 35-37 | Public | 1 | 2 | 0 | handler GUI |
| `CO_DblClick` | 39-43 | Public | 1 | 3 | 0 | handler GUI |
| `CO_GotFocus` | 45-62 | Public | 2 | 15 | 0 | handler GUI |
| `CO_LostFocus` | 64-68 | Public | 2 | 3 | 0 | handler GUI |
| `CO_KeyPress` | 70-80 | Public | 5 | 9 | 0 | handler GUI |
| `Cb1_DblClick` | 86-90 | Public | 1 | 3 | 0 | handler GUI |
| `Cb1_GotFocus` | 92-110 | Public | 7 | 17 | 0 | handler GUI |
| `Cb1_LostFocus` | 112-116 | Public | 2 | 3 | 0 | handler GUI |
| `Cb1_KeyPress` | 118-127 | Public | 4 | 8 | 0 | handler GUI |
| `It_DblClick` | 129-133 | Public | 1 | 3 | 0 | handler GUI |
| `It_GotFocus` | 135-149 | Public | 2 | 13 | 0 | handler GUI |
| `It_LostFocus` | 151-155 | Public | 2 | 3 | 0 | handler GUI |
| `It_KeyPress` | 157-168 | Public | 7 | 10 | 0 | handler GUI |
| `mat_Dblclk` | 170-180 | Public | 2 | 9 | 0 | portée réductible ? |
| `ChkInput` | 182-191 | Public | 2 | 8 | 0 | portée réductible ? |
| `TriMat` | 193-208 | Public | 1 | 14 | 0 | portée réductible ? |
| `ColMat_Data` | 210-240 | Public | 5 | 28 | 0 | handler GUI |
| `Deb1` | 242-270 | Public | 8 | 26 | 0 | portée réductible ? |
| `Deb2` | 272-300 | Public | 8 | 26 | 0 | portée réductible ? |
| `ColMat_MouseWheel` | 302-315 | Public | 7 | 11 | 0 | handler GUI |
| `Remonter_Click` | 317-325 | Public | 5 | 7 | 0 | handler GUI |
| `Descendre_Click` | 327-335 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 337-345 | Public | 5 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 347-355 | Public | 5 | 7 | 0 | handler GUI |
| `Frame1_KeyPress` | 357-363 | Public | 3 | 5 | 0 | handler GUI |
| `Deplacement` | 365-374 | Public | 3 | 8 | 0 | portée réductible ? |
| `ColMat_Click` | 376-387 | Public | 2 | 8 | 0 | handler GUI |
| `ColMat_KeyPress` | 389-416 | Public | 11 | 24 | 0 | handler GUI |
| `RadioButton1_Click` | 418-424 | Public | 2 | 5 | 0 | handler GUI |
| `RadioButton2_Click` | 426-432 | Public | 2 | 5 | 0 | handler GUI |
| `RadioButton3_Click` | 434-440 | Public | 2 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et chargement

- **`_new(...)`** [portée : nécessaire (spéciale)] [nature : GUI] : `Utils.Observers(Me)`, `lg`,
  centrage, mémorisation, `TriMat()`, `Deb1()`, libellés d'en-tête, curseur, puis
  `It_GotFocus()` (tri `mat_design` et **seconde** requête).
- **`TriMat()`** [portée : réductible] [GUI] : 6 colonnes calées sur les en-têtes (alignements
  droite/centre). Méthode **homonyme de la classe**.
- **`Deb1()` / `Deb2()`** [portée : réductible] [mixte] : sélection du filtre `mat_vendu` selon
  les boutons radio (`""`, `"1"`, `"0"`), tri `lpad(mat_code,15,' ')` pour le code (traduit pour
  SQLite par `DB_Connection`), puis une des **quatre** requêtes `Utils.Base2(ColMat, "SELECT
  mat_code, … FROM <TabMat> where <tri> like "%<sel>%"|"<sel>%" [and mat_vendu like
  "%<selection>%"] order by <lpd> [desc] limit <NbEnreg>, <lg>")` : recherche « contient » pour
  la désignation, « commence par » pour les autres champs. Valeurs **concaténées**. `Deb2` est la
  copie de `Deb1` avec `desc` (8 textes SQL quasi identiques au total).
- **`ColMat_Data(Row, Column)`** [handler] [GUI] : colonne 2 = champ courant de `CB1` déduit de
  `Tri` (sinon `mat_cli`) ; lecture dans `Utils.rs2` ; `Mattable` (7 cases pour 6 colonnes) réécrit
  à chaque cellule par une cascade de `If` imbriqués.
- **`Deplacement()`** [portée : réductible] [GUI] : borne `NbEnreg` puis `Deb2`/`Deb1` selon `Dbl`.
- **`mat_Dblclk()`** [portée : réductible] [GUI] : bascule croissant/décroissant (`Dbl`), sans
  remettre la page à 0.
- **`ChkInput()`** [portée : réductible] [mixte] : refuse `"` et `&` (`Stop Event`), sinon
  `sel = Utils.Obstch(sel)` et `Deb1()` (en ordre **croissant**, même si `Dbl` est vrai).

### Sélection et pagination

- **`ColMat_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] :
  protocole ci-dessus puis fermeture.
- **`ColMat_KeyPress()`** [handler] [GUI] : Entrée = sélection ; Échap/F2 ferme ; **navigation
  inversée** : flèche haut en première ligne → page suivante, flèche bas en dernière ligne → page
  précédente, PageDown → page précédente, PageUp → page suivante (TRIMAT-A01).
- **`Remonter_KeyPress` / `Descendre_KeyPress`** [handlers] [GUI] : Échap/F2 ferme ; PageDown →
  `Remonter_Click`, PageUp → `Descendre_Click` (même inversion).
- **`Remonter_Click`** (condition `Rows.Count <= lg` toujours vraie), **`Descendre_Click`**,
  **`ColMat_MouseWheel`** [handlers] [GUI] : page précédente / suivante, curseur en première ligne.
- **`Frame1_KeyPress`** [handler] [GUI] : Échap/F2 ferme ; un `Frame` ne prend pas le focus
  (probablement jamais levé, à confirmer).
- **`RadioButton1_Click`, `RadioButton2_Click`, `RadioButton3_Click`** [handlers] [GUI] :
  `Deb1()` **sans remise à 0 de la page** (`NbEnreg` conservé : page vide possible après filtrage,
  TRIMAT-A03) ; corps identiques.

### En-têtes de filtre et de tri

- **`CO_GotFocus`** [handler] [GUI] : `ObsGotf`, sélection, `SetFocus` sur lui-même, filtre vidé,
  tri `mat_code`, page 0, `Deb1()` ; `chkfocus` encadre l'appel (protège `Cb1_GotFocus`).
- **`It_GotFocus`** [handler] [GUI] : idem pour `mat_design`.
- **`Cb1_GotFocus`** [handler] [GUI] : si `chkfocus`, tri selon le libellé courant de `CB1`
  (`mat_cli`, `mat_serie`, `mat_marque`, `mat_type`), page 0, `Deb1()`, puis **vide** le texte de
  `CB1` pour la saisie du filtre. `Cb1_Click` est commenté : choisir un autre libellé dans la liste
  ne change le tri qu'au prochain passage de focus.
- **`CO_KeyPress`, `Cb1_KeyPress`, `It_KeyPress`** [handlers] [GUI] : `ChkInput()` pour toute
  touche (une requête aussi pour les flèches et Échap), puis Échap/F2 ferme, flèche bas → grille,
  flèches gauche/droite → autre en-tête.
- **`CO_DblClick`, `Cb1_DblClick`, `It_DblClick`** [handlers] : `mat_Dblclk()`.
- **`CO_LostFocus`, `Cb1_LostFocus`, `It_LostFocus`** [handlers] : `Utils.ObsLstf`.
- **`CO_click()`** [handler vide] : `CO` est un `TextBox`, l'événement `Click` n'est pas levé.

## État global utilisé

- `Utils.rs2` (résultat partagé), `Utils.Base2`, `Utils.Observers`, `Utils.ObsGotf`/`ObsLstf`,
  `Utils.Obstch` ; `Cbase.Table("TabMat")`.
- Auto-instance `EdMat` (`Bsel`, `CodeMat`).
- Membres jamais lus : `Bart`, `B2art` ; `Dbl` (Boolean) reçoit `""` à plusieurs endroits.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb1`/`Deb2` → `Charge(bDesc)` construisant le texte une seule fois (8 textes → 1, SQL
  identique).
- `ColMat_Data` : `Mattable` initialisé une fois ; colonne 2 calculée par `ChampColonne2(Tri)`.
- `RadioButton1/2/3_Click` → `Filtre()` commune (handlers conservés).
- Supprimer `Bart`, `B2art` (paramètres conservés pour la signature) et les `Dbl = ""`.

### Commonalisation avec d'autres fichiers

- **Pagination** : identique (au sens près, A01) à [`Tricp`](../Tricp.class/architecture.md),
  [`TriEqu`](../TriEqu.class/architecture.md),
  [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md),
  [`TriclientsD`](../../Caisse/Affichages/TriclientsD.class/architecture.md) → `PaginationListe`
  (TRICARTES-005) ; le partage n'est possible tel quel qu'en conservant l'inversion des touches,
  ou après validation de TRIMAT-A01.
- **`ChkInput`** : même idiome que `Tricartes`, `TriclientsD`, `Tricp` (`Utils.Obstch`).
- **Protocole** : passer l'appelant et écrire par `Object.SetProperty` comme
  [`TriArticles`](../TriArticles.class/architecture.md) supprimerait la dépendance en dur à
  `EdMat` (changement de signature, un seul appelant).

### Réduction de portée

- `mat_Dblclk`, `ChkInput`, `TriMat`, `Deb1`, `Deb2`, `Deplacement` : aucun appelant externe
  (vérifié ; `TriMat` n'est cité ailleurs que comme classe) → `Private`.

### Séparation traitement / GUI

- `RequeteMateriels(sTri, sSel, sVendu, bDesc, iDebut, iNb) As String` pure (texte identique),
  appelée par `Charge` avec les valeurs des boutons radio.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `mat_vendu` est filtré par `like "%1%"` / `like "%0%"` : un booléen strict (`tinyint` 0/1)
  permettrait une égalité indexable.
- Le tri `lpad(mat_code,15,' ')` révèle un code numérique stocké en texte : une colonne numérique
  (ou un code normalisé) permettrait un tri indexé.
