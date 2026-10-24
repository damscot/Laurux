# JournauxA — Architecture

> Source : `.src/Compta/Impressions/JournauxA.class`

## Vue d'ensemble

`JournauxA` est l'écran **« Impression des journaux analytiques »** (menu Compta,
`Fmenu.Menu292_Click`, `JournauxA.ShowModal()`). Créé en janvier 2012 par copie de
[`Journaux`](../Journaux.class/architecture.md) (55 % de lignes communes) en y intégrant une copie
de [`JournauxM.Imprime`](../JournauxM.module/architecture.md), il imprime les écritures
analytiques de `Fiches_MvtA` (via `Cbase.Table("TabMvtA")`) entre deux **postes** analytiques
(`Cpt`, `Cpt2`, liste de choix `coljour` sur `Fiches_Postes`), regroupées :

- par poste puis journal (`RadioButton1` « Tri par postes/journaux/comptes ») ;
- ou par journal puis poste (`RadioButton2` « Tri par journaux/postes »).

Il produit `~/tmp/Journaux.pdf` (même nom que l'impression des journaux) via
[`Ccompta`](../../../Reports/Ccompta.class/architecture.md), suivi d'une page de centralisation
par compte (table de travail `centralisation`).

Le choix d'exercice (`E0`, `E1`, `N1`…`N5`) ne règle que les **dates** : la table `Tab0` qu'il
renseigne n'est jamais utilisée (`Fiches_MvtA` est toujours lue).

L'analyse statique et le schéma de `Laurux01.sql` montrent que l'impression ne peut
vraisemblablement pas aboutir dès qu'une écriture tombe dans la période (appel de `level2J`
avec un argument manquant, colonne `intitule` inexistante dans `Fiches_Postes`, code de compte
écrit dans `njournal Char(2)`) : voir les anomalies A01 à A04, à confirmer par replay.

Nature globale : **GUI**, avec un traitement d'impression complet (SQL + PDF + écriture en base)
dans `Button1_click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebHP` | var | Private |  | Float | 11 |
| `CredHP` | var | Private |  | Float | 12 |
| `TotSldHP` | var | Private |  | Float | 13 |
| `TotDeb` | var | Private |  | Float | 14 |
| `TotCred` | var | Private |  | Float | 15 |
| `TotSld` | var | Private |  | Float | 16 |
| `debit` | var | Private |  | Float | 17 |
| `credit` | var | Private |  | Float | 18 |
| `solde` | var | Private |  | Float | 19 |
| `dte` | var | Private |  | String | 20 |
| `dte1` | var | Private |  | String | 21 |
| `dte2` | var | Private |  | String | 22 |
| `dte4` | var | Private |  | String | 23 |
| `Txt` | var | Private |  | String | 24 |
| `Filename` | var | Private |  | String | 25 |
| `Filetxt` | var | Private |  | String | 26 |
| `jour` | var | Private |  | String | 27 |
| `hfile` | var | Private |  | File | 28 |
| `r3Result` | var | Private |  | Result | 29 |
| `type_jour` | var | Private |  | String | 30 |
| `Tab` | var | Private |  | String | 31 |
| `Tab0` | var | Private |  | String | 32 |
| `Db_ction` | var | Private |  | Float | 33 |
| `Cd_ction` | var | Private |  | Float | 34 |
| `Compt` | var | Private |  | String | 35 |
| `iPage` | var | Private |  | Integer | 36 |
| `son` | var | Private |  | Integer | 37 |
| `PosY` | var | Private |  | Integer | 38 |
| `pdf` | var | Private |  | Ccompta | 39 |
| `Org` | var | Private |  | String | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-55 | Public | 1 | 11 | 0 | méthode spéciale |
| `Ex1` | 57-81 | Public | 2 | 22 | 0 | portée réductible ? |
| `Exo` | 83-102 | Public | 1 | 17 | 0 | portée réductible ? |
| `Exo1` | 104-119 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo2` | 121-136 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo3` | 138-153 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo4` | 155-170 | Public | 1 | 13 | 0 | portée réductible ? |
| `Exo5` | 172-191 | Public | 1 | 17 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 193-198 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 200-205 | Public | 1 | 4 | 0 | handler GUI |
| `Aff_Postes` | 207-242 | Public | 5 | 33 | 0 | portée réductible ? |
| `coljour_Click` | 244-258 | Public | 2 | 13 | 0 | handler GUI |
| `coljour_KeyPress` | 263-289 | Public | 7 | 23 | 0 | handler GUI |
| `Cmpt_KeyPress` | 291-348 | Public | 21 | 50 | 0 | handler GUI |
| `Btn_Click` | 350-368 | Public | 7 | 12 | 0 | handler GUI |
| `Cpt_GotFocus` | 370-374 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt_LostFocus` | 376-380 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt2_GotFocus` | 382-386 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cpt2_LostFocus` | 388-392 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN0_GotFocus` | 394-400 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 402-426 | Public | 9 | 23 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 428-432 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 434-466 | Public | 12 | 31 | 0 | portée réductible ? |
| `Compdate` | 468-480 | Public | 3 | 11 | 0 | portée réductible ? |
| `compdate2` | 482-494 | Public | 3 | 11 | 0 | portée réductible ? |
| `E0_Click` | 496-501 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 503-508 | Public | 1 | 4 | 0 | handler GUI |
| `N1_Click` | 510-515 | Public | 1 | 4 | 0 | handler GUI |
| `N2_Click` | 517-522 | Public | 1 | 4 | 0 | handler GUI |
| `N3_Click` | 524-529 | Public | 1 | 4 | 0 | handler GUI |
| `N4_Click` | 531-536 | Public | 1 | 4 | 0 | handler GUI |
| `N5_Click` | 538-543 | Public | 1 | 4 | 0 | handler GUI |
| `Create_table` | 545-557 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button1_click` | 559-765 | Public | 24 | 193 | 0 | portée réductible ? |
| `Raz` | 767-780 | Public | 1 | 12 | 0 | portée réductible ? |
| `Centralisation` | 782-809 | Public | 4 | 24 | 0 | portée réductible ? |
| `donnees1` | 811-815 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 817-821 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees3` | 823-827 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button3_Click` | 829-833 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation, exercice, saisie (copies de `Journaux`)

- **`_New()`** [portée : nécessaire] [nature : GUI]. Comme `Journaux._New` sans `Colonnes()` ;
  `filetxt = ~/journaux.txt` (inutilisé).
- **`Ex1()`, `Exo()`, `Exo1()`…`Exo5()`** [portée : réductible] [nature : mixte]. Identiques à
  `Journaux` (période de l'exercice depuis `dteclec*` de `Fiches_Parametres`).
- **`E0_Click`, `E1_Click`, `N1_Click`…`N5_Click`** [portée : nécessaire] [nature : GUI].
  Renseignent `Tab0` (**jamais lu** dans cette classe) puis la période.
- **`Cmpt_KeyPress`, `Btn_Click`, `Cpt*_GotFocus/LostFocus`, `dteN0_GotFocus`,
  `dteN1_GotFocus`, `Compdate`, `compdate2`** : identiques à `Journaux`, sauf `Btn_Click`
  (`Tag` 2 commenté, `Tag` 4 supprime le PDF) et F2 qui ouvre la liste des postes.
- **`dteN0_LostFocus()` / `dteN1_LostFocus()`** [portée : nécessaire] [nature : mixte]. Comme
  `Journaux`, avec en plus la **complétion** d'une saisie courte : 2-3 caractères → jour +
  `.mm.yyyy` courant, 5-6 caractères → jour.mois + `.yyyy` courant.

### Liste des postes

- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [portée : nécessaire] [nature : GUI].
  `Org = "1"` (poste de début) ou `"2"` (poste de fin), puis `Aff_Postes`.
- **`Aff_Postes()`** [portée : réductible] [nature : mixte]. Positionne `coljour` (X = 147 ou
  287), bascule visible/masqué, `SELECT * FROM Fiches_Postes order by code`, puis lit
  `rResult!intitule` alors que la colonne s'appelle `intitulep` (A02).
- **`coljour_Click()` / `coljour_KeyPress()`** [nature : GUI]. Recopie le code dans `Cpt` ou
  `Cpt2` selon `Org`, Échap/F2 ferme, F1 aide.

### Impression

- **`Button1_click()`** (CC 24, max du fichier) [portée : nécessaire (handler)] [nature : mixte].
  1. Cumuls à zéro, `Create_table()`, société (`Cbase.Table("TabSoc")`), PDF `Ccompta`,
     `Shell "cd ~"` (sans effet), lecture de `dtepc` et calcul de `Datep`/`ordre` inutilisés
     (la condition `RadioButton1` est testée deux fois, la seconde branche est morte).
  2. `SELECT * FROM Fiches_MvtA WHERE poste >= &1 and poste <= &2 and validee = 1 order by
     poste, jour, numero, dte, compte` (ou `jour, poste, …`) — **toutes dates confondues**.
  3. Pour chaque ligne : ruptures de poste et de journal avec trait et titre (`Level1A`/
     `Level2A`), libellés lus par `SELECT intitulep … WHERE code >= &1` et `SELECT libelle_jo …
     WHERE code_jo >= &1` (premier enregistrement supérieur ou égal, sans `ORDER BY` : A03) ;
     en tri journal/poste, `SELECT intitule FROM Fiches_Postes` (colonne inexistante, A02) ;
     trait à chaque changement de date ou de pièce. Les ruptures sont imprimées **avant** le
     filtre de période (A05).
  4. Si la date est dans la période : solde progressif, `pdf.level2J(…)` avec **9 arguments**
     alors que `Ccompta.level2J` en exige 10 (`Nlot` non optionnel : A01), puis cumul dans
     `centralisation` sous `njournal = Compt`, où `Compt` est le **compte** de la ligne (A04).
  5. Saut de page au-delà de Y = 283 mm (titre « Impression des journaux », `Level0J` avec le
     compte et son intitulé, A06).
  6. Fin : `type_jour` n'étant jamais renseigné, la page de centralisation est toujours imprimée
     (`Centralisation()` pour le dernier `Compt`), puis `Output` et `Visualiseur.Prog`.
     Sans écriture : `message(" Aucune ecriture pour cette demande")`.
- **`Create_table()`** [portée : réductible] [nature : calcul (DDL)]. Copie de
  `JournauxM.Createtable` (`Try` sur le `CREATE`).
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls.
- **`Centralisation()`** [portée : réductible] [nature : mixte]. Copie de
  `JournauxM.Centralisation` (titre de saut de page « Impression des journaux »).
- **`donnees1`, `donnees2`, `donnees3`** [portée : réductible] — **code mort** (`hfile` n'est
  jamais ouvert ; `donnees3` a 11 paramètres contre 12 dans `Journaux`).
- **`Button3_Click()`** [nature : GUI]. Aide `Doc.Open("Editjournaux")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe` ; `Utils.db`, `Utils.Calc_mois`, `Cdate_aff`,
  `CDate_calc`, `Cdate_Comp`, `Cdate_Dbase`, `Utils.Observers`.
- `Cbase.Table("TabSoc")`, `("TabMvtA")`, `("TabPostes")`, `("TabJour")`, `("TabComptes")` ; en
  dur : `Fiches_Parametres`, `Fiches_Mvt*` (`Tab0`, inutilisé), `centralisation`.
- `Visualiseur.Prog`, `Ccompta`, `Doc.Open`, `Music`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire les ruptures poste/journal (l. 631-671) dans une fonction privée par ordre de tri, et
  les lectures de libellés dans `LibellePoste(code)`/`LibelleJournal(code)`.
- Supprimer `ordre`, `Datep`, `Shell`, la lecture de `dtepc`, `donnees1..3`, `filetxt`/`hfile`.

### Commonalisation avec d'autres fichiers

- Exercice, contrôle de date (variante avec complétion), table d'exercice : socle `ImpCompta`
  décrit dans [Journaux](../Journaux.class/architecture.md) (`Bornes` (BALANCE-004), `ControleDate` (BALANCE-005) de BALANCE-005 avec complétion).
- Centralisation (création, cumul, impression) : socle décrit dans
  [JournauxM](../JournauxM.module/architecture.md).
- La complétion de date courte (l. 405-407, 437-439) existe aussi dans d'autres écrans de saisie
  de dates : candidate pour `Utils.CDate_calc` (phase 3, à vérifier sur les autres appelants).
- Duplication mesurée : `JournauxA` ↔ `Journaux` 365 lignes (55 %), ↔ `Jourcent` 423 (64 %),
  ↔ `EcrM` 315 (47 %), ↔ `JournauxM` 150 (23 %).

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `Aff_Postes`, `Compdate`, `compdate2`, `Create_table`, `Raz`,
  `Centralisation` → `Private` (aucun appelant externe : seul `Fmenu` ouvre l'écran) ;
  `donnees1..3` : suppression.

### Séparation traitement / GUI

- `Button1_click` : la lecture SQL et le cumul de centralisation peuvent passer dans des
  fonctions privées sans contrôles, le handler gardant le curseur, le PDF et les messages. À
  faire **après** décision sur les anomalies A01-A04 (aujourd'hui le chemin nominal échoue).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Postes` n'a pas d'index sur `code` (clé `lind`) : un index unique `code` fiabiliserait
  les recherches de libellé.
- Comme pour `JournauxM`, la centralisation pourrait être un `GROUP BY compte` sans table de
  travail.
