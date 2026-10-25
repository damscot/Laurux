# facopt — Architecture

> Source : `.src/Gestion/option/facopt.class`

## Vue d'ensemble

`facopt` gère les **onglets « consignes » et « régie »** de l'écran de saisie des factures
([`Facture`](../../Facturation/Facture.class/architecture.md)) quand l'option boisson est active
(`B`/`T`). Ce n'est pas un formulaire (aucun `.form`) : `Facture.modifpanel5` l'instancie par
`New Facopt(Panelcons, Panelregi) As "option"` et la classe **construit ses contrôles par code**
dans les deux panneaux reçus :

- panneau régie : grille `$gridregi` (droits par ligne d'alcool) et totaux (volume, AP, droits,
  sécu) ;
- panneau consignes : grille des consignes du BL (`$gridcons`), cadre de saisie des déconsignes
  (article, codes palette/colis/bouteille, quantités, bouton de validation), grille des
  déconsignes (`$gridsaisie`) et totaux.

Elle écrit directement dans `Fiches_ligcons` (consignes `type = 'B'`, déconsignes `numlig =
'D'`) et lit `Fiches_ligregie`, `Fiches_regie`, `Fiches_consigne`, `Fiches_Art`, `Fiches_Ligbl`,
`Fiches_Bl`. Elle lève l'événement `recalcul` à chaque changement du total des déconsignes ;
`Facture.option_recalcul` recalcule alors la fin de document.

Nature globale : **mixte**, la plupart des fonctions combinent SQL et remplissage de grilles.
`Utils.Observers(Me)` est commenté (l. 68) : les contrôles créés ici ne sont pas instrumentés
pour le rejeu, sauf si l'appel de `Facture` les couvre (à confirmer).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 6 |
| `Bval` | var | Public |  | String | 7 |
| `$pancons` | var | Private |  | Panel | 10 |
| `$panregi` | var | Private |  | Panel | 11 |
| `$gridcons` | var | Private |  | GridView | 12 |
| `$gridsaisie` | var | Private |  | GridView | 13 |
| `$gridregi` | var | Private |  | GridView | 14 |
| `$lab` | var | Private |  | Label | 15 |
| `$fram` | var | Private |  | Frame | 16 |
| `$texttotvol` | var | Private |  | TextBox | 17 |
| `$texttotap` | var | Private |  | TextBox | 18 |
| `$texttotdr` | var | Private |  | TextBox | 19 |
| `$texttotss` | var | Private |  | TextBox | 20 |
| `$textart` | var | Private |  | TextBox | 21 |
| `$textconsp` | var | Private |  | TextBox | 22 |
| `$textnbp` | var | Private |  | TextBox | 23 |
| `$textconsc` | var | Private |  | TextBox | 24 |
| `$textnbc` | var | Private |  | TextBox | 25 |
| `$textconsb` | var | Private |  | TextBox | 26 |
| `$textnbb` | var | Private |  | TextBox | 27 |
| `$texttotcons` | var | Private |  | TextBox | 28 |
| `$texttotdeco` | var | Private |  | TextBox | 29 |
| `$but` | var | Private |  | Button | 30 |
| `$fc` | var | Private |  | Float | 31 |
| `$inbc` | var | Private |  | Integer | 33 |
| `$inbb` | var | Private |  | Integer | 34 |
| `$ideb` | var | Private |  | Integer | 35 |
| `$ifin` | var | Private |  | Integer | 36 |
| `$bartcons` | var | Private |  | Boolean | 37 |
| `$bclicons` | var | Private |  | Boolean | 38 |
| `$ftvadra` | var | Private |  | Float | 39 |
| `$bimp` | var | Private |  | Boolean | 41 |
| `$bcreer` | var | Private |  | Boolean | 42 |
| `$snumbl` | var | Private |  | String | 43 |
| `$calcool` | var | Private |  | Collection | 44 |
| `regie` | property | Public |  | Boolean | 46 |
| `consigne` | property | Public |  | Boolean | 47 |
| `imprime` | property | Public |  | Boolean | 48 |
| `numbl` | property | Public |  | String | 49 |
| `artcons` | property | Public |  | Boolean | 50 |
| `clicons` | property | Public |  | Boolean | 51 |
| `tvadroit` | property | Public |  | Float | 52 |
| `texttotcons` | property | Public |  | TextBox | 53 |
| `texttotdeco` | property | Public |  | TextBox | 54 |
| `texttotdr` | property | Public |  | TextBox | 55 |
| `texttotss` | property | Public |  | TextBox | 56 |
| `textmondr` | property | Public |  | TextBox | 57 |
| `textmonss` | property | Public |  | TextBox | 58 |
| `lignedroit` | property | Public |  | Collection | 59 |
| `recalcul` | event | Public |  |  | 61 |
<!-- /AUTO:declarations -->

### Membres : usage réel (vérifié par `grep`)

| Membre | Usage |
|---|---|
| `Bsel`, `Bval` (Public) | positionnés par `TriArticles` via `Object.SetProperty` (`rechart_Click`) : **doivent rester `Public`** |
| `numbl`, `clicons`, `imprime` (propriétés) | écrites par `Facture` (1591, 2128-2129, 2215, 10335, 10769…) |
| `regie`, `consigne`, `artcons`, `texttotcons`, `texttotdeco`, `texttotdr`, `texttotss`, `tvadroit` | aucun lecteur (seules des lignes commentées de `Facture:2561-2562`) → code mort |
| `textmondr`, `textmonss`, `lignedroit` | lecteurs vides, aucun usage → code mort |
| `$calcool`, `$bcreer` (écrit seulement), `$bartcons` (via `artcons`) | code mort |
| `$ftvadra` | calculé par `affdroit`, lu seulement par `tvadroit` (mort) |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 63-259 | Public | 1 | 182 | 0 | méthode spéciale |
| `grpnb_GotFocus` | 262-266 | Public | 2 | 3 | 0 | handler GUI |
| `grpnb_LostFocus` | 268-272 | Public | 2 | 4 | 0 | handler GUI |
| `grpnb_KeyPress` | 274-318 | Public | 19 | 43 | 0 | handler GUI |
| `grpcle_gotfocus` | 320-325 | Public | 2 | 3 | 0 | handler GUI |
| `grpcle_lostfocus` | 327-334 | Public | 3 | 6 | 0 | handler GUI |
| `grpcle_keypress` | 336-358 | Public | 9 | 21 | 0 | handler GUI |
| `rechcons_Click` | 360-367 | Public | 1 | 5 | 0 | handler GUI |
| `rechcons_trouver` | 369-383 | Public | 4 | 13 | 0 | handler GUI |
| `verifcons` | 385-411 | Private | 6 | 24 | 0 |  |
| `butval_Click` | 413-417 | Public | 1 | 3 | 0 | handler GUI |
| `textart_LostFocus` | 420-456 | Public | 16 | 34 | 0 | handler GUI |
| `textart_KeyPress` | 458-465 | Public | 4 | 6 | 0 | handler GUI |
| `rechart_Click` | 467-478 | Public | 2 | 9 | 0 | handler GUI |
| `affdroit` | 480-561 | Public | 7 | 77 | 1 |  |
| `majdroit` | 563-583 | Public | 2 | 18 | 0 | portée réductible ? |
| `affcons` | 585-606 | Public | 3 | 18 | 1 |  |
| `affdecons` | 608-628 | Public | 3 | 18 | 1 |  |
| `tdec_Change` | 630-634 | Public | 1 | 3 | 0 | handler GUI |
| `majlig` | 637-700 | Public | 17 | 59 | 1 |  |
| `copdecons` | 702-724 | Public | 3 | 20 | 1 |  |
| `suplig` | 726-730 | Public | 1 | 3 | 1 |  |
| `deplig` | 732-764 | Public | 7 | 28 | 1 |  |
| `gridcons_MouseUp` | 767-791 | Public | 3 | 22 | 0 | handler GUI |
| `ajoutcons` | 792-807 | Private | 1 | 13 | 0 |  |
| `valide` | 810-872 | Private | 15 | 59 | 0 |  |
| `verifnb` | 874-887 | Private | 5 | 12 | 0 |  |
| `gridsaisie_Activate` | 890-921 | Public | 6 | 30 | 0 | handler GUI |
| `gridsaisie_KeyPress` | 923-938 | Public | 5 | 14 | 0 | handler GUI |
| `mabsaisie` | 940-953 | Public | 1 | 12 | 0 | portée réductible ? |
| `regie_Read` | 955-963 | Private | 2 | 7 | 0 |  |
| `consigne_Read` | 965-973 | Private | 3 | 7 | 0 |  |
| `imprime_Read` | 975-979 | Private | 1 | 3 | 0 |  |
| `imprime_write` | 981-985 | Private | 1 | 3 | 0 |  |
| `numbl_Read` | 987-991 | Private | 1 | 3 | 0 |  |
| `numbl_Write` | 993-1000 | Private | 1 | 7 | 0 |  |
| `artcons_Read` | 1002-1006 | Private | 1 | 3 | 0 |  |
| `artcons_Write` | 1008-1012 | Private | 1 | 3 | 0 |  |
| `clicons_Read` | 1014-1018 | Private | 1 | 3 | 0 |  |
| `clicons_Write` | 1020-1024 | Private | 1 | 3 | 0 |  |
| `texttotcons_Read` | 1026-1030 | Private | 1 | 3 | 0 |  |
| `texttotdeco_Read` | 1032-1036 | Private | 1 | 3 | 0 |  |
| `texttotdr_Read` | 1038-1042 | Private | 1 | 3 | 0 |  |
| `texttotss_Read` | 1044-1048 | Private | 1 | 3 | 0 |  |
| `tvadroit_Read` | 1050-1054 | Private | 1 | 3 | 0 |  |
| `textmondr_Read` | 1056-1060 | Private | 1 | 2 | 0 |  |
| `textmonss_Read` | 1062-1066 | Private | 1 | 2 | 0 |  |
| `lignedroit_Read` | 1068-1072 | Private | 1 | 2 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(pcons, pregi)`** [portée : nécessaire (constructeur)] [nature : GUI] (182 LOC).
  Construit toutes les grilles, étiquettes, zones et boutons, avec un facteur d'échelle `$fc =
  largeur / 880`. Groupes d'événements : `gridregi`, `gridcons`, `gridsaisie`, `textart`,
  `rechart`, `rechcons` (×3, `Tag` = `P`/`C`/`B`), `grpnb` (3 zones de quantité), `butval`,
  `tdec` ; observateurs `grpcle` sur les 3 zones de code consigne (l'observateur de `$textart`
  est commenté). Les zones de code ont pour `Tag` l'étiquette de libellé associée.

### Saisie des déconsignes

- **`grpnb_GotFocus` / `grpnb_LostFocus`** [handlers] [GUI] : couleurs de focus (`Utils.ObsGotf`/
  `ObsLstf`), désélection.
- **`grpnb_KeyPress`** [handler] [GUI] (CC 19, maximum). Entrée/Tab : si la quantité est valide
  (`verifnb`), calcule la quantité suivante (palettes × colis par palette, colis × bouteilles par
  colis) et avance ; sur la dernière zone, `valide`. ⚠️ La branche « Zone numérique » est
  inatteignable (`verifnb` contient déjà `IsNumber`) : une saisie non numérique est ignorée en
  silence (A05).
- **`grpcle_gotfocus` / `grpcle_lostfocus` / `grpcle_keypress`** [handlers d'observateur] [GUI].
  Perte de focus : `verifcons`. Entrée sur une zone vide : quantité à 0 et zone suivante (ou
  `valide`). Le test `Last <> $textart` est toujours vrai (pas d'observateur sur `$textart`).
- **`rechcons_Click`** [handler] [GUI] : ouvre `Rechcons(Tag)` (`As "rechcons"`).
  **`rechcons_trouver(value)`** [handler de l'événement `trouver` de `Rechcons`] : recopie le
  code selon `Last.Tag` (le `Tag` du formulaire `Rechcons`, fixé à son ouverture).
- **`verifcons(textb)`** [Private] [mixte]. Lit `Fiches_consigne` (code + type) ; libellé dans
  l'étiquette, sinon bulle « Consigne inconnue » et effacement.
- **`butval_Click`** [handler] : `valide`.
- **`textart_LostFocus` / `textart_KeyPress`** [handlers] [mixte]. Lit l'article
  (`Fiches_Art`) ; reprend ses codes de consigne et nombres colis/bouteilles, sinon bulle
  « Article innexistant » / « Article sans consigne ».
- **`rechart_Click`** [handler] [GUI] : `New TriArticles(True, False, "art_code", "", "", Null,
  False, False, Me)` (5 obligatoires, `Parent` = `Null`, optionnels ; appel correct), retour par
  `Bsel`/`Bval`.
- **`valide()`** [Private] [mixte] (CC 15). Sauf si `$bimp` ou BL vide : une ligne
  `Fiches_ligcons` (`type B`, `numlig D`, `nb` négatif, montant = nb × prix si client consigné)
  par type renseigné, ajoutée à la grille ; transaction ; total mis à jour ; `mabsaisie`. Trois
  blocs identiques (le 3e teste `$textnbb` au lieu de `$textconsb`, sans effet visible car la
  consigne vide n'est pas trouvée).
- **`verifnb(value)`** [Private] [calcul]. Nombre entier non nul.
- **`mabsaisie()`** [portée : réductible (aucun appel externe)] [GUI]. Vide la zone de saisie.

### Affichage

- **`affdroit(num)`** [portée : nécessaire (`Facture` ×4)] [mixte]. Facture éditée : lignes
  `Fiches_ligregie × Fiches_regie × Fiches_Art × Fiches_Bl` (`numbl = num`, `num = numfac`) ;
  sinon recalcul par `Calculdroit` sur `Fiches_Ligbl` (articles `art_dra`), droits affichés
  seulement si suspendu ou `drsurfac`. Totaux ; `$ftvadra` (TVA des droits, calculée de deux
  façons différentes selon la branche). La colonne « Libelle » reçoit `drt.lib`, dont le lecteur
  de `Calculdroit` ne renvoie rien (colonne vide, A04).
- **`affcons(value)`** [portée : nécessaire (`Facture` ×4)] [mixte]. Consignes du BL
  (`type B`, `numlig <> 'D'`) via `ajoutcons` ; total.
- **`affdecons()`** [portée : nécessaire (`Facture` ×4)] [mixte]. Déconsignes du BL courant
  (`$snumbl`) ; total (déclenche `tdec_Change`).
- **`ajoutcons(grid, cle, nomb, tot, i)`** [Private] [mixte]. Lit `Fiches_consigne` (sans test
  `Available`) et remplit une ligne de grille.
- **`tdec_Change`** [handler] : `Raise recalcul`.

### Mise à jour depuis la facture

- **`majlig(num, numlig, textpal, textcol, artqte, checkcons)`** [portée : nécessaire
  (`Facture:8767/8949/10398`)] [calcul]. Sauf si `$bimp` : supprime puis recrée les consignes de
  la ligne (`numlig = num & numlig`) pour palette, colis, bouteilles d'après l'article
  (`Fiches_Ligbl` → `Fiches_Art` → `Fiches_consigne`, sans test `Available`) ; renvoie le
  montant. Trois blocs identiques.
- **`copdecons(numfac, numbl)`** [portée : nécessaire (`Facture:10312`)] [calcul]. Avoir :
  recopie les déconsignes de la facture sur le BL avec signes inversés.
- **`suplig(num, numlig)`** [portée : nécessaire (`Facture` ×4)] [calcul]. Supprime les
  consignes de la ligne.
- **`deplig(num, numlig, numlig1)`** [portée : nécessaire (`Facture:8440/8535`)] [calcul].
  Échange les numéros de ligne des consignes de deux lignes (si les deux existent).
- **`majdroit(num, numlig)`** [portée : réductible] **code mort** (commentaire « sert a rien ») :
  utiliserait `reslig` et `drt` non initialisés (erreur si appelée).

### Grilles

- **`gridcons_MouseUp`** [handler] [mixte]. Clic gauche : crée une déconsigne pour **chaque
  ligne entre la première et la dernière ligne sélectionnées** (lignes non sélectionnées
  incluses), sans contrôle de `$bimp` (A01, A02).
- **`gridsaisie_Activate`** [handler] [mixte]. Recharge la déconsigne choisie dans la zone de
  saisie puis la **supprime** de la base (`DELETE … WHERE code = <auto-incrément>`) ; sans contrôle
  de `$bimp` (A01, A03).
- **`gridsaisie_KeyPress`** [handler] [mixte]. Suppr : supprime la déconsigne ; Entrée :
  `gridsaisie_Activate`. Sans contrôle de `$bimp` (A01).

### Propriétés

`numbl` (écriture : `affdroit`, `affcons`, `affdecons`), `imprime`, `clicons` [nécessaires] ;
`artcons`, `regie`, `consigne`, `texttot*`, `tvadroit`, `textmondr`, `textmonss`, `lignedroit`
[code mort].

## Tables

`Fiches_ligcons`, `Fiches_consigne`, `Fiches_ligregie`, `Fiches_regie` (créées par
[`modfichier`](../modfichier.module/architecture.md), absentes de `db_control.csv`), `Fiches_Art`,
`Fiches_Ligbl`, `Fiches_Bl` (en dur, sans variante `M`).

## État global utilisé

`Utils.db` (`Exec`, `Create9`, `Edit`, `Begin`, `Commit`), `Utils.totobs`, `Utils.ObsGotf`/
`ObsLstf`, `Balloon`, `Key`, `Mouse`, `Last`. Classes `Calculdroit`, `Rechcons`, `TriArticles`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` (182 LOC) : helpers `CreeGrille(parent, titres[], largeurs[])` et
  `CreeZoneConsigne(x, type)` (trois blocs identiques palette/colis/bouteilles).
- `valide` et `majlig` : helper `CreeLigneCons(num, numlig, code, nb, prixActif) As Float` (six
  blocs identiques), même ordre des requêtes.
- `affcons`/`affdecons` : `RemplitGrille(grid, result) As Float`.

### Commonalisation avec d'autres fichiers

- Lecture d'une consigne par code (`SELECT * FROM Fiches_consigne WHERE code = &1`) : ici ×6,
  dans [`artopt`](../artopt.class/architecture.md) ×5, `Rechcons`, `Saisiedecons`,
  `Tconsigne` : helper `LitConsigne(code) As Result` dans un module de l'option boisson.
- Recalcul des droits d'une ligne (`Calculdroit` sur `Fiches_Ligbl`) : logique proche de
  [`ObjFacB.calcul`](../ObjFacB.class/architecture.md) (branche « non éditée »).

### Réduction de portée

`mabsaisie` → `Private`. Les handlers restent `Public` ; `Bsel`/`Bval` restent `Public`.

### Séparation traitement / GUI

- `affdroit` : `DroitsDuBl(num)` renvoyant lignes et totaux, remplissage séparé.
- `valide`, `gridcons_MouseUp`, `gridsaisie_*` : écriture `Fiches_ligcons` dans des fonctions
  sans contrôle (`AjouteDeconsigne(code, nb)`, `SupprimeDeconsigne(code)`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_ligcons` et ses voisines au schéma de référence ; séparer `numlig` en numéro
  de document + numéro de ligne (aujourd'hui concaténés, d'où des `LIKE`).
