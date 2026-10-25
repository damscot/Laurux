# Etiqart — Architecture

> Source : `.src/Gestion/Etiquettes/Etiqart.class`

## Vue d'ensemble

Écran d'impression des **étiquettes produit** (petites étiquettes article : code, deux lignes
d'intitulé, code-barres EAN13, prix TTC optionnel). Il est ouvert :
- depuis le menu (`Fmenu.Menu157_Click` et `Menu161_Click`, deux entrées identiques) par
  `New Etiqart("")` puis `ShowModal` ;
- depuis la fiche article (`Articles.Btn_click`, `Tag` 7, choix « 1- Article ») par
  `New Etiqart(Code.text)` : les bornes article sont alors fixées sur l'article courant.

Deux modes de sélection :
- **plage** : bornes article / famille / fournisseur, 5 tris (`Radiobutton1..5` : code, famille,
  fournisseur, désignation, casier), `Nbtiq` étiquettes par article, ou le stock de l'article si
  `EtiqStk` est coché ;
- **liste** (`Liste` coché) : table de travail SQL `Etiquettes(code, nombre)` créée par
  `liste_Click`, alimentée article par article (`Art_man`, avec cumul/remplacement), affichée dans
  la grille `Gridbart`, ou remplie par l'import du terminal portable (`Import_Portable`, bouton
  `Tag` 4).

La sortie est un **PDF** (`~/tmp/EtiqArt.pdf`, classe `CEtiquettes` héritée de `PdfWriter`) ouvert
par `Visualiseur.Prog` (commande `/Soc<XX>/caisse/CmdVis` ou `Desktop.Open`). Trois imprimantes
sont proposées (`/Soc<XX>/Impetiq`) : A4 (planche décrite dans `Fiches_Etiquettes`), Dymo (une
étiquette par page, format `dymog` 88 × 35 mm codé en dur) et Zebra (flux ZPL, **inatteignable**,
voir ZEBRA-A01).

Le fichier est la souche d'une famille de trois écrans quasi identiques : 753 lignes communes avec
[`Etiqcasier`](../Etiqcasier.class/architecture.md) (ratio 0,92) et 750 avec
[`Etigond`](../Etigond.class/architecture.md) (0,85) (mesure `dup.py`, lignes hors commentaires).

Nature globale : **mixte** (GUI, SQL et mise en page PDF entremêlés).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `rarts` | var | Private |  | Result | 27 |
| `rarts2` | var | Private |  | Result | 28 |
| `Tab` | var | Private |  | String | 29 |
| `Tab2` | var | Private |  | String | 30 |
| `code` | var | Private |  | String | 31 |
| `son` | var | Private |  | Integer | 32 |
| `Nbetiq` | var | Private |  | Integer | 33 |
| `txtPosX` | var | Private |  | Integer | 34 |
| `txtPosY` | var | Private |  | Integer | 35 |
| `SorP` | var | Private |  | Boolean | 36 |
| `CoulZns` | var | Private |  | Integer | 37 |
| `CoulZnaf` | var | Private |  | Integer | 38 |
| `CoulFc` | var | Private |  | Integer | 39 |
| `i2` | var | Private |  | Integer | 40 |
| `Nbre` | var | Private |  | Integer | 41 |
| `intitule` | var | Private |  | String | 42 |
| `intitule2` | var | Private |  | String | 43 |
| `Nblargeur` | var | Private |  | String | 44 |
| `Nbhauteur` | var | Private |  | String | 45 |
| `Largeur` | var | Private |  | Float | 46 |
| `Hauteur` | var | Private |  | Float | 47 |
| `Mrghaut` | var | Private |  | Float | 48 |
| `Mrgauche` | var | Private |  | Float | 49 |
| `Esplargeur` | var | Private |  | Float | 50 |
| `Esphauteur` | var | Private |  | Float | 51 |
| `Page` | var | Private |  | String | 52 |
| `Filename` | var | Private |  | String | 53 |
| `Bsel` | var | Public |  | Boolean | 55 |
| `Bval` | var | Public |  | String | 56 |
| `Origine` | var | Private |  | String | 58 |
| `b` | var | Private |  | Integer | 59 |
| `IpZebra` | var | Private |  | String | 60 |
| `ConnZbr` | var | Private |  | Boolean | 61 |
| `MySock` | var | Private |  | Socket | 62 |
| `pdf` | var | Private |  | Cetiquettes | 63 |
| `cd` | var | Private |  | String | 64 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 66-78 | Public | 1 | 11 | 0 | méthode spéciale |
| `Form_Open` | 80-114 | Public | 5 | 31 | 0 | handler GUI |
| `init_ComboBox` | 116-133 | Public | 5 | 14 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 135-140 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 142-147 | Public | 1 | 4 | 0 | handler GUI |
| `SelectionArt` | 150-176 | Public | 5 | 24 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 181-212 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam_KeyPress` | 217-237 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 242-273 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam2_KeyPress` | 278-298 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton5_Click` | 303-334 | Public | 5 | 29 | 0 | handler GUI |
| `Colfour_KeyPress` | 339-359 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton6_Click` | 364-395 | Public | 5 | 29 | 0 | handler GUI |
| `Colfour2_KeyPress` | 400-420 | Public | 6 | 17 | 0 | handler GUI |
| `Colfam_Click` | 425-433 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 438-446 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 451-459 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 464-471 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 473-499 | Public | 8 | 20 | 0 | handler GUI |
| `Btn_KeyPress` | 501-508 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 510-595 | Public | 22 | 73 | 0 | handler GUI |
| `liste_Click` | 597-622 | Public | 2 | 24 | 0 | handler GUI |
| `EtiqStk_Click` | 624-634 | Public | 2 | 9 | 0 | handler GUI |
| `Art_man` | 639-696 | Public | 13 | 55 | 0 | portée réductible ? |
| `Art1_man` | 698-713 | Public | 3 | 14 | 0 | portée réductible ? |
| `Art2_man` | 715-734 | Public | 4 | 18 | 0 | portée réductible ? |
| `ChkInput` | 736-744 | Public | 6 | 7 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 749-755 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 758-864 | Public | 24 | 103 | 0 | portée réductible ? |
| `fin_impression` | 866-878 | Public | 2 | 11 | 0 | portée réductible ? |
| `Imprime` | 881-955 | Public | 16 | 69 | 0 | portée réductible ? |
| `pos_Etiq` | 957-979 | Public | 4 | 21 | 0 | portée réductible ? |
| `pos_Etiq2` | 981-990 | Public | 2 | 8 | 0 | portée réductible ? |
| `Connect` | 992-1011 | Public | 6 | 17 | 0 | portée réductible ? |
| `Import_Portable` | 1016-1029 | Public | 3 | 12 | 0 | portée réductible ? |
| `Button1_Click` | 1031-1035 | Public | 1 | 3 | 0 | handler GUI |
| `Gridbart_Update` | 1037-1058 | Public | 5 | 19 | 0 | portée réductible ? |
| `Gridbart_Click` | 1060-1082 | Public | 5 | 19 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et ouverture

- **`_new(cod)`** [portée : nécessaire (constructeur, `Fmenu`, `Articles`)] [nature : GUI]. Mémorise
  le code article d'ouverture (`cd`) et prépare la grille `Gridbart` (3 colonnes, 4 lignes).
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. Couleurs (`/Coul/*`, valeurs
  jamais relues), **deux** appels `Utils.Observers(Me)` (l. 93 et 97 : observateurs de rejeu en
  double), coche l'imprimante selon `/Soc<XX>/Impetiq` (`"1- A4"`, `"2- Zebra"`, `"3- Dymo"`),
  bornes par défaut (`00000`–`ZZZZZ`, fournisseurs `40100001`–`40199999`, ou `cd`), puis
  `init_ComboBox`.
- **`init_ComboBox()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Etiquettes`
  (littéral, membre `Tab`) ; libellé `"<code> - <libellé>(<page>)"` (sans espace avant la
  parenthèse, contrairement aux écrans voisins). Erreur SQL ignorée.

### Sélection des bornes

- **`ToggleButton1_Click` / `ToggleButton2_Click`** [portée : nécessaire (handlers)] [nature :
  GUI]. Fixent `Origine` (`"1"` borne basse, `"2"` borne haute) et appellent `SelectionArt`.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. Ouvre `New TriArticles(True, False,
  "art_code", "", "", Null, False, False, Me)` en modal ; `TriArticles` écrit `Bsel`/`Bval` sur
  l'écran par `Object.SetProperty` (d'où `Bsel`/`Bval` **Public**). Reporte le code dans `Art` ou
  `Art2` ; en mode liste, ajoute l'article (`Art_man`).
- **`ToggleButton3_Click` … `ToggleButton6_Click`** [portée : nécessaire (handlers)] [nature :
  mixte]. Affichent/masquent les listes `Colfam`, `Colfam2` (`SELECT * FROM Cbase.Table("TabFam")
  order by code_fam`) et `Colfour`, `Colfour2` (`Cbase.Table("TabFour") order by fo_code`). Quatre
  corps identiques au nom du contrôle près.
- **`Colfam_KeyPress`, `Colfam2_KeyPress`, `Colfour_KeyPress`, `Colfour2_KeyPress`** [portée :
  nécessaire (handlers)] [nature : GUI]. Entrée → `<liste>_Click` ; F1 → aide ; Échap/F2 →
  ferme la liste. ⚠️ `Colfam2`/`Colfour2` redonnent le focus à `fam`/`four` puis sélectionnent
  `fam2`/`four2` (incohérence sans conséquence fonctionnelle).
- **`Colfam_Click`, `Colfam2_Click`, `Colfour_Click`, `Colfour2_Click`** [portée : nécessaire
  (handlers ; appelés par le rejeu via `Object.Call`)] [nature : GUI]. Recopient le code choisi,
  ferment la liste, focus sur la zone suivante.
- **`Art_man()`** [portée : réductible] [nature : mixte]. Code commençant par `*` → recherche par
  code-barres (`Utils.Find_Cbarre`, tables `CdBarre` puis `Art`). `SELECT * FROM TabArt where
  art_code = &1` ; inconnu → avertissement. En mode liste et si `art_etiq` est vrai :
  `INSERT INTO Etiquettes (code, nombre)` ; en cas de doublon (erreur de clé), question
  « Cumuler / Remplacer / Annuler » puis `UPdate Etiquettes SET code = &1, nombre = &2 WHERE code =
  &1`. Termine par `Gridbart_Update`. Partie extractible : l'ajout/cumul dans la table de travail.
- **`Art1_man()`** [portée : réductible] — **code mort** (`deps.py` `unused`, confirmé par grep) :
  contrôle d'existence de la borne basse, remplacé par `Art_man`.
- **`Art2_man()`** [portée : réductible] [nature : mixte]. Même contrôle pour la borne haute (avec
  `*` code-barres).
- **`Cmpt_KeyPress()`** (groupe des zones de saisie, CC 22) [portée : nécessaire (handler)]
  [nature : GUI]. Enchaînement Entrée/Tab selon `Tag` 1..8, `ChkInput` sur `Nbtiq`/`Posetiq`,
  F1 aide, F2 ouvre la liste correspondant au `Tag` (sauf `Tag` 2 : pas de F2 sur `Art2`,
  contrairement à `Etigond`).
- **`Cmpt_GotFocus()`** [portée : nécessaire (handler)] [nature : GUI]. `Utils.SetEditColor`.
- **`ChkInput()`** [portée : réductible] [nature : GUI]. Chiffres seulement (Tab non autorisé ici,
  autorisé dans `Etigond`).
- **`EtiqStk_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Masque `Nbtiq` quand le
  nombre d'étiquettes vient du stock.
- **`Btn_Click()`** (groupe `Btn`) [portée : nécessaire (handler)] [nature : GUI]. `Tag` 1 aide,
  2 impression, 3 suppression de `~/tmp/EtiqArt.ps` (fichier qu'aucun code ne produit plus) et
  fermeture, 4 import portable après confirmation (coche `Liste`).
- **`Btn_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée sur `Tag` 2 → impression.

### Table de travail « Etiquettes » (mode liste)

- **`liste_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Bascule l'affichage ;
  `drop Table IF exists Etiquettes` puis, en mode liste, `CREATE TABLE Etiquettes (code Char(15)
  NOT NULL, nombre integer, PRIMARY KEY (code))` + `Utils.db.Engine()`. ⚠️ Table **permanente**
  (alors que `Etigond` et `Eticli` créent une table `temporary` du même nom) : partagée entre
  postes et absente de `db_control.csv` (ETIQART-A04). Appelée aussi par `fin_impression`.
- **`Gridbart_Update()`** [portée : réductible] [nature : mixte]. Si la table existe
  (`Utils.db.Tables.Exist`), affiche code / désignation (une requête `TabArt` par ligne) /
  nombre. Réutilise les membres `Rarts`/`Rarts2`.
- **`Gridbart_Click()`** [portée : nécessaire (handler ; rejeu `Object.Call`)] [nature : mixte].
  Question « Cumuler / Remplacer / Supprimer » sur la ligne cliquée, `UPdate`/`Delete From
  Etiquettes`, puis rafraîchissement.
- **`Import_Portable()`** [portée : réductible] [nature : mixte]. `Portable.Import("Etiq")` lit
  `~/Portable/inventaire.txt` (code-barres ; nombre), insère dans `Etiquettes` et écrit les rejets
  dans `~/tmp/ImpT.txt` ; puis `Button2_Click` imprime, et si `Portable.cpt2 <> 0`, ouvre
  `Filename` dans l'éditeur. ⚠️ `Button2_Click` a remplacé `Filename` par le chemin du PDF : le
  rapport de rejets n'est jamais montré (ETIQART-A02). `Portable.cpt2` n'est jamais remis à zéro
  (module `Portable`). `Catch` → `Message.Error`.

### Impression

- **`Button2_Click()`** (CC 24) [portée : réductible (contrôle `Button2` du groupe `Btn`, appelé
  par `Btn_Click`/`Btn_KeyPress`/`Import_Portable`)] [nature : mixte]. Étapes :
  1. modèle obligatoire ; `SELECT * FROM Fiches_Etiquettes WHERE code = &1 and page = &2` (page
     extraite par `Scan(Codetiq.Text, "*(*)")[1]`), dimensions divisées par 10, `PageA =
     Split(page)` ;
  2. `Shell "cd ~"` (sans effet : sous-processus) ; `Kill` du PDF précédent ;
  3. `New CEtiquettes(PageA[1], "mm", PageA[0])` en A4, ou `("Portrait", "mm", "dymog")` en Dymo
     avec dimensions forcées (88 × 35, marges 0) ; **rien en Zebra** → `pdf.Open()` sur `Null`
     (ETIQART-A01) ;
  4. mode plage : une des 5 requêtes `SELECT * FROM TabArt WHERE art_code BETWEEN… art_fam…
     art_four… order by …` (bornes en `&1..&6`) ;
  5. `Posetiq - 1` positions sautées (`pos_Etiq` + `Inc Nbetiq`, sans impression) ;
  6. mode liste : `SELECT * FROM Etiquettes`, puis pour chaque ligne `Try rarts = SELECT … TabArt
     WHERE art_code = &1` et `Imprime` si la requête n'a pas échoué (un article supprimé donne un
     résultat vide et une erreur dans `Imprime`, ETIQART-A03) ; mode plage : `Imprime` par article ;
  7. `fin_impression`, ou message « Aucun article ».
- **`Imprime()`** [portée : réductible] [nature : mixte]. Lit l'article courant de `rarts`, le
  nombre d'étiquettes (`rarts2!nombre` en liste, `Nbtiq` sinon, ou `art_qte` tronqué si `EtiqStk` ;
  article non stocké → aucune étiquette), formate les prix (`Utils.Find_nbdec`, espace ajouté si
  une seule décimale). Pour chaque étiquette : position (`pos_Etiq` en A4, `pos_Etiq2` sinon),
  code, intitulés tronqués à `85 × ratio` / `90 × ratio` caractères, EAN13 si `art_cbarre` a 13
  caractères, prix TTC si `EtiqPrix`. Le ratio de police est `Largeur / 100`. Branche Zebra morte.
  Les variables `pvht`, `tva`, `fami`, `fourn` sont calculées sans être imprimées.
- **`pos_Etiq()`** [portée : réductible] [nature : calcul (état de planche)]. Variante « V1 » du
  calcul de position (voir § Commonalisation) : 1re colonne → retour en haut si `Nbetiq = 1`,
  sinon `X = 2 + Mrgauche + (Largeur + Esplargeur) × (Nbetiq - 1)` ; fin de ligne → ligne suivante ;
  `i2 >= Nbhauteur` → `pdf.NewPage()`. Identique à `Eticli.pos_Etiq`.
- **`pos_Etiq2()`** [portée : réductible] [nature : calcul]. Dymo : première étiquette en haut,
  sinon nouvelle page à chaque étiquette.
- **`fin_impression()`** [portée : réductible] [nature : mixte]. `pdf.Output`, `Visualiseur.Prog`,
  son, message « Traitement terminé », vide la grille et rappelle `liste_Click` (en mode liste : la
  table de travail est **vidée** par drop/create).
- **`Connect()`** [portée : réductible] — **code mort** (`unused`) : connexion TCP 9100 à
  `IpZebra` (jamais renseigné), attente active `Wait 0.1` ; seule source de `ConnZbr = True`
  (ZEBRA-A01).
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Etiqart")`.

## État global utilisé

- `Start.Musique`, `Start.Son`, `Start.Societe`, `Start.LocalSettings` (`/Coul/*`,
  `/Soc<XX>/Impetiq`).
- `Utils.db` (dont `Tables.Exist`, `Engine`), `Utils.FColr`, `Utils.Observers`,
  `Utils.SetEditColor`, `Utils.Find_Cbarre`, `Utils.Find_nbdec`, `Utils.cpoint`, `Cbase.Table`.
- `Portable.Import`, `Portable.cpt2` (global du module `Portable`), `Editeur.Prog_Editeur`,
  `Visualiseur.Prog`, `Doc.Open`, `TriArticles`, `CEtiquettes`, `Zebra`.
- Fichiers : `~/tmp/EtiqArt.pdf` (partagé avec `Etiqcasier`), `~/tmp/EtiqArt.ps` (supprimé, jamais
  créé), `~/tmp/ImpT.txt`, `~/Portable/inventaire.txt`.
- Membres d'état de planche : `Nbetiq`, `i2`, `txtPosX`, `txtPosY`, dimensions ; `rarts`/`rarts2`
  partagés entre l'impression, la saisie en liste et la grille.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Button2_Click` (CC 24) : `ChargeFormat()`, `OuvrePdf()`, `RequeteArticles()` (les 5
  requêtes ne diffèrent que par le `ORDER BY` : un tableau de clauses indexé par le tri choisi),
  `SauteEtiquettes(n)`, boucle d'impression.
- `Imprime` : séparer la lecture de l'article (structure de valeurs), le calcul du nombre
  d'étiquettes et le dessin.
- Supprimer `Art1_man`, les membres jamais lus (`SorP`, `CoulZns`, `CoulZnaf`, `CoulFc`, `dte`),
  le `Shell "cd ~"` sans effet et le `Kill` du `.ps` obsolète.
- Un seul `Utils.Observers(Me)`.

### Commonalisation avec d'autres fichiers

**1. Socle `PlancheEtiquettes`** (classe sans GUI, proposée par FCLIENT-014 / FFOURNISSEUR-013 dans
[`FClient`](../../Tables/FClient.class/architecture.md) et
[`FFournisseur`](../../Tables/FFournisseur.class/architecture.md)). Mesure `dup.py` : avec les
fiches tiers, le recouvrement est faible (55 à 146 lignes, ratio ≤ 0,09) et se limite exactement à
ce socle ; entre écrans d'étiquettes il est de 86 à 241 lignes hors famille Etiqart. Contenu :

| Élément du socle | Copies actuelles |
|---|---|
| `Modeles(format)` : liste `Fiches_Etiquettes` pour un `ComboBox` (3 formats de libellé) | `init_ComboBox` de Etiqart, Etigond, Etiqcasier, Eticli, EtiqRecpt, EtiqPromo, Etiqfbtarif, Etiquettes, FClient (+ FFournisseur) |
| `Charge(code [, page])` : 8 dimensions ÷ 10, `Page`, `PageA` | Button2_Click de Etiqart, Etiqcasier, Eticli, EtiqRecpt, EtiqPromo, Etiqfbtarif ; `Init` de Etigond et EtiqPromo ; FClient.Button13_Click, FFournisseur.Button15_Click |
| `Ouvre(imprimante)` : `New CEtiquettes` A4 / `dymog` / `dymoc` + dimensions Dymo forcées | Etiqart, Etigond, Etiqcasier, EtiqRecpt, EtiqPromo, Etiqfbtarif |
| `Suivante()` / `Saute(n)` : état `Nbetiq`, `i2`, `X`, `Y`, saut de page | `pos_Etiq` (8 copies), `pos_Etiq2`, boucles `Posetiq` |
| `Termine(fichier)` : `Output` + `Visualiseur.Prog` (+ son, message chez l'appelant) | `fin_impression` (7 copies) |

Les copies de `pos_Etiq` ne sont **pas** équivalentes ; pour garder des PDF identiques, le socle
doit d'abord exposer les variantes comme options, l'harmonisation étant une anomalie à valider :

| Variante | X de la colonne n | Saut de page | Retour en haut quand `Nbetiq = 1` | Branche Dymo | Fichiers |
|---|---|---|---|---|---|
| V1 | `(Largeur + Esplargeur) × (n-1)` | `i2 >= Nbhauteur` | oui | non | Etiqart, Eticli (corps identiques) |
| V2 | idem V1 | `>=` | oui | oui | Etigond, EtiqRecpt (corps identiques) |
| V3 | `Largeur × (n-1) + Esplargeur` | `>=` | oui | non | Etiqcasier |
| V4 | `Largeur × (n-1) + Esplargeur` | `>=` | non | non | Etiqfbtarif |
| V5 | `Largeur × (n-1) + Esplargeur` | `i2 > Nbhauteur` | non | oui | EtiqPromo |
| V6 | V5 + mode « colis » (`sFetiq`) | `>` | non | non | FClient, FFournisseur |

La formule `Largeur × (n-1) + Esplargeur` (V3-V6) n'ajoute l'espacement qu'une fois quel que soit
le rang de la colonne : décalage dès la 3e colonne si `Esplargeur ≠ 0` ; le seuil `>` imprime une
rangée de trop par page (voir les anomalies de chaque fichier).

**2. Module `EtiqArticles`** pour la famille Etiqart / [`Etigond`](../Etigond.class/architecture.md)
/ [`Etiqcasier`](../Etiqcasier.class/architecture.md) (≈ 650 lignes identiques par écran) : listes
famille/fournisseur (`ToggleButton3..6`, `Col*_KeyPress`, `Col*_Click` : 12 fonctions × 3 écrans,
handlers conservés et réduits à un appel), contrôle de borne (`Art_man`/`Art2_man`), requête de
sélection à 5 tris, table de travail `Etiquettes` (création, ajout/cumul, grille), import portable
et connexion Zebra. Les fonctions prennent l'écran (`Form`) ou les contrôles en paramètre.

**3. Table de travail `Etiquettes`** : même structure créée par `Etiqart`, `Etigond`,
`Etiqcasier`, [`Eticli`](../Eticli.class/architecture.md) et alimentée par `Portable.module` :
un helper unique `EtiqArticles.TableListe(creer As Boolean)` (en conservant `temporary` ou non selon
l'écran tant que ETIQART-A04 n'est pas tranchée).

**4. Code-barres** : l'écran imprime `art_cbarre` tel quel (EAN13 via `PdfWriter.EAN13`, qui
calcule la clé si 12 chiffres sont fournis) et ne fait que la recherche inverse par
`Utils.Find_Cbarre`. Il n'utilise ni `Utils.Calcode` ni le préfixe `"299999"` (propres à
`FClientcarte`, `FFournisseur` et `Articles`) : pas de commonalisation à faire ici.

### Réduction de portée

- `init_ComboBox`, `SelectionArt`, `Art_man`, `Art2_man`, `ChkInput`, `Button2_Click`,
  `fin_impression`, `Imprime`, `pos_Etiq`, `pos_Etiq2`, `Import_Portable`, `Gridbart_Update` :
  aucun appelant externe (grep) → `Private`. Restent `Public` : les handlers, `Gridbart_Click` et
  `Col*_Click` (rejeu), `Bsel`/`Bval` (écrits par `TriArticles` via `Object.SetProperty`), `_new`.
  `Art1_man` et `Connect` sont traités comme code mort / anomalie.

### Séparation traitement / GUI

- `ListeAjoute(code, nombre, mode)` (SQL de la table de travail) sans `Message` ;
  `NombreEtiquettes(rArt, liste, saisie, stock)` pur ; requêtes dans `RequeteArticles`. Les
  handlers gardent les questions et messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table de travail `Etiquettes` à déclarer dans le schéma (`Fiches_EtiqListe`, avec un identifiant
  de poste/utilisateur) plutôt que créée à la volée, permanente ici et temporaire ailleurs.
- `Fiches_EtiProd` (alimentée par les réceptions) a la même structure `(code, nombre)` : une seule
  table de file d'impression typée (produit, gondole, casier, liste manuelle) unifierait
  `Etiqart`, `Etigond`, `Etiqcasier` et `EtiqRecpt`.
- Dimensions Dymo (88 × 35, 25 × 25) à stocker dans `Fiches_Etiquettes` avec le type d'imprimante.
