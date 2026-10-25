# TriArticles — Architecture

> Source : `.src/Affichages/TriArticles.class`

## Vue d'ensemble

`TriArticles` est la **fenêtre modale de sélection d'un article** (ou d'une main d'œuvre) utilisée
par 29 écrans (31 appels). Elle héberge une liste [`TriGen`](../TriGen.class/architecture.md)
dans `Panel2` et ajoute au-dessus un bandeau de **filtres métier** (`Panel1`) :

- `CB2` (liste « Fournisseur / Famille / Centrale ») + bouton `Button1` qui ouvre la liste de
  choix `Colist` (`ColumnView`) des fournisseurs, familles ou centrales ; le code choisi est
  recopié dans `CB2` et le nom dans `Fnom` ;
- `CB1` : choix de la 3ᵉ colonne affichée (code équivalent, code-barres, CN8, casier,
  caractéristique, fournisseur) ;
- cases `Disponible` (stock positif) et `Materiel` (articles matériels, visible si l'option
  société `/Soc<XX>/Materiel` est active).

### Signature et interprétation des appels à 9 arguments

```gambas
Public Sub _new(Barticle As Boolean, Bstocke As Boolean, TriArticle As String, Selection As String,
                Option As String, Optional Dispo As Boolean = False, Optional Mat As Boolean = False,
                Optional ob As Object = Null)
```

`TriArticles` est un `Form` : Gambas consomme d'abord les **5 paramètres obligatoires**, puis le
**`Parent`** du `Form`, puis les **optionnels**. L'appel type
`New TriArticles(True, False, "art_code", "", "", Null, False, False, Me)` se lit donc :

| Rang | Argument | Paramètre | Rôle |
|---|---|---|---|
| 1 | `True` | `Barticle` | mémorisé dans `Bart`, **jamais lu** |
| 2 | `False` | `Bstocke` | filtre `art_stocke = 1` (et `art_qte > 0` avec `Disponible`) |
| 3 | `"art_code"` | `TriArticle` | `"art_code"` (articles) ou `"mo_code"` (main d'œuvre, `Prodcomposes`) ; autre valeur → `Error.Raise("Unsupported Feature")` |
| 4 | `""` | `Selection` | code initial du filtre `CB2` |
| 5 | `""` | `Option` | `"Fournisseur"`, `"Famille"`, `"Centrale"` ou `""` (pas de filtre) |
| 6 | `Null` | `Parent` du `Form` | fenêtre de premier niveau |
| 7 | `False` | `Dispo` | état initial de `Disponible` |
| 8 | `False` | `Mat` | état initial de `Materiel` (si l'option société est active) |
| 9 | `Me` | `ob` | écran appelant qui reçoit `Bsel`/`Bval` |

Variantes réelles : `Calcstock` (`Bstocke = True`, `Option = "Fournisseur"`), `Changefam`
(`"Famille"`), `Changefour` et `Facture` (`"Fournisseur"`), `Achat` (`$fournisseur`, option
variable), `Materiel` (`Dispo = Radiobutton2.Value`, `Mat = True`), `Prodcomposes:673`
(`"mo_code"`), `Facture:4432` (`Bart.Value`, `B2art.Value`, `Tri` : le 1ᵉʳ est ignoré, le 3ᵉ vaut
`"art_code"`, affecté juste avant à la ligne 4431).

### Protocole de retour

1. `_new` remet `Bsel = False` et `Bval = Null` **chez l'appelant** `ob` (`Object.SetProperty`,
   lignes 30-31) ; c'est le comportement attendu, absent de `TriCpt` (TRICPT-A01).
2. `TriGen` est créé avec `ob = Me` : il écrit `Bsel`/`Bval` sur **`TriArticles`** (membres
   `Public` de la classe), puis lève `ColTri_MajSel(val)`.
3. `ColTri_MajSel` recopie `Bsel = True` et `Bval = val` chez l'appelant si `Bsel` est vrai et
   `val` non vide ; sinon `Stop Event`. Dans tous les cas `Me.Close()`.

`Bsel`/`Bval` de `TriArticles` doivent rester `Public` (écrits par `TriGen`), comme ceux des 29
appelants. Valeur transmise : le **code article** (colonne 0 de la grille), ou le code MO.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Dbl` | var | Private |  | Boolean | 3 |
| `sel` | var | Private |  | String | 4 |
| `Tri2Art` | var | Private |  | String | 5 |
| `Bart` | var | Private |  | Boolean | 6 |
| `BStock` | var | Private |  | Boolean | 7 |
| `Org` | var | Private |  | String | 8 |
| `NbEnreg` | var | Private |  | Integer | 9 |
| `lg` | var | Private |  | Integer | 10 |
| `chkfocus` | var | Private |  | Boolean | 11 |
| `Coul` | var | Private |  | LCoul | 12 |
| `tr` | var | Private |  | TriGen | 15 |
| `Col` | var | Private |  | Collection | 16 |
| `CB1Conv` | var | Private |  | Collection | 17 |
| `Obj` | var | Private |  | Object | 18 |
| `Bsel` | var | Public |  | Boolean | 19 |
| `Bval` | var | Public |  | String | 20 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 24-81 | Public | 6 | 52 | 0 | méthode spéciale |
| `form_Close` | 83-87 | Public | 1 | 3 | 0 | handler GUI |
| `Update_Req` | 89-158 | Public | 5 | 63 | 0 | portée réductible ? |
| `ColTri_MajSel` | 160-177 | Public | 4 | 15 | 0 | handler GUI |
| `ColTri_ReDim` | 179-183 | Public | 1 | 3 | 0 | handler GUI |
| `ChkInput` | 185-193 | Public | 2 | 7 | 0 | portée réductible ? |
| `TriArticles_KeyPress` | 195-201 | Public | 3 | 5 | 0 | portée réductible ? |
| `_KeyPress` | 203-209 | Public | 3 | 5 | 0 | portée réductible ? |
| `Panel1_KeyPress` | 211-217 | Public | 3 | 5 | 0 | handler GUI |
| `Panel2_KeyPress` | 219-225 | Public | 3 | 5 | 0 | handler GUI |
| `FourMan` | 230-241 | Public | 2 | 9 | 0 | portée réductible ? |
| `Button1_Click` | 243-325 | Public | 13 | 80 | 0 | handler GUI |
| `Colist_Click` | 330-339 | Public | 1 | 8 | 0 | handler GUI |
| `Colist_KeyPress` | 344-356 | Public | 5 | 10 | 0 | handler GUI |
| `CB2_KeyPress` | 358-362 | Public | 3 | 3 | 0 | handler GUI |
| `CB2_GotFocus` | 364-368 | Public | 2 | 3 | 0 | handler GUI |
| `CB2_LostFocus` | 370-379 | Public | 1 | 7 | 0 | handler GUI |
| `CB1_Click` | 381-385 | Public | 1 | 3 | 0 | handler GUI |
| `CB2_Click` | 387-394 | Public | 1 | 6 | 0 | handler GUI |
| `Filter_Calc` | 396-448 | Public | 16 | 47 | 0 | portée réductible ? |
| `Materiel_Click` | 451-456 | Public | 1 | 4 | 0 | handler GUI |
| `Disponible_Click` | 458-463 | Public | 1 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et liste

- **`_new(...)`** [portée : nécessaire (spéciale)] [nature : GUI] : `Utils.Observers(Me)` (avant
  la création des contrôles de `TriGen`, qui ne sont donc pas instrumentés), centrage, remise à
  zéro de `Bsel`/`Bval` chez `ob`, initialisation de `CB2`/`Org` selon `Option`, mémorisation des
  paramètres, visibilité de `Materiel`, remplissage de `CB1` et de sa table de conversion
  `CB1Conv` (libellé → champ), `Coul = New LCoul`, puis `Update_Req()`. Le nom du fournisseur
  (`Fnom`) **n'est pas rempli** quand `Selection` est fourni (`FourMan`, qui le ferait, n'est
  jamais appelée).
- **`Update_Req()`** [portée : réductible] [nature : mixte] : construit la `Collection` d'`ObjProp`
  et (re)crée le `TriGen` dans `Panel2` :
  - `art_code` : `select *, <Coul.Art_DB_bgcolor()> from <TabArt>` — **la table entière est lue**
    une première fois, uniquement pour obtenir `Res.Fields` ; colonnes code, intitulé (tri
    initial), champ choisi dans `CB1`, famille, PV HT, PV TTC, quantité (3 décimales) ;
  - `mo_code` : `select * from <TabMo>` ; colonnes code, intitulé, famille, PV HT, PV TTC ; `CB1`
    désactivé ;
  - autre : `Error.Raise("Unsupported Feature")`.
  Puis `New TriGen(Panel2, Col, Res, Req, 20, Me) As "ColTri"` et `Filter_Calc()`.
  Chaque ouverture émet donc : la requête complète, la requête paginée de `TriGen._ready`, puis
  celle de `ExtraSel` (3 requêtes). `Return` silencieux si la table est vide (fenêtre vide).
- **`Filter_Calc()`** [portée : réductible] [nature : mixte] : construit le filtre imposé
  (`art_four`, `art_fam` ou `art_centrale = "<CB2.Text>"` **concaténé**, `art_stocke = 1`,
  disponibilité, `art_mat = 1`) et le passe à `tr.ExtraSel(filtre, "and"|"")`. Pour `mo_code`,
  le filtre est toujours vide. `Org` invalide est remis à `""`.

### Événements de la liste `TriGen`

- **`ColTri_MajSel(val)`** [handler d'événement `TriGen`] [GUI] : protocole ci-dessus. Le
  `Stop Event` n'empêche pas `Me.Close()` (exécuté dans tous les cas).
- **`ColTri_ReDim(w)`** [handler] [GUI] : largeur de la fenêtre = largeur de la liste.
- **`form_Close()`** [handler] [GUI] : trace `Utils.Log` (niveau Debug) de `Bsel`/`Bval`.

### Filtres métier

- **`Button1_Click()`** [handler] [mixte] (CC 13) : bascule l'affichage de `Colist` et la remplit
  selon `Org` avec `SELECT * FROM <TabFour>` (`fo_code`, `fo_nom`), `<TabFam>` (`code_fam`,
  `libell_fam`) ou `<TabCentrales>` (`code`, `libelle`) ; trois blocs identiques à la table et
  aux champs près ; idiome `Do … Loop Until MoveNext()` (le dépôt utilise `Repeat … Until`).
- **`Colist_Click()`** [handler, rejoué par `Object.Call` : doit rester `Public`] [GUI] : recopie
  code et nom, masque la liste, `Filter_Calc()` puis `tr.Update()` — `ExtraSel` ayant déjà fait
  `Update`, la requête est émise **deux fois**.
- **`Colist_KeyPress()`** [handler] [GUI] : Entrée = `Colist_Click` ; Échap/F2 masque la liste.
- **`CB2_Click()`** [handler] [GUI] : choix du type de filtre (`Org = CB2.Text`) puis
  `Button1_Click()` (ouverture de la liste correspondante).
- **`CB2_KeyPress`** (Échap/F2 ferme), **`CB2_GotFocus`** (`Utils.ObsGotf`),
  **`CB2_LostFocus`** (couleur de fond `/Coul/Znss`) [handlers] [GUI].
- **`CB1_Click()`** [handler] [GUI] : `Update_Req()` — reconstruit **toute** la liste (filtres
  saisis perdus, 3 requêtes).
- **`Materiel_Click` / `Disponible_Click`** [handlers] [GUI] : `Filter_Calc()` puis `tr.Update()`
  (requête en double, comme `Colist_Click`).
- **`Panel1_KeyPress` / `Panel2_KeyPress`** [handlers] [GUI] : Échap/F2 ferme. Un `Panel` ne
  prend pas le focus : ces handlers ne sont probablement jamais levés (à confirmer).

### Code mort (signal `unused`, vérifié par grep)

- **`ChkInput()`** : saisie de filtre à l'ancienne (`Utils.Obstch`), remplacée par les `TextReg`
  de `TriGen` ; seule utilisatrice de `sel`.
- **`TriArticles_KeyPress()`** et **`_KeyPress()`** : noms qui ne correspondent à aucun
  événement levé (les événements du formulaire sont levés sous le nom `Form`).
- **`FourMan()`** : lecture du nom du fournisseur `CB2.Text` (`SELECT fo_nom FROM <TabFour> WHERE
  fo_code = &1`) ; jamais appelée (d'où `Fnom` vide à l'ouverture, TRIARTICLES-A02).
- Variables jamais lues : `Dbl`, `Bart`, `NbEnreg`, `lg`, `chkfocus`, `sel` (hors `ChkInput`).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/Coul/Znss"]` ; `Start.Societe`.
- `Utils.db`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.FColr`, `Utils.Log`, `Utils.Obstch`
  (code mort) ; `Cbase.Table` (`TabArt`, `TabMo`, `TabFour`, `TabFam`, `TabCentrales`).
- `LCoul.Art_DB_bgcolor()` : expression SQL de couleur de fond par article.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le code mort (`ChkInput`, `TriArticles_KeyPress`, `_KeyPress`, `FourMan` sauf
  correction A02, variables inutiles).
- `Button1_Click` : `RemplitListe(sTable, sCode, sLibelle)` privée, appelée trois fois (SQL
  identique).
- `Colist_Click`, `Materiel_Click`, `Disponible_Click` : supprimer `tr.Update()` redondant
  (« SQL modifié, dump identique » : une requête de moins).
- `Update_Req` : obtenir `Res.Fields` par la requête de base suivie de ` LIMIT 0` (ou `WHERE
  1 = 0`) au lieu de lire toute la table (« SQL modifié, dump identique »).

### Commonalisation avec d'autres fichiers

- Le relais `ColTri_MajSel` (recopie de `Bsel`/`Bval` vers l'appelant, `Stop Event`, fermeture) et
  `ColTri_ReDim` sont **identiques** dans [`TriCpt`](../TriCpt.class/architecture.md) : une
  méthode `TriGen.Relais(ob)` ou une petite classe `SelectionModale` les factoriserait (handlers
  conservés, un appel chacun).
- La liste de choix fournisseurs/familles est reprise dans [`Changefour`](../../Utils/Changefour.class/architecture.md)
  et [`Changefam`](../../Utils/Changefam.class/architecture.md) (247 lignes identiques entre elles).
- Le motif d'appel `New TriArticles(...)` + `ShowModal` + `If Bsel Then … Bval` est répété dans
  29 écrans : une fonction `TriArticles.Choisir(ob, …) As String` (renvoyant `""` en cas
  d'annulation) simplifierait les appelants, mais impose de les modifier tous (phase 3).

### Réduction de portée

- `Update_Req`, `Filter_Calc` → `Private` (aucun appelant externe, vérifié). Les fonctions mortes
  sont supprimées plutôt que réduites. `Bsel`/`Bval` restent `Public` (écrits par `TriGen`).

### Séparation traitement / GUI

- `Filter_Calc` : fonction pure `FiltreArticles(sOrg, sCode, bStock, bDispo, bMat, sTri) As
  String` (texte identique), appelée avec les valeurs des contrôles.
- `Update_Req` : description des colonnes (`ColonnesArticles(sTri, sChamp3)`) séparée de la
  création du `TriGen`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Art(art_four)`, `(art_fam)`, `(art_centrale)` et `(art_design)` pour les
  filtres et le tri initial de la liste paginée.
- `art_stocke`/`art_mat` stockés en `tinyint` comparés à `1` : un vrai booléen homogène
  simplifierait le filtre « disponible ».
