# Tresor — Architecture

> Source : `.src/Compta/Tresor.class`

## Vue d'ensemble

`Tresor` est l'écran de **saisie des écritures de trésorerie** (journaux de type `TR`). L'utilisateur
choisit un journal (dont le compte de banque `cde_banque` donne la contrepartie automatique), une
date, puis saisit des lignes (compte, montant, sens, n° de document, n° de lot, libellé, date
d'échéance). À la validation, la classe écrit dans `Fiches_Mvt` :

- une ligne par ligne saisie ;
- une ligne **collectif** par compte collectif touché (cumulée si plusieurs tiers partagent le même
  collectif) ;
- une ligne de **contrepartie banque** égale au solde de l'écriture ;

puis met à jour les soldes `Fiches_Comptes.solde` (comptes, collectifs, banque), le lettrage des lots
soldés (`Listextcpt.letgroupe`), le chaînage d'inaltérabilité (`Sha1Calc.CalcSha1`) et libère le
verrou applicatif `DocActif` « Reglement ».

Fonctions annexes : lettrage interactif des factures ouvertes d'un tiers (`EcritL`), libellés
types (`Libview`), masques d'abonnement (`Colabt`, expressions `LVar`), rappel d'une écriture non
validée (`ecrit2`) ou validée (`Ecrit3`, avec annulation des soldes et historique dans
`Fiches_MvtM`), suppression, rattachement GED (`LGed`).

Points d'entrée : `Fmenu.class:677` et `Extrait.class:1246` (`New Tresor("")`, saisie) ;
`Extrait.class:1218`, `Ecritures.class:400` et `Fmontant.class:202` (`New Tresor(num)`, **modification
d'une écriture validée** : `_new` appelle `Ecrit3` puis la fenêtre se ferme si l'utilisateur
refuse).

Nature globale : **écran GUI mixte, très couplé** : 88 fonctions, toutes `Public` sauf une, état
partagé dans ~45 membres privés, logique comptable et SQL écrits dans les handlers. Fonctions les
plus complexes : `Cmpt_KeyPress` (CC 82), `Ecrit3` (36), `EcritL_Click` (32), `Lettrage` (28),
`compteman` (26).

### Cycle de vie d'une écriture (vu de la base)

1. **Validation de la date** (`QuitteDate`) : réservation d'un numéro (`Fiches_Parametres.numecriture
   + 1`, sans verrou), même si l'écriture est abandonnée ensuite.
2. **Validation d'une ligne** (`ToggleButton4_Click` → `Movt`) : écriture **provisoire** immédiate
   (`validee = 0`, `provisoire = 1`) de la ligne et d'une ligne banque portant **les montants de la
   ligne courante** (et non le solde) ; `Sha1Calc` recalculé.
3. **Validation de l'écriture** (`Button2_Click`) : `DelMvt2` supprime toutes les lignes du numéro,
   puis `Enrg_Ecr` réécrit les lignes définitives, collectifs, banque et soldes.
4. **Rappel d'une écriture validée** (`Ecrit3`) : copie de chaque ligne dans `Fiches_MvtM`,
   annulation des soldes, suppression des lignes collectif, délettrage, passage en provisoire ;
   l'utilisateur doit ensuite revalider (étape 3).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | FCalc | 27 |
| `Type` | var | Private |  | String | 28 |
| `type_jour` | var | Private |  | String | 29 |
| `Ncpt` | var | Private |  | String | 30 |
| `n` | var | Private |  | Integer | 31 |
| `l` | var | Private |  | Integer | 32 |
| `Cnt` | var | Private |  | String | 33 |
| `soldec` | var | Private |  | Float | 34 |
| `montantdb` | var | Private |  | Float | 35 |
| `montantcd` | var | Private |  | Float | 36 |
| `Montantsel` | var | Private |  | Float | 37 |
| `Totalcd` | var | Private |  | Float | 38 |
| `Totaldb` | var | Private |  | Float | 39 |
| `Modif` | var | Private |  | String | 40 |
| `Vld` | var | Private |  | Boolean | 41 |
| `Prov` | var | Private |  | Boolean | 42 |
| `numCpt` | var | Private |  | String | 43 |
| `numlotT` | var | Private |  | String | 44 |
| `Gntva` | var | Private |  | Boolean | 45 |
| `num` | var | Private |  | Integer | 46 |
| `ecriture` | var | Private |  | String | 47 |
| `TT` | var | Private |  | Float | 48 |
| `TD` | var | Private |  | String | 49 |
| `TC` | var | Private |  | String | 50 |
| `iLet` | var | Private |  | Integer | 51 |
| `numlet` | var | Private |  | String | 52 |
| `nvlle` | var | Private |  | Integer | 53 |
| `Lettrable` | var | Private |  | Integer | 54 |
| `b` | var | Private |  | Integer | 55 |
| `b2` | var | Private |  | Integer | 56 |
| `Lf` | var | Private |  | Integer | 57 |
| `son` | var | Private |  | Integer | 58 |
| `Prg` | var | Private |  | String | 59 |
| `Numr` | var | Private |  | String | 60 |
| `LbCptbanque` | var | Private |  | String | 61 |
| `Tri` | var | Private |  | String | 62 |
| `sel` | var | Private |  | String | 63 |
| `Nv` | var | Private |  | Integer | 64 |
| `TypeAbt` | var | Private |  | String | 65 |
| `ecrA` | var | Private |  | String | 66 |
| `Cle` | var | Private |  | String | 67 |
| `Numlig` | var | Private |  | Integer | 68 |
| `rappel` | var | Private |  | Boolean | 69 |
| `hder` | var | Private |  | TextBox | 70 |
| `Sjour` | var | Private |  | String | 71 |
| `Ext` | var | Private |  | Boolean | 72 |
| `$lstex` | var | Private |  | Listextcpt | 73 |
| `Bsel` | var | Public |  | Boolean | 75 |
| `Bval` | var | Public |  | String | 76 |
<!-- /AUTO:declarations -->

État d'écran (membres privés) — principaux rôles :

- **Saisie en cours** : `numCpt`/`Ncpt` (compte courant / précédent, touche `<`), `montantdb`/`montantcd`
  (montants de la ligne), `Totaldb`/`Totalcd`/`soldec` (totaux de l'écriture), `iLet` (lettrée),
  `numlotT` (lot retenu au lettrage), `numlet`, `Numlig` (compteur de clé de ligne), `Cle`, `Type`
  (`C`/`F`/`G`/`B`), `type_jour`, `LbCptbanque` (intitulé de la banque), `Modif` (`"0"`/`"1"`),
  `nvlle` (1 = nouvelle écriture à numéroter), `ecrA` (`"1"` = masque d'abonnement choisi), `Sjour`
  (journal mémorisé au focus).
- **Navigation** : `b` (0/1 = erreur de saisie, refocus), `b2` (1 montant, 0 libellé, 3 liste
  EcritL), `LF` (1 = ignorer le LostFocus), `l` (cible de la liste de libellés), `cnt`
  (`"1"` = renvoyer le focus au journal), `hder` (dernier contrôle quitté), `rappel` (ne pas changer
  le sens au changement de type).
- **Rappel externe** : `Numr` (numéro passé au constructeur), `Ext` (ouvert depuis un autre écran),
  `Nv` (1 = rappel d'écriture validée).
- **Objets** : `hForm` (`FCalc`, F5), `$lstex` (`Listextcpt`, requêtes multi-exercices et lettrage).
- **Inutiles** (écrits, jamais lus) : `Gntva`, `Prov`, `Vld`, `Tri`, `Montantsel`, `ecriture`,
  `Prg`, `n`, `TT`/`TD`/`TC` hors `EcritL_Click` ; `sel` vaut toujours `""` ; `Lettrable` pourrait
  être local. `Prov`/`Vld` sont des `Boolean` affectés à `0`/`1`, `TD`/`TC` des `String` affectés à
  des nombres.
- `Bsel`/`Bval` : **doivent rester `Public`** (écrits par `Object.SetProperty` depuis
  `TriCpt.class:112-113`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 78-107 | Public | 3 | 27 | 0 | méthode spéciale |
| `form_open` | 109-159 | Public | 19 | 47 | 0 | handler GUI |
| `Maj_Zones` | 161-165 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cmpt_enter` | 170-177 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_leave` | 179-186 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_GotFocus` | 188-198 | Public | 2 | 9 | 0 | handler GUI |
| `Lib` | 200-219 | Public | 3 | 17 | 0 | portée réductible ? |
| `Libutton_Click` | 221-235 | Public | 3 | 13 | 0 | handler GUI |
| `Libutton2_Click` | 237-251 | Public | 3 | 13 | 0 | handler GUI |
| `Libview_Keypress` | 253-277 | Public | 7 | 22 | 0 | handler GUI |
| `Libview_Click` | 279-290 | Public | 2 | 10 | 0 | handler GUI |
| `DelMvt` | 292-308 | Public | 3 | 13 | 0 | portée réductible ? |
| `DelEcr` | 310-330 | Public | 5 | 18 | 0 | portée réductible ? |
| `Cleanchamps` | 332-357 | Public | 5 | 23 | 0 | portée réductible ? |
| `Movt` | 359-380 | Public | 4 | 19 | 0 | portée réductible ? |
| `compte` | 382-404 | Public | 3 | 19 | 0 | portée réductible ? |
| `compteman` | 406-472 | Public | 26 | 64 | 0 | portée réductible ? |
| `Journauxman` | 474-506 | Public | 5 | 30 | 0 | portée réductible ? |
| `Ecritures` | 508-517 | Public | 2 | 7 | 0 | portée réductible ? |
| `Majnum` | 522-526 | Public | 1 | 3 | 0 | portée réductible ? |
| `Journaux` | 528-564 | Public | 4 | 34 | 0 | portée réductible ? |
| `Lettrage` | 566-667 | Public | 28 | 98 | 0 | portée réductible ? |
| `EcritL_KeyPress` | 669-687 | Public | 9 | 17 | 0 | handler GUI |
| `EcritL_Click` | 689-759 | Public | 32 | 68 | 0 | handler GUI |
| `Totsl` | 761-780 | Public | 6 | 18 | 0 | portée réductible ? |
| `ecritnv` | 782-796 | Public | 2 | 12 | 0 | portée réductible ? |
| `ecritv` | 798-812 | Public | 2 | 12 | 0 | portée réductible ? |
| `comptetresorerie` | 814-834 | Public | 3 | 18 | 0 | portée réductible ? |
| `Cmpt_LostFocus` | 839-863 | Public | 7 | 22 | 0 | handler GUI |
| `Cmpt_KeyPress` | 865-1081 | Public | 82 | 193 | 0 | handler GUI |
| `Btn_KeyPress` | 1083-1098 | Public | 6 | 12 | 0 | handler GUI |
| `Btn_Click` | 1100-1133 | Public | 10 | 22 | 0 | handler GUI |
| `Journal_GotFocus` | 1135-1139 | Public | 1 | 3 | 0 | portée réductible ? |
| `Journal_LF` | 1141-1163 | Public | 9 | 21 | 0 | portée réductible ? |
| `Datej_GotFocus` | 1165-1177 | Public | 4 | 11 | 0 | portée réductible ? |
| `Datej_LF` | 1179-1184 | Public | 1 | 4 | 0 | portée réductible ? |
| `numcompte_LF` | 1186-1215 | Public | 10 | 28 | 0 | portée réductible ? |
| `Montant_LF` | 1217-1235 | Public | 3 | 16 | 0 | portée réductible ? |
| `numdoc_LF` | 1237-1253 | Public | 6 | 14 | 0 | portée réductible ? |
| `Debit_Click` | 1255-1259 | Public | 2 | 3 | 0 | handler GUI |
| `Credit_Click` | 1261-1265 | Public | 2 | 3 | 0 | handler GUI |
| `datee_GotFocus` | 1267-1271 | Public | 1 | 3 | 0 | portée réductible ? |
| `datee_LF` | 1273-1277 | Public | 1 | 3 | 0 | portée réductible ? |
| `QuitteDate` | 1279-1335 | Public | 10 | 53 | 0 | portée réductible ? |
| `Button1_Click` | 1337-1356 | Public | 10 | 18 | 0 | portée réductible ? |
| `Choix1_Click` | 1358-1373 | Public | 5 | 14 | 0 | handler GUI |
| `Jour_KeyPress` | 1378-1401 | Public | 6 | 20 | 0 | handler GUI |
| `jour_Click` | 1403-1419 | Public | 1 | 14 | 0 | handler GUI |
| `ToggleButton4_Click` | 1421-1524 | Public | 17 | 97 | 0 | portée réductible ? |
| `Calculsolde` | 1529-1548 | Public | 4 | 18 | 0 | portée réductible ? |
| `btn_Enter` | 1550-1561 | Public | 3 | 8 | 0 | handler GUI |
| `Btn_Leave` | 1563-1574 | Public | 3 | 8 | 0 | handler GUI |
| `Button2_Click` | 1576-1590 | Public | 2 | 9 | 0 | portée réductible ? |
| `DelMvt2` | 1595-1607 | Public | 2 | 10 | 0 | portée réductible ? |
| `Enrg_Ecr` | 1609-1723 | Public | 14 | 107 | 0 | portée réductible ? |
| `ToggleButton6_Enter` | 1726-1730 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton6_Leave` | 1732-1736 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton6_Click` | 1738-1754 | Public | 3 | 15 | 0 | handler GUI |
| `ToggleButton8_Click` | 1759-1785 | Public | 6 | 25 | 0 | handler GUI |
| `Boutonmontant_Click` | 1787-1793 | Public | 1 | 5 | 0 | handler GUI |
| `Boutonmontant_KeyPress` | 1795-1803 | Public | 3 | 7 | 0 | handler GUI |
| `Ecrit1_Activate` | 1805-1862 | Public | 14 | 55 | 0 | handler GUI |
| `Recup_Type` | 1864-1879 | Public | 6 | 13 | 0 | portée réductible ? |
| `Ecrit1_Keypress` | 1881-1915 | Public | 9 | 33 | 0 | handler GUI |
| `Ecrit_Click` | 1920-1928 | Public | 2 | 7 | 0 | portée réductible ? |
| `ecrit2` | 1933-2007 | Public | 13 | 72 | 0 | portée réductible ? |
| `Ecrit3` | 2012-2195 | Public | 36 | 166 | 0 | portée réductible ? |
| `Jour_Activate` | 2197-2201 | Public | 1 | 3 | 0 | handler GUI |
| `Lettre_Click` | 2203-2215 | Public | 3 | 10 | 0 | portée réductible ? |
| `Quit_Click` | 2217-2232 | Public | 1 | 14 | 0 | portée réductible ? |
| `Selct_Click` | 2234-2258 | Public | 5 | 23 | 0 | portée réductible ? |
| `Necrit_Click` | 2274-2285 | Public | 2 | 10 | 0 | portée réductible ? |
| `Clear` | 2287-2310 | Public | 1 | 22 | 0 | portée réductible ? |
| `Suppr_Click` | 2312-2319 | Public | 1 | 6 | 0 | portée réductible ? |
| `Bclient_Click` | 2321-2328 | Public | 2 | 6 | 0 | handler GUI |
| `Bfournisseur_Click` | 2330-2337 | Public | 2 | 6 | 0 | handler GUI |
| `Bgestion_Click` | 2339-2346 | Public | 2 | 6 | 0 | handler GUI |
| `Bbilan_Click` | 2348-2355 | Public | 2 | 6 | 0 | handler GUI |
| `Button3_Click` | 2357-2361 | Public | 1 | 3 | 0 | portée réductible ? |
| `Ecrit1_MouseDown` | 2366-2370 | Public | 2 | 3 | 0 | handler GUI |
| `Aff_Mask` | 2372-2409 | Public | 6 | 36 | 0 | portée réductible ? |
| `Deb3` | 2411-2434 | Public | 4 | 21 | 0 | portée réductible ? |
| `Colabt_Click` | 2436-2456 | Public | 3 | 18 | 0 | handler GUI |
| `Colabt_KeyPress` | 2458-2468 | Public | 7 | 9 | 0 | handler GUI |
| `LignAbt` | 2470-2563 | Public | 12 | 85 | 0 | portée réductible ? |
| `Type_compte` | 2565-2582 | Public | 7 | 16 | 0 | portée réductible ? |
| `Button5_Click` | 2584-2637 | Public | 10 | 44 | 0 | handler GUI |
| `FileFilter` | 2639-2646 | Private | 1 | 5 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les handlers des groupes `Cmpt` (`Journal` 1, `Datej` 2, `LibelleTresor` 3, `Numcompte` 4,
`Montant` 5, `Numdoc` 6, `Numlot` 7, `Libelecrit` 8, `Datee` 9) et `Btn` (`Necrit` 1, `Suppr` 2,
`Lettre` 3, `ToggleButton4` 4, `Button3` 5, `Selct` 6, `Quit` 7, `Button2` 8, `Button1` 9) aiguillent
selon `Last.Tag`. Comme `Journal`, `Datej` et `Datee` appartiennent au groupe `Cmpt`, les méthodes
`Journal_GotFocus`, `Datej_GotFocus` et `datee_GotFocus` **ne sont pas des handlers** (Gambas lève
l'événement sous le nom du groupe) : ce sont des méthodes appelées explicitement (étiquette
« handler GUI » de `deps.py` erronée, à confirmer par un replay).

### Initialisation, préférences, fermeture

- **`_new(num2)`** [portée : nécessaire (spéciale)] [nature : mixte]. Crée `$lstex` sans compte
  (bornes d'exercices seulement), configure la recherche de `Numcompte` (`TextReg.champs
  ("Fiches_Comptes", …)` en dur, condition `type_cc='C'`), valeurs par défaut (type client, crédit),
  focus journal ; si `num2` non vide : `Ext = True`, `Nv = 1`, `Ecrit_Click()` → `Ecrit3`.
- **`form_open()`** [handler] (CC 19) [nature : GUI]. Largeurs des 7 premières colonnes d'`Ecrit1`
  lues dans `/Soc<XX>/Col/LcolT` (`col0:100;col1:240;…`) ou valeurs par défaut ; titres et
  alignements. Même code que `Lettrage` pour `EcritL` (`LcolTL`).
- **`Button1_Click()`** [handler, Btn 9] [nature : GUI]. Fermeture : confirmation si saisie en cours
  (l'écriture reste « non validée »), sauvegarde des largeurs `LcolT`/`LcolTL` (code dupliqué dans
  les deux branches), `Start.LocalSettings.Save`, `Me.Close`. Le verrou `DocActif` « Reglement »
  pris par `Ecrit3` n'est pas libéré.
- **`Maj_Zones()`** [code mort] : `Journal.Text = jour.Current[0]`, jamais appelée.
- **`Button3_Click()`** [handler, Btn 5] : aide `Doc.Open("Saisiestresorerie")`.
- **`FileFilter(All)`** [Private, code mort] : renvoie `["*.*"]`, jamais appelée.

### Navigation clavier et focus

- **`Cmpt_enter()` / `Cmpt_leave()`** [handlers] : `LF = 1/0` sur le journal (tag 1).
- **`Cmpt_GotFocus()`** [handler] : couleur d'édition ; mémorise `Sjour` sur le journal.
- **`Cmpt_LostFocus()`** [handler] : mémorise `hder` ; journal → `Journal_LF` ; date → `Datej_LF`
  puis focus libellé ou retour sur la date si `b = 1` (sauf si `LF = 1`).
- **`Cmpt_KeyPress()`** [handler] (CC 82, max du fichier, 193 lignes) [nature : GUI, aiguillage].
  Entrée/Retour/Tab : journal → `Journal_LF` + `journauxman` ; date → `Datej_LF` ; libellé
  trésorerie → `Utils.Remplace` et recopie dans `Libelecrit` ; compte → `numcompte_LF`, déduction
  du type (6/7 gestion, sinon bilan, 401 fournisseur, 411 client), focus selon `b`/`b2` ; montant →
  `Montant_LF` et contrôle non nul ; n° doc → `numdoc_LF` ; n° lot ; libellé ligne → `Remplace` ;
  date d'échéance → `datee_LF` puis focus sur `ToggleButton4`. Touches : F1 aide ; F2 listes
  (journaux, libellés, comptes) ; F4 fiches (`FComptes`, `FClient`, `FFournisseur` en modal) ; F5
  calculatrice (`FCalc`) sur le montant ; F7 masques d'abonnement (tags `"3"` à `"4"`, comparaison
  de chaînes) ; F8 extrait de compte (`Extrait`) ; touche de code 60 (`<`) : rappel du compte
  précédent.
- **`Btn_KeyPress()`** [handler] : sur `ToggleButton4` (tag 4), **toute touche** appelle
  `ToggleButton4_Click()` (Entrée/Retour/Tab sont seulement stoppées avant) ; sur `Button2` (tag 8),
  **toute touche** valide l'écriture (`Button2_Click`). Comportement à confirmer (anomalie A01).
- **`Btn_Click()`** [handler] : aiguillage des 9 boutons du groupe `Btn`.
- **`btn_Enter()` / `Btn_Leave()`** [handlers] : `LF = 1/0` sur `Button2`/`Button1`.
- **`ToggleButton6_Enter/Leave/Click()`** [handlers] : `LF` et menu `Choix1` (journaux, écritures
  non validées, validées).
- **`Choix1_Click()`** [handler] : `Wait 0.2`, puis `Journaux`, `ecritnv` ou `ecritv`.
- **`Debit_Click()` / `Credit_Click()`** [handlers] : remettent le focus sur `hder`.
- **`Boutonmontant_Click()` / `Boutonmontant_KeyPress()`** [handlers] : propose `|soldec|` comme
  montant (code dupliqué).

### Journal et date

- **`Journal_GotFocus()`** [méthode, voir plus haut] : `cnt = "1"`.
- **`Journal_LF()`** [portée : réductible] : journal obligatoire tant qu'aucune ligne ; si le journal
  change en cours d'écriture : avertissement puis `journauxman`.
- **`Journaux()`** [portée : réductible] [nature : mixte]. Liste `Jour` des journaux `type_jo = 'TR'`
  (`Fiches_Journaux`) ; message si aucun.
- **`Jour_KeyPress()` / `jour_Click()` / `Jour_Activate()`** [handlers] : choix d'un journal dans la
  liste → titre, compte banque `Cptt`, `Journal_LF`, `comptetresorerie`.
- **`Journauxman()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Journaux WHERE
  code_jo = &1` ; refuse un journal non `TR` ; sinon titre et `comptetresorerie()`.
- **`comptetresorerie()`** [portée : réductible] [nature : mixte]. Lit `cde_banque` du journal puis
  solde et intitulé du compte banque (`"Fiches_Journaux"`, `"Fiches_Comptes"` en dur) ; focus date.
- **`Datej_GotFocus()`** [méthode] : couleur, date du jour si nouvelle écriture, renvoi au journal si
  `cnt = "1"`.
- **`Datej_LF()`** [portée : réductible] : `QuitteDate()` puis `datee = Datej`.
- **`datee_GotFocus()` / `datee_LF()`** [méthodes] : recopie de la date ; `QuitteDate()` (qui
  relit `Datej`, pas `datee` : la date d'échéance n'est jamais normalisée, à confirmer).
- **`QuitteDate()`** [portée : réductible] [nature : mixte]. Lit `Fiches_Parametres` (`dtepc`,
  `dteclec`), normalise `Datej` (`Utils.Cdate_calc`/`Cdate_aff`, sentinelle `"00.00.0:00"` →
  date du jour), refuse une date ≤ début de période ou > fin d'exercice suivant (`b = 1`) ; sinon, si
  `nvlle = 1`, **réserve le numéro** : `Ecritures("numecriture")` + 1, affiché dans `numecrit`,
  `numdoc`, `numlot`, puis `Majnum("numecriture")` — sans verrou (risque de doublon en multi-poste).
- **`Ecritures(numecr)`** [portée : réductible] : `SELECT <numecr> FROM Fiches_Parametres` (nom de
  colonne concaténé ; lecture `Params[...]`), résultat dans le membre `num`.
- **`Majnum(numecr)`** [portée : réductible] : `UPDATE Fiches_Parametres set <numecr> = &1`.

### Compte et type de compte

- **`compte()`** [portée : réductible] : `TriCpt(Type, Avec_Solde, Me)` en modal, puis
  `compteman()` si un compte est choisi.
- **`ToggleButton8_Click()`** [handler] : exige date validée et journal, puis `compte()`.
- **`compteman()`** [portée : réductible] (CC 26) [nature : mixte]. Si journal vide : message mais
  **poursuite du traitement**. Requête selon le préfixe : 401 → `Fiches_Comptes left join
  Fiches_Four on fo_code = compte`, 411 → `left join Fiches_Cli`, sinon filtre `type_cc = Type` ;
  toutes avec `compte_cc like '<saisie>%'` **concaténé** dans le SQL et `coll <> 1`. Refuse un compte
  principal (`cprincipal`) ou de trésorerie (`comptr_cc <> 0`) ; affiche intitulé (raison sociale +
  nom pour les tiers) et solde ; si compte lettrable (`401`/`411`/type `B`) et option
  `/Soc<XX>/Lettrage`, ouvre la liste de lettrage (`Lettre_Click`). Précédence `And`/`Or` de la
  condition ligne 444 à confirmer.
- **`numcompte_LF()`** [portée : réductible] : déduction du type (copie de `Cmpt_KeyPress`),
  `compteman()`, remise à zéro de la sélection ; double message si compte vide ; `Catch` muet.
- **`Recup_Type()`** [portée : réductible] [nature : mixte] : `type_cc` du compte et coche du bouton
  radio correspondant.
- **`Type_compte()`** [portée : réductible] : déduction du type par préfixe (même code que
  `numcompte_LF`).
- **`Bclient_Click` / `Bfournisseur_Click` / `Bgestion_Click` / `Bbilan_Click`** [handlers] : type,
  condition de recherche de `Numcompte`, sens par défaut (sauf `rappel`), focus compte (4 copies).

### Libellés types

- **`Lib()`** [portée : réductible] [nature : mixte] : liste `Libview` depuis `Fiches_Libelles`
  (`TabLibel`).
- **`Libutton_Click()` / `Libutton2_Click()`** [handlers] : bascule de `Libview` pour le libellé de
  ligne (`l = 1`) ou de trésorerie (`l = 0`) ; corps identiques ; `Catch` muet.
- **`Libview_Keypress()` / `Libview_Click()`** [handlers] : choix ou abandon du libellé.

### Lignes de l'écriture

- **`Montant_LF()`** [portée : réductible] : `Utils.Cpoint`, contrôle numérique (`b = 1` sinon),
  format `0.00`.
- **`numdoc_LF()`** [portée : réductible] [nature : mixte] : recherche d'un doublon (`numdoc`,
  compte, journal, autre numéro, hors collectif) ; la question « Voulez-vous continuer ? » est posée
  mais **la réponse est ignorée** ; lot = document par défaut.
- **`ToggleButton4_Click()`** [handler, Btn 4] (CC 17) [nature : mixte]. Si un masque est choisi
  (`ecrA = "1"`) → `LignAbt`. Sinon contrôles (compte, montant, document — proposition « Auto » =
  numéro d'écriture, numéro d'écriture présent), calcul débit/crédit, `Movt()` (écriture provisoire
  en base), ajout de la ligne dans `Ecrit1` (colonnes cachées 6 à 9 : date, intitulé, journal,
  échéance), `Calculsolde()`, puis `Cleanchamps()`. `Catch` : toute erreur est affichée comme
  « Il semblerait que cette ecriture a déjà été saisie ».
- **`Movt()`** [portée : réductible] [nature : calcul]. Écriture provisoire (`validee = 0`,
  `provisoire = 1`, `tresorerie = 1`) : `SELECT` puis `UPDATE` ou `INSERT` de la ligne
  (`numero`, `compte`, `numdoc`, `numlot`), puis même chose pour la ligne banque `Cptt` **avec les
  montants de la ligne courante** (pas le solde). Pour la banque, le `SELECT` filtre sur
  `numero`+`compte` mais l'`UPDATE` aussi sur `numdoc`+`numlot` (17 paramètres pour 16 marqueurs).
  `Sha1Calc.CalcSha1(TabMvt, numero)` ; libère le verrou `DocActif` s'il est pris.
- **`Calculsolde()`** [portée : réductible] [nature : mixte] : recalcule `Totaldb`, `Totalcd`,
  `soldec` en parcourant `Ecrit1` (sélectionne chaque ligne au passage).
- **`Ecrit1_Activate()`** [handler] (CC 14) [nature : mixte]. Reprise d'une ligne pour modification :
  recopie dans les champs, retrait des totaux, suppression de la ligne de la liste et `DelEcr()` en
  base, puis `Recup_Type()` et déduction du type par préfixe si le compte est inconnu.
- **`Ecrit1_Keypress()`** [handler] : Suppr → confirmation, retrait des totaux, `DelEcr()` ; F1 ;
  Entrée → `Ecrit1_Activate()`.
- **`Ecrit1_MouseDown()`** [handler] : clic droit → `Aff_Mask()`.
- **`DelEcr()`** [portée : réductible] [nature : calcul]. Supprime la ligne provisoire
  (`numero`, `compte`, `numdoc`, `numlot`) puis la ligne collectif d'intitulé identique. La boucle
  `Repeat` réaffecte `rResult` à l'intérieur (la condition `MoveNext` porte sur le dernier résultat
  lu, à confirmer) et `numlot` est passé sans marqueur `&4` dans la 2e requête.
- **`Cleanchamps()`** [portée : réductible] : vide les champs de ligne ; garde le libellé tant que
  l'écriture n'est pas soldée ; sens par défaut selon le type.
- **`Clear()`** [portée : réductible] : vide toute l'écriture et l'état.
- **`Necrit_Click()`** [handler, Btn 1] : si des lignes existent, avertit (l'écriture reste non
  validée), `Clear()` et nouvelle numérotation.

### Validation

- **`Button2_Click()`** [handler, Btn 8] : si `Ecrit1` non vide : `DelMvt2()` puis `Enrg_Ecr()`.
- **`DelMvt2()`** [portée : réductible] [nature : mixte] : `DELETE FROM Fiches_Mvt WHERE numero = &1`
  puis focus journal.
- **`Enrg_Ecr()`** [portée : réductible] (CC 14, 107 lignes) [nature : mixte, traitement
  extractible]. Pour chaque ligne d'`Ecrit1` :
  `INSERT` définitif (`validee = 1`, `provisoire = 0`, `tresorerie = 1`) ; si le compte a un
  collectif : `solde` du compte et du collectif `+= débit - crédit`, puis `UPDATE` cumulatif de la
  ligne collectif existante ou `INSERT` (`collectif = 1`) ; sinon, si `comptr_cc = 0`, mise à jour du
  solde et d'un `update … Where compte = &6` où `&6` est le collectif **vide** (requête sans effet) ;
  enfin `Listextcpt.Controle(lot, compte)` et `letgroupe` si le lot est soldé. Après la boucle :
  solde de la banque `+= soldec`, ligne banque (`UPDATE` si elle existe, sinon `INSERT`) seulement
  si le solde est non nul, `Sha1Calc.CalcSha1("Fiches_Mvt", …)` (**nom en dur**), libération du
  verrou `DocActif`, remise à zéro de l'écran.

### Rappel, modification, suppression

- **`ecritnv()` / `ecritv()`** [portée : réductible] : `TriEcritures("0"|"1", "", "1")` en modal
  puis `ecrit2()` ou `ecrit3()` si `Comptabilite.Bsel`.
- **`Ecrit_Click()`** [méthode] : `ecrit2` si `Nv = 0`, sinon `ecrit3` ; appelée seulement par
  `_new` avec `Nv = 1` (la branche `ecrit2` n'est pas atteinte). Aucun contrôle `Ecrit` : ce n'est
  pas un handler.
- **`ecrit2()`** [portée : réductible] (CC 13) [nature : mixte]. Rappel d'une écriture **non
  validée** (`Comptabilite.snum`) : copie de chaque ligne hors collectif dans `Fiches_MvtM` (en dur,
  23 colonnes), affichage des lignes dont le compte ne commence pas par `512`/`53` (les autres
  donnent le libellé de trésorerie), puis `validee = 0, provisoire = 1` et `Sha1Calc`. `Catch` :
  message « écriture pas terminée ».
- **`Ecrit3()`** [portée : réductible] (CC 36, 166 lignes) [nature : mixte]. Rappel d'une écriture
  **validée** (`Numr` ou `Comptabilite.snum`) après confirmation : `DocActif.Get_lock("Reglement")`
  (**résultat ignoré**) ; lit le journal (si inexistant : `Message.Error` + `Me.Close` mais la boucle
  continue) ; pour chaque ligne hors collectif : copie dans `Fiches_MvtM`, affichage (sauf la ligne
  du compte banque du journal, test différent de `ecrit2`), annulation du solde du compte, et pour le
  collectif : annulation partielle (`Mnt2` = crédit pour un `41…`, débit sinon — l'autre sens
  n'est pas annulé) et `DELETE` de la ligne collectif ; puis annulation du solde banque, délettrage
  `$lstex.letgroupe(Nlot, Nlot2, False, Cptt.Text)` **sur le compte banque** (le lot vient d'une
  ligne 401/411), passage de toute l'écriture en provisoire et `Sha1Calc("Fiches_Mvt")`.
  Refus → fermeture si `Ext`. `Catch` : propose de **supprimer toute l'écriture** puis ferme.
- **`Suppr_Click()`** [handler, Btn 2] : `DelMvt()`, `Calculsolde()`, `Clear()` — **sans
  confirmation**.
- **`DelMvt()`** [portée : réductible] [nature : calcul] : `DELETE` de toutes les lignes du numéro,
  `UPDATE Fiches_MvtM SET supprimee = 1, datem` (en dur), suppression du document GED associé
  (`LGed.Search` + `Supprime`).

### Lettrage interactif

- **`Lettre_Click()`** [handler, Btn 3] : ouvre la liste si un compte est saisi.
- **`Lettrage()`** [portée : réductible] (CC 28) [nature : mixte]. Largeurs `LcolTL` (copie de
  `form_open`), puis `$lstex = New Listextcpt(compte, 01.01.1900, 31.12.9999, "n", "dte asc")` et
  remplissage d'`EcritL` avec les écritures non lettrées (tous exercices) ; affiche le cadre de
  sélection. Le nom `Lettrage` masque la classe homonyme `Lettrage` (`Compta/Lettrages`) dans ce
  fichier. `Catch` muet.
- **`EcritL_KeyPress()`** [handler] : Échap/F2 ferme, Espace bascule, flèches.
- **`EcritL_Click()`** [handler] (CC 32) [nature : mixte]. Bascule la marque `L` de la ligne et
  ajoute ou retire son montant du total sélectionné selon le type (client, fournisseur, bilan) ; les
  deux branches sont symétriques (duplication) ; `numlotT` = lot de la ligne.
- **`Totsl(sens)`** [code mort] : total des lignes marquées, jamais appelée.
- **`Selct_Click()`** [handler, Btn 6] : pour chaque ligne marquée, `$lstex.letcpt(numero, True,
  numlotT, "tresor")` (renumérote le lot des factures), recopie document et libellé, montant =
  total sélectionné, fermeture de la liste.
- **`Quit_Click()`** [handler, Btn 7] : ferme la liste et remet les totaux à zéro.

### Masques d'abonnement

- **`Aff_Mask()`** [portée : réductible] : affiche `Colabt` (journal et date requis), puis `Deb3()`.
- **`Deb3()`** [portée : réductible] [nature : mixte] : masques de type `T` (`Fiches_Numabon`).
- **`Colabt_Click()` / `Colabt_KeyPress()`** [handlers] : choisit un masque (première ligne de
  `Fiches_Ligabon`, paramètre `"0,00"` superflu) → compte, libellé, `ecrA = "1"`.
- **`LignAbt()`** [portée : réductible] (CC 12) [nature : mixte]. Lignes du masque
  (`Fiches_Ligabon` ⋈ `Fiches_Numabon`) : n° doc, n° lot et libellé calculés par la séquence `LVar`
  (`New LVar` / `AddDate` / `ParseResult` / `Evaluate`, répétée 3 fois), débit et crédit évalués avec
  `$montant` ; ajout dans `Ecrit1` **sans écriture provisoire en base** (contrairement à
  `ToggleButton4_Click`) ; `Abont.Compteur_Incr` ; `Ecrit1.Item[0] = cle` aussitôt écrasé.

### GED

- **`Button5_Click()`** [handler] [nature : mixte]. Document GED de l'écriture (`LGed.Search` ou
  `New LGed(…, "Treso", numero)`), tags par défaut des fournisseurs/clients (`SELECT tag_def … WHERE
  fo_code = ` **concaténé sans guillemets**), tag de chaque compte et de la banque, montant TTC
  = |solde|, date ; suppression si annulation.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings` (`/Soc<XX>/Col/LcolT`, `LcolTL`,
  `/Soc<XX>/Lettrage`), `Start.Societe`.
- `Comptabilite.Bsel`, `.snum`, `.libelle`, `.journal` (retour de `TriEcritures`).
- `Utils.db`, `Utils.cpoint`, `Utils.Remplace`, `Utils.Cdate_calc`, `Utils.Cdate_aff`,
  `Utils.Cdate_Dbase`, `Utils.SetEditColor`, `Utils.Observers`.
- Classes : `Listextcpt`, `TriCpt`, `TriEcritures`, `Extrait`, `FCalc`, `FComptes`, `FClient`,
  `FFournisseur`, `LDate`, `LPrix`, `LVar`, `LGed`, `DocActif`, `Sha1Calc`, `Abont`, `Doc`.
- Tables : `Fiches_Mvt` (`TabMvt`), `Fiches_Comptes` (`TabComptes`, et en dur), `Fiches_Journaux`
  (`TabJour`, et en dur), `Fiches_Parametres` (`TabParam`), `Fiches_Libelles`, `Fiches_Numabon`,
  `Fiches_Ligabon`, `Fiches_Cli`, `Fiches_Four`, `Fiches_MvtM` (en dur, clé `TabMvtM` disponible) ;
  `Fiches_Mvt1-5` via `Listextcpt` (lettrage) ; table de verrous de `DocActif` ; tables GED via
  `LGed`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **Code mort** : `Maj_Zones`, `Totsl`, `FileFilter`, membres écrits jamais lus (`Gntva`, `Prov`,
  `Vld`, `Tri`, `Montantsel`, `ecriture`, `Prg`, `n`), `Ecrit1.Item[0] = cle` (l. 2527),
  `update … Where compte = ''` d'`Enrg_Ecr` (l. 1661, SQL modifié, dump identique), blocs commentés.
- **`Cmpt_KeyPress`** (CC 82) : une fonction privée par tag (`Touche_Journal`, `Touche_Date`, …)
  renvoyant `True` si l'événement doit être stoppé ; le handler garde le `Select Case` et les
  `Stop Event`. Même découpage pour les touches de fonction.
- **Déduction du type de compte** par préfixe : 4 copies (`Cmpt_KeyPress`, `numcompte_LF`,
  `Type_compte`, `Ecrit1_Activate`) → `Private Sub Type_Depuis_Compte(compte)`.
- **Choix du type** (`Bclient`/`Bfournisseur`/`Bgestion`/`Bbilan_Click`) → `Private Sub
  Choix_Type(type, condition, debit As Boolean)`.
- **Libellés** : `Libutton_Click`/`Libutton2_Click` → `Private Sub Bascule_Libelles(cible)`.
- **Largeurs de colonnes** : lecture (`form_open`, `Lettrage`) et écriture (`Button1_Click` × 2)
  → `Private Sub Lit_Largeurs(cv, clef, n)` / `Sauve_Largeurs(cv, clef, n)`.
- **`EcritL_Click`** (CC 32) : `Private Function Delta_Selection(td, tc) As Float` selon le type, la
  bascule appliquant `+`/`-`.
- **`ecrit2`/`Ecrit3`** : `Private Sub Archive_MvtM(r As Result)` (INSERT 23 colonnes dupliqué) et
  `Private Sub Ajoute_Ligne(r As Result)` (remplissage d'`Ecrit1` dupliqué) ; extraire de `Ecrit3`
  l'annulation des soldes (`Annule_Soldes_Ligne`).
- **Noms de tables** : `Cbase.Table("TabMvt")` pour `Sha1Calc` (l. 1695, 2180),
  `Cbase.Table("TabMvtM")` (l. 300, 1960, 2079), `TabComptes`/`TabJour` (l. 88, 819-825) — même SQL.

### Commonalisation avec d'autres fichiers

- **Séquence `LVar`** répétée 3 fois dans `LignAbt` : helper `LVar.Calcule(...)` prévu par LVAR-004
  ([LVar](../../Utils/LVar.class/architecture.md)), partagé avec
  [`Saisecrit`](../Saisecrit.class/architecture.md), `EcrAuto`, `ValidBR`, `ValidBR1`.
- **Historique `Fiches_MvtM`** : même `INSERT` dans [`Saisecrit`](../Saisecrit.class/architecture.md)
  (l. 2491, 2580) et `FClotureAn` (l. 455) → helper commun d'archivage d'une ligne.
- **Mise à jour incrémentale de solde** (`SELECT solde` puis `UPDATE`) : `Enrg_Ecr`, `Ecrit3`,
  [`Trecarts`](../Trecarts.class/architecture.md), `Saisecrit` → helper `Maj_Solde(cpt, delta)`.
- **Numérotation** (`Ecritures` + `Majnum`) : même besoin dans `Trecarts` (sous `LOCK`) et
  `Saisecrit` → `ProchainNumeroEcriture()` commun (à rapprocher de `DB_Connection.LockIncrement`).
- **Normalisation de date** à sentinelle `"00.00.0:00"` : commune avec
  [`Echeances.Quittedate`](../Echeances.class/architecture.md).
- **Largeurs de colonnes `/Col/`** : même idiome dans `Saisecrit`, `Extrait`, `Facture`, `Archives`
  → helper `Utils` (phase 3).
- **`Sha1Calc` avec `"Fiches_Mvt"` en dur** : même défaut dans `Saisecrit` et `Moulinage` (note
  transverse).

### Réduction de portée

- Passables en `Private` (aucun appelant externe, vérifié par `grep -rn`) : `Lib`, `DelMvt`,
  `DelEcr`, `Cleanchamps`, `Movt`, `compte`, `compteman`, `Journauxman`, `Ecritures`, `Majnum`,
  `Journaux`, `Lettrage`, `ecritnv`, `ecritv`, `comptetresorerie`, `Journal_LF`, `Datej_LF`,
  `numcompte_LF`, `Montant_LF`, `numdoc_LF`, `datee_LF`, `QuitteDate`, `Calculsolde`, `DelMvt2`,
  `Enrg_Ecr`, `Recup_Type`, `ecrit2`, `Ecrit3`, `Clear`, `Aff_Mask`, `Deb3`, `LignAbt`,
  `Type_compte`.
- À laisser `Public` par prudence : `Journal_GotFocus`, `Datej_GotFocus`, `datee_GotFocus`,
  `Ecrit_Click` (noms de forme handler) et `Bsel`/`Bval` (`Object.SetProperty`).

### Séparation traitement / GUI

- `Enrg_Ecr` : extraire `Private Sub Ecrit_Definitif(lignes, journal, numero, date, banque,
  libelle_banque)` qui prend les lignes sous forme de tableau (lu depuis `Ecrit1` par le handler) et
  émet exactement les mêmes requêtes ; la remise à zéro de l'écran reste dans l'appelant.
- `Ecrit3` : extraire la partie base (`Annule_Ecriture(numero, banque)` : archivage, soldes,
  collectifs, délettrage, passage en provisoire) de la partie affichage.
- `QuitteDate` : `Private Function Reserve_Numero() As Integer` (mêmes deux requêtes).
- `Movt`, `DelEcr`, `DelMvt` : prendre leurs valeurs en paramètres au lieu de lire les contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les écritures provisoires écrites ligne à ligne dans `Fiches_Mvt` (puis supprimées et réécrites)
  pourraient vivre dans une table de brouillon dédiée, ce qui supprimerait les lignes banque
  incohérentes et les recalculs `Sha1Calc` intermédiaires.
- `Fiches_Comptes.solde` dénormalisé : source de dérive (annulation partielle des collectifs) ; un
  solde calculé ou une table de mouvements de solde éviterait les mises à jour incrémentales.
- Numéro d'écriture : une séquence/auto-incrément dédiée éviterait la réservation non atomique.
- Le collectif est porté par une ligne `collectif = 1` dans `Fiches_Mvt` : une colonne `collectif`
  sur la ligne tiers suffirait et supprimerait les lignes cumulées.
