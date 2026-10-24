# Journaux — Architecture

> Source : `.src/Compta/Impressions/Journaux.class`

## Vue d'ensemble

`Journaux` est l'écran **« Impression des journaux »** (menu Compta, `Fmenu.Menu32_Click`,
`journaux.Show` sur l'auto-instance). L'utilisateur choisit :

- un **exercice** (boutons radio `E0` « Exercice en cours », `E1` « Exercice précédent », `N1`
  … `N5`) qui fixe la table d'écritures `Tab0` (`Fiches_Mvt` … `Fiches_Mvt5`) et la période
  proposée (`dteN0`/`dteN1`, bornes mémorisées dans `dte1`/`dte2`) ;
- une **période** (`dteN0`, `dteN1`, contrôlée à la sortie du champ) ;
- un **intervalle de journaux** (`Cpt`, `Cpt2`, liste de choix `coljour`/`coljour2` sur F2) ;
- un tri (`RadioButton1` date/numéro/compte, `RadioButton2` numéro/date/compte) et l'impression
  des totaux (`CheckBox1`).

Deux traitements :

- **Imprimer** (`Button1_Click`) : délégué à [`JournauxM.Imprime`](../JournauxM.module/architecture.md)
  (PDF `~/tmp/Journaux.pdf`).
- **Exporter** (`Button2_Click` ouvre `Panel2`, `Button4_Click` lance) : fichier texte
  `~/tmp/journaux.txt`, une ligne par écriture non collective, colonnes séparées par `;` dans
  l'ordre configuré par [`journauxSetting`](../journauxSetting.class/architecture.md) (clés
  `/ExportJournal<société>/Entete<i>` et `/Titre<i>` de `Start.LocalSettings`).

Le fichier est **à 78 % identique** à [`Jourcent`](../Jourcent.class/architecture.md) (487
lignes communes) et à 59 % à [`JournauxA`](../JournauxA.class/architecture.md) : sélection
d'exercice, contrôle de dates, listes de journaux et navigation clavier sont recopiés.

Nature globale : **GUI**, avec un traitement d'export complet (SQL + fichier) dans
`Button4_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebhP` | var | Private |  | Float | 27 |
| `CredhP` | var | Private |  | Float | 28 |
| `TotSldhP` | var | Private |  | Float | 29 |
| `TotDeb` | var | Private |  | Float | 30 |
| `TotCred` | var | Private |  | Float | 31 |
| `TotSld` | var | Private |  | Float | 32 |
| `debit` | var | Private |  | Float | 33 |
| `credit` | var | Private |  | Float | 34 |
| `solde` | var | Private |  | Float | 35 |
| `dte` | var | Private |  | String | 36 |
| `dte1` | var | Private |  | String | 37 |
| `dte2` | var | Private |  | String | 38 |
| `Txt` | var | Private |  | String | 39 |
| `Filename` | var | Private |  | String | 40 |
| `Filetxt` | var | Private |  | String | 41 |
| `jour` | var | Private |  | String | 42 |
| `hfile` | var | Private |  | File | 43 |
| `type_jour` | var | Private |  | String | 44 |
| `Tab` | var | Private |  | String | 45 |
| `Tab0` | var | Private |  | String | 46 |
| `Db_ction` | var | Private |  | Float | 47 |
| `Cd_ction` | var | Private |  | Float | 48 |
| `Compt` | var | Private |  | String | 49 |
| `son` | var | Private |  | Integer | 50 |
| `Janx` | var | Private |  | String | 51 |
| `p` | var | Private |  | New String[12] | 52 |
| `q` | var | Private |  | New String[12] | 53 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 55-69 | Public | 1 | 12 | 0 | méthode spéciale |
| `Ex1` | 71-96 | Public | 2 | 23 | 0 | portée réductible ? |
| `Exo` | 98-116 | Public | 1 | 16 | 0 | portée réductible ? |
| `Exo1` | 118-132 | Public | 1 | 12 | 0 | portée réductible ? |
| `Exo2` | 134-148 | Public | 1 | 12 | 0 | portée réductible ? |
| `Exo3` | 150-164 | Public | 1 | 12 | 0 | portée réductible ? |
| `Exo4` | 166-180 | Public | 1 | 12 | 0 | portée réductible ? |
| `Exo5` | 182-201 | Public | 1 | 17 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 203-233 | Public | 4 | 28 | 0 | handler GUI |
| `ToggleButton2_Click` | 235-265 | Public | 4 | 28 | 0 | handler GUI |
| `Cmpt_KeyPress` | 267-324 | Public | 21 | 50 | 0 | handler GUI |
| `Btn_Click` | 326-344 | Public | 7 | 13 | 0 | handler GUI |
| `Cpt_GotFocus` | 346-350 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt_LostFocus` | 352-356 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt2_GotFocus` | 358-362 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt2_LostFocus` | 364-368 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN0_GotFocus` | 370-376 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 378-399 | Public | 5 | 20 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 401-405 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 407-436 | Public | 8 | 28 | 0 | portée réductible ? |
| `Compdate` | 438-450 | Public | 3 | 11 | 0 | portée réductible ? |
| `compdate2` | 452-464 | Public | 3 | 11 | 0 | portée réductible ? |
| `coljour_Click` | 466-475 | Public | 1 | 8 | 0 | handler GUI |
| `coljour_KeyPress` | 480-502 | Public | 6 | 19 | 0 | handler GUI |
| `coljour2_Click` | 504-513 | Public | 1 | 8 | 0 | handler GUI |
| `coljour2_KeyPress` | 518-540 | Public | 6 | 19 | 0 | handler GUI |
| `E0_Click` | 542-547 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 549-554 | Public | 1 | 4 | 0 | handler GUI |
| `N1_Click` | 556-561 | Public | 1 | 4 | 0 | handler GUI |
| `N2_Click` | 563-568 | Public | 1 | 4 | 0 | handler GUI |
| `N3_Click` | 570-575 | Public | 1 | 4 | 0 | handler GUI |
| `N4_Click` | 577-582 | Public | 1 | 4 | 0 | handler GUI |
| `N5_Click` | 584-589 | Public | 1 | 4 | 0 | handler GUI |
| `Createtable` | 591-603 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button1_Click` | 605-609 | Public | 1 | 3 | 0 | portée réductible ? |
| `Raz` | 611-624 | Public | 1 | 12 | 0 | portée réductible ? |
| `donnees1` | 626-630 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 632-636 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees3` | 638-642 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button2_Click` | 647-651 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 653-784 | Public | 22 | 126 | 0 | handler GUI |
| `BtnPrefColonnes_Click` | 786-791 | Public | 1 | 4 | 0 | handler GUI |
| `Colonnes` | 793-808 | Public | 5 | 13 | 0 | portée réductible ? |
| `Button5_Click` | 810-814 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 816-820 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et choix de l'exercice

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Observateurs, son, chemin
  d'export, centrage, `Colonnes()`, exercice en cours (`E0_click`), journaux `01`-`99`, focus sur
  `dteN0`.
- **`Ex1()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` :
  `Janx = jdr` (inutilisé), début = `Utils.Calc_mois(dteclec)` (1er jour du mois suivant la
  dernière clôture). Si aujourd'hui précède ce début, bascule sur `Exo()` ; sinon fin =
  aujourd'hui. Mémorise `dte1`/`dte2`. Appelle `Raz()`.
- **`Exo()`, `Exo1()` … `Exo4()`** [portée : réductible] [nature : mixte]. Période
  `Calc_mois(dteclec<n+1>)` → `Cdate_aff(dteclec<n>)` (exercice précédent, N-1 … N-4).
- **`Exo5()`** [portée : réductible] [nature : mixte]. Pas de `dteclec6` : le début est
  `dteclec5` moins un an plus un mois (`Left$(dte, 6) & (année - 1)` puis `Calc_mois`), ce qui
  suppose un exercice de 12 mois et une conversion `Date` → `String` au format `mm/dd/yyyy`
  (à confirmer).
- **`E0_Click`, `E1_Click`, `N1_Click` … `N5_Click`** [portée : nécessaire (handlers)]
  [nature : GUI]. Fixent `Tab0` (noms en dur, sans `Cbase.Table`) et appellent la fonction
  d'exercice correspondante.

### Saisie et contrôles

- **`Cmpt_KeyPress()`** (CC 21, groupe `Cmpt` : `DteN0`, `Dten1`, `Cpt`, `Cpt2` selon `Tag`)
  [portée : nécessaire (handler)] [nature : GUI]. Entrée/Tab : valide le champ et passe au
  suivant (boucle) ; F1 : aide ; F2 sur `Cpt`/`Cpt2` : liste des journaux.
- **`Btn_Click()`** (groupe `Btn`) [portée : nécessaire] [nature : GUI]. `Tag` 1 aide, 2 panneau
  d'export, 3 impression, 4 quitter (`Kill filename` sur une variable jamais affectée dans cette
  classe : sans effet).
- **`Cpt_GotFocus`/`LostFocus`, `Cpt2_…`, `dteN0_GotFocus`, `dteN1_GotFocus`** [nature : GUI].
  Couleur de fond de saisie (`&HAAFF7F&`) / couleur standard.
- **`dteN0_LostFocus()` / `dteN1_LostFocus()`** [portée : nécessaire] [nature : mixte].
  Normalise la saisie (`Utils.CDate_calc` puis `Cdate_aff`), remplace `00.00.0:00` par
  aujourd'hui, compare (chaînes `yyyymmdd` converties par `Val`) aux bornes `dte1`/`dte2` de
  l'exercice : hors bornes → `Compdate`/`compdate2`. `dteN1` < `dteN0` → avertissement puis
  `Exo()` (exercice précédent, et non l'exercice sélectionné). `Catch` : retour du focus.
- **`Compdate()` / `compdate2()`** [portée : réductible] [nature : GUI]. Son, avertissement
  `Txt`, puis **réinitialise sur l'exercice précédent** (`Exo()` + `E0.Value = True`, soit le
  bouton « Exercice en cours » coché avec les dates de l'exercice précédent ; si l'affectation
  déclenche `E0_Click`, à confirmer, `Ex1` recharge ensuite l'exercice en cours).

### Listes de journaux

- **`ToggleButton3_Click()` / `ToggleButton2_Click()`** [nature : mixte]. Affiche ou masque
  `coljour`/`coljour2` remplies par `SELECT * FROM Fiches_Journaux order by code_jo`.
- **`coljour_Click`/`coljour_KeyPress`, `coljour2_Click`/`coljour2_KeyPress`** [nature : GUI].
  Recopie du code choisi dans `Cpt`/`Cpt2`, Échap/F2 ferme, F1 aide. Les deux paires sont
  identiques à la cible près.

### Impression et export

- **`Button1_Click()`** [portée : nécessaire] [nature : GUI]. `JournauxM.Imprime(cpt, cpt2,
  dten0, dten1, RadioButton1, CheckBox1.Value, Tab0, False)`. ⚠️ `RadioButton1` est la
  **commande** et non sa valeur : convertie en booléen, elle vaut toujours `True` (anomalie A01).
- **`Button2_Click()`, `Button5_Click()`** [nature : GUI]. Ouvre / ferme `Panel2`.
- **`BtnPrefColonnes_Click()`** [nature : GUI]. `journauxSetting.ShowModal` puis `Colonnes()`.
- **`Colonnes()`** [portée : réductible] [nature : GUI]. Affiche dans `ListBox1` deux lignes de
  titre puis les titres configurés `/ExportJournal<soc>/Titre0..15`.
- **`Button4_Click()`** (CC 22, max du fichier) [portée : nécessaire] [nature : mixte].
  Refuse si aucune colonne n'est configurée (`ListBox1.Count > 2`). Puis :
  1. `DROP TABLE IF EXISTS centralisation` / `CREATE TABLE centralisation` (types `FLOAT`,
     `Char(40)`) : table inutilisée par l'export (A04) ;
  2. recrée `~/tmp/journaux.txt` ; lit `dtepc` (résultat écrasé, code mort l. 695-699) ;
  3. pour chaque journal de `Fiches_Journaux` entre `Cpt` et `Cpt2` : `SELECT * FROM <Tab0>
     WHERE jour = &1 and validee = 1 order by dte, numero, compte` (tout l'exercice), filtre la
     période **en Gambas** (`Cdate_Comp`), ignore les lignes collectives (après une requête
     `Fiches_Comptes` inutile), cumule un solde (`InStr(Str(solde), "E")` → 0 pour la notation
     exponentielle), remplit `p[0..11]` (journal, compte, intitulé, pièce, date `dd.mm.yy`,
     numéro, libellé, débit, crédit et solde via `Utils.cpoint`, deux colonnes vides), le réordonne
     dans `q[]` selon `/Entete<y>` (lu deux fois par colonne et par ligne) et écrit 12 champs
     par `donnees3` ;
  4. question « ouvrir ? » → `Editeur.Prog_Editeur`.
  Le solde n'est **jamais** remis à zéro (`pl` reste 0) : il court sur tous les journaux et sur
  les exports successifs de la session (A02).
- **`donnees1`, `donnees2`** [portée : réductible] — **code mort**. **`donnees3`** [portée :
  réductible] : écrit une ligne de 12 champs `;` dans `hfile`.
- **`Createtable()`** [portée : réductible] — **code mort** (copie de `JournauxM.Createtable`,
  jamais appelée dans cette classe).
- **`Raz()`** [portée : réductible] [nature : calcul]. Remet à zéro les cumuls (dont six jamais
  lus ailleurs : `DebhP`, `CredhP`, `TotSldhP`, `Db_ction`, `Cd_ction`, et les totaux de
  `Button4_Click` jamais exportés). Ne remet pas `solde` à zéro.
- **`Button3_Click()`** [nature : GUI]. Aide `Doc.Open("Editjournaux")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe`, `Start.LocalSettings["/ExportJournal<soc>/…"]`.
- `Utils.db`, `Utils.Calc_mois`, `Cdate_aff`, `CDate_calc`, `Cdate_Comp`, `Cdate_Dbase`,
  `cpoint`, `Utils.Observers`.
- Auto-instance : `Fmenu` l'ouvre par `journaux.Show` ; `JournauxM` (l. 70, 314), `EcrM` (l. 419,
  570) et `Extrait` (l. 1210, `Journaux.visible`) **lisent ou écrivent l'auto-instance**, ce qui
  l'instancie (et exécute `_New` avec ses requêtes) si l'écran n'est pas ouvert.
- Fichiers : `~/tmp/journaux.txt` (export), `~/tmp/Journaux.pdf` (via `JournauxM`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button4_Click` : construire une fois la table de correspondance des colonnes
  (`Integer[]` lu dans `Start.LocalSettings`) avant la boucle, au lieu de 32 lectures de
  configuration par ligne ; filtrer la période en SQL (bornes `>=` début et `<` lendemain de la
  fin, pour garder les heures non nulles) au lieu de lire tout l'exercice.
- Supprimer la requête `Fiches_Comptes` sur les collectifs (résultat inutilisé) et la création de
  table `centralisation` (anomalie A04, car le dump change).

### Commonalisation avec d'autres fichiers — socle des éditions comptables

Le trio `Journaux` / `JournauxA` / `JournauxM` suit le même schéma que `Balance`/`BalanceM` et
`Editcompte`/`EditcompteA`/`EditcompteM` : un écran de saisie (exercice, période, bornes) recopié,
et un moteur d'impression PDF `Ccompta`. Mesure de la duplication (lignes non vides hors
commentaires, appariement `difflib`) :

| Paire | Lignes communes | Part du 1er / du 2nd |
|---|---|---|
| `Journaux` ↔ [`Jourcent`](../Jourcent.class/architecture.md) | 487 | 78 % / 62 % |
| `Journaux` ↔ [`JournauxA`](../JournauxA.class/architecture.md) | 365 | 59 % / 55 % |
| `Journaux` ↔ [`Editcompte`](../Editcompte.class/architecture.md) | 253 | 41 % / 44 % |
| `Journaux` ↔ [`EditcompteA`](../EditcompteA.class/architecture.md) | 249 | 40 % / 36 % |
| `Journaux` ↔ [`Balance`](../Balance.class/architecture.md) | 244 | 39 % / 49 % |
| `Journaux` ↔ [`EcrM`](../EcrM.class/architecture.md) | 237 | 38 % / 49 % |

Socle proposé (rendu et dialogues inchangés) : les helpers de bornes et de contrôle de date sont
ceux décidés par le groupe Balance/Editcompte ([BALANCE-004/005](../Balance.class/rework.md),
emplacement à fixer en phase 3) ; les autres vont dans un module `ImpCompta` à créer en phase 3 :

| Fonction du socle | Remplace | Fichiers concernés |
|---|---|---|
| `Bornes(index)` (BALANCE-004 ; `[début, fin]` au format `dd.mm.yyyy`, y compris le cas particulier `Exo5` et la bascule d'`Ex1`) | `Ex1`, `Exo`, `Exo1`…`Exo5` (7 fonctions × 9 fichiers) | Journaux, JournauxA, Jourcent, EcrM, Balance, Editcompte, EditcompteA, RubImp ; variante `LDate` pour [ExportA47](../ExportA47.class/architecture.md) |
| `TableMvt(index) As String` (`Cbase.Table("TabMvt" & suffixe)`) | `Tab0 = "Fiches_Mvt…"` en dur | mêmes fichiers |
| `ControleDate(texte, debut, fin)` (BALANCE-005) + option de complétion | corps de `dteN0_LostFocus`/`dteN1_LostFocus` (comparaisons `Right$/Mid$/Left$`) | Journaux, Jourcent, JournauxA (`bComplete`), EcrM, Editcompte, EditcompteA, Balance, RubImp |
| `ListeJournaux(hCol)` | `ToggleButton2/3_Click` | Journaux, Jourcent, [ExportJdv](../../Utils/ExportJdv.class/architecture.md) |
| `CentralisationCree/Cumule/Imprime` | voir [JournauxM](../JournauxM.module/architecture.md) | JournauxM, JournauxA, Jourcent, EcrM |

Les handlers (`E0_Click`, `dteN0_LostFocus`, `ToggleButton3_Click`…) restent dans chaque classe,
avec leur nom et leur portée `Public`, et délèguent au socle.

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Colonnes`, `donnees3`, `Raz` : aucun appelant
  externe (grep `Journaux\.` : seuls `Mouse` et `visible` sont lus de l'extérieur) → `Private`.
  `Createtable`, `donnees1`, `donnees2` : suppression (code mort).

### Séparation traitement / GUI

- `Button4_Click` → `ExporteJournaux(sFichier, sJ1, sJ2, sDeb, sFin, sTab) As Integer` (nombre
  de journaux trouvés), sans accès aux contrôles ; le handler garde le test de configuration, le
  curseur et les messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker la configuration de l'export (ordre des colonnes) dans le blob `conf` de
  `Fiches_Parametres` plutôt que dans `Laurux.conf` local, pour la partager entre postes.
