# Attrib — Architecture

> Source : `.src/Caisse/Attrib.class` (+ `Attrib.form`)

## Vue d'ensemble

`Attrib` est l'écran de **paramétrage des touches de la caisse tactile** : il associe à chacune des
35 touches de famille (`A1`…`A35`, `ImageButton` du groupe `Clav2` dans `Panel1`) un libellé, un
code article, une couleur, une image de fond et un drapeau « sous-famille » ; une touche marquée
sous-famille ouvre un second clavier de 35 touches (`<touche>B<n>`, créées dynamiquement dans un
panneau `hpan`, groupe `Clav3`). Les données sont dans `Fiches_Touches` (clé `Cbase` `TabTouches`,
clé primaire `(touche, cai)`, colonnes `libelle`, `code`, `tva`, `coul`, `fond`, `touche_s`), **par
caisse** (`cai = Start.$Tcai`).

Ouverture : `Cmenu.ControleCai` (`Cmenu.class:177`, `Attrib.ShowModal()`, **auto-instance**), seulement
si une caisse est connectée (`Start.$Tcai` non nul). Les touches sont relues par `Caisse` pour
construire le clavier de vente (lot Caisse).

Mode opératoire : clic sur une touche → ses données dans les zones `Bouton` (nom de la touche),
`TextArea1` (texte), `Cart` (code article, recherche par `Button3` via `TriArticles`), `CheckBox1`
(sous-famille) ; « Enregistrer » (`Button1`) ; « Supprimer » (`Button5` ou touche Suppr dans
`Bouton`) ; double-clic → couleur via `FSetFormat` ; « Sous-familles » (`Button4`) bascule sur le
second clavier.

Les boutons `b8`, `b16`, `b24`, `b32`, `b40` (groupe `Clav2`, désactivés) illustrent les touches de
fonction fixes de la caisse.

Nature : **mixte**, SQL dans les handlers, manipulation de contrôles par nom (`Me.Controls[...]`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 4 |
| `Bval` | var | Public |  | String | 5 |
| `Libellearticle` | var | Public |  | String | 6 |
| `fnd` | var | Public |  | String | 7 |
| `btn` | var | Private |  | Imagebutton | 9 |
| `Touche_P` | var | Private |  | String | 10 |
| `Touche_S` | var | Private |  | String | 11 |
| `CodeA` | var | Private |  | New String[36] | 12 |
| `ToucheS` | var | Private |  | New String[36] | 13 |
| `hpan` | var | Private |  | Panel | 14 |
| `hbutton` | var | Private |  | ImageButton | 15 |
| `Pan` | var | Private |  | Boolean | 16 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 18-25 | Public | 1 | 6 | 0 | handler GUI |
| `createPanel` | 27-38 | Public | 1 | 9 | 0 | portée réductible ? |
| `Init` | 40-71 | Public | 11 | 29 | 0 | portée réductible ? |
| `Cart_LostFocus` | 73-77 | Public | 2 | 3 | 0 | handler GUI |
| `TestArt` | 79-93 | Public | 4 | 12 | 0 | portée réductible ? |
| `Button2_Click` | 95-99 | Public | 1 | 3 | 0 | handler GUI |
| `Clav2_Click` | 101-118 | Public | 3 | 15 | 0 | handler GUI |
| `Clav2_Dblclick` | 120-143 | Public | 7 | 21 | 0 | handler GUI |
| `Bouton_KeyPress` | 145-162 | Public | 4 | 16 | 0 | handler GUI |
| `Button1_Click` | 164-185 | Public | 7 | 19 | 0 | handler GUI |
| `Button5_Click` | 187-206 | Public | 5 | 17 | 0 | handler GUI |
| `Button3_Click` | 210-224 | Public | 2 | 12 | 0 | handler GUI |
| `CheckBox1_Click` | 226-234 | Public | 3 | 7 | 0 | handler GUI |
| `Button4_Click` | 236-267 | Public | 6 | 30 | 0 | handler GUI |
| `Cbutton` | 272-290 | Public | 3 | 16 | 0 | portée réductible ? |
| `Clav3_Click` | 292-303 | Public | 1 | 10 | 0 | handler GUI |
| `Clav3_Dblclick` | 305-309 | Public | 1 | 3 | 0 | handler GUI |
| `Init2` | 311-343 | Public | 12 | 30 | 0 | portée réductible ? |
| `Fond_ImageButton` | 345-375 | Public | 8 | 28 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Membres publics

- **`Bsel`, `Bval`** : retour de sélection écrit par `TriArticles` via
  `Object.SetProperty(Obj, "Bsel"/"Bval")` (`TriArticles.class:30-31`, `165-166`) : **doivent rester
  `Public`**.
- **`Libellearticle`** : lu par `Button3_Click` pour afficher la désignation, mais **écrit par
  personne** (`TriArticles` ne transmet que `Bsel`/`Bval`) : `Label3` reste vide (ATTRIB-A04).
- **`fnd`** : nom de la dernière touche cliquée ; lu par `FSetFormat.Lgo2_Click`
  (`FSetFormat.class:72`) pour enregistrer l'image de fond : **doit rester `Public`**.

### Chargement

- **`Form_Open()`** [handler] [mixte] : `Utils.Observers(Me)` (à chaque ouverture : l'auto-instance
  est recréée après fermeture, pas de cumul attendu, à confirmer), `Init()`,
  `Caisse.origine = "Attrib"` — écriture sur l'**auto-instance** de `Caisse`, membre jamais lu
  (seuls des paramètres homonymes `origine` existent dans `Caisse`), alors que la caisse affichée est
  une instance `New Caisse` (`Cmenu.class:253`) : effet de bord = création d'une fenêtre `Caisse`
  cachée (ATTRIB-A06). Puis `createPanel()`.
- **`createPanel()`** [portée : réductible] [GUI] : crée `hpan` (panneau invisible de la taille de
  `Panel1`). Rappelée par `Button4_Click` : le panneau créé à l'ouverture n'est jamais supprimé.
- **`Init()`** [réductible] [mixte] (CC 11) : vide les textes des touches `A1`…`A35` et `CodeA[1..35]` ;
  `SELECT * FROM Fiches_Touches WHERE left(touche,1) = 'A' AND cai = &2 ORDER BY touche` ; pour chaque
  ligne dont la touche existe comme contrôle (`Try Me.Controls[touche].Name = touche`, test
  d'existence détourné) : texte, `CodeA[tag]`, `ToucheS[tag]` (`Utils.convBool(touche_s)`), couleur,
  image (`Picture[fond]`). Vide enfin les zones de saisie. ⚠️ Le filtre `left(touche,1) = 'A'` inclut
  les touches de sous-famille (`A12B3`) : quand le second clavier est affiché, leurs contrôles existent
  et `CodeA`/textes sont mélangés entre famille et sous-famille (ATTRIB-A05, à confirmer).
- **`Init2()`** [réductible] [mixte] (CC 12) : idem pour le second clavier ; la remise à vide vise
  `B1`…`B35`, **noms qui n'existent pas** (les touches s'appellent `<famille>B<n>`) : sans effet.
  `SELECT … WHERE cai = &1` puis filtre en Gambas sur le préfixe `Touche_P` et la présence de `B`
  (le préfixe `A1` accepte aussi `A12B3`, sans conséquence car le contrôle n'existe pas).
- **`Cbutton(oObj)`** [réductible] [GUI] : pour chaque touche de `Panel1` ayant un `Tag`, crée un
  `ImageButton` dans `hpan` nommé `Touche_P & "B" & <numéro>`, même géométrie et tag ; puis `Init2()`.

### Sélection et saisie

- **`Clav2_Click()`** [handler] [GUI] : charge la touche cliquée dans les zones (`Bouton`, texte,
  code article `CodeA[tag]`, sous-famille `ToucheS[tag]`), mémorise `Touche_P` et `fnd`, puis
  `TestArt()` si le code diffère du numéro de touche.
- **`Clav3_Click()`** [handler] [GUI] : même chose pour une touche de sous-famille (`Touche_S`,
  `fnd`), sans `TestArt`.
- **`Cart_LostFocus()`** [handler] : `TestArt()` si le code article diffère du numéro de la touche
  (`Right$(Bouton, Len - 1)`, convention historique « code article = numéro de touche » à confirmer).
- **`TestArt()`** [réductible] [mixte] : hors sous-famille, `SELECT * FROM Fiches_Art WHERE art_code =
  &1` (table en dur) ; article inconnu → avertissement, zone vidée.
- **`Button3_Click()`** [handler] [GUI] : `Bsel = False` puis `New TriArticles(True, False,
  "art_code", "", "", Null, False, False, Me)` (9 arguments : 8 paramètres de `_new` + `Parent`,
  forme correcte, voir les acquis) ; au retour recopie `Bval` dans `Cart` et `Libellearticle` (vide)
  dans `Label3`. `Bsel` est bien remis à `False` avant l'appel (pas de défaut MATERIEL-A09).
- **`CheckBox1_Click()`** [handler] : affiche `Button4` si la touche est une sous-famille.

### Enregistrement et suppression

- **`Button1_Click()`** — Enregistrer [handler] [mixte] : exige code article et touche ;
  `SELECT … WHERE touche = &1 AND cai = &2` → `UPDATE libelle, code, touche_s` ou `INSERT` (sous
  `Try`). ⚠️ En cas d'échec de l'`INSERT`, repli `UPDATE … SET cai = &1 WHERE touche = &2` avec
  **`Cart.Text` (code article) comme nom de touche** : déplace vers cette caisse toutes les touches
  dont le nom égale le code article (ATTRIB-A01). Puis `Me.Controls[Bouton.Text]` **sans `Try`**
  (erreur si le nom tapé dans `Bouton` n'est pas une touche, ATTRIB-A07) et `Init()` (même en mode
  sous-famille, A05). Message d'erreur si saisie incomplète.
- **`Button5_Click()`** — Supprimer [handler] [mixte] : `DELETE FROM Fiches_Touches WHERE touche =
  &1 AND cai = &2` si elle existe, **sans confirmation** (ATTRIB-A07), remise à blanc de la touche,
  `Init()`.
- **`Bouton_KeyPress()`** [handler] [mixte] : touche Suppr dans la zone `Bouton` → même suppression
  que `Button5_Click`, sans confirmation, couleur par défaut `&HDFE7FF&`, `Init()`. Doublon de
  `Button5_Click`.

### Couleur et sous-familles

- **`Clav2_Dblclick()`** [handler] [mixte] : format courant lu dans
  `/Soc<XX>/caisse/<tag>` (`CFormat`), édition par `FSetFormat.Run()`, application fond/texte au
  bouton ; `SELECT … WHERE touche = &1` **sans filtre `cai`** puis `UPDATE … SET coul WHERE touche
  AND cai` (incohérent : l'existence est testée sur toutes les caisses) ; pas d'`INSERT` si la
  touche n'existe pas dans cette caisse (la couleur est perdue au `Init()` suivant) (ATTRIB-A02).
  `Couleur` est calculée mais jamais utilisée. Le format modifié n'est pas réécrit dans
  `LocalSettings`. La levée de `DblClick` par l'`ImageButton` (UserControl qui délègue à une
  `DrawingArea` via `Proxy`, seul `Click` est déclaré) est à confirmer en phase 2.
- **`Clav3_Dblclick()`** [handler] : `Fond_ImageButton()`.
- **`Fond_ImageButton()`** [réductible] [mixte] : variante de `Clav2_Dblclick` pour le clavier courant :
  `SELECT … WHERE touche AND cai`, `UPDATE coul` ou `INSERT` (sous `Try`), puis `Init()` ou
  `Init2()` selon le panneau affiché. Duplication à 80 % de `Clav2_Dblclick`.
- **`Button4_Click()`** [handler] [GUI] : bascule famille ↔ sous-famille : à l'ouverture, vide les
  zones, `createPanel()`, `Cbutton(Panel1)`, `Pan = True`, `CheckBox1` désactivée ; au retour,
  `hpan.Delete`. `Catch` vide : toute erreur est silencieusement ignorée.
- **`Button2_Click()`** [handler] : ferme.

## État global utilisé

- `Start.$Tcai` (caisse connectée, filtre de toutes les requêtes), `Start.LocalSettings`
  (`/Soc<XX>/caisse/<tag>` : formats de couleur), `Start.Societe`.
- `Caisse.origine` (écriture sur l'auto-instance, ATTRIB-A06).
- `FSetFormat.Format` / `FSetFormat.Run()` (auto-instance de l'écran de format), et en retour
  `FSetFormat.Lgo2_Click` lit `Attrib.fnd` (auto-instance d'`Attrib`).
- `CFormat[…]` (format nommé), `Picture[…]` (cache d'images).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer le test d'existence `Try Me.Controls[x].Name = x` par une fonction `Touche(sNom) As
  ImageButton` (renvoie `Null` si absente), utilisée par `Init`, `Init2`, `Button1_Click`,
  `Button5_Click`, `Bouton_KeyPress`.
- `Bouton_KeyPress` (Suppr) et `Button5_Click` → une méthode `SupprimeTouche()` (même SQL ; la
  couleur remise par `Bouton_KeyPress` est conservée en paramètre).
- `Init`/`Init2` → `ChargeClavier(sPrefixe, bSousFamille)` avec les deux filtres actuels conservés.
- `Clav2_Dblclick`/`Fond_ImageButton` → `ChoisitCouleur(hBouton, bAvecCai, bInsere)` paramétré pour
  conserver les deux comportements actuels (SELECT sans `cai` et sans INSERT pour `Clav2`).

### Commonalisation avec d'autres fichiers

- **Application d'un `CFormat`** (fond/texte avec `-1` → couleur système) : même idiome dans
  `SetColors`, `FSetFormat`, `RichDataGrid` (notes transverses : `CFormat.Applique`) → méthode
  `CFormat.Applique(hControle)`.
- **Clavier de la caisse** : `Caisse` relit `Fiches_Touches` pour construire ses touches (lot Caisse) :
  un `ChargeTouches(cai, prefixe) As Result` commun servirait aux deux écrans.
- **Recherche d'article** : `TestArt` est une variante de plus de la recherche par code (notes
  transverses : `DB_Connection.RecArt`, `SupprArt.art_man`, `Changefam.art_man`).

### Réduction de portée

- `createPanel`, `Init`, `TestArt`, `Cbutton`, `Init2`, `Fond_ImageButton` : aucun appelant externe
  (vérifié) → `Private`.
- `Bsel`, `Bval`, `fnd` restent `Public` (`TriArticles`, `FSetFormat`). `Libellearticle` pourrait
  devenir `Private` mais son sort dépend d'ATTRIB-A04.

### Séparation traitement / GUI

- `EnregistreTouche(touche, libelle, code, sousfam, cai)`, `SupprimeTouche(touche, cai)`,
  `EnregistreCouleur(touche, coul, cai, …)` et `LitTouches(prefixe, cai) As Result` : SQL sans
  contrôle, appelés par les handlers.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Touches.touche` encode la hiérarchie (`A12B3`) : une colonne `parent` explicite
  remplacerait les filtres `left(touche,1)` / préfixe + `B` et l'ambiguïté `A1`/`A12`.
- `fond` est mis à jour sans `cai` par `FSetFormat` : la clé `(touche, cai)` existe déjà, il suffit
  d'utiliser les deux colonnes (pas un changement de schéma, voir ATTRIB-A03).
- `libelle char(30)` tronque le texte multi-lignes saisi dans `TextArea1` (non signalé à
  l'utilisateur).
