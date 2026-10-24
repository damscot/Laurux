# EdImpayes — Architecture

> Source : `.src/Compta/Impressions/EdImpayes.class`

## Vue d'ensemble

`EdImpayes` est un écran **« Impression des impayés »** qui n'est **ouvert par aucun code** du
projet : `grep -rn "EdImpayes" .src` ne trouve que le couple `EdImpayes.class`/`EdImpayes.form`
(aucune entrée de `Fmenu`, aucun `New EdImpayes`). C'est l'ancêtre d'[`EdNlettrees`](../EdNlettrees.class/architecture.md) :
l'en-tête de licence porte « EdNlettrees.class / Edition des ecritures non lettrees », le PDF
produit porte le même nom (`~/tmp/Enlettrees.pdf`), le titre imprimé est « Impression des
écritures non lettrées » et l'aide est la même (`Doc.Open("Nlettrees")`).

Fonctionnellement, pour une plage de comptes clients (`41100001`–`41199999` par défaut), il
imprime, compte par compte, les écritures **validées non lettrées** de `Fiches_Mvt` dont la date
(testée en Gambas, pas en SQL) est comprise entre deux bornes, avec totaux par compte et général.
Contrairement à `EdNlettrees`, il ne lit que l'exercice en cours, n'utilise pas `Listextcpt`, ne
filtre pas les comptes `lettrable`, et recrée la table de travail `Ctrln` sans l'utiliser.

Nature globale : **mixte** ; **code mort** à l'échelle du projet (couple `.class` + `.form`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TotDeb` | var | Private |  | Float | 27 |
| `TotCred` | var | Private |  | Float | 28 |
| `TotSld` | var | Private |  | Float | 29 |
| `Slddeb` | var | Private |  | Float | 30 |
| `Sldcred` | var | Private |  | Float | 31 |
| `Sldtot` | var | Private |  | Float | 32 |
| `debit` | var | Private |  | Float | 33 |
| `credit` | var | Private |  | Float | 34 |
| `solde` | var | Private |  | Float | 35 |
| `montantd` | var | Private |  | Float | 36 |
| `montantc` | var | Private |  | Float | 37 |
| `dte` | var | Private |  | String | 38 |
| `dte1` | var | Private |  | String | 39 |
| `dte2` | var | Private |  | String | 40 |
| `Filename` | var | Private |  | String | 41 |
| `type` | var | Private |  | String | 42 |
| `Tab0` | var | Private |  | String | 43 |
| `Tab1` | var | Private |  | String | 44 |
| `jour` | var | Private |  | String | 45 |
| `Centr` | var | Private |  | String | 46 |
| `Datj` | var | Private |  | String | 47 |
| `libelle` | var | Private |  | String | 48 |
| `Compt` | var | Private |  | String | 49 |
| `rResult` | var | Private |  | Result | 50 |
| `rrResult` | var | Private |  | Result | 51 |
| `Tab` | var | Private |  | String | 52 |
| `Tab2` | var | Private |  | String | 53 |
| `son` | var | Private |  | Integer | 54 |
| `Coulfond` | var | Private |  | New String[] | 55 |
| `PosY` | var | Private |  | Integer | 56 |
| `pdf` | var | Private |  | Ccompta | 57 |
| `Bsel` | var | Public |  | Boolean | 59 |
| `Bval` | var | Public |  | String | 60 |
<!-- /AUTO:declarations -->

Variables utiles (si l'écran était ouvert) : `type`, `Compt`, `Centr`, cumuls `TotDeb`/`TotCred`/
`TotSld`/`Slddeb`/`Sldcred`/`Sldtot`, `debit`/`credit`/`solde`, `PosY`, `pdf`, `rResult`/`rrResult`,
`Bsel`/`Bval` (écrits par `TriCpt`). Inutiles : `dte1`, `dte2`, `Tab0`, `Tab1` (`Ctrln`, DDL sans
usage), `montantd`, `montantc`, `libelle`, `Datj`, `Coulfond`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 65-77 | Public | 1 | 11 | 0 | méthode spéciale |
| `Ex1` | 82-95 | Public | 1 | 12 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 100-150 | Public | 12 | 38 | 0 | handler GUI |
| `Btn_Click` | 155-171 | Public | 4 | 9 | 0 | handler GUI |
| `Cbl_GotFocus` | 176-182 | Public | 1 | 5 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 184-190 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LostFocus` | 192-202 | Public | 3 | 9 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 204-214 | Public | 3 | 9 | 0 | portée réductible ? |
| `Raz` | 219-229 | Public | 1 | 9 | 0 | portée réductible ? |
| `Bclient_Click` | 234-241 | Public | 1 | 6 | 0 | portée réductible ? |
| `E0_Click` | 246-251 | Public | 1 | 4 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 256-267 | Public | 2 | 9 | 0 | handler GUI |
| `ToggleButton2_Click` | 272-283 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 288-435 | Public | 15 | 143 | 0 | portée réductible ? |
| `Button3_Click` | 440-444 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Coulfd` (inutile),
  observateurs, musique, centrage, `E0_click()`, `Bclient_Click()`, `ex1()` (deuxième lecture des
  paramètres).
- **`Ex1()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (nom en
  dur) ; `dteN0` = 1er jour du mois suivant `dteclec1`, `dteN1` = aujourd'hui.
- **`E0_Click()`, `Bclient_Click()`** [portée : réductible — aucun contrôle `E0` ni `Bclient` dans
  le `.form`] [nature : GUI]. Initialisation (`Tab0`, plage clients, `type = "C"`).
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI].
  Chaînage `DteN0` (1) → `Dten1` (2) → `Cpt` (3) → `Cpt2` (4) → `DteN0` ; F1 aide ; F2 sur
  `Cpt`/`Cpt2` → `TriCpt`.
- **`Btn_Click()`** [portée : nécessaire (handler des groupes `Btn`/`btn`)] [nature : GUI].
- **`Cbl_GotFocus()`** [portée : réductible — aucun groupe `Cbl` dans le `.form`, code mort]
  [nature : GUI]. **`Cmpt_GotFocus()`** [portée : nécessaire (handler du groupe)] [nature : GUI].
  `Utils.SetEditColor(Me, Last)`.
- **`dteN0_LostFocus()`, `dteN1_LostFocus()`** [portée : nécessaire (noms de handlers, appelées
  explicitement)] [nature : GUI]. Normalisation de date.
- **`ToggleButton3_Click()`, `ToggleButton2_Click()`** [portée : nécessaire (handlers)] [nature :
  GUI]. Sélection par `TriCpt`.
- **`Raz()`** [portée : réductible] [nature : calcul].
- **`Button1_Click()`** (CC 15) [portée : nécessaire (appelé par `Btn_Click`)] [nature : mixte].
  `Fiches_Societes` (nom en dur) ; comptes `SELECT compte_cc, intitule_cc, cent_cc FROM
  Fiches_Comptes WHERE cast(compte_cc as char) BETWEEN … and type_cc = &4` ; par compte
  `SELECT * FROM Fiches_Mvt WHERE compte = &1 and validee = 1 and lettree = 0 order by dte` ; si au
  moins une ligne : **`DROP TABLE IF EXISTS Ctrln` + `CREATE TABLE Ctrln`** (jamais alimentée),
  `level3`, lignes de la période (filtre en Gambas) hors comptes centralisateurs, `level4`,
  `Lines` ; `level5`, `BasPage`, `Output`, `Visualiseur.Prog`. Ici `BasPage` est appelé à chaque
  saut de page (pied de page sur toutes les pages, contrairement aux autres éditions du lot).
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Aide « Nlettrees ».

## État global utilisé

- `Utils.db`, `Utils.Calc_mois`, `Utils.Cdate_*`, `Utils.SetEditColor`, `Utils.Observers`,
  `Utils.Coulfd` ; `TriCpt` ; `Ccompta` ; `Visualiseur` ; `Doc`.
- `Start.Son`, `Start.Musique`, `Start.Societe`.
- Table de travail `Ctrln`, partagée par nom avec Editcompte, EditcompteM, Extrait, FTVA
  (structures différentes, collision multi-poste : EDITCOMPTE-A06 dans
  [Editcompte/rework.md](../Editcompte.class/rework.md)).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune réécriture n'est utile tant que l'écran n'est pas atteignable : la proposition principale
  est sa **suppression** (EDIMPAYES-A01, validation utilisateur requise).

### Commonalisation avec d'autres fichiers

- Si l'écran devait être conservé (rattaché à un menu), il devrait devenir une option
  « validées seulement / exercice en cours » d'[EdNlettrees](../EdNlettrees.class/architecture.md),
  ou réutiliser le socle commun des éditions (EDITCOMPTE-006, voir
  [FTVA](../FTVA.class/architecture.md#commonalisation-avec-dautres-fichiers)).

### Réduction de portée

- `Ex1`, `E0_Click`, `Bclient_Click`, `Raz` → `Private` ; `Cbl_GotFocus` supprimée. `Bsel`/`Bval`
  restent `Public` (`TriCpt`).

### Séparation traitement / GUI

- Sans objet (fichier mort) ; voir EDNLETTREES-006 pour la version active.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce fichier ; `Ctrln` devrait devenir une table temporaire (voir FTVA).
