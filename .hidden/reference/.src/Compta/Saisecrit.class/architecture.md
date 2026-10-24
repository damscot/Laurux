# Saisecrit — Architecture

> Source : `.src/Compta/Saisecrit.class` (+ `Saisecrit.form`)

## Vue d'ensemble

`Saisecrit` est l'écran de **saisie des écritures comptables** des journaux d'achat (`AC`), de
vente (`VE`) et d'opérations diverses (`OD`) ; les journaux de trésorerie (`TR`) sont refusés et
relèvent de [`Tresor`](../Tresor.class/architecture.md), dont `Saisecrit` est un quasi-clone
(64 fonctions de même nom). Fichier legacy de 3148 lignes (2528 LOC, CC totale 654), créé en 2004.

Ouvertures :
- `Fmenu.Menu21_Click` (`Fmenu.class:660`) et `Extrait.Appel_Saisie` : `New Saisecrit("")`,
  nouvelle écriture ;
- `Extrait.Necrit_Click`, `Ecritures.Necrit_Click`, `Fmontant` :
  `New Saisecrit(num, Me.Parent, True)`, rappel d'une écriture validée pour modification
  (`Ecrit3`). Trois arguments pour un `_new(num2, Optional ecrmodif)` à deux paramètres :
  répartition entre `_new` et le constructeur de `Window` à confirmer (voir Risques).

Cycle d'une écriture :

```
Journal (code ou F2/liste) → Journauxman/Jour_Click : type_jour, sens par défaut
Date (Entrée) → QuitteDate : contrôle d'exercice, numéro = Fiches_Parametres.numecriture + 1
Compte (TextReg numcompte) → compteman (tiers 40x/41x) | compteGman (général)
   → libellé par défaut évalué (LVar), échéance (dateEcheance), solde du compte
Libellé, N° document, N° lot, Montant (Entrée) → Montant_LostFocus → Calctva
Button4 (Enregistrer la ligne) → ligne dans Ecrit1 + INSERT Fiches_Mvt (provisoire)
   → aff_tva (ligne de TVA automatique) → Calculsolde → VentilAuto (ventilation unique)
   → Analytique (si compte analytique)
… jusqu'à solde nul …
Button2 (Valider l'écriture) → DelMvt2 (DELETE numero) → Enrg_Ecr (INSERT validées,
   soldes des comptes et collectifs, MvtA validée, Sha1Calc)
```

Les lignes saisies sont **écrites immédiatement** dans `Fiches_Mvt` comme provisoires
(`Movt`, `provisoire = 1`) ; la validation efface puis réécrit toutes les lignes de l'écriture
(`validee = 1`, `provisoire = 0`). Une écriture abandonnée reste en provisoire
(« écritures non validées », `Ecr1`/`ecrit2`).

Nature globale : **mixte**, fortement couplée à la GUI : le SQL est mêlé aux lectures et écritures
de contrôles dans presque toutes les fonctions ; le `ColumnView` `Ecrit1` sert de **modèle de
données** de l'écriture en cours (colonnes 7 à 10 non affichées : date, intitulé, journal, `lind`).

### Contrôles et groupes d'événements (`.form`)

| Groupe | Contrôles (`Tag`) | Conséquence |
|---|---|---|
| `Cmpt` | `Journal` (1), `Datej` (2), `Numcompte` (3, `TextReg`), `Libelecrit` (4), `Numdoc` (5), `Numlot` (6), `Montant` (7), `Dateech` (8) | les événements arrivent dans `Cmpt_*` et sont aiguillés par `Last.Tag` |
| `Btn` | `Ventilations` (2), `Necrit` (3), `Button4` (4), `Button3` (5), `Suppr` (6), `Button2` (7), `Button1` (8) | `Btn_Click` appelle `Ventilations_Click`, `Necrit_Click`, `Button4_Click`, `Button3_Click`, `DelMvt`, `Button2_Click`, `Button1_Click` |
| — | `Ecrit1`, `Jour`, `Vtl`, `Libview`, `Colabt` (ColumnView), `Choix1` (ListBox), `Debit`/`Credit`/`Bclient`/`Bfournisseur`/`Bgestion`/`Bbilan` (RadioButton), `Boutonmontant`, `ToggleButton6`, `ToggleButton8`, `Libutton` (ToggleButton), `Button5`, `DateChooser1` | handlers nominaux classiques |

Conséquence importante : les fonctions nommées comme des handlers pour un contrôle d'un groupe
(`Journal_GotFocus`, `Journal_LostFocus`, `Datej_GotFocus`, `Datej_LostFocus`, `Dateech_GotFocus`,
`Dateech_LostFocus`, `numcompte_GotFocus`, `Montant_GotFocus`, `Montant_LostFocus`,
`numdoc_*`, `numlot_*`, `Libelecrit_*`, `Ventilations_Click`, `Necrit_Click`, `Button1_Click` à
`Button4_Click`) **ne sont jamais levées par Gambas** : ce sont des méthodes ordinaires appelées
directement. Deux d'entre elles ne sont appelées par personne : `numcompte_LostFocus` et
`Dateech_DblClick` (signalées par `deps.py`, confirmé par grep) ; voir Code mort.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | FCalc | 27 |
| `Type` | var | Private |  | String | 28 |
| `type_jour` | var | Private |  | String | 29 |
| `Cnt` | var | Private |  | String | 30 |
| `n` | var | Private |  | Integer | 31 |
| `soldec` | var | Private |  | Float | 32 |
| `compte_tva` | var | Private |  | String | 33 |
| `montantdb` | var | Private |  | Float | 34 |
| `montantcd` | var | Private |  | Float | 35 |
| `montantht` | var | Private |  | Float | 36 |
| `Totalcd` | var | Private |  | Float | 37 |
| `Totaldb` | var | Private |  | Float | 38 |
| `Modif` | var | Private |  | String | 39 |
| `Vld` | var | Private |  | Boolean | 40 |
| `Prov` | var | Private |  | Boolean | 41 |
| `numCpt` | var | Private |  | String | 42 |
| `Gntva` | var | Private |  | Boolean | 43 |
| `num` | var | Private |  | Integer | 44 |
| `tva` | var | Private |  | Float | 45 |
| `ecriture` | var | Private |  | String | 46 |
| `supp` | var | Private |  | Integer | 47 |
| `B` | var | Private |  | Integer | 48 |
| `txt` | var | Private |  | String | 49 |
| `nvlle` | var | Private |  | Integer | 50 |
| `son` | var | Private |  | Integer | 51 |
| `Dne` | var | Private |  | String | 52 |
| `Itm` | var | Private |  | String | 53 |
| `Cle` | var | Private |  | String | 54 |
| `Prg` | var | Private |  | String | 55 |
| `Ncpt` | var | Private |  | String | 56 |
| `Numr` | var | Private |  | String | 57 |
| `LF` | var | Private |  | Integer | 58 |
| `Tri` | var | Private |  | String | 59 |
| `sel` | var | Private |  | String | 60 |
| `Nv` | var | Private |  | Integer | 61 |
| `Numcvtl` | var | Private |  | String | 62 |
| `TypeAbt` | var | Private |  | String | 63 |
| `ecrA` | var | Private |  | String | 64 |
| `numlig` | var | Private |  | Integer | 65 |
| `sLind` | var | Private |  | String | 66 |
| `hder` | var | Private |  | TextBox | 67 |
| `Sjour` | var | Private |  | String | 68 |
| `Ext` | var | Private |  | Boolean | 69 |
| `Ech` | var | Private |  | String | 70 |
| `avoir` | var | Private |  | Boolean | 71 |
| `$libelle` | var | Private |  | String | 72 |
| `$cpt` | var | Private |  | String | 73 |
| `bmodif` | var | Private |  | Boolean | 74 |
| `Bsel` | var | Public |  | Boolean | 76 |
| `Bval` | var | Public |  | String | 77 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 82-159 | Public | 23 | 75 | 0 | méthode spéciale |
| `Cleanchamps` | 164-177 | Public | 2 | 12 | 0 | portée réductible ? |
| `dateEcheance` | 179-208 | Public | 4 | 27 | 0 | portée réductible ? |
| `Cmpt_enter` | 213-220 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_leave` | 222-229 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_GotFocus` | 231-241 | Public | 2 | 9 | 0 | handler GUI |
| `Movt` | 246-286 | Public | 6 | 35 | 0 | portée réductible ? |
| `compte` | 291-318 | Public | 6 | 25 | 0 | portée réductible ? |
| `compteman` | 323-442 | Public | 34 | 113 | 0 | portée réductible ? |
| `compteGman` | 447-485 | Public | 11 | 36 | 0 | portée réductible ? |
| `Leccompteg` | 490-514 | Public | 15 | 21 | 0 | portée réductible ? |
| `Journauxman` | 519-562 | Public | 6 | 41 | 0 | portée réductible ? |
| `Journaux` | 568-606 | Public | 5 | 36 | 0 | portée réductible ? |
| `Ecritures` | 611-620 | Public | 2 | 7 | 0 | portée réductible ? |
| `Majnum` | 625-629 | Public | 1 | 3 | 0 | portée réductible ? |
| `ecritnv` | 631-648 | Public | 2 | 15 | 0 | portée réductible ? |
| `ecritv` | 650-667 | Public | 2 | 15 | 0 | portée réductible ? |
| `Ecr1` | 672-698 | Public | 6 | 24 | 0 | portée réductible ? |
| `Ecr2` | 703-733 | Public | 4 | 28 | 0 | portée réductible ? |
| `ventil` | 738-762 | Public | 4 | 22 | 0 | portée réductible ? |
| `ventilAuto` | 767-790 | Public | 3 | 21 | 0 | portée réductible ? |
| `Lib` | 795-817 | Public | 3 | 20 | 0 | portée réductible ? |
| `Calctva` | 822-888 | Public | 25 | 63 | 0 | portée réductible ? |
| `aff_tva` | 893-968 | Public | 15 | 73 | 0 | portée réductible ? |
| `Debit_Click` | 970-974 | Public | 2 | 3 | 0 | handler GUI |
| `Credit_Click` | 976-980 | Public | 2 | 3 | 0 | handler GUI |
| `Compdate` | 982-992 | Public | 3 | 9 | 0 | portée réductible ? |
| `QuitteDate` | 997-1059 | Public | 12 | 60 | 0 | portée réductible ? |
| `QuitteDate2` | 1061-1078 | Public | 3 | 16 | 0 | portée réductible ? |
| `Cmpt_LostFocus` | 1083-1151 | Public | 25 | 65 | 0 | handler GUI |
| `Cmpt_KeyPress` | 1153-1380 | Public | 72 | 197 | 0 | handler GUI |
| `Type_compte` | 1382-1399 | Public | 7 | 16 | 0 | portée réductible ? |
| `Btn_KeyPress` | 1404-1425 | Public | 8 | 17 | 0 | handler GUI |
| `Btn_Enter` | 1427-1436 | Public | 3 | 8 | 0 | handler GUI |
| `Btn_Leave` | 1438-1447 | Public | 3 | 8 | 0 | handler GUI |
| `Btn_Click` | 1452-1484 | Public | 9 | 19 | 0 | handler GUI |
| `Journal_GotFocus` | 1489-1494 | Public | 1 | 4 | 0 | portée réductible ? |
| `Journal_LostFocus` | 1496-1518 | Public | 7 | 21 | 0 | portée réductible ? |
| `Datej_GotFocus` | 1520-1532 | Public | 4 | 11 | 0 | portée réductible ? |
| `Dateech_GotFocus` | 1534-1538 | Public | 1 | 3 | 0 | portée réductible ? |
| `numcompte_GotFocus` | 1540-1544 | Public | 1 | 3 | 0 | portée réductible ? |
| `Datej_LostFocus` | 1546-1552 | Public | 1 | 5 | 0 | portée réductible ? |
| `Dateech_LostFocus` | 1554-1559 | Public | 1 | 4 | 0 | portée réductible ? |
| `numcompte_LostFocus` | 1561-1581 | Public | 6 | 19 | 0 | portée réductible ? |
| `Montant_GotFocus` | 1583-1607 | Public | 7 | 23 | 0 | portée réductible ? |
| `Montant_LostFocus` | 1609-1638 | Public | 6 | 27 | 0 | portée réductible ? |
| `numdoc_GotFocus` | 1640-1644 | Public | 1 | 3 | 0 | portée réductible ? |
| `numdoc_LostFocus` | 1646-1663 | Public | 5 | 15 | 0 | portée réductible ? |
| `numlot_GotFocus` | 1665-1669 | Public | 1 | 3 | 0 | portée réductible ? |
| `numlot_LostFocus` | 1671-1676 | Public | 2 | 4 | 0 | portée réductible ? |
| `Libelecrit_GotFocus` | 1678-1682 | Public | 1 | 3 | 0 | portée réductible ? |
| `Libelecrit_LostFocus` | 1684-1688 | Public | 1 | 3 | 0 | portée réductible ? |
| `Choix1_Click` | 1693-1710 | Public | 4 | 13 | 0 | handler GUI |
| `Choix1_Keypress` | 1715-1727 | Public | 4 | 10 | 0 | handler GUI |
| `Jour_KeyPress` | 1732-1755 | Public | 6 | 18 | 0 | handler GUI |
| `Jour_Click` | 1761-1785 | Public | 2 | 22 | 0 | handler GUI |
| `Boutonmontant_Click` | 1790-1795 | Public | 1 | 4 | 0 | handler GUI |
| `Button4_Click` | 1800-1970 | Public | 48 | 164 | 0 | portée réductible ? |
| `Button2_Click` | 1976-2029 | Public | 6 | 50 | 0 | portée réductible ? |
| `Enrg_Ecr` | 2031-2090 | Public | 12 | 54 | 0 | portée réductible ? |
| `ToggleButton6_Enter` | 2095-2099 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton6_Leave` | 2101-2105 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton6_Click` | 2107-2124 | Public | 3 | 16 | 0 | handler GUI |
| `ToggleButton8_Enter` | 2129-2133 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton8_Leave` | 2135-2139 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton8_Click` | 2141-2166 | Public | 5 | 23 | 0 | handler GUI |
| `Ventilations_Click` | 2171-2180 | Public | 2 | 8 | 0 | portée réductible ? |
| `Vtl_Click` | 2185-2196 | Public | 1 | 10 | 0 | handler GUI |
| `Libutton_Click` | 2201-2210 | Public | 2 | 8 | 0 | handler GUI |
| `Libview_Keypress` | 2215-2235 | Public | 6 | 17 | 0 | handler GUI |
| `Libview_Click` | 2240-2248 | Public | 1 | 7 | 0 | handler GUI |
| `Calculsolde` | 2253-2272 | Public | 4 | 18 | 0 | portée réductible ? |
| `Ecrit1_Keypress` | 2277-2321 | Public | 13 | 42 | 0 | handler GUI |
| `Ecrit1_Activate` | 2326-2374 | Public | 8 | 44 | 0 | handler GUI |
| `Recup_Type` | 2376-2391 | Public | 6 | 13 | 0 | portée réductible ? |
| `renlig` | 2393-2409 | Public | 5 | 14 | 0 | portée réductible ? |
| `DelEcr` | 2411-2431 | Public | 5 | 18 | 0 | portée réductible ? |
| `Ecrit_Click` | 2436-2444 | Public | 2 | 7 | 0 | portée réductible ? |
| `ecrit2` | 2449-2518 | Public | 12 | 67 | 0 | portée réductible ? |
| `Ecrit3` | 2523-2658 | Public | 28 | 130 | 0 | portée réductible ? |
| `Necrit_Click` | 2663-2676 | Public | 4 | 12 | 0 | portée réductible ? |
| `DelMvt` | 2681-2707 | Public | 5 | 24 | 0 | portée réductible ? |
| `DelMvt2` | 2712-2724 | Public | 2 | 10 | 0 | portée réductible ? |
| `clear` | 2729-2751 | Public | 1 | 21 | 0 | portée réductible ? |
| `Masque_Click` | 2753-2757 | Public | 1 | 3 | 0 | portée réductible ? |
| `Bclient_Click` | 2759-2767 | Public | 1 | 7 | 0 | handler GUI |
| `Bfournisseur_Click` | 2769-2777 | Public | 1 | 7 | 0 | handler GUI |
| `Bgestion_Click` | 2779-2787 | Public | 1 | 7 | 0 | handler GUI |
| `Bbilan_Click` | 2789-2797 | Public | 1 | 7 | 0 | handler GUI |
| `Sens_Ecr` | 2799-2824 | Public | 11 | 24 | 0 | portée réductible ? |
| `Button1_Click` | 2826-2843 | Public | 6 | 16 | 0 | portée réductible ? |
| `Button3_Click` | 2848-2852 | Public | 1 | 3 | 0 | portée réductible ? |
| `Ecrit1_MouseDown` | 2856-2860 | Public | 2 | 3 | 0 | handler GUI |
| `Aff_Mask` | 2862-2902 | Public | 6 | 39 | 0 | portée réductible ? |
| `Deb3` | 2904-2929 | Public | 4 | 22 | 0 | portée réductible ? |
| `Colabt_Click` | 2931-2950 | Public | 3 | 17 | 0 | handler GUI |
| `Colabt_KeyPress` | 2952-2960 | Public | 7 | 7 | 0 | handler GUI |
| `LignAbt` | 2962-3055 | Public | 12 | 84 | 0 | portée réductible ? |
| `Dateech_DblClick` | 3057-3065 | Public | 2 | 7 | 0 | portée réductible ? |
| `DateChooser1_Activate` | 3067-3072 | Public | 1 | 4 | 0 | handler GUI |
| `Button5_Click` | 3074-3139 | Public | 11 | 55 | 0 | handler GUI |
| `FileFilter` | 3141-3148 | Private | 1 | 5 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions sont regroupées par thème. Sauf mention contraire, la portée est **réductible**
(aucun appelant externe ; les handlers nominaux et pseudo-handlers restent `Public`, règle du
PLAN) et la nature **mixte** (SQL + contrôles).

### Initialisation, fermeture, remise à blanc

- **`_new(num2, Optional ecrmodif)`** [nécessaire] [GUI] (CC 23). Configure `numcompte`
  (`TextReg` : recherche dans `Fiches_Comptes` **en dur**, condition `type_cc='C'`, position),
  `Utils.Observers(Me)` (journalisation/rejeu), largeurs des colonnes depuis
  `/Soc<XX>/Col/LcolS` (`col<n>:<largeur>;…`, `col0` toujours forcée à 0, `col6` plafonnée à 80)
  ou valeurs par défaut, titres des colonnes, `Journal_GotFocus`. Si `num2` est fourni :
  `Ext = True`, `Nv = 1`, `Ecrit_Click()` (donc `Ecrit3`, rappel d'une écriture validée).
  `ecrmodif` → `bmodif` (archivage dans `Fiches_MvtM` lors du rappel). Note : `Ecrit1.Columns.Count = 7`
  alors que les lignes utilisent les indices 7 à 10 (données cachées).
- **`Cleanchamps()`** [GUI]. Vide compte, intitulé, solde, montant, TVA ; `montantdb/cd = 0` ;
  `If Val(soldeecrit.text) <> Null` (toujours vrai sauf texte non numérique) → `Ventilations` visible.
- **`clear()`** [GUI]. Remise à blanc complète de l'écran (`nvlle = 1`). Nom en minuscule qui masque
  `Me.Clear` des conteneurs (à confirmer).
- **`Button1_Click()`** [nécessaire, via `Btn`] [GUI]. Fermeture : si une écriture est en cours,
  `Message.Question` ; enregistre `/Soc<XX>/Col/LcolS` (largeurs) puis `Save` et `Me.Close`. Le
  code de sauvegarde des largeurs est dupliqué (l. 2833 et 2838) et existe dans 4 autres écrans.
- **`Button3_Click()`** [nécessaire, via `Btn` et F1] [GUI]. `Doc.Open("Saisiesdesachats")`.

### Gestion du focus et du clavier (groupes `Cmpt` et `Btn`)

- **`Cmpt_enter`/`Cmpt_leave`** [handlers] : `LF = 1/0` sur le journal (`Tag` 1). `LF` (« lost
  focus ») est un drapeau qui inhibe les contrôles de perte de focus pendant les navigations
  programmées ; il est positionné dans une trentaine d'endroits.
- **`Cmpt_GotFocus`** [handler] : `Utils.SetEditColor` ; mémorise le journal (`Sjour`).
- **`Cmpt_LostFocus`** [handler] (CC 25). `hder = Last` (contrôle à rendre au focus après un clic
  sur `Debit`/`Credit`). `Tag` 2 : `Datej_LostFocus` ; `Tag` 3 : contrôle du compte
  (`Type_compte`, `compteman`/`compteGman`) puis navigation selon `B` (0 libellé, 1 compte,
  2 journal, 3 date) ; écriture soldée → avertissement ; `Tag` 4 : mémorise `$libelle`.
- **`Cmpt_KeyPress`** [handler] (CC 72, max du fichier). Entrée/Tab enchaîne les champs
  (journal → date → compte → libellé → document → lot → montant → `Button4`) ; F2 : listes
  (journaux, comptes `TriCpt`, libellés) ; F4 : fiche comptes/clients/fournisseurs (`ShowModal`
  sur l'auto-instance du formulaire) ; F5 : calculatrice `FCalc` sur le montant ; F6 : solde
  (`Boutonmontant_Click`) ; F7 : masques d'abonnement (`Aff_Mask`) ; F8 : extrait du compte
  (`Extrait`) ; touche 60 (`<`) sur le compte : rappel du dernier compte (`Ncpt`) ; Échap : ferme
  `Colabt`. ⚠️ Les raccourcis du montant (touche 60 → solde, `D` → débit, `C` → crédit,
  l. 1289-1308) sont placés sous `Case 8` (date d'échéance) et non `Case 7` (montant) : saisis
  dans `Dateech`, ils modifient `Montant` ; saisis dans `Montant`, ils sont sans effet
  (comportement à confirmer en replay, anomalie SAISECRIT-A06).
- **`Btn_KeyPress`/`Btn_Enter`/`Btn_Leave`/`Btn_Click`** [handlers] : Entrée sur `Button4`/`Button2`,
  F1 ; `LF` sur `Button2`/`Button1` ; aiguillage des clics par `Tag` (cas 1 vide, `ToggleButton2`
  commenté). `Btn_Leave` met `LF = 1` pour le `Tag` 8 comme `Btn_Enter` (asymétrie à confirmer).
- **Pseudo-handlers de couleur** `Journal_GotFocus` (aussi `cnt = "1"`), `Datej_GotFocus` (date
  du jour si nouvelle écriture ; si `cnt = "1"`, renvoie le focus au journal), `Dateech_GotFocus`,
  `numcompte_GotFocus`, `numdoc_GotFocus`, `numlot_GotFocus`, `Libelecrit_GotFocus`,
  `Libelecrit_LostFocus`, `Dateech_LostFocus` (→ `QuitteDate2`), `Datej_LostFocus` (→ `QuitteDate`,
  recopie la date dans l'échéance), `numlot_LostFocus` (libellé par défaut = intitulé si vide) [GUI].
- **`Journal_LostFocus`** [GUI] : journal vide ou modifié en cours d'écriture → avertissement.
- **`numdoc_LostFocus`** [mixte] : `SELECT` d'une autre écriture du même journal, compte et numéro
  de document ; `Message.Question` dont la réponse est ignorée (`If … = 1 Then` vide) ; recopie le
  numéro de document dans le lot.

### Journal

- **`Journauxman()`** [mixte] : `SELECT * FROM Fiches_Journaux WHERE code_jo = &1` ; refuse `TR` ;
  fixe `type_jour`, libellé, titre ; `Type` = `F` si achat, sinon `C`.
- **`Journaux()`** [mixte] : liste `Jour` (journaux hors `TR`, ou préfixe saisi avec
  `left(code_jo,'<n>') = '<texte>'` **concaténé**).
- **`Jour_KeyPress`, `Jour_Click`** [handlers ; `Jour_Click` appelé aussi par `ReplayObserver`] :
  sélection d'un journal, même logique de type que `Journauxman` (dupliquée).
- **`Choix1_Click`, `Choix1_Keypress`, `ToggleButton6_Click/Enter/Leave`** [handlers] : menu
  « journaux / écritures non validées (`Ecr1`) / validées (`ecritv`) ». `Wait 0.2` dans `Choix1_Click`.

### Date et numérotation

- **`QuitteDate()`** [mixte] (CC 12). Si aucune ligne : lit `Fiches_Parametres` (`dtepc`,
  `dteclec`), normalise la date (`Utils.CDate_calc`/`Cdate_aff`), refuse une date ≤ `dtepc` ou
  > fin de l'exercice suivant `dteclec` (`LDate.EFin`). Nouvelle écriture : **numéro** =
  `Ecritures("numecriture")` + 1, écrit par `Majnum` (lecture puis `UPDATE` sans verrou : deux
  postes simultanés peuvent obtenir le même numéro) ; le numéro sert aussi de document et de lot.
  `Catch` vide : toute erreur est silencieuse.
- **`QuitteDate2()`** [GUI] : normalisation de la date d'échéance ; `Catch` vide.
- **`Ecritures(numecr)`** [mixte] : `SELECT <numecr> FROM Fiches_Parametres` (nom de colonne
  concaténé) → `num`. Nom trompeur (homonyme de la classe `Ecritures`).
- **`Majnum(numecr2)`** [calcul] : `UPDATE Fiches_Parametres SET <numecr2> = &1`.
- **`dateEcheance(Ech2)`** [mixte] : `SELECT * FROM Fiches_Echeances` (**table en dur**, variable
  `Tab4`) ; date d'échéance par `Utils.Calcech` ou date de l'écriture. Déclarée `Function … As
  String` sans `Return`.
- **`Compdate()`** : **code mort** (aucun appel ; affiche `Txt`, jamais renseigné).
- **`Dateech_DblClick()`** : **inactif** (`Dateech` appartient au groupe `Cmpt`, aucun
  `Cmpt_DblClick`) : le sélecteur `DateChooser1` n'est donc jamais affiché et
  **`DateChooser1_Activate`** [handler] est inatteignable en pratique.

### Comptes

- **`compte()`** [mixte] : `TriCpt(Type, TriCpt.Avec_Solde, Me)` en modal ; `TriCpt` renvoie la
  sélection par `Object.SetProperty(Me, "Bsel"/"Bval")` (d'où `Public Bsel`, `Bval`) ; puis
  `compteman` ou `compteGman`.
- **`compteman()`** [mixte] (CC 34). Compte de tiers. Contrôles (journal saisi, numéro attribué,
  compte 41 en vente, 40 en achat, écriture non soldée), `Sens_Ecr`, puis
  `SELECT … Fiches_Comptes LEFT JOIN Fiches_Four|Fiches_Cli … WHERE compte_cc LIKE '<saisie>%'`
  (**valeur concaténée**) ; refuse un compte principal ou d'un autre type ; intitulé du tiers,
  échéance (`dateEcheance`), **libellé par défaut** évalué par `LVar` (`libel_def` du tiers, date
  de l'écriture, variable `$numbl` vide), solde. Positionne `B` (0 OK, 1 erreur, 2 journal, 3 date).
- **`compteGman()`** [mixte] (CC 11) : compte général (`G` ou `B`) par `LIKE` **concaténé** ;
  `Leccompteg`, `Montant_GotFocus`.
- **`Leccompteg()`** [mixte] (CC 15) : `gen_tv`/`gen_ta` du compte et code/taux de TVA de vente
  (classe 7, ou 4 en vente) ou d'achat (classe 6, ou 4 en achat).
- **`Type_compte()`**, **`Recup_Type()`** [GUI / mixte] : déduisent le bouton radio de type
  (6/7 → gestion, 401 → fournisseur, 411 → client, sinon bilan ; ou `type_cc` lu en base).
- **`Bclient_Click`, `Bfournisseur_Click`, `Bgestion_Click`, `Bbilan_Click`** [handlers] : `Type`,
  condition de recherche du `TextReg` (`coll= False` pour le bilan), `Sens_Ecr`, `Tri` (écrit,
  jamais lu).
- **`Sens_Ecr()`** [GUI] (CC 11) : sens débit/crédit par défaut selon journal, type et `avoir`.
- **`ToggleButton8_Click/Enter/Leave`** [handlers] : bouton de recherche de compte (`compte()`).
- **`numcompte_LostFocus()`** : **code mort** (contrôle dans le groupe `Cmpt`, jamais appelé ;
  la logique active est `Cmpt_LostFocus`, `Tag` 3).

### Montant et TVA

- **`Montant_GotFocus()`** [GUI] : propose le solde de l'écriture (`soldec`) en valeur absolue ;
  si un taux de TVA est connu, calcule le HT et la TVA ; `Catch` → `"0,00"`.
- **`Montant_LostFocus()`** [GUI] : normalise le montant (`Utils.cpoint`), `montantht`, puis
  `Calctva` si `Modif = "0"`.
- **`Calctva()`** [mixte] (CC 25) : `SELECT … Fiches_Tvaac|Fiches_Tvaav WHERE code_tva = &1` →
  `compte_tva` et montant de TVA selon la classe du compte (6/2 achat, 7 vente, 4 selon le
  journal). Quatre branches quasi identiques ; trois utilisent `Val(Montant.Text)` sans
  `Utils.cpoint`, contrairement à la première (à confirmer selon la locale). Compare
  `montant.Text <> 0` (String/Integer).
- **`aff_tva()`** [mixte] (CC 15) : crée ou met à jour la **ligne de TVA automatique** dans
  `Ecrit1` (recherche du compte de TVA dans les lignes, `DELETE FROM Fiches_Mvt WHERE lind`,
  cumul si ligne existante), puis `Movt()` (INSERT). Clés de ligne `compte & numcol`, avec replis
  `+100`/`+200` sous `Try` en cas de doublon.
- **`Boutonmontant_Click`** [handler] : montant = |solde de l'écriture|.
- **`Debit_Click`, `Credit_Click`** [handlers] : rendent le focus au dernier champ (`hder`).

### Lignes de l'écriture

- **`Button4_Click()`** [nécessaire, via `Btn`/Entrée] [mixte] (CC 48, 164 LOC). Enregistre la
  ligne : si un masque d'abonnement est actif (`ecrA = "1"`) délègue à `LignAbt` ; sinon contrôle
  le compte (`Fiches_Comptes`, `coll <> 1`), compte/montant/document (proposition « Auto » = numéro
  d'écriture)/numéro/libellé, ajoute la ligne à `Ecrit1`, `Movt()`, analytique
  (`Fiches_Analytiques`, `/Soc<XX>/Analytique`), TVA (`Calctva` + `aff_tva`), `Calculsolde`,
  détection d'avoir, `Cleanchamps`, ventilation automatique (`VentilAuto`), fenêtre `Analytique`.
- **`Movt()`** [mixte] : `INSERT INTO Fiches_Mvt` de la ligne courante (18 colonnes, provisoire)
  puis **rechargement complet** de `Ecrit1` depuis la base (`ORDER BY cast(numcol as unsigned)`).
  `With utils` inutile.
- **`Calculsolde()`** [GUI] : totaux débit/crédit et solde des lignes de `Ecrit1` (sélectionne
  chaque ligne au passage).
- **`Ecrit1_Keypress`** [handler] : Suppr → `DELETE … WHERE lind` puis rechargement par
  `numero = num` (variable `num`, pas `numecrit.Text`) ; F1 ; Entrée → `Ecrit1_Activate`.
- **`Ecrit1_Activate`** [handler] : rappel d'une ligne pour modification (champs remplis,
  `DelEcr`, suppression de la ligne de la grille, `Modif = "1"`). Avec une grille vide, `DelEcr` et
  `Ecrit1.Current.Delete` s'exécutent quand même (erreur probable, à confirmer).
- **`DelEcr()`** [calcul] : `DELETE` de la ligne par `lind`, puis de la ligne de collectif
  correspondante (`numero`, `compte = coll_cc`, `numdoc`, `intitule`) ; boucle `Repeat` sur un
  `Result` réaffecté dans la boucle (une seule itération utile) ; paramètre `&4` (`numlot`) passé
  mais inutilisé.
- **`renlig()`** : **code mort** (renumérotation `numcol`, aucun appel).
- **`Ecrit1_MouseDown`** [handler] : clic droit → `Aff_Mask`.

### Écriture : validation, suppression, nouvelle écriture

- **`Button2_Click()`** [nécessaire, via `Btn`] [mixte] : refuse un solde non nul ; `Prov = 0`,
  `Vld = 1`, `DelMvt2()` puis `Enrg_Ecr()` ; remise à blanc ; type par défaut selon le journal.
- **`Enrg_Ecr()`** [calcul + lecture de `Ecrit1`] (CC 12). Pour chaque ligne de `Ecrit1` :
  `INSERT INTO Fiches_Mvt` (validée) ; `UPDATE Fiches_MvtA SET validee = 1` (analytique, répété à
  chaque ligne) ; **solde du compte** relu puis réécrit (`UPDATE Fiches_Comptes SET solde`) ;
  pour un compte rattaché à un collectif (`coll_cc`) : ligne de collectif cumulée (`UPDATE` ou
  `INSERT` avec `collectif = 1`) et solde du collectif. Après la boucle, suppression de la ligne de
  collectif si elle est soldée (seulement pour le **dernier** collectif rencontré) ;
  `Sha1Calc.CalcSha1("Fiches_Mvt", numéro)` (**table en dur**). Aucune transaction : une erreur au
  milieu laisse l'écriture et les soldes incohérents.
- **`DelMvt()`** [nécessaire, via `Btn` `Tag` 6] [mixte] : confirmation, `DELETE` dans
  `Fiches_Mvt` et `Fiches_MvtA`, `UPDATE Fiches_MvtM SET supprimee = 1` (**en dur**), suppression
  du document GED (`LGed.Search`/`Supprime`). **Les soldes des comptes ne sont pas recalculés**
  (sans effet pour une écriture provisoire ; pour une écriture rappelée par `Ecrit3`, les soldes ont
  déjà été décrémentés au rappel).
- **`DelMvt2()`** [mixte] : `DELETE FROM Fiches_Mvt WHERE numero` avant réécriture.
- **`Necrit_Click()`** [nécessaire, via `Btn`] [GUI] : abandonne l'écriture en cours (elle reste
  provisoire) et prépare une nouvelle écriture.

### Rappel d'écritures

- **`Ecr1()`**, **`Ecr2()`** [mixte] : reconstruisent la **table de travail `Ecrs`**
  (`DROP`/`CREATE … Utils.db.Engine()`/`INSERT` ligne à ligne) avec les écritures provisoires
  (`Ecr1`) ou validées (`Ecr2`, **`Fiches_Mvt` en dur** et `Ecrs` sans `Cbase.Table`), sous
  `LOCK TABLES Ecrs WRITE` (sous `Try` dans `Ecr1`, pas dans `Ecr2`), puis ouvrent `TriEcritures`
  en modal avant `UNLOCK TABLES`. La colonne `intitule` reçoit `libelle`. Sous MySQL, le verrou
  posé avant le `DROP` puis la lecture de `Fiches_Mvt` non verrouillée pendant `LOCK TABLES` sont à
  confirmer (erreur « table was not locked » possible, masquée par `Try` dans `Ecr1`). `Ecr2` n'a
  aucun appelant (`Choix1_Click` appelle `ecritv` directement) : **code mort**.
- **`ecritnv()`** (appelé par `Ecr1`), **`ecritv()`** (appelé par `Choix1_Click` et `Ecr2`) [GUI] : `TriEcritures("0"|"1", "", "0")` ; la sélection revient
  par `Comptabilite.Bsel`/`Comptabilite.snum` ; puis `ecrit2`/`Ecrit3` avec `bmodif = True`.
- **`Ecrit_Click()`** : aiguillage `Nv` → `ecrit2`/`Ecrit3` (appelé par `_new`). Pas un handler
  (aucun contrôle `Ecrit`).
- **`ecrit2()`** [mixte] (CC 12) : charge une écriture **provisoire** (`numero = Comptabilite.snum`)
  dans `Ecrit1` ; si `bmodif`, archive chaque ligne dans `Fiches_MvtM` (**en dur**, 23 colonnes,
  `datem` = maintenant).
- **`Ecrit3()`** [mixte] (CC 28, 130 LOC) : rappel d'une écriture **validée** (`numr` ou
  `Comptabilite.snum`) après confirmation : chargement dans `Ecrit1`, archivage `Fiches_MvtM` si
  `bmodif`, **décrément des soldes** du compte et du collectif (formules différentes selon 41 ou
  autre), délettrage des écritures de même numéro de lot (`UPDATE … SET lettree = 0, numlot =
  <lot sans préfixe M/S>` **répété** pour chaque ligne trouvée), passage de l'écriture en
  provisoire, `Sha1Calc.CalcSha1("Fiches_Mvt", …)`. Refus de confirmation : fermeture si ouvert
  depuis l'extérieur (`Ext`). `Catch` → message « Votre écriture n'est pas terminée ».

### Ventilations et libellés

- **`ventil()`**, **`ventilAuto()`** [mixte] : ventilations du tiers (`Fiches_Cli_Vtl` ou
  `Fiches_Four_Vtl`) ; `ventilAuto` sélectionne directement l'unique ventilation et calcule le
  montant HT (`compteGman`, `Montant_GotFocus`, `Montant_LostFocus`).
- **`Ventilations_Click`** [via `Btn`], **`Vtl_Click`** [handler, appelé aussi par
  `ReplayObserver`] : liste et sélection d'une ventilation.
- **`Lib()`**, **`Libutton_Click`**, **`Libview_Keypress`**, **`Libview_Click`** : libellés
  prédéfinis (`Fiches_Libelles`).

### Masques de saisie (abonnements)

- **`Aff_Mask()`** [GUI] : affiche `Colabt` (masques) si journal et numéro sont renseignés, puis
  `Deb3`.
- **`Deb3()`** [mixte] : `SELECT * FROM Fiches_Numabon WHERE type = 'A'` (toujours `A`, la ligne
  conditionnelle est commentée) ; libellé de type « Achat » en dur.
- **`Colabt_Click`**, **`Colabt_KeyPress`** [handlers] : sélection d'un masque (premier compte de
  `Fiches_Ligabon`, argument `"0,00"` superflu), `ecrA = "1"`.
- **`LignAbt()`** [mixte] (CC 12) : remplace les lignes de `Ecrit1` par les lignes du masque
  (`Fiches_Ligabon` ⨝ `Fiches_Numabon`) ; numéro de document, lot et libellé évalués par `LVar`
  (trois séquences `New Collection` / `New LVar` / `AddDate` / `ParseResult` / `Evaluate`
  identiques), débit et crédit évalués avec la variable `$montant` puis formatés par
  `LPrix(mnt).L` ; `Abont.Compteur_Incr` (appel sur l'auto-instance du formulaire `Abont`).
  ⚠️ Les lignes ne sont **pas** écrites dans `Fiches_Mvt` (pas de `Movt`) : elles ne le sont qu'à la
  validation (`Enrg_Ecr`) ; un abandon perd les lignes du masque (à confirmer).
- **`Masque_Click()`** : **code mort** (aucun contrôle `Masque`, aucun appel).

### GED

- **`Button5_Click()`** [handler] [mixte] : document GED de l'écriture (`LGed.Search` ou
  `New LGed(Null, 0, LGed.Comptabilite, "Compta", numéro)`), TTC = Σ(crédit − débit) des comptes de
  tiers (4 hors 445), TVA = Σ des comptes 445, HT = TTC + TVA, valeurs absolues (`LPrix.Add`,
  `Sub`, `Abs`) ; étiquettes : `tag_def` du fournisseur (401) ou du client (411) par
  `SELECT tag_def … WHERE fo_code = <compte>` (**valeur concaténée sans quotes**) et chaque
  compte de l'écriture (`AddTag`) ; date ; `ShowModal`, `Delete()` du formulaire si annulé.
  La variable locale `$cpt` masque le membre `Private $cpt` (inutilisé).
- **`FileFilter()`** [Private] : **code mort**.

## SQL émis : synthèse

| Table | Accès | Fonctions | Remarque |
|---|---|---|---|
| `Fiches_Mvt` (`TabMvt`) | SELECT, INSERT, UPDATE, DELETE | `Movt`, `aff_tva`, `Enrg_Ecr`, `DelMvt`, `DelMvt2`, `DelEcr`, `Ecrit1_Keypress`, `numdoc_LostFocus`, `Ecr1`, `ecrit2`, `Ecrit3` | `Ecr2` et `Sha1Calc` en dur ; `Fiches_Mvt1-5` jamais touchées |
| `Fiches_MvtA` (`TabMvtA`) | UPDATE, DELETE | `Enrg_Ecr`, `DelMvt` | analytique |
| `Fiches_MvtM` | INSERT, UPDATE | `ecrit2`, `Ecrit3`, `DelMvt` | **en dur** (`TabMvtM` existe) |
| `Fiches_Comptes` (`TabComptes`) | SELECT, UPDATE solde | `compteman`, `compteGman`, `Leccompteg`, `Button4_Click`, `aff_tva`, `Enrg_Ecr`, `Ecrit3`, `DelEcr`, `Recup_Type` | `LIKE` concaténé ; soldes en lecture-modification-écriture |
| `Fiches_Parametres` (`TabParam`) | SELECT, UPDATE | `QuitteDate`, `Ecritures`, `Majnum` | numéro d'écriture sans verrou |
| `Fiches_Journaux` (`TabJour`) | SELECT | `Journauxman`, `Journaux` | préfixe concaténé |
| `Fiches_Cli`, `Fiches_Four` | SELECT | `compteman`, `Button5_Click` | `tag_def` concaténé |
| `Fiches_Cli_Vtl`, `Fiches_Four_Vtl` | SELECT | `ventil`, `ventilAuto` | |
| `Fiches_Echeances` | SELECT | `dateEcheance` | **en dur** |
| `Fiches_Tvaac`, `Fiches_Tvaav` | SELECT | `Calctva` | |
| `Fiches_Libelles`, `Fiches_Analytiques`, `Fiches_Numabon`, `Fiches_Ligabon` | SELECT | `Lib`, `Button4_Click`, `Deb3`, `Colabt_Click`, `LignAbt` | |
| `Ecrs` (travail) | LOCK, DROP, CREATE, INSERT | `Ecr1`, `Ecr2` | table temporaire partagée entre postes |
| GED (`Docs_*` via `LGed`) | — | `DelMvt`, `Button5_Click` | |

Compatibilité SQLite : `cast(numcol as unsigned)` (affinité numérique), `left()` (traduit),
`LOCK TABLES` neutralisé, `Integer(6)` accepté ; pas de syntaxe non traduite relevée.

## État global utilisé

- `Start.LocalSettings` (`/Soc<XX>/Col/LcolS`, `/Soc<XX>/Analytique`), `Start.Societe`,
  `Start.son`, `Start.Musique`.
- `Comptabilite.Bsel`, `Comptabilite.snum` (retour de `TriEcritures`).
- Auto-instances de formulaires : `FComptes`, `FClient`, `FFournisseur` (`ShowModal` par F4),
  `Abont` (`Compteur_Incr`), `FCalc.Resultat`.
- **48 variables d'instance `Private`** utilisées comme variables globales de l'écran : drapeaux
  de navigation (`LF`, `B`, `cnt`, `n`, `nvlle`, `Nv`, `Ext`, `bmodif`), état de l'écriture
  (`soldec`, `montantdb`, `montantcd`, `Totaldb`, `Totalcd`, `montantht`, `tva`, `compte_tva`,
  `Gntva`, `Modif`, `Vld`, `Prov`, `avoir`, `ecrA`, `numlig`, `Cle`, `Itm`), sélection
  (`numCpt`, `Ncpt`, `Numcvtl`, `Type`, `type_jour`, `Sjour`, `$libelle`). Variables écrites mais
  jamais lues : `ecriture`, `supp`, `Prg`, `sLind`, `Tri`, `n` ; jamais renseignée : `txt` ;
  inutilisée : `$cpt` (membre). `Modif` (String) est comparé à `"1"` et à `1`, `Vld`/`Prov`
  (Boolean) reçoivent `0`/`1` et sont insérés tels quels en base.

## Propositions d'amélioration

### Réécriture / refactorisation (ciblée, fichier legacy)

- **Ne pas réécrire** l'écran : il est très sensible à l'ordre des effets de focus (`LF`, `B`).
  Les reworks se limitent au code mort, aux extractions de fonctions SQL pures et aux
  commonalisations ci-dessous.
- `Cmpt_KeyPress` (CC 72) : extraire un `Select Case` par champ en fonctions privées
  (`ToucheJournal`, `ToucheDate`, `ToucheCompte`…) sans changer l'ordre des tests ; les raccourcis
  mal placés (A06) restent sous `Case 8`.
- `Calctva` : une fonction pure `MontantTva(classe, typeJour, gntva, montant, montantht, taux)` et
  une requête `CompteTva(table, code)` remplacent les quatre branches.
- `Movt`, `ecrit2`, `Ecrit3`, `Ecrit1_Keypress` : un seul `ChargeEcriture(numero)` pour remplir
  `Ecrit1` (quatre copies de la boucle de chargement).
- `Ecrit3` : la boucle de délettrage exécute le même `UPDATE` pour chaque ligne trouvée ; un seul
  `UPDATE` suffit (« SQL modifié, dump identique »).
- `Enrg_Ecr` : l'`UPDATE Fiches_MvtA SET validee = 1 WHERE numero` est répété pour chaque ligne :
  le sortir de la boucle (« SQL modifié, dump identique »).

### Commonalisation avec d'autres fichiers

- **[`Tresor`](../Tresor.class/architecture.md)** : 64 fonctions homonymes ; identiques ou
  presque pour `Colabt_Click` (1 ligne de différence), `Calculsolde` (4), `Aff_Mask` (5), `Deb3` (6),
  `LignAbt` (20 sur 94) ; divergentes pour `Enrg_Ecr`, `Ecrit3`, `compteman`, `Movt`. Candidats à un
  module commun (phase 3), avec les contrôles passés en paramètre : chargement des masques
  (`Deb3`), calcul des lignes de masque (`LignAbt`), solde de la grille (`Calculsolde`), calcul des
  montants GED (`Button5_Click`), archivage `Fiches_MvtM`.
- **Séquence `LVar`** (`New Collection` → `New LVar` → `AddDate` → `ParseResult` → `Evaluate` →
  `Left(…, n)`) : 4 fois ici (`compteman`, `LignAbt` ×3), 3 fois dans `Tresor.LignAbt`, et dans
  [`EcrAuto`](../Utils/EcrAuto.class/architecture.md), `ValidBR`, `ValidBR1` → helper
  `LVar.EvalueTexte(controle, vars, modele, date, result, longueur)` (voir LVar).
- **`Sha1Calc.CalcSha1("Fiches_Mvt", …)`** en dur : ici, dans `Tresor` et `Moulinage` →
  `Cbase.Table("TabMvt")` (même valeur).
- **Numéro d'écriture** (`Ecritures` + `Majnum`) : `DB_Connection.LockIncrement("numecriture",
  Cbase.Table("TabParam"))` (utilisé par `Caisse` et `Moulinage`) donnerait le même numéro avec un
  verrou (« SQL modifié, dump identique » en mono-poste).
- **Largeurs de colonnes** `/Col/LcolS` (`_new`, `Button1_Click`) : même code dans `Tresor`,
  `Extrait`, `Archives`, `Facture` → `Utils.LitLargeurs(cv, cle)` / `Utils.SauveLargeurs(cv, cle)`.
- **Table de travail `Ecrs`** (`Ecr1`, `Ecr2`) : propre à `Saisecrit` (aucun autre utilisateur que
  `Cbase`) ; `Ecr2` est mort et `Ecr1` peut perdre ses copies de DDL (voir rework).

### Réduction de portée

- Fonctions non-handlers sans appelant externe → `Private` : `Cleanchamps`, `dateEcheance`, `Movt`,
  `compte`, `compteman`, `compteGman`, `Leccompteg`, `Journauxman`, `Journaux`, `Ecritures`, `Majnum`,
  `ecritnv`, `ecritv`, `Ecr1`, `ventil`, `ventilAuto`, `Lib`, `Calctva`, `aff_tva`, `QuitteDate`,
  `QuitteDate2`, `Type_compte`, `Enrg_Ecr`, `Calculsolde`, `Recup_Type`, `DelEcr`, `Ecrit_Click`,
  `ecrit2`, `Ecrit3`, `DelMvt`, `DelMvt2`, `clear`, `Sens_Ecr`, `Aff_Mask`, `Deb3`, `LignAbt`.
- **À garder `Public`** : `_new`, les handlers nominaux et de groupe, les pseudo-handlers nommés
  `<Contrôle>_<Événement>` (règle du PLAN, même s'ils ne sont jamais levés), `Bsel`/`Bval` (écrits
  par `TriCpt` via `Object.SetProperty` : faux positif de `deps.py`).
- Variables d'instance écrites mais jamais lues : suppression (code mort).

### Séparation traitement / GUI

- Extraire sans accès aux contrôles, dans le même fichier : `InsereLigne(...)` (SQL de `Movt`),
  `ValideEcriture(numero, lignes)` (SQL de `Enrg_Ecr`, lignes passées sous forme de tableau),
  `AnnuleSoldes(numero)` (soldes de `Ecrit3`), `ProchainNumero()` (`QuitteDate`), `MontantsGed(lignes)`
  (`Button5_Click`), `ControleDate(date, dtepc, dteclec)` (`QuitteDate`), `MontantTva` (`Calctva`).
  Ces fonctions sont testables en gb.test et préparent la mise en commun avec `Tresor`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Soldes des comptes (`Fiches_Comptes.solde`) maintenus par lecture-modification-écriture dans
  l'application : une vue ou un calcul agrégé sur `Fiches_Mvt` (ou un `UPDATE … SET solde = solde +
  &1`) supprimerait les incohérences en cas d'accès concurrent.
- Numéro d'écriture : séquence ou table de compteurs avec `AUTO_INCREMENT` dédiée.
- Table de travail `Ecrs` partagée entre postes : la remplacer par une requête directe (ou une
  table temporaire de session `CREATE TEMPORARY TABLE`).
- Colonne `provisoire`/`validee` en double : un seul état (`statut`) éviterait les combinaisons
  incohérentes.
