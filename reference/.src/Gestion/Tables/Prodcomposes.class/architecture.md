# Prodcomposes — Architecture

> Source : `.src/Gestion/Tables/Prodcomposes.class`

## Vue d'ensemble

`Prodcomposes` gère la **nomenclature des produits composés** : un article marqué
`art_prdcomp = 1` dans `Fiches_Art` (le « produit composé », code `codep`) est décrit par des
lignes `Fiches_PrdComp (codep, codec, libelle, qte, mo)` dont chaque composant est soit un
**article** (`mo = 0`), soit une **main-d'œuvre** (`mo = 1`, code de `Fiches_Mo`). La quantité est
stockée en texte (`varchar(50)`, virgule décimale).

À chaque affichage d'un produit composé (`Cprdcomp`), l'écran **recalcule** son coût (somme des
PMP des articles et des prix de revient des MO, pondérés par les quantités) et l'**écrit** dans la
fiche article du produit composé (`art_pbht`, `art_pauaht`, `art_pmp`, `art_prvt`, `art_coef`) :
l'écran de consultation modifie donc `Fiches_Art`.

Ouverture modale sur l'auto-instance depuis le menu Gestion (`Fmenu.Menu227_Click`).

Structure du formulaire : zone `Code` et bouton `Button5` (liste `Colprdc` des produits
composés), zones d'information du produit (`Desg`, `Pvht`, `Pvttc`, `Pmp`, `Marge`, `Margep`,
`Pxrvt`, toutes dans le groupe `Cmpt` avec le tag 1, comme `Code`), grille `Colartprdc`
(GridView, composants, alimentée par `Utils.Base` → `Utils.rs1`), zone composant `CArt`
(tag 2), `Qte` (tag 3), boutons radio `rprod`/`rmo` (article ou MO), `Button3` (ajouter),
`Button2` (retirer), `Button6` (sélection), `Button1` (aide), `Button4` (fermer).

Nature globale : **mixte** ; les calculs de coût sont mêlés au SQL et aux contrôles.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 27 |
| `Sel` | var | Private |  | String | 28 |
| `PArtTable` | var | Private |  | New String[7] | 29 |
| `Ttva` | var | Private |  | Float | 30 |
| `rResult` | var | Private |  | Result | 31 |
| `son` | var | Private |  | Integer | 32 |
| `CoulZns` | var | Private |  | Integer | 33 |
| `CoulZnaf` | var | Private |  | Integer | 34 |
| `Coulfc` | var | Private |  | Integer | 35 |
| `Txtva` | var | Private |  | String | 36 |
| `B` | var | Private |  | Integer | 37 |
| `iPmp` | var | Private |  | Float | 38 |
| `Modif` | var | Private |  | Boolean | 39 |
| `Nbdec` | var | Private |  | String | 40 |
| `Coeff` | var | Private |  | Float | 41 |
| `Bsel` | var | Public |  | Boolean | 43 |
| `Bval` | var | Public |  | String | 44 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 46-83 | Public | 1 | 34 | 0 | méthode spéciale |
| `Code_KeyPress` | 88-103 | Public | 4 | 13 | 0 | portée réductible ? |
| `Button5_Click` | 108-146 | Public | 4 | 36 | 0 | handler GUI |
| `Colprdc_Click` | 148-159 | Public | 1 | 10 | 0 | handler GUI |
| `Colprdc_KeyPress` | 161-175 | Public | 9 | 12 | 0 | handler GUI |
| `Cprdcomp` | 177-207 | Public | 3 | 28 | 0 | portée réductible ? |
| `Cmpt_Keypress` | 209-271 | Public | 20 | 56 | 0 | handler GUI |
| `Cmpt_LF` | 273-279 | Public | 2 | 5 | 0 | portée réductible ? |
| `Colartprdc_Data` | 281-290 | Public | 3 | 8 | 0 | handler GUI |
| `Deb2` | 292-296 | Public | 1 | 3 | 0 | portée réductible ? |
| `button3_KeyPress` | 298-302 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 304-343 | Public | 9 | 36 | 0 | handler GUI |
| `Button4_Click` | 345-349 | Public | 1 | 3 | 0 | handler GUI |
| `Button6_Click` | 351-364 | Public | 3 | 12 | 0 | handler GUI |
| `CleanChamps` | 366-375 | Public | 1 | 8 | 0 | portée réductible ? |
| `Colartprdc_Click` | 380-418 | Public | 6 | 36 | 0 | handler GUI |
| `Colartprdc_KeyPress` | 423-427 | Public | 2 | 3 | 0 | handler GUI |
| `button2_Click` | 429-445 | Public | 5 | 14 | 0 | handler GUI |
| `delArt` | 447-457 | Public | 2 | 9 | 0 | portée réductible ? |
| `SelectionArt` | 460-471 | Public | 2 | 9 | 0 | portée réductible ? |
| `ChkPrx` | 473-481 | Public | 7 | 7 | 0 | portée réductible ? |
| `Art_Man` | 486-522 | Public | 5 | 34 | 0 | portée réductible ? |
| `CalcTTC` | 527-532 | Public | 1 | 4 | 0 | portée réductible ? |
| `CalcHt` | 537-545 | Public | 1 | 7 | 0 | portée réductible ? |
| `Recup_Tva` | 550-558 | Public | 2 | 7 | 0 | portée réductible ? |
| `Calc_Pmp` | 563-601 | Public | 10 | 26 | 0 | portée réductible ? |
| `Calc_coeff` | 603-607 | Public | 2 | 3 | 0 | portée réductible ? |
| `Calc_Marge` | 609-635 | Public | 5 | 25 | 0 | portée réductible ? |
| `Calc_Prvt` | 637-657 | Public | 6 | 17 | 0 | portée réductible ? |
| `Button1_Click` | 662-666 | Public | 1 | 3 | 0 | handler GUI |
| `SelectionMo` | 669-680 | Public | 2 | 9 | 0 | portée réductible ? |
| `Mo_man` | 682-702 | Public | 4 | 19 | 0 | portée réductible ? |
| `rprod_Click` | 704-714 | Public | 2 | 9 | 0 | handler GUI |
| `rmo_Click` | 716-726 | Public | 2 | 9 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et sélection du produit composé

- **`_New()`** [nature : GUI] : délai des bulles, lecture de trois couleurs de configuration
  (`CoulZns`, `CoulZnaf`, `Coulfc` : jamais relues), `Utils.Observers`, son, colonnes de
  `Colprdc`/`Colartprdc`, `Tri = "codep"`, `Pmp`/`Marge` à `0,00`.
- **`Code_KeyPress()`** : **code mort** — `Code` est dans le groupe `Cmpt`, Gambas lève
  `Cmpt_Keypress` et jamais `Code_KeyPress` (handler inactif signalé par `deps.py`, vérifié dans
  le `.form`).
- **`Button5_Click()`** [handler] [nature : mixte] : liste `Colprdc` des articles
  `art_prdcomp = true` (PA HT, PV TTC, PMP rangé dans `Item[4]` au-delà des 4 colonnes).
- **`Colprdc_Click()`** [handler, rejeu dynamique] / **`Colprdc_KeyPress()`** : recopie code,
  désignation, prix ; `Cprdcomp`. F2/Échap/Suppr ferment ou rouvrent la liste.
- **`Cprdcomp()`** [portée : réductible] [nature : mixte] : `SELECT … <TabArt> WHERE art_code = &1
  AND art_prdcomp = &2` ; si trouvé : affichage, `Tri = "codec"`, `Sel = code`, `Deb2`, puis
  **`Calc_Pmp` → `Calc_marge` → `Calc_Prvt`** (cet ordre fait que `Calc_Pmp` écrit le prix de
  revient calculé à l'appel précédent, PRODCOMPOSES-A02) ; sinon message d'erreur et `b = 1`.
- **`Deb2()`** [portée : réductible] : `Utils.Base(Colartprdc, Subst("SELECT * FROM Fiches_PrdComp
  WHERE codep=&1 ORDER BY &2", Sel, Tri))`. ⚠️ `&2` est substitué en **chaîne littérale**
  (`ORDER BY 'codec'`) : aucun tri effectif (A04) ; nom de table en dur.
- **`Colartprdc_Data(Row, Column)`** [handler] : lit `Utils.rs1` (colonnes `codec`, `libelle`,
  `qte`, `mo` affiché par `Str()` d'un booléen).

### Saisie (groupe `Cmpt`)

- **`Cmpt_Keypress()`** (CC 20, max du fichier) [handler] : sur `Qte` (tag 3) filtre les
  caractères (`ChkPrx`). Entrée/Retour/Tab : tag 1 → `Cprdcomp` (y compris depuis les zones
  d'information `Pvht`, `Pmp`…, qui ont aussi le tag 1) ; tag 2 → `Art_Man` puis `Qte` ; tag 3 →
  format de la quantité et focus sur `Button3`. F2 : listes. F4 : `Articles.ShowModal()` puis
  `Cprdcomp` — ⚠️ y compris depuis la zone composant (tag 2), qui recharge le produit composé au
  lieu du composant (A06, à confirmer).
- **`Cmpt_LF()`** [portée : réductible] : format de `Qte` selon `Nbdec` puis `Calc_Pmp`.
- **`ChkPrx()`** [portée : réductible] [nature : GUI] : `Stop Event` sur les caractères non
  numériques (hors touches d'édition).

### Composants

- **`Button6_Click()`** [handler] : `SelectionArt` ou `SelectionMo` selon `rprod`.
- **`SelectionArt()`** / **`SelectionMo()`** [portée : réductible] : `New TriArticles(True,
  False, "art_code"|"mo_code", "", "", Null, False, False, Me)` puis `ShowModal` ; `TriArticles`
  renseigne `Bsel`/`Bval` par `Object.SetProperty` (9 arguments corrects : le 6ᵉ est le `Parent`
  du constructeur hérité de `Form`, vérifié). Ensuite `Art_Man` ou `Mo_man`.
- **`Art_Man()`** [portée : réductible] [nature : mixte] : refuse un produit composé comme
  composant ; sinon lit l'article (`art_prdcomp = 0 OR NULL`), affiche désignation, PMP, prix,
  `Nbdec` (`Utils.Find_nbdec`), `Qte = "1"` ; absent → message et `b = 1`.
- **`Mo_man()`** [portée : réductible] [nature : mixte] : lit la MO (`<TabMo>`) ; ⚠️ affiche
  `mo_txht` (taux horaire) dans `PmpA` alors que `Colartprdc_Click` y met `mo_prvt` et que
  `Calc_Pmp` utilise `mo_prvt` (A07).
- **`Button3_Click()`** (CC 9) [handler] / **`button3_KeyPress()`** [handler] — ajout/modification :
  `Cmpt_LF` (qui recalcule et **écrit** le PMP avec la quantité saisie, A01), puis `UPdate` de la
  quantité (avec question si le composant existe et n'est pas en modification) ou `INSERT`
  (`mo` = bouton « Ajouter MO ») ; `Cprdcomp` ; affectation de `Pmp` (aussitôt recalculée par le
  second `Cprdcomp`, sauf si `Calc_Pmp` échoue) ; `CleanChamps` ; `Cprdcomp`.
  ⚠️ `button3_KeyPress` appelle `Button3_Click` pour **n'importe quelle touche** (Tab compris)
  sur le bouton (A05).
- **`Colartprdc_Click()`** [handler, rejeu dynamique] : charge le composant sélectionné (article
  si la colonne `mo` vaut `"False"`, sinon MO via `Fiches_Mo` en dur) et passe en modification
  (`Modif = True`). Le test sur le texte `"False"` dépend de la conversion booléenne du pilote
  (A08, à confirmer sous SQLite). `Catch` vide.
- **`Colartprdc_KeyPress()`** / **`button2_Click()`** [handlers] — retrait : si le composant figure
  dans des lignes de BL (`<TabLigbl>.code_ligbl`), confirmation ; puis `delArt`. `Catch` vide.
- **`delArt()`** [portée : réductible] : `DELETE … WHERE codec = &1 AND codep = &2`, `Sel =
  "codep"` (écrasé par `Cprdcomp`), décrément de `Pmp`, `CleanChamps`, `Cprdcomp`.
- **`CleanChamps()`** [portée : réductible] : vide la zone composant, `Qte = "0"`.
- **`rprod_Click()`** / **`rmo_Click()`** [handlers] : libellés article/MO.
- **`Button1_Click()`** : `Doc.Open("ProduitsComposes")` ; **`Button4_Click()`** : fermeture.

### Calculs de coût

- **`Calc_Pmp()`** (CC 10) [portée : réductible] [nature : calcul + SQL + GUI] : pour chaque
  composant de `<TabPrdComp>` : article → `art_pmp` (lu **sans test `Available`**) × quantité,
  ⚠️ la quantité est celle de la **zone `Qte`** si elle n'est ni `"0"` ni vide, sinon celle de la
  ligne (A01) ; MO → `mo_prvt × qte` (`Fiches_Mo` en dur). `Pmp = total`. Puis, si le produit
  existe : `UPdate <TabArt> SET art_pbht = art_pauaht = art_pmp = Val(Pmp), art_prvt =
  Val(Pxrvt), art_coef = Coeff`. ⚠️ `Coeff` n'est jamais calculé (`Calc_coeff` n'est appelé
  nulle part) : **`art_coef` est remis à 0** à chaque affichage (A02). `Catch` muet : un composant
  article supprimé interrompt le calcul sans mise à jour (A03).
- **`Calc_Prvt()`** [portée : réductible] [nature : calcul + SQL] : somme `art_prvt × qte`, ou
  `mo_prvt × qte` si la lecture article échoue (`Fiches_Art`/`Fiches_Mo` en dur) → `Pxrvt`.
- **`Calc_Marge()`** [portée : réductible] [nature : calcul + GUI] : `Marge = PV HT − PMP`,
  `Margep = Marge × 100 / PMP` (marge sur coût) ; fonds rouges si négatif (couleurs en dur).
- **`Calc_coeff()`**, **`CalcTTC()`**, **`CalcHt()`**, **`Recup_Tva()`** : **code mort** (jamais
  appelés ; `Recup_Tva` lirait un `Txtva` jamais renseigné). `Calc_coeff` est conservé tant que
  l'anomalie A02 n'est pas tranchée.

## État global utilisé

- `Utils.db`, `Utils.rs1` (via `Utils.Base`), `Utils.cpoint`, `Utils.Find_nbdec`, `Utils.FColr`,
  `Utils.Observers`, `Utils.db.Subst` ; `Cbase.Table` (`TabPrdComp`, `TabArt`, `TabMo`,
  `TabLigbl`, `TabTvav`) mais `Fiches_PrdComp`, `Fiches_Mo`, `Fiches_Art` en dur dans `Deb2`,
  `Colartprdc_Click`, `Calc_Pmp`, `Calc_Prvt`.
- `Start.LocalSettings` (`/Coul/*`), `Start.Son`, `Start.Musique`.
- Membres `Public` `Bsel`/`Bval` : écrits par [`TriArticles`](../../../Affichages/TriArticles.class/architecture.md) via `Object.SetProperty` (portée
  `Public` obligatoire).
- Membres d'état : `Sel`, `Tri`, `B`, `Modif`, `Nbdec`, `Coeff`, `iPmp` (utilisé comme variable
  locale), `rResult` (partagé `Recup_Tva`/`Mo_man`), `Ttva`/`Txtva` (morts), `PArtTable`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Calc_Pmp` et `Calc_Prvt` : une seule lecture des composants et des fiches liées (N+1 → jointure
  ou lecture unique) — seulement après décision sur A01/A02, car l'ordre actuel détermine la valeur
  écrite de `art_prvt`.
- `Cmpt_Keypress` : une fonction par touche (`ValideZone`, `OuvreListe`, `OuvreArticles`).
- `SelectionArt`/`SelectionMo` → `Selection(sTri)` unique.

### Commonalisation avec d'autres fichiers

- Calcul de marge sur coût (`Calc_Marge`) : même formule que
  [Materiel.Calc_Marge](../Materiel.class/architecture.md) (marge / PMP).
- Recalcul du PMP d'un produit composé : à rapprocher des mises à jour de PMP du stock
  ([Calcstock](../../../Utils/Calcstock.class/architecture.md)) et de la facturation qui
  décompose les produits composés ([Facture](../../Facturation/Facture.class/architecture.md) :
  `Facture.class:6773` lit `<TabPrdComp>`) et des mouvements de stock des produits composés
  ([MvtProdcomp](../../Stock/MvtProdcomp.class/architecture.md), qui ne lit que `codec`/`qte` de
  `Fiches_PrdComp` et ne touche pas au PMP).
- Sélection article/MO par `TriArticles` + `Bsel`/`Bval` : motif répété dans une trentaine
  d'écrans (`.src/Affichages/TriArticles.class`, lot Affichages).

### Réduction de portée

`Cprdcomp`, `Cmpt_LF`, `Deb2`, `CleanChamps`, `delArt`, `SelectionArt`, `SelectionMo`, `ChkPrx`,
`Art_Man`, `Mo_man`, `Calc_Pmp`, `Calc_Marge`, `Calc_Prvt` → `Private`. `Bsel`/`Bval` restent
`Public`. Les handlers (`Colprdc_Click`, `Colartprdc_Click` rejoués dynamiquement, `button2_Click`,
`button3_KeyPress`…) restent `Public`.

### Séparation traitement / GUI

- `CoutCompose(sCode, sQteSaisie) As Float` et `PrixRevientCompose(sCode) As Float` sans contrôle
  (la quantité saisie est passée en paramètre pour préserver A01) ; `MajCoutArticle(sCode, fPmp,
  fPrvt, fCoef)` pour l'`UPdate`.
- `AjouteComposant(sCodep, sCodec, sLibelle, sQte, bMo, bRemplace)` et `RetireComposant(...)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_PrdComp.qte` en `varchar(50)` → `DECIMAL` (supprime les conversions `cpoint`).
- `codec` mélange codes article et codes MO (distingués par `mo`) : deux colonnes ou clés
  étrangères distinctes permettraient une intégrité référentielle (suppression d'un article ou
  d'une MO utilisés).
- Le coût du produit composé recopié dans `Fiches_Art` (`art_pmp`, `art_prvt`…) est une donnée
  dérivée : une vue calculée éviterait l'écriture à chaque consultation.
