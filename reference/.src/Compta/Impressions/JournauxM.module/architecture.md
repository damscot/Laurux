# JournauxM — Architecture

> Source : `.src/Compta/Impressions/JournauxM.module`

## Vue d'ensemble

`JournauxM` est le **moteur d'impression PDF des journaux comptables** (écran
[`Journaux`](../Journaux.class/architecture.md), bouton « Imprimer »). Pour chaque journal de
`Fiches_Journaux` compris entre deux codes, il lit les écritures validées de la table d'exercice
choisie (`Fiches_Mvt`, `Fiches_Mvt1` … `Fiches_Mvt5`, passée en paramètre `Tab0`), les imprime ligne
à ligne avec un solde progressif, puis imprime une page de **centralisation** (cumul débit/crédit
par compte) pour les journaux autres que `OD`. Une page « Totaux impressions » termine le document
si la case « totaux » est cochée. Le PDF `~/tmp/Journaux.pdf` est produit par
[`Ccompta`](../../../Reports/Ccompta.class/architecture.md) (`Inherits PdfWriter`) puis ouvert par
`Visualiseur.Prog`.

La centralisation passe par une **table physique de travail** `centralisation` (`cd_cent`,
`intitule`, `db_cent`, `crd_cent`, `njournal`), supprimée puis recréée par `Createtable` au début
de l'impression et après chaque journal centralisé. Cette table n'est pas déclarée dans
`db_control.csv` ni dans `Cbase` ; elle est partagée entre tous les postes connectés à la base.

Le module a été extrait de `Journaux.class` : il en garde l'état d'instance sous forme de 24
variables `Private` de module (totaux, page, position Y, PDF) et accède directement à
l'auto-instance du formulaire (`Journaux.Mouse`). `EcrM.class` contient une copie quasi intégrale
de `Imprime` (55 % des lignes communes, voir commonalisation).

Nature globale : **mixte**. SQL de lecture, SQL d'écriture sur la table de travail, rendu PDF et
messages utilisateur sont entremêlés dans `Imprime` (CC 55, la plus forte du lot).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebhP` | var | Private | oui | Float | 3 |
| `CredhP` | var | Private | oui | Float | 4 |
| `TotSldhP` | var | Private | oui | Float | 5 |
| `TotDeb` | var | Private | oui | Float | 6 |
| `TotCred` | var | Private | oui | Float | 7 |
| `TotDeb2` | var | Private | oui | Float | 8 |
| `TotCred2` | var | Private | oui | Float | 9 |
| `TotDeb3` | var | Private | oui | Float | 10 |
| `TotCred3` | var | Private | oui | Float | 11 |
| `TotSld` | var | Private | oui | Float | 12 |
| `debit` | var | Private | oui | Float | 13 |
| `credit` | var | Private | oui | Float | 14 |
| `solde` | var | Private | oui | Float | 15 |
| `dte` | var | Private | oui | String | 16 |
| `Filename` | var | Private | oui | String | 17 |
| `r3Result` | var | Private | oui | Result | 18 |
| `type_jour` | var | Private | oui | String | 19 |
| `Tab` | var | Private | oui | String | 20 |
| `Db_ction` | var | Private | oui | Float | 21 |
| `Cd_ction` | var | Private | oui | Float | 22 |
| `Compt` | var | Private | oui | String | 23 |
| `iPage` | var | Private | oui | Integer | 24 |
| `PosY` | var | Private | oui | Integer | 25 |
| `pdf` | var | Private | oui | Ccompta | 26 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Imprime` | 28-316 | Public | 55 | 268 | 1 |  |
| `Raz` | 318-331 | Public | 1 | 12 | 0 | portée réductible ? |
| `Centralisation` | 333-360 | Public | 4 | 23 | 0 | portée réductible ? |
| `Createtable` | 362-374 | Public | 2 | 11 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Imprime(cpt, cpt2, dten0, dten1, Radiobutton1, CheckBox1, Tab0, Cloture)`** (CC 55, l. 28-316)
  [portée : nécessaire, appelée par `Journaux.Button1_Click`] [nature : mixte].
  Paramètres : bornes de codes journaux, bornes de dates au format `dd.mm.yyyy`, tri (`True` =
  date/numéro/compte, `False` = numéro/date/compte), impression des totaux, table d'exercice,
  mention « après clôture ».
  1. Initialise les cumuls, `Journaux.Mouse = Mouse.Wait`, recrée la table `centralisation`.
  2. Lit `Fiches_Societes` (`cd_sc = Start.Societe`, libellé « Société  <int_sc> », sans test
     `Available`) et `Fiches_Parametres` (`dtepc`, date de dernière clôture de période). Si la date
     de fin dépasse `dtepc`, l'édition est qualifiée « ( Edition provisoire ) » et la numérotation
     affichée est `numero` ; sinon `numerodef` (numéro définitif). Le test `IsNull(Qual)` repose sur
     `IsNull("") = True`.
  3. `SELECT * FROM Fiches_Journaux WHERE code_jo >= &1 and code_jo <= &2 order by code_jo`.
  4. Pour chaque journal : `SELECT * FROM <Tab0> WHERE jour = &1 and validee = 1 and dte >= &3 and
     dte <= &4 order by dte, numero, compte` (ou `numero, dte, compte`). Les dates sont passées par
     `Utils.Cdate_Dbase` au format `yyyymmdd` (voir anomalie A02).
  5. Pour chaque écriture :
     - `collectif` (Try) distingue les lignes de **compte collectif** (non imprimées, cumulées
       sous le collectif) des lignes détaillées ;
     - `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1` : si le compte n'existe pas,
       `Message.Error` puis `Return` (anomalie A01) ; un compte de trésorerie (`comptr_cc <> 0`)
       est imprimé avec l'intitulé du plan comptable au lieu de celui de la ligne ;
     - comptes `401`/`411`/`453` : libellé normalisé « Facture »/« Avoir » selon les 3 premières
       lettres, suffixé du `numdoc` dans un journal de type `VE` (sauf libellé « Caisse… ») ;
     - ligne imprimée par `pdf.level2J` (dont le `Lot` = `numdoc`) ; trait de séparation
       `pdf.Lines` à chaque changement de pièce ;
     - **centralisation** (journal non `OD`) : compte détaillé hors `401`/`411`/`453` →
       `SELECT … centralisation WHERE cd_cent = &1` puis `UPDATE` (paramétré) ou `INSERT`
       avec l'intitulé du plan comptable ; ligne de collectif → libellé « Collectif
       fournisseurs » (`40…`), « Collectif clients » (`41…`), « Collectif clients coop » (`453`)
       puis `UPDATE` construit **par concaténation** (l. 242) ou `INSERT` ;
     - saut de page au-delà de Y = 283 mm (`Baspage2`, `Entete`, `Level0J`, `Level1J`).
  6. Fin de journal : trait, ligne « Total journal » si `CheckBox1`, cumul des totaux généraux ;
     pour un journal non `OD`, nouvelle page « Centralisation du journal » (`Centralisation`)
     puis `Createtable` ; numéro de page remis à 1.
  7. Page « Totaux impressions » (`level1JT`/`level2JT`) si `CheckBox1`, `pdf.Output`, puis
     `Visualiseur.Prog`. Sans journal dans l'intervalle : `message(" Aucune ecriture pour cette
     demande")`. Un journal sans écriture est simplement sauté.
  Effets de bord : table `centralisation` recréée (DDL) et remplie ; fichier
  `~/tmp/Journaux.pdf` écrasé ; curseur de `Journaux` modifié ; `Shell "cd ~"` sans effet.
  Variables mortes : `Datep`, `Ccoll`, `TotSldhP`, `DebhP`, `CredhP`, `TotDeb`, `TotCred`,
  `TotSld` (calculés mais jamais imprimés dans `Imprime`), blocs `If p1 <> 0 Then 'solde = 0`
  vides. Le paramètre `Cloture` vaut toujours `False` (seul appelant) : la branche « après
  clôture » est morte.
- **`Raz()`** [portée : réductible, usage interne] [nature : calcul]. Remet à zéro les cumuls du
  module (sauf `solde`, `Totdeb2/3`, `Totcred2/3`).
- **`Centralisation()`** [portée : réductible] [nature : mixte]. `SELECT * FROM centralisation
  WHERE njournal = &1 order by cd_cent` ; imprime chaque compte (`level7J`) avec un solde cumulé,
  saut de page au-delà de 283 mm (sans `Level0J`, contrairement à la première page).
- **`Createtable()`** [portée : réductible] [nature : calcul (DDL)]. `DROP TABLE IF EXISTS
  centralisation` puis `CREATE TABLE centralisation (cd_cent Char(8) NOT NULL, intitule Char(50),
  db_cent Decimal(12,2), crd_cent Decimal(12,2), njournal Char(2), PRIMARY KEY (cd_cent))` +
  `Utils.db.Engine()` (création dans un `Try` : un échec est silencieux). Copie identique dans
  `Journaux`, `JournauxA`, `Jourcent`, `EcrM` ; variante `FLOAT`/`Char(40)` dans
  `Journaux.Button4_Click` et `ExportA47.Button2_Click`.

## État global utilisé

- `Utils.db` (toutes les requêtes) ; `Utils.Cdate_Dbase`, `Utils.CDate_Aff`.
- `Start.Societe` (société courante).
- Auto-instance du formulaire `Journaux` (`Journaux.Mouse`, l. 70 et 314) : le module ne peut pas
  être appelé sans ce formulaire.
- `Visualiseur.Prog` (ouverture du PDF), `Ccompta` (rendu).
- Tables en dur : `Fiches_Journaux`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Comptes`
  (non passées par `Cbase.Table`), table d'exercice reçue en paramètre, table de travail
  `centralisation`.
- État de module persistant entre deux appels : `Totdeb2`/`Totcred2` ne sont remis à zéro qu'en fin
  de journal (voir A01).

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Imprime` (CC 55) en fonctions privées : `NumeroPiece(rLigne, bProvisoire)` (l. 111-116,
  159-180), `LibelleLigne(compte, libelle, type_jour, numdoc)` (l. 182-193), `TypeCollectif(compte)`
  (l. 225-235), `EntetePage(titre)` (l. 104-109 et 251-254), `FinJournal()` (l. 262-294).
- Réutiliser le résultat `Nm` de la l. 125 au lieu de la même requête l. 208 (une requête de
  moins par ligne ; dump identique).
- Passer les tables par `Cbase.Table("TabJour")`, `("TabParam")`, `("TabSoc")`, `("TabComptes")`.

### Commonalisation avec d'autres fichiers

Socle commun proposé pour les éditions comptables : un module `ImpCompta`
(`.src/Compta/Impressions/ImpCompta.module`, à créer en phase 3), **sans changement de rendu** :

| Fonction du socle | Remplace | Fichiers |
|---|---|---|
| `CentralisationCree()` | `Createtable`/`Create_table` | JournauxM, [Journaux](../Journaux.class/architecture.md), [JournauxA](../JournauxA.class/architecture.md), [Jourcent](../Jourcent.class/architecture.md), [EcrM](../EcrM.class/architecture.md) |
| `CentralisationCumule(compte, intitule, debit, credit, journal)` | `SELECT` + `UPDATE`/`INSERT` sur `centralisation` | JournauxM (×2), JournauxA, Jourcent (×2), EcrM |
| `CentralisationImprime(pdf, journal, titre, posy, ipage)` | `Centralisation`/`Centralisation2` | JournauxM, JournauxA, Jourcent, EcrM |
| `Bornes(index)` (BALANCE-004) | `Ex1`/`Exo`…`Exo5` | voir [Journaux](../Journaux.class/architecture.md) |

Mesure de la duplication (lignes non vides hors commentaires, appariement `difflib`) :
`JournauxM` ↔ `EcrM.class` 187 lignes communes (55 % de `JournauxM`) ; `JournauxM` ↔
`JournauxA.class` 150 (44 %) ; `JournauxM` ↔ `Jourcent.class` 116 (34 %). En revanche
`JournauxM` ↔ [`BalanceM`](../BalanceM.module/architecture.md) (61, 18 %) et
[`EditcompteM`](../EditcompteM.module/architecture.md) (54, 16 %) ne partagent que l'ossature
PDF (`New Ccompta`, `Open`, `AliasNbPages`, `Entete`, sauts de page, `Output`/`Visualiseur`) :
cette ossature relève du socle « édition PDF paginée » décidé par le groupe Balance/Editcompte
([EDITCOMPTE-006](../Editcompte.class/rework.md), qui couvre BalanceM, EditcompteM, JournauxM,
EditcompteA) ; un socle plus profond avec Balance/Editcompte n'est pas rentable. La centralisation
**par journal** décrite ici (table `centralisation`) est distincte de la centralisation
**mensuelle** d'EDITCOMPTE-006 (`Ctrln`, `finmois`) : les deux helpers restent séparés mais
peuvent partager le paramétrage du nom de table et du DDL.

### Réduction de portée

- `Raz`, `Centralisation`, `Createtable` : aucun appelant externe (`grep -rn "JournauxM\."` ne
  trouve que `Imprime`). Passage en `Private` couvert par les replays de `Journaux`.

### Séparation traitement / GUI

- Le module touche le formulaire `Journaux` (`Mouse`) et affiche `Message.Error`/`message`.
  Proposition : isoler dans des fonctions privées sans GUI la lecture des paramètres (société,
  `dtepc`, qualification provisoire) et le cumul de centralisation, `Imprime` gardant les messages
  et le curseur à l'identique.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer la table physique `centralisation` par une table temporaire ou par un simple
  `SELECT compte, SUM(montantd), SUM(montantc) … GROUP BY compte` (aucune écriture en base, plus
  de conflit entre postes).
- Un index `(jour, validee, dte)` sur `Fiches_Mvt*` couvrirait la requête principale
  (`idx_jour (jour, dte)` existe déjà).
