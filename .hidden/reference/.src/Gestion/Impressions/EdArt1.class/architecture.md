# EdArt1 — Architecture

> Source : `.src/Gestion/Impressions/EdArt1.class` · Formulaire : `.src/Gestion/Impressions/EdArt1.form`

## Vue d'ensemble

`EdArt1` est l'écran d'**impression du tarif interne** des articles (menu Gestion > Impression des
tables > Tarif > Interne, `Fmenu.Menu73_Click` → `EdArt1.Show`, auto-instance non modale).
L'utilisateur saisit des plages (article `Art`–`Art2`, famille `Fam`–`Fam2` de type
[`textfamille`](../../../Utils/textfamille.class/architecture.md), fournisseur `Four`–`Four2`),
choisit un tri (`RadioButton1` code, `2` famille, `3` fournisseur, `4` désignation) et l'option
marge (`Mg`). **Imprimer** (`Button2`, groupe `btn`) produit `~/tmp/Tarif1.pdf` avec la classe
PdfWriter `Carticles` (`.src/Reports/Carticles.class`), puis l'ouvre par `Visualiseur.Prog`.

Colonnes imprimées par ligne d'article (`Carticles.Level6`) : code, désignation (36 car.), famille,
fournisseur, prix de base HT (`art_pbht`), remise (`art_tr`), prix de revient (`art_prvt`),
coefficient (`art_coef`), prix de vente HT (`art_pvht`) ; avec `Mg` coché (`Level6M`) : prix de
revient, coefficient, PV HT, PMP (`art_pmp`) et marge = PV HT − PMP. Si le paramètre société
`/Soc<XX>/Pvcons` est vrai, une ligne « prix consommateur » (`art_pvcons`, `Level10`) suit chaque
article dont ce prix est non nul. Une variante « photo » (`Phot`, `Level6bis` + `Photo`) existe dans
le code mais la case `Phot` est **invisible** dans le `.form` (`Visible = False`, valeur par
défaut `False`) : cette branche est inatteignable par l'interface.

Le reste de la classe est l'outillage de saisie des plages, **dupliqué presque à l'identique** dans
[`EdArt2`](../EdArt2.class/architecture.md) (91 % pour `EdArt3`, 81 % pour `EdArt2`, 64 % pour
`EdStk`, voir « Commonalisation ») : 4 listes déroulantes `ColumnView` (familles, fournisseurs),
recherche d'article par `TriArticles`, contrôle d'existence d'un code article saisi (`art_man`),
navigation au clavier (`Cmpt_KeyPress`, F1 aide, F2 liste).

Nature globale : **GUI** avec un traitement SQL + rendu PDF entièrement dans le handler
`Button2_Click` (CC 31).

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
| `ToggleButton3_Click` | 80-113 | Public | 5 | 31 | 0 | handler GUI |
| `Colfam_KeyPress` | 118-138 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 143-176 | Public | 5 | 31 | 0 | handler GUI |
| `Colfam2_KeyPress` | 181-201 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton5_Click` | 206-239 | Public | 5 | 31 | 0 | handler GUI |
| `Colfour_KeyPress` | 244-264 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton6_Click` | 269-302 | Public | 5 | 31 | 0 | handler GUI |
| `Colfour2_KeyPress` | 307-327 | Public | 6 | 17 | 0 | handler GUI |
| `SelectionArt` | 330-351 | Public | 4 | 19 | 0 | portée réductible ? |
| `art_man` | 356-382 | Public | 6 | 24 | 0 | portée réductible ? |
| `Colfam_Click` | 387-395 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 400-408 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 413-421 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 426-433 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 435-451 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 453-460 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 462-540 | Public | 20 | 69 | 0 | handler GUI |
| `Cmpt_GotFocus` | 545-551 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 553-696 | Public | 31 | 140 | 0 | portée réductible ? |
| `Button1_Click` | 698-702 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Charge le son
  (`Music.Load(Start.Musique)`), centre la fenêtre, lit `/Soc<XX>/Photart` (répertoire des photos),
  lit `/Coul/Fnets` dans `Frmt` et `Utils.Coulfd()` dans `Coulfond` (**jamais relus** : code mort),
  instrumente l'écran (`Utils.Observers(Me)`), puis pose les plages par défaut : articles
  `00000`–`ZZZZZ`, familles `00000`–`ZZZZZ`, fournisseurs `40100001`–`40199999`. Focus sur `Art`.

### Listes de choix (ColumnView)

- **`ToggleButton3_Click()` / `ToggleButton4_Click()`** [portée : nécessaire (handler)]
  [nature : mixte]. Bascule l'affichage de `Colfam` / `Colfam2` : à l'ouverture, 2 colonnes
  (code, intitulé), `SELECT * FROM Fiches_Fam order by code_fam` (nom de table en dur dans `Tab`,
  sans `Cbase.Table`), sélection de la première ligne. À la fermeture, vide la liste. Partie
  extractible : le remplissage `ColumnView ← requête` (identique pour les 4 listes).
- **`ToggleButton5_Click()` / `ToggleButton6_Click()`** [portée : nécessaire (handler)]
  [nature : mixte]. Idem pour `Colfour` / `Colfour2` avec `SELECT * FROM Fiches_Four order by
  fo_code` (colonnes `fo_code`, `fo_nom`).
- **`Colfam_KeyPress()`, `Colfam2_KeyPress()`, `Colfour_KeyPress()`, `Colfour2_KeyPress()`**
  [portée : nécessaire (handler)] [nature : GUI]. Entrée/Retour : `MoveCurrent` puis appel du
  `<Liste>_Click` ; F1 : aide ; Échap/F2 : ferme et vide la liste, rend le focus. ⚠️ Pour
  `Colfam2` et `Colfour2`, le focus est donné au **premier** champ (`fam`, `four`) mais la
  sélection au second (`fam2.Select`, `four2.Select`).
- **`Colfam_Click()`, `Colfam2_Click()`, `Colfour_Click()`, `Colfour2_Click()`** [portée :
  nécessaire (handler, rejeu dynamique)] [nature : GUI]. Copient `Item[0]` (code) dans le champ
  correspondant, ferment la liste et avancent le focus. Appelés par `ReplayObserver` via
  `Object.Call` (`replay_dynamic`) : doivent rester `Public`.

### Sélection et contrôle d'article

- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire (handler)]
  [nature : GUI]. Fixent `Origine` à `"1"` / `"2"` puis appellent `SelectionArt`.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. Ouvre en modal
  `New TriArticles(True, False, "art_code", "", "", Null, False, False, Me)` (9 arguments pour 8
  paramètres : le 9ᵉ est le `Parent` de `Form`, appel correct). `TriArticles` renseigne `Bsel` /
  `Bval` de l'écran par `Object.SetProperty`. Si `Bsel`, copie `Bval` dans `Art` ou `Art2` selon
  `Origine`. ⚠️ `Bsel` n'est **jamais remis à `False`** : après une première sélection, une
  sélection annulée recopie l'ancien `Bval` (même défaut que MATERIEL-A09).
- **`art_man()`** [portée : réductible] [nature : mixte]. Cherche `Art.Text` dans
  `Cbase.Table("TabArt")` successivement sur `art_code`, `art_cfour`, `art_cbarre`,
  `art_refcentrale` (4 `SELECT *` au pire). Introuvable : son, `Message.Warning`, `b = 1` ; sinon
  `b = 0`. ⚠️ Le code trouvé par code fournisseur / code-barre / référence centrale **n'est pas
  substitué** au texte saisi : la plage SQL `art_code >= &1` utilise ensuite la saisie brute.
  Partie extractible : la recherche (fonction `ChercheArticle(code) As Boolean`).

### Navigation et boutons

- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : GUI]. Selon
  `Last.Tag` : 1 → aide (inatteignable : `Button1` n'appartient pas au groupe), 2 → impression,
  3 → supprime `Filename` s'il existe puis ferme.
- **`Btn_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Tag 2 → impression, **pour
  toute touche** (Tab, flèches…). Une barre d'espace déclenche probablement `KeyPress` puis `Click`,
  donc deux impressions (à confirmer en replay).
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : mixte] (CC 20).
  Entrée/Retour/Tab : tags 1 et 2 → `art_man` puis focus suivant (ou retour sur `Art` si
  introuvable) ; 3 à 6 → champ suivant. F1 : aide. F2 : ouvre la liste du champ (`ToggleButton1..6`).
  ⚠️ Le tag 2 (`Art2`) contrôle **`Art.Text`** et non `Art2.Text`, et renvoie le focus sur `Art`.
- **`Cmpt_GotFocus()`** [portée : nécessaire (handler)] [nature : GUI]. `Utils.SetEditColor(Me,
  Last)` (coloration du champ actif).
- **`Button1_Click()`** [portée : nécessaire (handler, `Button1` hors groupe)] [nature : GUI].
  `Doc.Open("Edtar")` (aide HTML).

### Impression

- **`Button2_Click()`** [portée : réductible (`Button2` est dans le groupe `btn` : ce n'est pas un
  handler, seul `Btn_Click`/`Btn_KeyPress` l'appellent)] [nature : mixte] (CC 31, 143 lignes).
  1. Lit `/Soc<XX>/Pvcons` (`Gpvcons`), `Shell "cd ~"` (sans effet : sous-processus), fichier
     `~/tmp/Tarif1.pdf` (**partagé avec `EdArt3`**).
  2. `New CArticles("Portrait", "mm", "A4")`, `Open`, `AliasNbPages`, `Entete("Impression du tarif
     interne au <date>")`, en-tête de colonnes `Level7bis` (photo) / `Level7M` (marge) / `Level7`.
  3. Une des 4 requêtes `SELECT * FROM Fiches_Art WHERE art_code BETWEEN &1/&2, art_fam &3/&4,
     art_four &5/&6 order by …` (tri `lpad(art_code,15,' ')`, `art_fam`, `art_four` ou
     `art_design`) ; nom de table en dur (`Tab = "Fiches_Art"`).
  4. Par article : formatage selon `art_nbd` (`Utils.Find_nbdec`), alignement « ajoute une espace
     si 2 décimales » (`Len(x) - InStr(x, ",") = 2`), marge `Val(Pvht) - Val(Pmp)` (chaînes au
     format local, virgule), impression `Level6`/`Level6M`/`Level6bis`, ligne `Level10` du prix
     consommateur, pas de 5 mm (20 mm en mode photo). En mode photo, un article dont la photo est
     renseignée mais illisible est omis (même défaut qu'EDART3-A06, inatteignable ici).
  5. Saut de page à `PosY >= 283` : `Footer` explicite, `Entete` (qui fait `AddPage`), en-têtes de
     colonnes, `PosY = 26`.
  6. `Footer`, `Output`, `Visualiseur.Prog`. Sans article : son + « Aucun article pour cette
     demande ».
  ⚠️ Ligne 623 : l'alignement de `paht` teste `InStr(pvht, ",")`, valeur de l'article
  **précédent** (`paht` n'est d'ailleurs imprimé qu'en mode photo).
  ⚠️ `Me.Mouse = Mouse.Wait` n'est pas restauré si une erreur interrompt l'impression (pas de
  `Catch`).
  Variables mortes : `Nbpage`, `dte`, `PosX`. Partie extractible : la requête (`SelectArticles`),
  le formatage d'une ligne (`LigneTarif(rarts) As String[]`) et la pagination.

## État global utilisé

- `Start.Musique`, `Start.Son` (initialiseur de `son`), `Start.Societe`, `Start.LocalSettings`
  (`/Soc<XX>/Photart`, `/Soc<XX>/Pvcons`, `/Coul/Fnets`).
- `Utils.db.Exec`, `Utils.Observers`, `Utils.FColr`, `Utils.Coulfd`, `Utils.SetEditColor`,
  `Utils.Find_nbdec`, `Cbase.Table("TabArt")`.
- `Visualiseur.Prog` (commande `/Soc<XX>/caisse/CmdVis` ou `Desktop.Open`), `Doc.Open`.
- `Bsel`/`Bval` : `Public`, écrits par `TriArticles` (`Object.SetProperty`) : à conserver `Public`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` (CC 31) : extraire `SelectArticles(tri) As Result` (une seule requête avec
  `ORDER BY` choisi par table de correspondance), `EnteteTarif(pdf)` (bloc `Entete` + `Level7*`,
  écrit 2 fois), `ImprimeArticle(pdf, rarts)` et `SautDePage(pdf)`.
- `art_man` : une seule requête `WHERE art_code = &1 OR art_cfour = &1 OR …` changerait l'ordre de
  priorité si plusieurs articles correspondent : on garde les 4 requêtes dans un helper.
- Supprimer `Frmt`, `Coulfond`, `Nbpage`, `dte`, `PosX`, `Shell "cd …"`, les blocs `With Utils`
  vides de sens, et le `Case 1` inatteignable de `Btn_Click`.

### Commonalisation avec d'autres fichiers

Mesure de duplication (lignes non vides hors commentaires, `difflib`, script
`output/claude/2026-10-24_rework/phase1/tools/dup.py`) :

| Paire | Lignes communes | Taille | Ratio |
|---|---|---|---|
| `EdArt1` ↔ [`EdArt3`](../EdArt3.class/architecture.md) | 507 | 532 / 583 | 0,91 |
| `EdArt1` ↔ [`EdArt2`](../EdArt2.class/architecture.md) | 416 | 532 / 489 | 0,81 |
| `EdArt2` ↔ `EdArt3` | 413 | 489 / 583 | 0,77 |
| `EdArt1` ↔ [`EdStk`](../EdStk.class/architecture.md) | 310 | 532 / 435 | 0,64 |
| `EdArt1` ↔ [`Edmo`](../Edmo.class/architecture.md) / [`EdRup`](../EdRup.class/architecture.md) / [`EdMat`](../EdMat.class/architecture.md) | 183 / 207 / 176 | — | 0,41 / 0,40 / 0,38 |
| `EdArt1` ↔ [`Edart4`](../Edart4.class/architecture.md) | 36 | 532 / 392 | 0,08 (autre conception : gb.report) |

Fonctions homonymes : les 23 fonctions d'`EdArt1` existent dans `EdArt2` et `EdArt3` ; 21 dans
`EdStk` (sans `art_man`, avec `Cmpt_LostFocus`). Le bloc « liste ColumnView » (≈ 30 lignes) existe
en **20 copies** (4 par fichier dans `EdArt1`, `EdArt2`, `EdArt3`, `EdStk`, `Edmo`), ainsi que
20 `Col*_KeyPress` et 20 `Col*_Click` ; `art_man` en 4 copies (`EdArt1/2/3`, `EdRup`) plus une
variante matériel (`EdMat.Mat_man`) ; `SelectionArt` en 5 copies.

Socle proposé (phase 3, nom à valider), sans toucher aux `.form` ni aux noms de handlers :

- module **`EdSelection`** : `ListeCodes(cv As ColumnView, sTable, sCode, sLib, bRaise)` (remplit
  et affiche une liste ; `bRaise` conserve la différence `EdArt1` = `Raise`, `EdArt2/3`/`EdStk` sans
  `Raise`), `ChercheArticle(sCode) As Boolean` (les 4 requêtes d'`art_man`, à rapprocher de
  `DB_Connection.RecArt` relevé par les notes transverses), `SelectArticles(bornes, iTri,
  bStocke) As Result` (requêtes d'`EdArt1`, `EdArt3`, `EdStk`) ;
- dans `Carticles` : `EnteteTarif(sTitre, bPhoto, bMarge)` (bloc en-tête + colonnes, 8 copies dans
  `EdArt1/3`) et un format `FormatAligne(v, nbdec)` pour l'idiome « espace si 2 décimales »
  (≈ 15 copies dans le lot) ;
- `ImprimeTarif(sTitre, sTypeClient)` partagé par `EdArt1` et `EdArt3` (les deux `Button2_Click`
  ne diffèrent que par le titre, la marge et le coefficient de type client, voir EDART3-A01).

Gain estimé : 600 à 700 lignes sur `EdArt1`, `EdArt3`, `EdStk`, `Edmo` (plus 489 si `EdArt2` est
supprimé, EDART2-A01). L'en-tête société commun `Creleve.EnteteSociete` (notes transverses) ne
s'applique **pas** ici : `Carticles.Entete` n'imprime que le titre (aucune donnée société).

### Réduction de portée

- `SelectionArt`, `art_man` : aucun appelant externe (grep `EdArt1\.` : seul `Fmenu:857`
  `EdArt1.Show`) → `Private`.
- `Button2_Click` : `Button2` appartient au groupe `btn` (le handler levé est `Btn_Click`), il n'est
  appelé que par `Btn_Click`/`Btn_KeyPress` → `Private` (le replay passe par le clic du bouton).
- Handlers (`ToggleButton*_Click`, `Col*_Click`, `Col*_KeyPress`, `Btn_*`, `Cmpt_*`,
  `Button1_Click`) : restent `Public`.

### Séparation traitement / GUI

- `Button2_Click` : isoler `SelectArticles` (SQL) et `LigneTarif(rarts, bMarge) As String[]`
  (formatage pur, testable en gb.test), le handler gardant les contrôles (`Radiobutton*`, `Mg`,
  `Phot`) et le PDF.
- `art_man` : `ChercheArticle(code) As Boolean` sans accès aux contrôles ni message ; l'appelant
  garde `Music.Play` et `Message.Warning`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Art(art_cfour)`, `(art_cbarre)`, `(art_refcentrale)` pour `art_man` (à
  vérifier dans `db_control.csv`).
- Tri `lpad(art_code,15,' ')` non indexable : une colonne de tri normalisée éviterait le tri complet.
