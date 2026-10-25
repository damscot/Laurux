# Etiqcasier — Architecture

> Source : `.src/Gestion/Etiquettes/Etiqcasier.class`

## Vue d'ensemble

Écran d'impression des **étiquettes de casier** (emplacement de rangement : casier en gros corps,
code, intitulé, EAN13, stock). Ouverture : `Fmenu.Menu302_Click` (`New Etiqcasier("")`, modal) et
`Articles.Btn_click` (`Tag` 7, « 3- Casier », `New Etiqcasier(Code.text)`).

Copie de [`Etiqart`](../Etiqart.class/architecture.md) à 92 % (753 lignes communes, `dup.py`).
Différences :
- pas de grille `Gridbart` : en mode liste, les codes saisis s'affichent dans le `TextLabel`
  `listBart` ; pas de `Gridbart_Update`/`Gridbart_Click` ;
- `Art_man` n'accepte en liste que les articles avec `art_etiq` **et** un casier renseigné ;
  `Art1_man` (morte) gère en plus le préfixe `*` code-barres ;
- format chargé par **code seul** (`WHERE code = &1`, sans la page : la première page trouvée pour
  ce code est utilisée, quel que soit le choix affiché) ;
- Dymo : format `dymoc` (25 × 25 mm) mais dimensions lues dans la base (non forcées) ;
- `Imprime` : mise en page A4 « casier » (casier, code, stock, intitulé ≤ 45 car., EAN13) ou Dymo
  (`casierc`, `Codec`, `Intitulec` ≤ 25 car., EAN13, `stockc`), toujours `pos_Etiq` ;
- `pos_Etiq` variante **V3** (espacement ajouté une seule fois) ;
- sortie `~/tmp/EtiqArt.pdf`, **même fichier** qu'Etiqart ; aide `Doc.Open("Etiqart")`.

Nature globale : **mixte**.

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
| `Filename` | var | Private |  | String | 52 |
| `Bsel` | var | Public |  | Boolean | 54 |
| `Bval` | var | Public |  | String | 55 |
| `Origine` | var | Private |  | String | 57 |
| `b` | var | Private |  | Integer | 58 |
| `IpZebra` | var | Private |  | String | 59 |
| `ConnZbr` | var | Private |  | Boolean | 60 |
| `MySock` | var | Private |  | Socket | 61 |
| `pdf` | var | Private |  | Cetiquettes | 62 |
| `cd` | var | Private |  | String | 63 |
| `Page` | var | Private |  | String | 64 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 66-70 | Public | 1 | 3 | 0 | méthode spéciale |
| `Form_Open` | 72-106 | Public | 5 | 31 | 0 | handler GUI |
| `init_ComboBox` | 108-124 | Public | 5 | 14 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 126-131 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 133-138 | Public | 1 | 4 | 0 | handler GUI |
| `SelectionArt` | 141-167 | Public | 5 | 24 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 172-203 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam_KeyPress` | 208-228 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton4_Click` | 233-264 | Public | 5 | 29 | 0 | handler GUI |
| `Colfam2_KeyPress` | 269-289 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton5_Click` | 294-325 | Public | 5 | 29 | 0 | handler GUI |
| `Colfour_KeyPress` | 330-350 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton6_Click` | 355-386 | Public | 5 | 29 | 0 | handler GUI |
| `Colfour2_KeyPress` | 391-411 | Public | 6 | 17 | 0 | handler GUI |
| `Colfam_Click` | 416-424 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 429-437 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 442-450 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 455-462 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 464-490 | Public | 8 | 20 | 0 | handler GUI |
| `Btn_KeyPress` | 492-499 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 501-586 | Public | 22 | 73 | 0 | handler GUI |
| `liste_Click` | 588-616 | Public | 2 | 27 | 0 | handler GUI |
| `EtiqStk_Click` | 618-628 | Public | 2 | 9 | 0 | handler GUI |
| `Art_man` | 633-690 | Public | 14 | 56 | 0 | portée réductible ? |
| `Art1_man` | 692-711 | Public | 4 | 18 | 0 | portée réductible ? |
| `Art2_man` | 713-732 | Public | 4 | 18 | 0 | portée réductible ? |
| `ChkInput` | 734-742 | Public | 6 | 7 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 747-753 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 756-858 | Public | 24 | 99 | 0 | portée réductible ? |
| `fin_impression` | 860-873 | Public | 2 | 11 | 0 | portée réductible ? |
| `Imprime` | 876-943 | Public | 16 | 64 | 0 | portée réductible ? |
| `pos_Etiq` | 945-967 | Public | 4 | 21 | 0 | portée réductible ? |
| `Connect` | 969-988 | Public | 6 | 17 | 0 | portée réductible ? |
| `Import_Portable` | 993-1006 | Public | 3 | 12 | 0 | portée réductible ? |
| `Button1_Click` | 1008-1012 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions communes sont décrites dans
[Etiqart › Description des fonctions](../Etiqart.class/architecture.md#description-des-fonctions).

### Communes avec Etiqart (même comportement)

- `_new` [nécessaire ; pas de préparation de grille], `Form_Open` [handler ; deux
  `Utils.Observers(Me)`, l. 85 et 89], `init_ComboBox` [réductible ; libellé `" (" & page & ")"`],
  `ToggleButton1..6_Click`, `Colfam*`/`Colfour*` `_KeyPress` et `_Click` [handlers ; `_Click`
  rejoués par `Object.Call`], `SelectionArt` [réductible], `Btn_Click`, `Btn_KeyPress`,
  `Cmpt_KeyPress` (CC 22), `Cmpt_GotFocus`, `EtiqStk_Click` [handlers], `Art2_man`, `ChkInput`
  [réductibles], `Import_Portable` [réductible ; même défaut ETIQART-A02], `Button1_Click`
  [handler ; aide `Etiqart`].
- **`Art1_man()`** — **code mort** (`unused`, grep).
- **`Connect()`** — **code mort** (`unused`) ; ZEBRA-A01.

### Différences

- **`liste_Click()`** [handler] [nature : mixte]. Bascule `listBart` ; `CREATE TABLE Etiquettes`
  **permanente** (comme Etiqart, ETIQART-A04) ; focus sur `Art`.
- **`Art_man()`** [réductible] [nature : mixte]. Comme Etiqart ; condition `Rarts!art_etiq And
  Rarts!art_casier` (Booléen `And` chaîne `char(5)` : une chaîne non vide vaut vrai — conversion à
  confirmer) ; ajoute le code au texte de `listBart`.
- **`Button2_Click()`** (CC 24) [réductible] [nature : mixte]. Comme Etiqart, mais format lu par
  `code` seul (l. 775) et Dymo `dymoc` sans dimensions forcées ; Zebra → pas de PDF, `pdf.Open()`
  sur `Null` (l. 798).
- **`Imprime()`** [réductible] [nature : mixte]. Lit casier, stock (`art_qte` en Float), etc. ;
  `pos_Etiq` puis dessin A4 (ratio `Largeur/100`) ou Dymo (ratio `Largeur/50`). Branche Zebra
  morte (l. 936).
- **`pos_Etiq()`** [réductible] [nature : calcul]. Variante V3 :
  `X = 2 + Mrgauche + Largeur × (n-1) + Esplargeur` (l'espacement n'est compté qu'une fois).
- **`fin_impression()`** [réductible]. Comme Etiqart, vide `listBart` et le modèle choisi.

## État global utilisé

- Comme Etiqart. Fichiers `~/tmp/EtiqArt.pdf` (partagé avec Etiqart), `~/tmp/EtiqArt.ps`,
  `~/tmp/ImpT.txt`, `~/Portable/inventaire.txt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Mêmes découpages qu'Etiqart (`Button2_Click` CC 24, `Imprime`), suppression du code mort
  (`Art1_man`, membres jamais lus, `Shell "cd ~"`, second `Utils.Observers`).

### Commonalisation avec d'autres fichiers

- Module `EtiqArticles` et socle `PlancheEtiquettes` : voir
  [Etiqart › Commonalisation](../Etiqart.class/architecture.md#commonalisation-avec-dautres-fichiers)
  (variante V3).
- La mise en page casier est **dupliquée** dans [`EtiqRecpt`](../EtiqRecpt.class/architecture.md)
  (branche « casier », mêmes appels `casier`/`Code`/`Intitule`/`Barcode`/`stock` à un décalage
  près pour le stock, et version Dymo identique) : `PlancheEtiquettes.DessineCasier(valeurs)` après
  preuve d'égalité des PDF.

### Réduction de portée

- `init_ComboBox`, `SelectionArt`, `Art_man`, `Art2_man`, `ChkInput`, `Button2_Click`,
  `fin_impression`, `Imprime`, `pos_Etiq`, `Import_Portable` → `Private`. `Bsel`/`Bval` restent
  `Public` (TriArticles).

### Séparation traitement / GUI

- Comme Etiqart (`ListeAjoute`, `NombreEtiquettes`, `RequeteArticles`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir Etiqart (table de travail déclarée, type d'imprimante et dimensions Dymo dans
  `Fiches_Etiquettes`).
