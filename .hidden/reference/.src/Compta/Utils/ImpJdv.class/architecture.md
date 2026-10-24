# ImpJdv — Architecture

> Source : `.src/Compta/Utils/ImpJdv.class` · Form : `ImpJdv.form`

## Vue d'ensemble

Fenêtre « Import du JDV Laurux » (menu Comptabilité > Outils, visible quand `/Exp` est faux) :
intègre dans la comptabilité les fichiers produits par [`ExportJdv`](../ExportJdv.class/architecture.md)
au format « 1- Fichier texte » sur un autre poste ou une autre base (caisse / gestion → compta) :

- `<rep>/clients.txt` : un client par ligne, 31 champs séparés par `;` (ordre des colonnes de
  `Fiches_Cli` écrit par ExportJdv l.608 : code, raison sociale, nom, prénom, adresses, CP, ville,
  mail, téléphones, fax, encours, RIB, domiciliation, … , observations, collectif, rmo, rart) ;
- `<rep>/ecritures<JJ>.csv` (`JJ` = code journal saisi) : `compte;intitulé;date;n° pièce;libellé;
  débit;crédit[;…]`.

Déroulement (`Import`, bouton « Importer ») : dump de la base (`Sauve`), confirmation, création ou
mise à jour des clients (+ compte `Fiches_Comptes` associé), édition PDF des clients créés
(`Cclients`), contrôle de l'existence des comptes non clients (`Controle`, table de travail
`Nvcompte`, fichier `Nvcomptes.txt`), puis import des écritures (`Compta`) : pour chaque ligne
411, une ligne collectif + la ligne client avec un nouveau numéro d'écriture ; les lignes suivantes
(contreparties) prennent le même numéro ; le solde de chaque compte est mis à jour au fil de l'eau.
Les écritures déjà présentes (même compte et même pièce) sont rejetées (`rejets.txt`).

Nature globale : **mixte** ; tout l'état passe par ~40 membres privés (un par champ client).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `Tab` | var | Private |  | String | 28 |
| `Filename` | var | Private |  | String | 29 |
| `rResult` | var | Private |  | Result | 30 |
| `ParaResult` | var | Private |  | Result | 31 |
| `CliResult` | var | Private |  | Result | 32 |
| `code` | var | Private |  | String | 33 |
| `Cv` | var | Private |  | String | 34 |
| `nom` | var | Private |  | String | 35 |
| `Prenom` | var | Private |  | String | 36 |
| `adr1` | var | Private |  | String | 37 |
| `adr2` | var | Private |  | String | 38 |
| `cp` | var | Private |  | String | 39 |
| `ville` | var | Private |  | String | 40 |
| `Email` | var | Private |  | String | 41 |
| `Telbur` | var | Private |  | String | 42 |
| `Teldom` | var | Private |  | String | 43 |
| `Telpble` | var | Private |  | String | 44 |
| `Poste` | var | Private |  | String | 45 |
| `Portable` | var | Private |  | String | 46 |
| `Fax1` | var | Private |  | String | 47 |
| `Fax2` | var | Private |  | String | 48 |
| `Encours` | var | Private |  | String | 49 |
| `codebanque` | var | Private |  | String | 50 |
| `codeguichet` | var | Private |  | String | 51 |
| `Cle` | var | Private |  | String | 52 |
| `numcompte` | var | Private |  | String | 53 |
| `Dom` | var | Private |  | String | 54 |
| `Cent` | var | Private |  | String | 55 |
| `Cacc` | var | Private |  | String | 56 |
| `Tire` | var | Private |  | String | 57 |
| `Idtva` | var | Private |  | String | 58 |
| `Relcompte` | var | Private |  | String | 59 |
| `Relfacture` | var | Private |  | String | 60 |
| `obs` | var | Private |  | String | 61 |
| `collectif` | var | Private |  | String | 62 |
| `rmo` | var | Private |  | String | 63 |
| `rart` | var | Private |  | String | 64 |
| `hfile3` | var | Private |  | File | 65 |
| `Jnl` | var | Private |  | String | 66 |
| `Nfac` | var | Private |  | String | 67 |
| `numecr` | var | Private |  | String | 68 |
| `numr` | var | Private |  | Integer | 69 |
| `Ctrl` | var | Private |  | String | 70 |
| `PosY` | var | Private |  | Integer | 71 |
| `Coulfond` | var | Private |  | New String[] | 72 |
| `pdf` | var | Private |  | Cclients | 73 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 75-91 | Public | 3 | 14 | 0 | méthode spéciale |
| `coljour_Click` | 93-99 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 101-116 | Public | 6 | 11 | 0 | handler GUI |
| `Svs2_Click` | 118-128 | Public | 2 | 8 | 0 | handler GUI |
| `Import` | 130-243 | Public | 15 | 111 | 0 | portée réductible ? |
| `Sauve` | 245-254 | Public | 2 | 7 | 0 | portée réductible ? |
| `Creation_Client` | 256-285 | Public | 9 | 27 | 0 | portée réductible ? |
| `Maj_Client` | 287-310 | Public | 5 | 21 | 0 | portée réductible ? |
| `Controle` | 312-385 | Public | 10 | 68 | 0 | portée réductible ? |
| `Compta` | 387-530 | Public | 17 | 138 | 0 | portée réductible ? |
| `Parametres` | 535-545 | Public | 2 | 7 | 0 | portée réductible ? |
| `Ecritures` | 550-561 | Public | 2 | 9 | 0 | portée réductible ? |
| `Maj_Parametres` | 566-576 | Public | 1 | 7 | 0 | portée réductible ? |
| `Majnum` | 581-586 | Public | 1 | 4 | 0 | portée réductible ? |
| `header` | 588-599 | Public | 1 | 10 | 0 | portée réductible ? |
| `content1` | 601-605 | Public | 1 | 3 | 0 | portée réductible ? |
| `content0` | 607-611 | Public | 1 | 3 | 0 | portée réductible ? |
| `footer` | 613-617 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button3_Click` | 619-623 | Public | 1 | 3 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 625-653 | Public | 4 | 27 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Cycle de vie et handlers

- **`_New()`** [constructeur] [nature : mixte]. `Utils.Coulfd()` (résultat jamais utilisé),
  `SELECT * FROM Fiches_Parametres` → journal par défaut `jrnal` dans `Cpt` ; chemin
  `/Soc<XX>/Chemin-import`.
- **`coljour_Click()`, `ToggleButton3_Click()`** [handlers] [nature : mixte]. Liste des journaux
  `VE` (`SELECT * FROM Fiches_Journaux WHERE type_jo = &1 ORDER BY code_jo`) dans `Coljour`.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 1 → aide (`Button3_Click`), tag 2 → `Import`,
  tag 3 → suppression de `~/tmp/Edclients.pdf` et fermeture.
- **`Svs2_Click()`** [handler] : choix du répertoire d'import (`Dialog.SelectDirectory`).
- **`Button3_Click()`** [handler nominal ; `Button3` est dans le groupe `Btn`, appelé par
  `Btn_Click` tag 1] : `Doc.Open("Export")`.

### Import (orchestration)

- **`Import()`** [portée : réductible] [nature : mixte, CC 15]. `Shell "cd ~"` (sans effet),
  création du PDF `~/tmp/Edclients.pdf`, `Sauve()` **avant** la vérification des fichiers et la
  confirmation, ouverture de `clients.txt` et **ouverture en écriture du même fichier PDF dans
  `hFile3`** (vestige Kugar). Pour chaque ligne client : `Split(";")` puis 31 affectations
  `Lig2[0..30]` **sans protection** (moins de 31 champs → erreur d'indice) ; `SELECT * FROM
  Fiches_Cli WHERE cli_code = &1` → `Maj_Client` ou `Creation_Client` + ligne PDF
  (`pdf.Level2` avec **12 arguments** alors que `Cclients.Level2` en exige 13 depuis 2016 : erreur
  « Not enough arguments » attendue à la première création, à confirmer à l'exécution). Puis
  `footer()` (écrit `</KugarData>` dans `hFile3`), `Controle`, `Compta` si aucun compte ne manque,
  sortie PDF et `Visualiseur.Prog` si des clients ont été créés. Ferme la fenêtre dans tous les cas.
- **`Sauve()`** [portée : réductible] [nature : traitement]. Supprime `<rep>/Laurux_dump.sql` puis
  lance `mysqldump -h <host> -u <login> -p<mdp> <base> --add-drop-table > <rep>/Laurux_dump.sql<JJMMAAAA>`
  (le fichier supprimé n'est pas celui produit ; port, tunnel et code retour ignorés).

### Clients

- **`Creation_Client()`** [portée : réductible] [nature : traitement]. Détermine le collectif si
  la ligne n'en fournit pas : `SELECT * FROM Fiches_Comptes WHERE coll = '1' ORDER BY cast(compte_cc
  AS char)` en gardant le **dernier** compte `41*` (paramètre `1` passé mais inutilisé). Puis
  `Try INSERT INTO Fiches_Cli (34 colonnes)` : ⚠️ décalage d'arguments (`cli_dmln` ← clé RIB,
  `cli_cle_rib` ← n° de compte, `cli_num_cpt` ← domiciliation) et `cli_obs` ← code client ;
  `Try INSERT INTO Fiches_Comptes` (compte = code client, type `C`) ; `UPDATE Fiches_Parametres SET
  dnc` si le code dépasse le dernier numéro.
- **`Maj_Client()`** [portée : réductible] [nature : traitement]. Même recherche de collectif, puis
  `UPDATE Fiches_Cli` (29 colonnes ; ⚠️ `cli_tel_dom` et `cli_tel_bur` inversés par rapport à la
  création et à l'export), `UPDATE … cli_rmo, cli_rart`, `UPDATE Fiches_Comptes` (intitulé, type,
  collectif). **Identique** à `ImpSage.Maj_Client` (où elle est morte).

### Contrôle des comptes

- **`Controle(Ctrl2)`** [portée : réductible] [nature : mixte]. Paramètre inutilisé. Ouvre
  `Nvcomptes.txt` en écriture, `DROP TABLE IF EXISTS Nvcompte` + `CREATE TABLE IF NOT EXISTS
  Nvcompte (cd, intitule)` (table de travail hors `LauruxMaj`). Pour chaque ligne d'écriture dont
  le compte ne commence pas par `41` : `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1` ; si
  absent, `UPDATE Nvcompte` **par concaténation** (apostrophe → erreur SQL) ou `INSERT`. Écrit la
  liste dans `Nvcomptes.txt` et renvoie `"O"` si des comptes manquent. `hFile2` jamais fermé ; les
  affectations de `Ctrl` dans la boucle sont sans effet.

### Écritures

- **`Compta()`** [portée : réductible] [nature : mixte, CC 17]. `cloturee` = case « Clôturer les
  écritures ». Pour chaque ligne de `ecritures<JJ>.csv` : `Parametres()` (relit
  `Fiches_Parametres` à chaque ligne pour rien), `numr = Ecritures("numecriture")`, puis `SELECT *
  FROM Fiches_Mvt WHERE compte = &1 AND numdoc = &2` :
  - absente : si compte `41*` → `numr + 1`, ligne collectif (`compte = coll_cc` lu sans test
    `Available`, `collectif = 1`) et mise à jour du solde du collectif ; puis ligne du compte
    (`INSERT INTO Fiches_Mvt`, placeholders `&1…&18` sans `&4`), mise à jour du solde
    (`solde = solde + débit − crédit`), `Majnum("numecriture", numr)` et **`Maj_Parametres()`** ;
  - présente : si `41*`, ligne dans `rejets.txt` (le compteur `Nbe2` n'est jamais incrémenté).
  - Journal = `Fiches_Parametres.jrnal` (et non le journal saisi), dates via `Utils.Cdate_Dbase`,
    montants via `Utils.cpoint`/`PointBase`. Aucune transaction. Ouvre `rejets.txt` dans l'éditeur.
- **`Parametres()`** [portée : réductible] : relit `jrnal` dans le membre `Jnl` (jamais relu).
- **`Ecritures(numecr2)`** [portée : réductible] : `SELECT <colonne> FROM Fiches_Parametres`,
  affecte le membre `numr` (effet de bord) et le renvoie en `String`.
- **`Maj_Parametres()`** [portée : réductible]. `SELECT` inutile puis `UPDATE Fiches_Parametres SET
  dnfac = &1` avec `Nfac`, **jamais affecté** : remet à vide (`NULL`, à confirmer) le **dernier
  numéro de facture** à chaque écriture importée (voir IMPJDV-A01).
- **`Majnum(numecr2, numr2)`** [portée : réductible] : `UPDATE Fiches_Parametres SET <colonne> =
  &1` (nom de colonne concaténé, toujours `numecriture`).

### Vestiges Kugar (code mort)

- **`header()`, `content1()`, `content0()`** : jamais appelés (vérifié par `grep`).
- **`footer()`** : appelé une fois, écrit dans `hFile3` = le fichier PDF, écrasé ensuite par
  `pdf.Output`.

## État global utilisé

- `Start.LocalSettings` (`/Soc<XX>/Chemin-import`, `/dbase/Host`), `Start.Societe`, `Start.Son`,
  `Start.Musique` ; `Utils.db` (Exec, Login, Password, Name, Engine), `Utils.cpoint`,
  `Utils.PointBase`, `Utils.Cdate_Dbase`, `Utils.Coulfd`, `Utils.Observers`.
- `Cclients` (PDF), `Visualiseur.Prog`, `Editeur.Prog_Editeur`, `Doc.Open`.
- Tables : `Fiches_Cli`, `Fiches_Comptes` (INSERT/UPDATE dont `solde`), `Fiches_Mvt` (INSERT),
  `Fiches_Parametres` (`dnc`, `numecriture`, `dnfac`), `Fiches_Journaux` (lecture), `Nvcompte`
  (travail). Tous les noms sont en dur.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les ~30 membres « champ client » par un tableau (ou une `Collection`) local passé à
  `Creation_Client` / `Maj_Client` ; lecture des 31 champs par une boucle sur une liste de noms.
- `Ecritures`/`Majnum` : toujours appelées avec `"numecriture"` → `DernierNumeroEcriture() As
  Integer` et `MajNumeroEcriture(n)` sans nom de colonne concaténé.
- Supprimer l'appel à `Parametres()` dans la boucle de `Compta` et le `SELECT` de `Maj_Parametres`
  (SQL modifié, dump identique).
- Extraire de `Compta` le traitement d'une ligne `ImporteLigne(aCol, iNumero) As Integer`.
- Tables via `Cbase.Table` (`TabCli`, `TabComptes`, `TabMvt`, `TabParam`, `TabJour`).

### Commonalisation avec d'autres fichiers

- [`ImpSage`](../ImpSage.class/architecture.md) est une copie adaptée : `Maj_Client`,
  `Parametres`, `Ecritures`, `Maj_Parametres`, `Majnum`, `header`/`content*`/`footer`,
  `Button3_Click` **identiques** (diff vide), `Controle`, `Sauve`, `Svs2_Click`, `Btn_Click`
  quasi identiques, `Compta` ↔ `ComptaS` et `Creation_Client` voisins. Un module commun d'import
  comptable (ex. `ImpCompta.module`) regrouperait : numéro d'écriture, insertion d'une ligne
  `Fiches_Mvt` + ligne collectif, mise à jour de `Fiches_Comptes.solde`, liste `Nvcompte`.
- `Sauve` → `Utils.DumpBase` (SAUVESAUTO-003, voir
  [SauvesAuto](../../../Communs/SauvesAuto.module/architecture.md)), comme `ImpSage` et `Epurjdv`.
- Recherche du collectif client (`coll = '1'` + préfixe `41`) : aussi dans `ImpSage.Import_Sage` et
  [`Impclient`](../../../Utils/Exports-Imports/Impclient.class/architecture.md) l.91-97, mais avec
  une sémantique différente (ici le **dernier** `41*`, là-bas le **premier**) : un helper
  `CollectifClient(bDernier As Boolean)` doit conserver les deux.
- `Svs2_Click`, `ToggleButton3_Click`/`coljour_Click` : socle `ImpExp` et helper de liste des
  journaux partagés avec [`ExportJdv`](../ExportJdv.class/architecture.md) et
  [`Intjdv`](../Intjdv.class/architecture.md).
- Format des fichiers : couplé à `ExportJdv` (type 1) ; une description commune du format
  (constantes de colonnes) servirait aux deux fichiers.

### Réduction de portée

- `Import`, `Sauve`, `Creation_Client`, `Maj_Client`, `Controle`, `Compta`, `Parametres`,
  `Ecritures`, `Maj_Parametres`, `Majnum`, `footer` → `Private` (aucun appelant externe : seul
  `Fmenu` ouvre la fenêtre par `ShowModal`, vérifié par `grep -rn "ImpJdv\." .src`).

### Séparation traitement / GUI

- `ImporteClients(sFichier) As Integer[]` (créés / mis à jour), `ComptesManquants(sFichier) As
  String[]` et `ImporteEcritures(sFichier, bCloture) As Integer` sans accès aux contrôles ; les
  handlers gardent souris, messages, PDF, éditeur et visualiseur.

### Requêtes signalées par `sql_params` (après le lot Gestion-2)

- l. 268 : `Exec` reçoit un argument (`1`) sans marqueur `&N` dans le SQL (signal `sql_params`) : argument inutile, sans effet ; à retirer avec le rework de documentation.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Comptes.solde` mis à jour ligne à ligne (lecture puis écriture) : une vue ou un recalcul
  global (`Calcsolde`) éviterait les dérives.
- `Nvcompte` est une table de travail persistante créée hors `LauruxMaj` : table temporaire.
- Une clé d'unicité (`compte`, `numdoc`, `jour`) sur `Fiches_Mvt` rendrait le contrôle de doublon
  fiable.
