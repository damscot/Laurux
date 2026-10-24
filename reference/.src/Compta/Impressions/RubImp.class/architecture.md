# RubImp — Architecture

> Source : `.src/Compta/Impressions/RubImp.class`

## Vue d'ensemble

`RubImp` est l'écran « Impression bilan/SIG/compte de résultat », ouvert par Comptabilité > Compte
de résultat > Impression (`Fmenu.Menu124_Click`). L'utilisateur choisit :

- l'édition (boutons radio `Bilan`, `Crlt` « Compte de résultat » coché par défaut, `Sig`) et
  `Impd` « Impression détaillée » (actif seulement pour le compte de résultat) ;
- l'exercice (`E1` exercice en cours, coché par défaut, `N1`…`N5`) et la période `DteN0`…`DteN1`.

`Button2` (Imprimer) lance `Button2_Click` (659 lignes, **CC 135**) qui :
- délègue le bilan à [Imp_Bilan](../Imp_Bilan.module/architecture.md) et les SIG à
  [Imp_Sig](../Imp_Sig.module/architecture.md) ;
- calcule et imprime **lui-même le compte de résultat** (`~/tmp/Resultat.pdf`, classe `Cresultat`)
  à partir des rubriques `R…`, avec une colonne N et une colonne N-1.

Les bornes d'exercice sont lues directement dans `Fiches_Parametres` (`dteclec` = fin de l'exercice
courant, `dteclec1`…`dteclec5` = fins des exercices précédents) : 20 lectures `rResult!dteclec*`
réparties dans `Recup_Dtes`, `Ex1`, `Exo`, `Exo1`…`Exo5`, sous forme de chaînes `mm/dd/yyyy`
(conversion implicite `Date` → `String`) retraitées par `Utils.Calc_mois` / `Utils.Cdate_aff`.

Nature globale : **mixte** ; `Button2_Click` mêle lecture des contrôles, SQL, calcul et impression.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dte` | var | Private |  | String | 11 |
| `dte1` | var | Private |  | String | 12 |
| `dte2` | var | Private |  | String | 13 |
| `dtes1` | var | Private |  | String | 14 |
| `dtes2` | var | Private |  | String | 15 |
| `jour` | var | Private |  | String | 16 |
| `Txt` | var | Private |  | String | 17 |
| `son` | var | Private |  | Integer | 18 |
| `Filename` | var | Private |  | String | 19 |
| `sens` | var | Private |  | Integer | 20 |
| `PosY` | var | Private |  | Integer | 21 |
| `Nbpage` | var | Private |  | Integer | 22 |
| `Ste` | var | Private |  | String | 23 |
| `dateedition` | var | Private |  | String | 24 |
| `pdf` | var | Private |  | Cresultat | 25 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 27-36 | Public | 1 | 7 | 0 | méthode spéciale |
| `Recup_Dtes` | 38-85 | Public | 8 | 44 | 0 | portée réductible ? |
| `Ex1` | 87-113 | Public | 2 | 24 | 0 | portée réductible ? |
| `Exo` | 115-136 | Public | 1 | 19 | 0 | portée réductible ? |
| `Exo1` | 138-155 | Public | 1 | 15 | 0 | portée réductible ? |
| `Exo2` | 157-174 | Public | 1 | 15 | 0 | portée réductible ? |
| `Exo3` | 176-193 | Public | 1 | 15 | 0 | portée réductible ? |
| `Exo4` | 195-212 | Public | 1 | 15 | 0 | portée réductible ? |
| `Exo5` | 214-234 | Public | 1 | 18 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 236-262 | Public | 10 | 22 | 0 | handler GUI |
| `Btn_Click` | 264-279 | Public | 6 | 11 | 0 | handler GUI |
| `Cmpt_GotFocus` | 284-290 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LostFocus` | 292-311 | Public | 4 | 18 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 313-340 | Public | 7 | 26 | 0 | portée réductible ? |
| `Compdate` | 342-353 | Public | 3 | 10 | 0 | portée réductible ? |
| `compdate2` | 355-366 | Public | 3 | 10 | 0 | portée réductible ? |
| `E0_Click` | 368-373 | Public | 1 | 3 | 0 | portée réductible ? |
| `E1_Click` | 375-380 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Click` | 382-387 | Public | 1 | 3 | 0 | handler GUI |
| `N2_Click` | 389-394 | Public | 1 | 3 | 0 | handler GUI |
| `N3_Click` | 396-401 | Public | 1 | 3 | 0 | handler GUI |
| `N4_Click` | 403-408 | Public | 1 | 3 | 0 | handler GUI |
| `N5_Click` | 410-415 | Public | 1 | 3 | 0 | handler GUI |
| `Raz` | 417-419 | Public | 1 | 2 | 0 | portée réductible ? |
| `Button2_Click` | 421-1133 | Public | 135 | 659 | 0 | portée réductible ? |
| `Bilan_Click` | 1135-1139 | Public | 1 | 3 | 0 | handler GUI |
| `Sig_Click` | 1141-1145 | Public | 1 | 3 | 0 | handler GUI |
| `Crlt_Click` | 1147-1151 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 1156-1160 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et choix de l'exercice

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Observateurs, `Music.Load`,
  `E1_click()` (dates de l'exercice en cours), centrage, focus sur `DteN0`.
- **`E1_Click`, `N1_Click`…`N5_Click`** [portée : nécessaire (handlers)] [nature : GUI] →
  `Exo`, `Exo1`…`Exo5`.
- **`Exo()`, `Exo1()`…`Exo4()`** [portée : réductible] [nature : mixte]. Pour l'exercice `k`
  (0 = en cours) : `DteN0 = Calc_mois(dteclec(k+1))` (1er jour du mois suivant la clôture
  précédente), `DteN1 = Cdate_aff(dteclec(k))`, `dte1 = DteN0`, `dte = dteclec(k+1)` (chaîne brute),
  `dte2 = Cdate_aff(dteclec(k+1))`. Cinq copies d'une même procédure paramétrée par `k`.
- **`Exo5()`** [portée : réductible] [nature : mixte]. Pas de `dteclec6` : début = `Calc_mois` de
  `dteclec5` moins un an (manipulation de chaîne `Left$(dte, 6) & (année − 1)`), fin = `dteclec5`.
- **`Ex1()`** et **`E0_Click()`** — **code mort** : `E0_Click` est le seul appelant d'`Ex1` et
  aucun contrôle `E0` n'existe dans `RubImp.form` (vérifié par `grep`).
- **`Raz()`** — procédure vide, appelée par `Ex1`, `Exo`…`Exo5` (code mort).
- **`Recup_Dtes()`** [portée : réductible] [nature : mixte]. Période N-1 **affichée** dans
  l'en-tête : `dtes1 = Calc_mois(dteclec(k+2))`, `dtes2 = Cdate_aff(dteclec(k+1))` **+ 1 jour**
  (l.78), cas particuliers `N4` (année recopiée) et `N5` (`dtes1 = dteclec5`, `dtes2 = ""`). Ces dates
  sont transmises à `Imp_Bilan`/`Imp_Sig` (qui les ignorent ou les recalculent) et servent à
  l'en-tête `Periode` du compte de résultat ; le calcul N-1 utilise, lui, `DteN0`/`DteN1` − 1 an
  (l.706-709).

### Saisie des dates

- **`Cmpt_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée/Tab sur `DteN0`
  (tag 1) ou `DteN1` (tag 2) → `dteN0_LostFocus`/`dteN1_LostFocus` et bascule du focus ; F1 → aide.
- **`dteN0_LostFocus()` / `dteN1_LostFocus()`** [portée : nécessaire (handlers)] [nature : mixte].
  Normalisent la saisie (`Cdate_calc` puis `Cdate_aff`) et la comparent à `dte1` (début) et à `dte`
  (chaîne brute `mm/dd/yyyy` de la clôture **précédente**) en recomposant `Right$(…,4) & Mid$(…,4,2)
  & Left$(…,2)` : sur `dte` cela donne `aaaajjmm` et non `aaaammjj`, et la borne est la fin de
  l'exercice précédent (à confirmer par T06, anomalie RUBIMP-A02). Hors bornes → `Compdate` /
  `compdate2`. Fin < début → avertissement puis `Exo()`.
- **`Compdate()` / `compdate2()`** [portée : réductible] [nature : GUI]. Son, `Message.Warning`,
  `Exo()`, `E1.Value = True`, focus.
- **`Cmpt_GotFocus()`** [portée : nécessaire] [nature : GUI]. `Utils.SetEditColor`.

### Boutons

- **`Btn_Click()`** [portée : nécessaire (handler de groupe)] [nature : GUI]. Tag 1 aide, 2
  `Button2_Click`, 3 : `If Exist(filename) Then Try Kill filename` puis `Me.Close`. ⚠️ `filename`
  désigne ici la variable de classe `Filename`, jamais affectée (`Button2_Click` déclare une locale
  du même nom) : le PDF n'est jamais supprimé (RUBIMP-A01).
- **`Bilan_Click`, `Sig_Click`, `Crlt_Click`** [portée : nécessaire (handlers)] [nature : GUI].
  Désactivent/activent `Impd` (sa valeur reste celle choisie avant).
- **`Button1_Click()`** [portée : nécessaire (appelé par `Btn_Click` et F1)] [nature : GUI].
  `Doc.Open("Bcrimp")`.

### `Button2_Click()` — structure par blocs

[portée : nécessaire (appelé par `Btn_Click`)] [nature : mixte].

| Bloc | Lignes | Rôle | SQL émis |
|---|---|---|---|
| A. Initialisation | 494-549 | ouvre `~/tmp/Resultat.csv` (même pour bilan/SIG) ; `Message.info("Attention, ce traitement peut être très long")` ; `Tab5`/`Tab6` et code `exercice` selon `E1`…`N5` ; nom de la société ; `Recup_Dtes` ; souris en attente | `SELECT … Fiches_Societes`, `Fiches_Parametres` |
| B. Table de travail | 552-566 | `DROP` + `CREATE centralisation` (version compte de résultat : `Col1`…`col4` `Char(25)`, clé `numrub, compte`), y compris pour bilan/SIG | DDL |
| C. Aiguillage | 569-591 | préfixe `B`/`R`/`S`, nom du PDF (variable locale), libellé `detail` et en-tête `Periode` ; `B` → `Imp_Bilan.Lancement`, `S` → `Imp_Sig.Lancement` | — |
| D. Centralisation N | 597-690 | pour chaque rubrique `R` : ligne d'en-tête (`compte "0"`, colonnes à 0, `L` → détail `N`) ; type `L` : pour chaque plage, écritures **validées** de la période dans `Tab5` ; écrit deux lignes par écriture dans `Resultat.csv` ; si détaillé, une ligne par compte (`detail O`, `col3 += débit − crédit`) ; une ligne de synthèse par plage (`compte " "`, `detail N`, `col3 = Etot3`) ; types `E` (détail `N`) et `O` : écrit le cumul `Etot1` sur la rubrique `E`/`O` **précédente** (`RubE`) | par rubrique : `SELECT`+`INSERT`/`UPdate` ; par plage : `SELECT Tab5` ; par écriture (détaillé) : `SELECT`+`INSERT`/`UPdate` |
| E. Centralisation N-1 | 697-799 | idem sur `Tab6` et dates − 1 an, colonne `col4` ; le détail des comptes reçoit `detail = "0"` (zéro) ; pas exécuté pour `N5` | idem |
| F. Sous-totaux | 804-854 | `SELECT * FROM centralisation` (sans `ORDER BY`) : cumule `col3`/`col4` des `E` dans les `S`, des `S` dans les `O` (rubriques `R`) | `UPdate` des lignes `S` et `O` |
| G. Totaux produits/charges | 859-896 | jointure `centralisation` ⋈ `Fiches_Rubriques` (sans `ORDER BY`) : `Tproduit1/2` (rubriques `num = P`), `Tcharge1/2` (`num = C`) en valeur absolue ; réécrit les `O` avec les cumuls `S`+`E` | `UPdate` des `O` |
| H. Résultat | 898-948 | lit les deux lignes `O` (première → `Ttot`, seconde → `Otot`), détermine bénéfice (`C`) ou perte (`D`) pour N et N-1 et écrit le montant sur la rubrique de type correspondant | `SELECT`, `UPdate` |
| I. Lignes `R`/`G` | 950-990 | `R` reçoit `Tproduit1/2`, `G` reçoit `Tcharge1/2` (si perte : `Stot5/6`) | `UPdate` |
| J. Impression | 995-1125 | `centralisation` triée `numrub, detail, compte` ; `Cresultat` : `T` nouvelle page, `E`/`S`/`O`/`C`/`D` `level1`, `L` `level7` (synthèse, détail `N`) ou `level2` (compte), `R`/`G` totaux ; après `R`, `sens = 1` inverse le signe des montants ; pagination à 44 lignes ; `Output` + `Visualiseur.Prog` | 1 `SELECT intitule_cc` par ligne |

Le compte de résultat est donc le seul des trois états à imprimer une colonne N-1. Les blocs D et E
sont presque identiques (différences : table et dates, colonne `col3`/`col4`, caractère de détail
`O`/`0`, mise à jour partielle de l'en-tête en N-1, `type`/`typeE` dans l'écriture du cumul `RubE`).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe`, `Music`.
- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Dbase`, `Utils.Cdate_calc`, `Utils.Cdate_aff`,
  `Utils.Calc_mois`, `Utils.SetEditColor`, `Utils.Observers`, `LDate(…)`, `Cbase.Table("TabComptes")`,
  `Visualiseur.Prog`, `Doc.Open`, `User.Home`.
- Variables de classe : `dte`, `dte1`, `dte2`, `dtes1`, `dtes2`, `jour`, `Txt` (dates et message),
  `sens`, `PosY`, `Ste`, `pdf` (impression) ; `Filename` (jamais affectée), `Nbpage` et
  `dateedition` (jamais relues).

## Propositions d'amélioration

### Réécriture / refactorisation (résultat identique)

- `Exo(k)` unique remplaçant `Exo`, `Exo1`…`Exo4` (et `Exo5` en cas particulier) ; les handlers
  `N1_Click`… gardent leur nom et appellent `Exo(1)`…
- Découper `Button2_Click` en `ChoixExercice`, `CreeCentralisation`, `CentralisePeriode(...)` (blocs
  D et E paramétrés par table, dates, colonne, caractère de détail, mode d'écriture de l'en-tête),
  `SousTotaux`, `TotauxProduitsCharges`, `Resultat`, `LignesRG`, `Imprime` ; **mêmes requêtes dans
  le même ordre** (les requêtes sans `ORDER BY` des blocs F, G et I rendent l'ordre physique des
  lignes significatif : ne pas les modifier).
- Supprimer `E0_Click`, `Ex1`, `Raz` et ses 7 appels, `Shell "cd …"`, `det = … & "detail"`,
  variables inutilisées.

### Commonalisation avec d'autres fichiers

- **Dates d'exercice** : `Exo`…`Exo5`, `Recup_Dtes` et la recomposition `aaaammjj` peuvent passer par
  `LDate.Exercice_Cloture(k)` ([LDate](../../../Utils/LDate.class/architecture.md)) :
  `Calc_mois(LDate.Exercice_Cloture(k + 1).G)` et `LDate.Exercice_Cloture(k).L` donnent les mêmes
  chaînes que les conversions actuelles (branche `Date` de `Calc_mois` et `Cdate_Aff` contre branche
  chaîne `mm/dd/yyyy`, à confirmer par T05) ; attention à l'heure 23:59:59.999 si la valeur sert dans
  une requête. Même idiome `Ex1`/`Exo`/`Exo1`… dans [Balance](../Balance.class/architecture.md),
  [EcrM](../EcrM.class/architecture.md), [EditcompteA](../EditcompteA.class/architecture.md),
  [Editcompte](../Editcompte.class/architecture.md), [ExportA47](../ExportA47.class/architecture.md),
  [Jourcent](../Jourcent.class/architecture.md), [Journaux](../Journaux.class/architecture.md),
  [JournauxA](../JournauxA.class/architecture.md) et [Verbal](../../Utils/Verbal.class/architecture.md) :
  un helper commun `BornesExercice(k) As String[]` (dans `LDate` ou un module Compta).
- **Choix des tables Mvt**, **en-tête société**, **table `centralisation`** : communs avec
  `Imp_Bilan` et `Imp_Sig` (IMP_BILAN-003/004, `Utils.TableTravail`).

### Réduction de portée

- `Recup_Dtes`, `Exo`…`Exo5`, `Compdate`, `compdate2` → `Private` (aucun appelant externe, vérifié par
  `grep`). Handlers (`E1_Click`…, `Bilan_Click`…, `Cmpt_*`, `Btn_Click`, `Button*_Click`,
  `dteN*_LostFocus`) inchangés.

### Séparation traitement / GUI

- `Button2_Click` lit une fois les contrôles (`E1`…`N5`, `Bilan`/`Crlt`/`Sig`, `Impd`, `DteN0`,
  `DteN1`) puis appelle `EditionResultat(sExercice, bDetail, sDeb, sFin, sPeriode)` sans accès aux
  contrôles ; le handler garde `Message.info`, la souris et l'aiguillage vers `Imp_Bilan`/`Imp_Sig`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table de travail `centralisation` temporaire de connexion (voir Imp_Bilan).
- Dates de clôture `dteclec`…`dteclec5` en lignes d'une table d'exercices (une ligne par exercice)
  au lieu de six colonnes : supprimerait les cascades `dteclec(k)` et le cas particulier `N5`.
