# Jourcent — Architecture

> Source : `.src/Compta/Impressions/Jourcent.class`

## Vue d'ensemble

`Jourcent` est l'écran **« Impression des journaux centralisateurs »** (menu Compta,
`Fmenu.Menu109_Click`, `jourcent.Show`). Pour chaque journal entre `Cpt` et `Cpt2`, il cumule
par compte les écritures validées de la période dans la table de travail `centralisation`, puis
imprime une page « Centralisation journal <code> » (compte, intitulé, débit, crédit, solde
cumulé) dans `~/tmp/jourcent.pdf` via [`Ccompta`](../../../Reports/Ccompta.class/architecture.md).

La partie saisie (exercice, période, journaux, navigation clavier) est une copie de
[`Journaux`](../Journaux.class/architecture.md) (78 % des lignes de `Journaux` se retrouvent ici).
La règle de cumul diffère de celle de [`JournauxM`](../JournauxM.module/architecture.md) : les
journaux `OD` sont centralisés, les comptes `453` sont traités comme des comptes ordinaires, et
les collectifs `401`/`411` sont tous libellés « Clients ».

Un second traitement, `Button2_Click` (export texte/XML de lignes `<Row …/>`), est
**inaccessible** : aucun bouton du formulaire n'a le `Tag` 2 du groupe `Btn`, et il appellerait
`Donnees0` avec un argument manquant.

Nature globale : **GUI** avec traitement complet (SQL, écriture en base, PDF) dans
`Button1_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebhP` | var | Private |  | Float | 27 |
| `CredhP` | var | Private |  | Float | 28 |
| `TotSldHP` | var | Private |  | Float | 29 |
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
| `rrrResult` | var | Private |  | Result | 44 |
| `type_jour` | var | Private |  | String | 45 |
| `Tab` | var | Private |  | String | 46 |
| `Tab0` | var | Private |  | String | 47 |
| `Db_ction` | var | Private |  | Float | 48 |
| `Cd_ction` | var | Private |  | Float | 49 |
| `Compt` | var | Private |  | String | 50 |
| `P` | var | Private |  | Integer | 51 |
| `son` | var | Private |  | Integer | 52 |
| `PosY` | var | Private |  | Integer | 53 |
| `Page` | var | Private |  | Integer | 54 |
| `Coulfond` | var | Private |  | New String[] | 55 |
| `Intit` | var | Private |  | String | 56 |
| `Intitcol` | var | Private |  | String | 57 |
| `dateedition` | var | Private |  | String | 58 |
| `Qual` | var | Private |  | String | 59 |
| `Ste` | var | Private |  | String | 60 |
| `pdf` | var | Private |  | Ccompta | 61 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 63-78 | Public | 1 | 13 | 0 | méthode spéciale |
| `Ex1` | 80-104 | Public | 2 | 22 | 0 | portée réductible ? |
| `Exo` | 106-125 | Public | 1 | 17 | 0 | portée réductible ? |
| `Exo1` | 127-142 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo2` | 144-159 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo3` | 161-176 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo4` | 178-193 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo5` | 195-214 | Public | 1 | 17 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 216-246 | Public | 4 | 28 | 0 | handler GUI |
| `ToggleButton2_Click` | 248-278 | Public | 4 | 28 | 0 | handler GUI |
| `Cmpt_KeyPress` | 280-332 | Public | 12 | 44 | 0 | handler GUI |
| `Btn_Click` | 334-352 | Public | 7 | 13 | 0 | handler GUI |
| `Cpt_GotFocus` | 354-358 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt_LostFocus` | 360-364 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt2_GotFocus` | 366-370 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt2_LostFocus` | 372-376 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN0_GotFocus` | 378-384 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 386-407 | Public | 5 | 20 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 409-413 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 415-444 | Public | 8 | 28 | 0 | portée réductible ? |
| `Compdate` | 446-458 | Public | 3 | 11 | 0 | portée réductible ? |
| `compdate2` | 460-472 | Public | 3 | 11 | 0 | portée réductible ? |
| `coljour_Click` | 474-483 | Public | 1 | 8 | 0 | handler GUI |
| `coljour_KeyPress` | 488-510 | Public | 6 | 19 | 0 | handler GUI |
| `coljour2_Click` | 512-521 | Public | 1 | 8 | 0 | handler GUI |
| `coljour2_KeyPress` | 526-548 | Public | 6 | 19 | 0 | handler GUI |
| `E0_Click` | 550-555 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 557-562 | Public | 1 | 4 | 0 | handler GUI |
| `N1_Click` | 564-569 | Public | 1 | 4 | 0 | handler GUI |
| `N2_Click` | 571-576 | Public | 1 | 4 | 0 | handler GUI |
| `N3_Click` | 578-583 | Public | 1 | 4 | 0 | handler GUI |
| `N4_Click` | 585-590 | Public | 1 | 4 | 0 | handler GUI |
| `N5_Click` | 592-597 | Public | 1 | 4 | 0 | handler GUI |
| `Donnees0` | 599-603 | Public | 1 | 3 | 0 | portée réductible ? |
| `Donnees1` | 605-609 | Public | 1 | 3 | 0 | portée réductible ? |
| `Donnees2` | 611-615 | Public | 1 | 3 | 0 | portée réductible ? |
| `Donnees3` | 617-621 | Public | 1 | 3 | 0 | portée réductible ? |
| `Create_table` | 623-635 | Public | 1 | 11 | 0 | portée réductible ? |
| `Button1_Click` | 637-809 | Public | 22 | 155 | 0 | portée réductible ? |
| `Raz` | 811-824 | Public | 1 | 12 | 0 | portée réductible ? |
| `Centralisation` | 826-843 | Public | 3 | 15 | 0 | portée réductible ? |
| `Centralisation2` | 845-876 | Public | 4 | 26 | 0 | portée réductible ? |
| `Button2_Click` | 878-985 | Public | 19 | 105 | 0 | portée réductible ? |
| `Button3_Click` | 987-991 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation, exercice, saisie (copies de `Journaux`)

- **`_New()`** [portée : nécessaire] [nature : GUI]. `Coulfond = Utils.Coulfd()` (inutilisé),
  observateurs, son, chemins `~/tmp/jourcent.pdf` et `~/tmp/jourcent.txt`, exercice en cours,
  journaux `01`-`99`.
- **`Ex1`, `Exo`, `Exo1`…`Exo5`** [portée : réductible] [nature : mixte]. Identiques à
  `Journaux` (`Exo5` : `dteclec5` − 1 an + 1 mois).
- **`E0_Click`, `E1_Click`, `N1_Click`…`N5_Click`** [portée : nécessaire] [nature : GUI].
  `Tab0` = `Fiches_Mvt…` en dur.
- **`Cmpt_KeyPress()`** (CC 12) [nature : GUI]. Même navigation que `Journaux`, test de touche
  factorisé avant le `Select Case`.
- **`Btn_Click()`** [nature : GUI]. `Tag` 1 aide, 2 `Button2_Click` (aucune commande), 3
  impression, 4 supprime `~/tmp/jourcent.pdf` et ferme.
- **`Cpt*_GotFocus/LostFocus`, `dteN0_*`, `dteN1_*`, `Compdate`, `compdate2`** : identiques à
  `Journaux` (voir JOURNAUX-A07 pour la réinitialisation sur l'exercice précédent).
- **`ToggleButton3_Click`, `ToggleButton2_Click`, `coljour_*`, `coljour2_*`** : listes de
  journaux identiques à `Journaux` (largeur de colonne 280 au lieu de 190).

### Impression

- **`Button1_Click()`** (CC 22, max du fichier) [portée : nécessaire] [nature : mixte].
  1. `Create_table()` (DDL `centralisation`, sans `Try`), société (`Fiches_Societes`), PDF
     `Ccompta`, `Shell "cd ~"` (sans effet), qualification « ( Edition provisoire ) » si la fin
     dépasse `dtepc`, `Datep` inutilisé.
  2. `SELECT * FROM Fiches_Journaux WHERE code_jo >= &1 and code_jo <= &2 order by code_jo`
     (un 3e argument `"OD"` est passé sans placeholder).
  3. Par journal : `SELECT * FROM <Tab0> WHERE jour = &1 and validee = 1 order by dte, numero,
     compte` (tout l'exercice) ; en-tête de page (`Entete`, `Level0J`, `level5J`, `level6J`).
  4. Par écriture dans la période (filtre `Cdate_Comp` en Gambas) :
     - collectif (`Try rResult!collectif`) : lecture de l'intitulé du collectif dans
       `Fiches_Comptes` ;
     - compte hors `401`/`411` (**y compris collectifs d'autres préfixes**) : cumul de `debit`/
       `credit` — qui pour une ligne collective sont ceux de la **ligne non collective
       précédente** (A01) — avec l'intitulé de la ligne ;
     - collectif `401`/`411` : cumul de `montantd`/`montantc` sous le libellé « Clients » à
       l'insertion (A02), `UPDATE` construit par concaténation avec l'intitulé du collectif ;
     - ligne `401`/`411` non collective : ignorée.
  5. Fin de journal : `Centralisation2()`, `pdf.BasPage()`, `Create_table()`.
  6. `pdf.Output`, visualiseur si au moins un journal avait des écritures, sinon message ;
     curseur final `Mouse.Custom` au lieu de `Mouse.Default` (A03).
  Variables mortes : `P` (compteur de lignes), `p1`, `copt`/`solde` (calculés, jamais
  imprimés), `totsld = totdeb - totdeb` (l. 783).
- **`Centralisation2()`** [portée : réductible] [nature : mixte]. `SELECT * FROM centralisation
  WHERE njournal = &1 order by cd_cent`, `level7J` par compte avec solde cumulé ; saut de page
  au-delà de 283 mm avec répétition de l'en-tête complet.
- **`Create_table()`** [portée : réductible] [nature : calcul (DDL)]. Copie de
  `JournauxM.Createtable`, **sans** `Try`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls.

### Code mort

- **`Button2_Click()`** (CC 19) [portée : réductible] — inaccessible (aucun contrôle `Tag` 2).
  Il créerait une table `TEMPORARY centralisation`, écrirait dans `filename` (le **PDF**) des
  lignes `<Row level=…/>`, appellerait `Donnees0` avec 4 arguments pour 5 paramètres, puis
  proposerait d'ouvrir `jourcent.txt` (« extrait.txt » dans le message).
- **`Centralisation()`** — appelée seulement par `Button2_Click` ; appelle `Donnees3` avec 5
  arguments pour 4 paramètres.
- **`Donnees0`…`Donnees3`** — écritures `Print #hFile` de `Button2_Click`. `Donnees3` contient
  des littéraux de chaîne juxtaposés sans `&` (l. 619, comportement du compilateur à vérifier en
  phase 2).
- **`Button3_Click()`** [nature : GUI] : aide `Doc.Open("Editjournaux")` (actif).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe` ; `Utils.db`, `Utils.Coulfd`, `Calc_mois`,
  `Cdate_aff`, `CDate_calc`, `Cdate_Comp`, `Cdate_Dbase`, `Observers`.
- Tables en dur : `Fiches_Parametres`, `Fiches_Journaux`, `Fiches_Comptes`, `Fiches_Societes`,
  `Fiches_Mvt*` ; table de travail `centralisation`.
- `Visualiseur.Prog`, `Ccompta`, `Doc.Open`, `Editeur.Prog_Editeur` (code mort), `Music`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Button2_Click`, `Centralisation`, `Donnees0..3`, `filetxt`, `hfile`, `Coulfond`,
  `P`, `Datep`, `Shell`, l'argument `"OD"` en trop et le `Case 2` de `Btn_Click`.
- Extraire la décision de cumul d'une ligne (l. 734-766) dans une fonction privée.

### Commonalisation avec d'autres fichiers

- Saisie : socle `ImpCompta` (`Bornes` (BALANCE-004), `TableMvt`, `ControleDate` (BALANCE-005), `ListeJournaux`)
  décrit dans [Journaux](../Journaux.class/architecture.md).
- Centralisation : `CentralisationCree`, `CentralisationCumule` et `CentralisationImprime`
  décrits dans [JournauxM](../JournauxM.module/architecture.md) ; `Centralisation2` est la
  variante avec en-tête complet au saut de page.
- La page de centralisation imprimée par `JournauxM` (après chaque journal) et celle de
  `Jourcent` reposent sur des règles de cumul différentes (OD, 453, libellé des collectifs) :
  l'écart est documenté (JOURCENT-A04) mais n'est pas factorisable sans changement de rendu.
  De même, `Jourcent` filtre la période en Gambas (`Cdate_Comp`, heures du dernier jour
  incluses) alors que `JournauxM` filtre en SQL (`yyyymmdd`, heures non nulles du dernier jour
  exclues, JOURNAUXM-A02) : les deux éditions peuvent diverger sur le dernier jour.
- Duplication mesurée : `Jourcent` ↔ `Journaux` 487 lignes (62 % de `Jourcent`), ↔ `JournauxA`
  423 (54 %), ↔ `EcrM` 290 (37 %), ↔ `EditcompteA` 314 (40 %).

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `Compdate`, `compdate2`, `Create_table`, `Centralisation2`, `Raz` →
  `Private` (seul `Fmenu` ouvre l'écran ; aucun accès externe trouvé par grep).

### Séparation traitement / GUI

- Extraire `CumuleJournal(sJournal, sDeb, sFin, sTab) As Boolean` (SQL de lecture + cumul dans
  `centralisation`, sans contrôle) ; `Button1_Click` garde le PDF, le curseur et les messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Centralisation par `SELECT compte, SUM(montantd), SUM(montantc) … GROUP BY compte` sur la
  période, sans table de travail.
