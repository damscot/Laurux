# Echeancier — Architecture

> Source : `.src/Compta/Impressions/Echeancier.class`

## Vue d'ensemble

`Echeancier` est l'écran **« Echéanciers »** (menu Compta, `Fmenu.Menu303_Click` →
`Echeancier.ShowModal()`). Il imprime, pour les comptes clients (`411…`) ou fournisseurs
(`401…`), les écritures **validées, non lettrées, hors trésorerie et hors collectif** dont la date
d'échéance (`dateech`) est comprise entre « Du » (`Dten1`) et « Jusqu'au » (`Dten0`), triées par
échéance ou par compte, chacune suivie des règlements du même lot (`numlot`, lignes de
trésorerie du même compte). Un filtre optionnel sur le mode de règlement du client
(`Fiches_Cli.cli_reg`) est proposé. Le PDF `~/tmp/Echeancier.pdf` est produit par `Ccompta`
(`Level1E`, `level2E`, `Level4E`, `Level5E`) et ouvert par `Visualiseur.Prog`.

Attention au nommage inversé des bornes : `Dten1` (libellé « Du ») est la borne **inférieure**,
`Dten0` (libellé « Jusqu'au ») la borne **supérieure**. Par défaut : `Dten1` = `dteclec1`
(clôture N-1, donc incluse), `Dten0` = `dteclec` (clôture de l'exercice en cours).

Le fichier contient aussi six méthodes de rendu `Level0`…`Level5` écrites pour l'ancienne API
`Draw` (impression sur `Printer`), copiées d'`EdNlettrees`/`Ccompta` et **jamais appelées**
(les appels passent par `pdf.Level…`, objet `Ccompta`).

Nature globale : **mixte** ; `Button2_Click` (CC 28) contient tout le traitement.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TotDeb` | var | Private |  | Float | 28 |
| `TotCred` | var | Private |  | Float | 29 |
| `TotSld` | var | Private |  | Float | 30 |
| `Sldtot` | var | Private |  | Float | 31 |
| `debit` | var | Private |  | Float | 32 |
| `credit` | var | Private |  | Float | 33 |
| `solde` | var | Private |  | Float | 34 |
| `Filename` | var | Private |  | String | 35 |
| `type` | var | Private |  | String | 36 |
| `Compt` | var | Private |  | String | 37 |
| `Tab` | var | Private |  | String | 38 |
| `Tab2` | var | Private |  | String | 39 |
| `PosY` | var | Private |  | Integer | 40 |
| `pdf` | var | Private |  | Ccompta | 41 |
| `tcompte` | var | Private |  | String | 42 |
| `rResult` | var | Private |  | Result | 43 |
| `Org` | var | Private |  | String | 44 |
<!-- /AUTO:declarations -->

Variables utiles : `type` (`"C"`/`"F"`), `TCompte` (« clients »/« fournisseurs », titre), `Compt`,
`TotDeb`/`TotCred`/`TotSld`/`Sldtot` (cumuls), `PosY`, `pdf`, `rResult`, `Org` (borne visée par
le `DateChooser`), `Filename`. Inutiles : `Tab`, `Tab2` (affectés, jamais utilisés), `debit`,
`credit`, `solde` (seulement remis à 0 par `Raz`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 49-71 | Public | 3 | 20 | 0 | méthode spéciale |
| `Raz` | 76-86 | Public | 1 | 9 | 0 | portée réductible ? |
| `Rcli_Click` | 91-96 | Public | 1 | 4 | 0 | handler GUI |
| `Rfour_Click` | 101-106 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 111-281 | Public | 28 | 168 | 0 | handler GUI |
| `Level0` | 284-293 | Public | 1 | 8 | 0 | portée réductible ? |
| `Level1E` | 296-321 | Public | 1 | 24 | 0 | portée réductible ? |
| `level2` | 324-340 | Public | 1 | 15 | 0 | portée réductible ? |
| `Level3` | 343-351 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level4` | 354-368 | Public | 1 | 13 | 0 | portée réductible ? |
| `Level5` | 371-385 | Public | 1 | 13 | 0 | portée réductible ? |
| `Dten0_DblClick` | 387-396 | Public | 2 | 8 | 0 | handler GUI |
| `dteN0_LostFocus` | 398-410 | Public | 3 | 11 | 0 | handler GUI |
| `dteN0_KeyPress` | 412-421 | Public | 4 | 7 | 0 | handler GUI |
| `Dten1_DblClick` | 423-432 | Public | 2 | 8 | 0 | handler GUI |
| `dteN1_LostFocus` | 434-446 | Public | 3 | 11 | 0 | handler GUI |
| `dteN1_KeyPress` | 448-458 | Public | 4 | 8 | 0 | handler GUI |
| `dteN0_GotFocus` | 460-464 | Public | 1 | 3 | 0 | handler GUI |
| `dteN1_GotFocus` | 466-470 | Public | 1 | 3 | 0 | handler GUI |
| `button2_KeyPress` | 472-480 | Public | 3 | 6 | 0 | handler GUI |
| `DateChooser1_Activate` | 482-496 | Public | 2 | 13 | 0 | handler GUI |
| `Button1_Click` | 501-505 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 507-511 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (constructeur)] [nature : mixte]. Observateurs, musique,
  centrage ; clients par défaut (`Rcli_Click` puis `Rcli.value = True`, alors que le `.form` coche
  `Rfour`) ; `SELECT * FROM Fiches_Parametres` (via `Cbase.Table("TabParam")`, sans `Available`)
  → `Dten0 = Cdate_Aff(dteclec)`, `Dten1 = Cdate_Aff(dteclec1)` ; combo `Eche` = « Tous » + chaque
  ligne de `SELECT * FROM Fiches_Reglements` (nom en dur) au format `code | libel`.
- **`Rcli_Click()`, `Rfour_Click()`** [portée : nécessaire (handlers)] [nature : GUI]. `type` et
  `TCompte`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls (`solde` deux fois).

### Impression

- **`Button2_Click()`** (CC 28) [portée : nécessaire (handler, appelé aussi par
  `button2_KeyPress`)] [nature : mixte].
  1. `SELECT * FROM Fiches_Societes Where cd_sc = &1` (nom en dur) → « Société  <int_sc> » ;
     `Shell "cd …"` inutile ; `New Ccompta`, `Entete("Impression de l'échéancier <clients|fournisseurs>")`,
     `Level0(dateedition, Ste)` avec `dateedition` **jamais affecté** (ECHEANCIER-A02), `Level1E`.
  2. Sélection (bornes par `Utils.Cdate_Dbase`, `validee = 1`, `lettree = 0`, `left(compte,3)` =
     411|401, `tresorerie <> 1`, `collectif is null`) :
     - tri par échéance, « Tous » ou fournisseurs : `Fiches_Mvt LEFT JOIN Fiches_Comptes` (via
       `Cbase.Table`) `order by dateech, compte, jour desc, numlot` ;
     - tri par échéance, clients, mode choisi : même requête avec `LEFT JOIN Fiches_Cli` et
       `cli_reg LIKE '<2 premiers caractères>%'` (**noms de tables en dur**) ;
     - tri par compte : `order by compte, jour desc, dateech, numlot`, **sans** filtre de mode de
       règlement (ECHEANCIER-A03).
  3. Boucle `While i < rResult.count` : rupture par échéance ou par compte (`Level4E` « Total
     échéance » / « Total compte », cumul `Sldtot`), montant = `montantd` sinon `montantc`, rendu
     négatif par concaténation `"-" & montant` (fournisseur au débit, client au crédit), solde selon
     le sens du tiers. Saut de page à `PosY >= 280` (bloc copié 4 fois). `level2E` pour la ligne.
  4. Pour chaque ligne : `SELECT * FROM Fiches_Mvt WHERE numlot = &1 and tresorerie = 1 and
     compte = &3 order by numero` (règlements du lot) ; chaque règlement est imprimé
     (« Règlement <intitule> ») et cumulé **seulement** dans le sens attendu (client : crédit ;
     fournisseur : débit) ; le signe est inversé par `"-" & montant` **sans test du signe**
     (ECHEANCIER-A01). Aucun contrôle de saut de page dans cette boucle (ECHEANCIER-A04).
  5. Dernier total, `Lines`, `Level5E(Sldtot)`, `BasPage` (dernière page seulement), `Output`,
     `Visualiseur.Prog`, focus sur `Dten0`.
  Variables `p`, `Nbpage`, `dte` : calculées pour rien.

### Saisie des dates

- **`Dten0_DblClick()`, `Dten1_DblClick()`** [portée : nécessaire (handlers)] [nature : GUI].
  Affichent/masquent `DateChooser1` et mémorisent la borne visée (`Org` = "2" ou "1").
- **`DateChooser1_Activate()`** [portée : nécessaire (handler)] [nature : GUI]. Recopie la date
  choisie (`dd.mm.yyyy`) dans la borne visée.
- **`dteN0_LostFocus()`, `dteN1_LostFocus()`** [portée : nécessaire (handlers)] [nature : GUI].
  Normalisation `Cdate_calc` → `Cdate_aff`, repli sur aujourd'hui si `"00.00.0:00"` ; `Catch` :
  refocalise. `dteN1_LostFocus` remet le fond de **`dteN0`** (copie ; sans effet visible car aucun
  fond n'est posé au `GotFocus`).
- **`dteN0_KeyPress()`, `dteN1_KeyPress()`** [portée : nécessaire (handlers)] [nature : GUI].
  Entrée/Tab : normalise puis passe au bouton « Imprimer » / à `Dten0`.
- **`dteN0_GotFocus()`, `dteN1_GotFocus()`** [portée : nécessaire (handlers)] [nature : GUI].
  Sélection du texte.
- **`button2_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Entrée → impression.
- **`Button1_Click()`** (aide `Doc.Open("Echeancier")`), **`Button3_Click()`** (fermeture)
  [portée : nécessaire (handlers)] [nature : GUI].

### Rendu `Draw` hérité (code mort)

- **`Level0`, `Level1E`, `level2`, `Level3`, `Level4`, `Level5`** [portée : réductible — code mort]
  [nature : GUI]. Dessin sur `Draw` (police « Bitstream Charter », coordonnées en 1/100 mm) ;
  aucun appel (`grep -rn "Echeancier\." .src` ne trouve que `ShowModal`, et les appels internes
  visent `pdf.`). Copies identiques de celles d'[EdNlettrees](../EdNlettrees.class/architecture.md)
  (sauf `Level1E`).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.Cdate_Aff`, `Utils.Cdate_Dbase`, `Utils.Cdate_calc`.
- `Cbase.Table("TabParam"|"TabMvt"|"TabComptes")` ; noms en dur : `Fiches_Reglements`,
  `Fiches_Societes`, `Fiches_Mvt`/`Fiches_Comptes`/`Fiches_Cli` (requête filtrée par mode).
- `Start.Musique`, `Start.Societe`.
- Fichier `~/tmp/Echeancier.pdf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Une seule construction de requête : jointure `Fiches_Cli` et filtre `cli_reg` ajoutés seulement
  si nécessaire, clause `ORDER BY` selon le tri (SQL modifié, mêmes lignes renvoyées, dump
  identique).
- Helper privé `SautPage()` pour les quatre blocs `PosY >= 280`.
- Inversion de signe : `montant = -montant` aux lignes 191 et 195 (montant > 0 garanti : même
  valeur) ; les lignes 220 et 226 relèvent de l'anomalie A01.
- Rupture par échéance/compte : une clé de rupture calculée une fois (`IIf(Dtech.value, dateech,
  compte)`) au lieu de deux branches symétriques.

### Commonalisation avec d'autres fichiers

- **Socle commun des éditions comptables** (voir [FTVA](../FTVA.class/architecture.md#commonalisation-avec-dautres-fichiers)) :
  en-tête société, fichier PDF, `Termine`, saisie de date normalisée, `SautPage` paramétré.
- Bascule `DateChooser` sur double-clic : même code dans [BordereauxC](../BordereauxC.class/architecture.md)
  et de nombreux écrans de saisie ; helper `Utils`/socle `BasculeCalendrier(chooser, cible)`.
- Lecture des clôtures par `LDate.Exercice_Cloture(0|1)` (LDATE-008).
- La liste des écritures non lettrées d'un compte existe dans
  [`Listextcpt`](../../Utils/Listextcpt.class/architecture.md) (multi-exercices) ; l'échéancier
  ne lit que `Fiches_Mvt` (à rapprocher en phase 3, sans changement de comportement).

### Réduction de portée

- `Raz` → `Private`. `Level0`…`Level5` supprimées (code mort).

### Séparation traitement / GUI

- `Requete_Echeances(sType, sDu, sAu, sModeRegl, bTriEcheance) As Result` et
  `Reglements_Lot(sNumlot, sCompte) As Result` ; calcul des montants signés et des cumuls dans une
  fonction pure `Montant_Signe(montantd, montantc, bFournisseur, bReglement) As Float` (à écrire en
  reproduisant les cas actuels, A01 compris).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `(lettree, validee, dateech)` et `(numlot, compte)` sur `Fiches_Mvt*` pour les deux
  requêtes de l'écran.
- Le mode de règlement n'est connu que pour les clients (`Fiches_Cli.cli_reg`) : une colonne
  équivalente sur `Fiches_Four` permettrait le filtre côté fournisseurs.
