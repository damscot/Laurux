# ConsultArt — Architecture

> Source : `.src/Gestion/Tables/ConsultArt.class`

## Vue d'ensemble

`ConsultArt` est l'écran **« Consultation des articles »** (lecture seule), ouvert par
`Fmenu.lblClm2_MouseDown` (`Fmenu.class:1561`, `ConsultArt.Show` sur l'auto-instance, non modal).
Il affiche une grille `Colarts` (`GridView`, 8 colonnes dont 3 masquées de largeur 1 : stocké,
quantité, suspendu) alimentée par `Utils.Base`, avec recherche incrémentale par frappe dans les
en-têtes `CO` (code), `Inte` (intitulé, recherche « contient »), `FO` (fournisseur), `FA` (famille)
et `CB1` (équivalent, code-barre ou référence fournisseur), tri ascendant/descendant par double clic,
filtres par radios (tous, stockés, non stockés, en stock, épuisés, suspendus) et coloration des lignes
selon l'état de stock (`/Coul/Eps`, `/Coul/Stk`, `/Coul/Nstk`, `/Coul/Spd`). Un clic sur une ligne
affiche la fiche résumée (prix, TVA, écotaxe, stock, quantité en commande fournisseur, remises
quantitatives) ; la saisie `*<code-barre>` dans `Code` retrouve l'article par code-barre.

C'est une **copie ancienne et simplifiée d'`Articles`** (l'en-tête du fichier porte encore le nom
`Articles.class`) : 14 fonctions homonymes (`Maj_Zones`, `CleanChamps`, `FamMan`, `fourMan`,
`Decimal`, `Refresh`…). Aucune écriture en base. Nature : **mixte** (requêtes construites et
contrôles dans les mêmes fonctions).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `n` | var | Private |  | Integer | 27 |
| `Tri` | var | Private |  | String | 28 |
| `tab` | var | Private |  | String | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `sel` | var | Private |  | String | 31 |
| `Arttable` | var | Private |  | New String[10] | 32 |
| `B` | var | Private |  | Integer | 33 |
| `Stk` | var | Private |  | Integer | 34 |
| `Stk2` | var | Private |  | Integer | 35 |
| `Spd` | var | Private |  | Integer | 36 |
| `nbdec` | var | Private |  | String | 37 |
| `Reaf` | var | Private |  | Integer | 38 |
| `Tvavente` | var | Private |  | Integer | 39 |
| `Ecotaxe` | var | Private |  | String | 40 |
| `Dbl` | var | Private |  | String | 41 |
| `CoulB` | var | Private |  | Integer | 42 |
| `CoulF` | var | Private |  | Integer | 43 |
| `CoulFc` | var | Private |  | Integer | 44 |
| `CoulZnaf` | var | Private |  | Integer | 45 |
| `Fnt` | var | Private |  | String | 46 |
| `ComboTest` | var | Private |  | Boolean | 47 |
| `Chkfocus` | var | Private |  | Integer | 48 |
<!-- /AUTO:declarations -->

⚠️ Le bloc ci-dessus est vide : les 22 variables du fichier sont déclarées **sans mot-clé**
(`Private` implicite, lignes 27-48), forme que le parseur ne reconnaît pas. Usage vérifié par grep :
`Tri`, `tab`, `Tab2`, `sel`, `Arttable`, `Stk`, `Stk2`, `Spd`, `nbdec`, `Dbl`, `CoulB`, `CoulF`,
`Fnt`, `ComboTest`, `Chkfocus` sont utilisées ; `n`, `B`, `Tvavente`, `Ecotaxe`, `CoulFc`, `CoulZnaf`
sont écrites mais jamais lues ; `Reaf` n'est jamais affectée hors `Code_KeyPress` (passée telle quelle
à `Maj_Zones`, dont le paramètre est inutilisé).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 50-93 | Public | 2 | 40 | 0 | méthode spéciale |
| `Form_Open` | 95-106 | Public | 1 | 10 | 0 | handler GUI |
| `Tabstrip1_click` | 108-112 | Public | 1 | 3 | 0 | handler GUI |
| `Colarts_Data` | 114-202 | Public | 37 | 86 | 0 | handler GUI |
| `Tris` | 204-218 | Public | 1 | 13 | 0 | portée réductible ? |
| `Deb2` | 220-259 | Public | 8 | 37 | 0 | portée réductible ? |
| `Deb3` | 261-300 | Public | 8 | 37 | 0 | portée réductible ? |
| `Deb4` | 302-337 | Public | 7 | 33 | 0 | portée réductible ? |
| `FamMan` | 342-375 | Public | 5 | 31 | 0 | portée réductible ? |
| `fourMan` | 380-395 | Public | 3 | 13 | 0 | portée réductible ? |
| `Maj_Zones` | 397-480 | Public | 34 | 78 | 0 | portée réductible ? |
| `Fam2` | 485-518 | Public | 5 | 31 | 0 | portée réductible ? |
| `Refresh` | 520-525 | Public | 1 | 4 | 0 | portée réductible ? |
| `CleanChamps` | 527-565 | Public | 1 | 37 | 0 | portée réductible ? |
| `Colarts_Click` | 567-592 | Public | 4 | 24 | 0 | handler GUI |
| `Code_KeyPress` | 594-606 | Public | 5 | 11 | 0 | handler GUI |
| `Rb_Click` | 608-645 | Public | 6 | 31 | 0 | handler GUI |
| `Btn_Click` | 647-657 | Public | 2 | 6 | 0 | handler GUI |
| `Co_GotFocus` | 659-664 | Public | 2 | 4 | 0 | handler GUI |
| `Co_LostFocus` | 666-670 | Public | 2 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 672-677 | Public | 2 | 4 | 0 | handler GUI |
| `Inte_LostFocus` | 679-683 | Public | 2 | 3 | 0 | handler GUI |
| `fo_GotFocus` | 685-690 | Public | 2 | 4 | 0 | handler GUI |
| `fo_LostFocus` | 692-696 | Public | 2 | 3 | 0 | handler GUI |
| `Fa_GotFocus` | 698-703 | Public | 2 | 4 | 0 | handler GUI |
| `Fa_LostFocus` | 705-709 | Public | 2 | 3 | 0 | handler GUI |
| `Cb1_LostFocus` | 711-715 | Public | 2 | 3 | 0 | handler GUI |
| `Cb1_GotFocus` | 717-722 | Public | 2 | 4 | 0 | handler GUI |
| `Dbclk` | 724-734 | Public | 2 | 9 | 0 | portée réductible ? |
| `entete` | 736-744 | Public | 2 | 7 | 0 | portée réductible ? |
| `Co_Click` | 746-755 | Public | 1 | 8 | 0 | handler GUI |
| `Co_Dblclick` | 757-761 | Public | 1 | 3 | 0 | handler GUI |
| `Co_KeyPress` | 763-773 | Public | 3 | 9 | 0 | handler GUI |
| `Inte_Click` | 775-784 | Public | 1 | 8 | 0 | handler GUI |
| `Inte_Dblclick` | 786-790 | Public | 1 | 3 | 0 | handler GUI |
| `Inte_KeyPress` | 792-802 | Public | 3 | 9 | 0 | handler GUI |
| `fo_Click` | 804-813 | Public | 1 | 8 | 0 | handler GUI |
| `fo_Dblclick` | 815-819 | Public | 1 | 3 | 0 | handler GUI |
| `fo_KeyPress` | 821-831 | Public | 3 | 9 | 0 | handler GUI |
| `Fa_Click` | 833-842 | Public | 1 | 8 | 0 | handler GUI |
| `Fa_Dblclick` | 844-848 | Public | 1 | 3 | 0 | handler GUI |
| `Fa_KeyPress` | 850-860 | Public | 3 | 9 | 0 | handler GUI |
| `Cb1_Click` | 862-881 | Public | 5 | 18 | 0 | handler GUI |
| `Cb1_Dblclick` | 883-887 | Public | 1 | 3 | 0 | handler GUI |
| `Cb1_KeyPress` | 889-899 | Public | 3 | 9 | 0 | handler GUI |
| `Stocke_Click` | 901-905 | Public | 3 | 3 | 0 | handler GUI |
| `Ref` | 907-915 | Public | 1 | 6 | 0 | portée réductible ? |
| `art_man` | 920-960 | Public | 8 | 37 | 0 | portée réductible ? |
| `Decimal` | 965-983 | Public | 4 | 17 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et grille

- **`_New()`** [portée : nécessaire] [nature : GUI] : musique, centrage, couleurs, observateurs,
  libellés des en-têtes, `Cb1 = "Equivalent"` (avec `ComboTest` pour neutraliser `Cb1_Click`),
  affichage du poids si `/Soc<XX>/Poids`, libellé de taxe, grille `Tbrem` 6 × 3.
- **`Form_Open()`** [handler] : `Tri = "art_code"`, `Tris`, `Deb2`, `CleanChamps`, focus sur `code`.
- **`Tabstrip1_click()`** [handler] : réinstalle les observateurs.
- **`Tris()`** [réductible] [GUI] : largeurs des 8 colonnes (alignées sur les en-têtes).
- **`Deb2()`** / **`Deb3()`** [réductibles] [mixte] : requête de la grille, triée ascendante
  (`Deb2`) ou descendante (`Deb3`), filtre `<Tri> like "<sel>%"` selon les radios (stock > 0, ≤ 0,
  suspendus, ou `art_stocke = Stk or art_stocke = Stk2`) ; tri sur `lpad(art_code,15,' ')` pour le
  code (traduit pour SQLite par `DB_Connection`). Les deux fonctions sont identiques à l'ordre près,
  sauf la variante « suspendus » de `Deb3` qui sélectionne `art_pvttc` **au lieu de** `art_fam`
  (CONSULTART-A03). Les valeurs `Stk`/`Stk2` positionnées par `Rb_Click` sont recalculées depuis les
  radios (affectations de `Rb_Click` sans effet), avec une différence : radio 3 « tous » → `(0, 1)`
  dans `Deb2`, `(1, 0)` dans `Deb3`/`Deb4` (même ensemble).
- **`Deb4()`** [réductible] : même requête avec recherche « contient » (`like "%<sel>%"`), utilisée
  par la frappe dans l'intitulé.
- ⚠️ Les trois fonctions **concatènent** `sel` (frappes de l'utilisateur) entre guillemets doubles :
  un `"` saisi casse la requête, `%` et `_` sont interprétés comme jokers (CONSULTART-A01).
- **`Colarts_Data(Row, Column)`** (CC 37, max du fichier) [handler] [mixte] : lit les quatre
  couleurs dans `Start.LocalSettings` **à chaque cellule**, positionne `Utils.rs1` sur la ligne
  (`MoveTo`), écrit le texte du champ `Arttable[Column]` ; pour les colonnes masquées 1 (quantité) et 2
  (suspendu), calcule couleur de fond, de texte et police (épuisé, stocké, non stocké, suspendu) dans
  les membres `CoulB`/`CoulF`/`Fnt`, puis les applique à la cellule. Les colonnes visibles
  réutilisent les valeurs calculées pour la cellule précédente : la coloration dépend de l'ordre
  d'appel de l'événement `Data` (à confirmer). Le test `Str(...) = "True"` sur `art_stocke` suppose
  un champ booléen (MySQL `tinyint(1)`) ; sous SQLite la valeur pourrait valoir `"1"` (à confirmer).
- **`Colarts_Click()`** [handler, appelé dynamiquement par le rejeu] : `CleanChamps`, `Maj_Zones`
  de la ligne cliquée (colonne 3), couleur de `qte` (stock < 1), `qte` vidé pour un article non
  stocké.

### Fiche résumée

- **`Maj_Zones(Prod, Reaf)`** (CC 34) [réductible] [mixte] : lit l'article (`Fiches_Art` **en dur**
  via `Tab2`) et remplit les champs ; quantité en commande fournisseur = somme des `qte` de
  `Fiches_Ligcom` (**en dur**, toutes commandes) **ajoutée** à la valeur courante de `qtecom`
  (CONSULTART-A02) ; TVA et écotaxe de la **famille** (`Fam2`), taux via `CPrix.CTva` ; fournisseur
  (`fourMan`) ; grille `Tbrem`. Le paramètre `Reaf` est inutilisé. Article inconnu : avertissement.
  ⚠️ `If Not qte.Text Then qte = CDec(Dec, 0) Else qte = CDec(Dec, art_qte)` : la quantité affichée
  dépend du texte précédent de `qte` ; après un article non stocké (`qte = ""`), une recherche par
  code-barre affiche 0 (CONSULTART-A02).
- **`Fam2()`** [réductible] [mixte] : famille (`Fiches_Fam`), TVA (`Fiches_Tvaav`), contrôle du
  compte de TVA (`Fiches_Comptes`), tous **en dur** ; `Rfams` et `Tvav` lus sans test `Available` :
  le `Catch` affiche « Cette famille n'existe pas ! » y compris quand c'est le code TVA qui manque
  (CONSULTART-A04).
- **`FamMan()`** [réductible] — **code mort transitif** : copie de `Fam2` (avec un
  `Message.Error` en plus), appelée seulement par `art_man`, elle-même jamais appelée.
- **`fourMan()`** [réductible] : nom du fournisseur (`Fiches_Four` en dur) ; inconnu → `Catch`.
- **`CleanChamps()`** [réductible] [GUI] : remise à blanc ; `Arr.Text = "0,01"` écrit deux fois ;
  `nbdec = Utils.Find_nbdec(2)`.
- **`Code_KeyPress()`** [handler] : `*<code-barre>` + Entrée → `Utils.Find_cbarre` puis `Maj_Zones`
  **sans** `CleanChamps` (accumulation de `qtecom`, A02).
- **`Stocke_Click()`** [handler] : `qte = "0"` si coché et vide (aucun enregistrement : l'écran ne fait que lire).
- **`Btn_Click()`** [handler] : `Button5` (tag 3) ferme l'écran.

### En-têtes de recherche

- **`Co_*`, `Inte_*`, `fo_*`, `Fa_*`, `Cb1_*`** [handlers] : `_GotFocus` (observateur + passage en
  mode recherche par `*_Click`), `_LostFocus` (observateur), `_Click` (vide `sel`, réinitialise les
  en-têtes par `entete`, choisit `Tri`, `Deb2`), `_Dblclick` (`Dbclk` : bascule ascendant/descendant),
  `_KeyPress` (ajoute `Key.Text` à `sel` ou retire un caractère sur Retour arrière, puis `Deb2`, ou
  `Deb4` pour l'intitulé ; `Catch` vide). Toute touche, y compris Entrée ou Tab, est ajoutée à `sel`
  (`Key.Text` éventuellement non vide pour ces touches, à confirmer).
- **`Cb1_Click()`** : `Tri` = `art_cequ`, `art_cfour` ou `art_cbarre` selon la liste.
- **`Dbclk()`**, **`entete()`** [réductibles] [GUI].
- **`Rb_Click()`** [handler] : `Refresh()` (donc `Form_Open` : tri remis sur le code, `Tris`, `Deb2`,
  `CleanChamps`), puis à nouveau `CleanChamps` et `Deb2` : **deux requêtes** identiques par clic.
- **`Refresh()`** [portée : à confirmer] : `sel = ""` + `Form_Open()` ; surcharge la méthode héritée
  du formulaire (même remarque que pour `Articles`).

### Code mort

- **`Ref()`**, **`art_man(Reaf)`**, **`Decimal(Stk)`** : aucun appel (`unused` de `deps.py`, confirmé
  par grep) ; `FamMan` n'est appelée que par `art_man`.

## SQL émis : synthèse

| Requête | Tables | Fonctions |
|---|---|---|
| Liste (4 variantes × asc/desc/contient) | `TabArt` (concaténation de `Tri`, `sel`, `Stk`, `Stk2`, `Spd`) | `Deb2`, `Deb3`, `Deb4` via `Utils.Base` |
| Fiche | `Fiches_Art`, `Fiches_Ligcom`, `Fiches_Fam`, `Fiches_Tvaav`, `Fiches_Comptes`, `Fiches_Four` (tous en dur) | `Maj_Zones`, `Fam2`, `fourMan` |

Aucune écriture.

## État global utilisé

- `Utils.rs1` : résultat **global** rempli par `Utils.Base` et relu par `Colarts_Data` à chaque
  affichage de cellule ; l'écran étant non modal, tout autre écran qui appelle `Utils.Base`
  remplace ce résultat (CONSULTART-A05, à confirmer).
- `Start.LocalSettings` : `/Coul/Znaff`, `/Coul/Focus`, `/Coul/Eps`, `/Coul/Stk`, `/Coul/Nstk`,
  `/Coul/Spd`, `/Soc<XX>/Poids`, `/Soc<XX>/Taxe`, `/Soc<XX>/Coul_fen` ; `Start.Societe`,
  `Start.Musique`, `Start.son`.
- `Utils.FColr`, `Utils.Observers`, `ObsGotf`, `ObsLstf`, `ObsLstf2`, `Find_nbdec`, `Find_cbarre`,
  `CDec`, `cpoint` ; `CPrix.CTva`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Fusionner `Deb2`/`Deb3`/`Deb4` en `ChargeListe(bDesc As Boolean, bContient As Boolean)` (même SQL
  pour chaque combinaison existante, y compris la variante `art_pvttc` de `Deb3` tant que A03 n'est
  pas validée).
- `Colarts_Data` : lire les quatre couleurs une seule fois (dans `_New` ou `Form_Open`) ; table de
  correspondance `Arttable` initialisée une fois (aujourd'hui recalculée à chaque cellule).
- Supprimer le code mort (`Ref`, `art_man`, `Decimal`, `FamMan`, variables écrites non lues).
- `Rb_Click` : une seule requête (supprimer le second `CleanChamps` + `Deb2`, **SQL modifié, dump
  identique**, l'écran ne fait que lire).
- Factoriser les 5 × 3 handlers d'en-tête (`*_GotFocus`, `*_KeyPress`, `*_Click`) autour de deux
  helpers privés `ChoixTri(sChamp, hEntete)` et `Frappe(bContient)` ; les handlers restent.

### Commonalisation avec d'autres fichiers

- Fiche résumée : `Maj_Zones`, `Fam2`, `fourMan`, `CleanChamps` dupliquent la logique
  d'[`Articles`](../Articles.class/architecture.md) (`Maj_Zones`, `FamMan`, `fourMan`). Une fonction
  commune de lecture « article + famille + TVA » (`Result` ou objet valeur) servirait aux deux écrans,
  l'affichage restant propre à chacun.
- Remplissage de la grille de remises quantitatives (`Tbrem`, 18 lignes) : même code dans `Articles`
  (`Maj_Zones`, `Button10_click`) → helper `AfficheRemisesQte` (ARTICLES-008).
- Liste d'articles filtrée et colorée : `Articles` utilise `TriGen` + `LCoul.Art_DB_bgcolor()`.
  Remplacer la grille de `ConsultArt` par `TriGen` modifierait le comportement visible (hors rework
  autonome) ; à étudier en phase 3.
- `Decimal` est identique à `Articles.Decimal` (mort ici).

### Réduction de portée

- `Tris`, `Deb2`, `Deb3`, `Deb4`, `Fam2`, `fourMan`, `Maj_Zones`, `CleanChamps`, `Dbclk`, `entete` →
  `Private` (aucun appelant externe, grep). `Refresh` : à confirmer (surcharge). `Colarts_Click` reste
  `Public` (rejeu dynamique) comme tous les handlers.

### Séparation traitement / GUI

- `Deb2`/`Deb3`/`Deb4` : extraire la construction de la requête en fonction pure
  `RequeteListe(sTri, sSel, iFiltre, bDesc, bContient) As String` (testable en gb.test, texte SQL
  comparé à l'octet près).
- `Maj_Zones` : extraire le calcul de la quantité en commande (`QteCommandee(sCode) As Float`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le tri sur `lpad(art_code,15,' ')` empêche l'usage d'un index : une colonne de tri normalisée
  (ou un code de longueur fixe) accélérerait la liste sur les grosses bases.
- Recherche « contient » sur `art_design` : index plein texte envisageable.
