# StatComm — Architecture

> Source : `.src/Statistiques/StatComm.class`

## Vue d'ensemble

`StatComm` est l'écran de **saisie des critères et de calcul** du « Chiffre d'affaires des
commerciaux (sur factures archivées exclusivement) » (menu Gestion › Statistiques ›
« CA clients/commerciaux », `Fmenu.Menu313_Click`, ouverture non modale de l'auto-instance par
`StatComm.Show()`). L'utilisateur saisit une période (`DteN0`, `Dten1`, groupe `Dte`), choisit la
source (`Fact` toutes les factures, `Face` factures d'entretien, `Facn` factures hors entretien ;
`HBox3` est masquée et `Facn` forcé si `/Soc<XX>/Materiel = 0`) et coche ou non `Detail`
(détail par client, coché par défaut).

`Traitement` reconstruit la **table de travail `Total`** (DROP + CREATE), la remplit ligne à ligne
à partir de `Fiches_HistoFac` et/ou `Fiches_HistoFacM` (période N) puis cumule le total de la
même période un an avant (N-1), et ouvre [`VisStatComm`](../VisStatComm.class/architecture.md)
(`New VisStatComm(Me, Start.Societe, son, dteN0, dteN1, Detail.Value)`).

Deux modes de clé pour `Total.cdclifac` :
- **détail** (`Detail` coché) : une ligne par **client** (`cdclifac` = code client, `commercial` =
  `cli_comm`) ;
- **synthèse** : une ligne par **commercial** (`cdclifac` = code du commercial, `nmclifac` = nom
  du commercial) via `Fiches_Cli LEFT JOIN Fiches_Commerciaux`.

Ce fichier fait partie de la famille des 5 couples critères/visualisation de
`.src/Statistiques` (`StatComArt`, `StatFour`, `StatTypCli`, `StatClimo`, `StatComm`), mesurés
très proches (voir « Commonalisation ») ; c'est ici qu'est décrit le **socle commun proposé**.

Nature globale : **mixte**. Le calcul (SQL, cumuls) est entièrement dans `Traitement`, mêlé à la
lecture des contrôles (`DteN0`, `Facn`/`Face`/`Fact`, `Detail`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | VisStatcomm | 27 |
| `dte1` | var | Private |  | String | 28 |
| `dte2` | var | Private |  | String | 29 |
| `Tot` | var | Private |  | Integer | 30 |
| `son` | var | Private |  | Integer | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-57 | Public | 2 | 20 | 0 | méthode spéciale |
| `dte_KeyPress` | 59-80 | Public | 9 | 18 | 0 | handler GUI |
| `dateN1` | 82-89 | Public | 1 | 6 | 0 | portée réductible ? |
| `Btn_Click` | 91-103 | Public | 3 | 9 | 0 | handler GUI |
| `dte_GotFocus` | 108-114 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LF` | 119-133 | Public | 3 | 13 | 0 | portée réductible ? |
| `dteN1_LF` | 138-159 | Public | 6 | 20 | 0 | portée réductible ? |
| `Traitement` | 161-296 | Public | 37 | 128 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte]. Lit `Fiches_Parametres`
  (nom en dur, `SELECT *`, champ `dteclec1` = date de dernière clôture, sans test `Available`),
  calcule `DteN0` = 1er jour du mois suivant (`Utils.Calc_mois`), `Dten1` = aujourd'hui, appelle
  `dateN1`, masque `HBox3` si la société n'a pas l'option matériel. `Utils.Observers(Me)` une
  seule fois (rejouable). `Frmt` (couleur `/Coul/Fnets`) et `Tot = 40` ne sont jamais relus.

### Saisie des dates (handlers et aides)

- **`dte_KeyPress()`** [handler du groupe `Dte`, `Public` obligatoire] [nature : GUI].
  Entrée/Retour/Tab : tag 1 → `dteN0_LF` puis focus `Dten1` ; tag 2 → `dteN1_LF` puis focus
  `DteN0` ; `Stop Event`.
- **`dateN1()`** [portée : réductible] [nature : calcul]. Calcule `dte1`/`dte2` = mêmes dates
  avec l'année − 1 par découpage de chaîne (`Left$(…, 6) & année-1`). Un 29.02 donne une date
  inexistante (29.02.N-1) : comportement de `Cdate_Dbase` sur cette chaîne à confirmer.
- **`Btn_Click()`** [handler du groupe `Btn`] [nature : GUI]. Tag 1 → `dateN1` + `Traitement` ;
  tag 2 → fermeture.
- **`dte_GotFocus()`** [handler] [nature : GUI]. `Utils.SetEditColor(Me, Last)`.
- **`dteN0_LF()` / `dteN1_LF()`** [portée : réductible] [nature : GUI]. Normalisent la saisie
  (`Utils.Cdate_calc` puis `Utils.Cdate_aff`), recalculent N-1, remplacent `"00.00.0:00"` par la
  date du jour ; `dteN1_LF` refuse une fin antérieure au début (son + `Message.Warning`, retour au
  champ). `Catch` : retour du focus au champ. Ces deux fonctions sont **identiques** dans
  `StatComArt`, `StatTypCli`, `StatClimo` (variante `Balloon`/format `dd/mm/yyyy` dans `StatFour`).

### Calcul

- **`Traitement()`** (CC 37, max du fichier) [portée : réductible] [nature : mixte].
  1. `DROP TABLE IF EXISTS Total` puis `CREATE TABLE Total (cdclifac Char(8) NOT NULL, nmclifac
     Char(25), pnmclifac Char(25), brutfac, rmfac, totfac, totfacn1 Decimal(12,2), commercial
     Char(2), PRIMARY KEY (cdclifac))` + `Utils.db.Engine()`.
  2. Test de saisie `dteN0 <> "" Or Left$(dteN0, 2) = "00" Or …` : équivaut à
     `dteN0 <> "" Or dteN1 <> ""` (les termes `Left$ = "00"` sont redondants).
  3. Période N : `SELECT * FROM Fiches_HistoFac` (+ `order by cdclifac, datefac` pour `Facn`
     seulement), `Fiches_HistoFacM`, ou leur `union`, sur `datefac` entre les deux dates
     (`Utils.Cdate_Dbase`).
  4. Par facture : remises `remmofac`/`remartfac` (varchar ; `Try Val()` puis repli sur la
     conversion implicite non localisée) ; `TotA = Val(cpoint(totfac))` ; `BrutA = TotA + remises`.
     - détail : `SELECT cli_nom, cli_comm FROM <TabCli>` **sans test `Available`** (l. 221-223) ;
       `Codec` = code client ;
     - synthèse : `SELECT cli_code, cli_nom, code, nom FROM <TabCli> LEFT JOIN <TabCommerciaux>
       ON code = cli_comm` ; `Codec`, `commercial`, `Client` et `TotResult` affectés par `Try`
       (l. 226-229) : si le client n'existe plus, ils **gardent la valeur de la facture
       précédente** (anomalie STATCOMM-A01).
     - si `Codec` non nul (`IsNull("")` est vrai : les clients sans commercial sont ignorés en
       synthèse) : `UPdate Total SET … brutfac, rmfac, totfac` cumulés, ou `INSERT`. En synthèse,
       `pnmclifac` reçoit le prénom du client de la facture courante dans une ligne de commercial
       (STATCOMM-A04).
  5. Période N-1 (`dte1`, `dte2`) : même source que N ; pour chaque facture, `UPdate Total SET
     totfacn1` cumulé sur la ligne existante (requête `TotResult` exécutée **deux fois** en mode
     détail, l. 257 et 263). Les clients/commerciaux sans vente en N sont ignorés ; la colonne
     `totfacn1` n'est **affichée nulle part** (STATCOMM-A03).
  6. `SELECT * FROM Total` : si vide, `Message.Warning("Aucune donnée pour cette période !")`,
     sinon ouverture de `VisStatComm`. La branche « Veuillez saisir une date » laisse aussi passer
     à ce `SELECT`.
  Tables : `Fiches_HistoFac`, `Fiches_HistoFacM` (noms en dur), `Cbase.Table("TabCli")`,
  `Cbase.Table("TabCommerciaux")`, `Total` (créée, écrite, lue). `Tab4`/`Tab5`
  (`Fiches_Bl`/`Fiches_BlM`) sont déclarées mais jamais utilisées.
  Volume SQL : 2 à 4 requêtes par facture N et 1 à 2 par facture N-1 (N+1 requêtes).

## Sources de ventes : comparaison des écrans de la famille

| Écran | Factures archivées `HistoFac` | Factures entretien `HistoFacM` | BL / factures en cours `Fiches_Bl(M)` | Tickets `HisEntTickets` | N-1 |
|---|---|---|---|---|---|
| `StatComm` | oui (entêtes) | selon `Face`/`Fact` | non (déclarées, inutilisées) | non | oui, même source que N |
| [`StatTypCli`](../StatTypCli.class/architecture.md) | oui (entêtes) | selon `Face`/`Fact` | non | non | **toujours `HistoFac` seule** |
| [`StatComArt`](../StatComArt.class/architecture.md) | oui (lignes `HistoLigfac`) | entêtes oui, **lignes lues dans `HistoLigfac`** | non | non | non (`dte1/dte2` calculés, inutilisés) |
| [`StatClimo`](../StatClimo.class/architecture.md) | oui (lignes) | oui (lignes `HistoLigfacM`) | **oui** (type `F`, + `B` si « Inclure les BL ») | non | non |
| [`TBord`](../TBord.class/architecture.md) (hors lot) | oui | oui | oui | non | — |
| [`Histocliart`](../Histocliart.class/architecture.md) (hors lot) | oui | oui | oui | **oui** | — |

Les écrans `StatComm`, `StatTypCli` et `StatComArt` annoncent « sur factures archivées
exclusivement » dans leur `.form` : l'absence des BL et factures en cours y est voulue. Les ventes
de caisse n'y figurent qu'une fois **moulinées** en BL puis facturées et archivées
(`Moulinage` écrit dans `Fiches_Ligbl`) : à confirmer avec l'utilisateur.

## État global utilisé

- `Start.LocalSettings["/Coul/Fnets"]` (lu, inutilisé), `["/Soc<XX>/Materiel"]`, `Start.Societe`,
  `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.Cdate_calc`, `Utils.Cdate_aff`,
  `Utils.Cdate_Dbase`, `Utils.cpoint`, `Utils.SetEditColor`, `Utils.FColr`.
- Table de travail **`Total`** : table physique (moteur InnoDB sous MySQL), hors
  `db_control.csv` et hors `Laurux01.sql`, recréée à chaque traitement sous un nom **partagé**
  par tous les postes et par 7 écrans de structures différentes (voir STATCOMM-A05 et
  [STATCAI-A04](../../Caisse/Statcai.class/rework.md)).

## Propositions d'amélioration

### Réécriture / refactorisation

- Accumulation en mémoire (`Collection` indexée par `Codec`) puis un `INSERT` par ligne de
  `Total` à la fin : supprime les `SELECT`/`UPDATE` répétés (SQL modifié, dump de `Total`
  identique). À faire après STATCOMM-A01 ou en reproduisant la persistance des variables.
- Supprimer la double requête `TotResult` du N-1 en mode détail, `Tab4`/`Tab5`, `Tot`, `Frmt`,
  les doubles remises à zéro (`TotA = 0` deux fois).
- Remplacer les noms de tables en dur par `Cbase.Table("TabHisFac")`, `("TabHisFacm")`,
  `("TabParam")` (même texte SQL émis).
- Simplifier le test de saisie des dates (même valeur booléenne).

### Commonalisation avec d'autres fichiers

Mesure (`output/claude/2026-10-24_rework/phase1/tools/dup.py`, lignes hors commentaires) :
les 5 écrans de critères partagent 117 à 172 lignes (ratio 0,60 à 0,80 ; `StatComm` ↔
`StatTypCli` 172/224, ratio 0,80). Fonctions **identiques au caractère près** :
`dateN1` et `Btn_Click` (5 copies : `StatComArt`, `StatFour`, `StatTypCli`, `StatClimo`,
`StatComm`), `dte_GotFocus` (7 copies, + `Histovmo`, `HitCarte`), `dte_KeyPress` (6, +
`HitCarte`), `dteN0_LF`/`dteN1_LF` (4 ; `StatFour` et `Histovmo`/`HitCarte` en variantes).

**Socle proposé : module `.src/Statistiques/StatCommun.module`** (sans `.form`, les handlers
restent dans chaque écran et délèguent) :
- `PeriodeN1(sDate As String) As String` : corps de `dateN1` ;
- `DateSaisie(sTexte As String) As String` : `Cdate_calc` + `Cdate_aff` + repli date du jour,
  `PeriodeInversee(sDeb, sFin) As Boolean` : comparaison `aaaammjj` ; les handlers gardent le
  focus et le message ;
- `TotalCree(sColonnes As String)` : `DROP TABLE IF EXISTS` + `CREATE TABLE` + `Engine()` ;
  partagé avec [`TBord`](../TBord.class/architecture.md), [`HitCarte`](../HitCarte.class/architecture.md)
  et [`Statcai`](../../Caisse/Statcai.class/architecture.md) ; c'est le point unique où une
  future correction de STATCAI-A04 (nom par poste) s'appliquera ;
- `Factures(iSource, sDeb, sFin, Optional sOrdre) As Result` : `Facn`/`Face`/`Fact` →
  `HistoFac`/`HistoFacM`/`union` (utilisé par `StatComm`, `StatTypCli`, `StatComArt`,
  `StatClimo`, `TBord`) ; une variante `LignesFacture(iSource, sNum)` pour `StatClimo` ;
- `Cumul(hCol As Collection, sCle, ...)` : accumulation mémoire décrite ci-dessus.
Côté visualisation, voir [`VisStatComm`](../VisStatComm.class/architecture.md) (`Sens_Aff`
identique dans les 5 `VisStat*`, requête de tri, boucle d'impression).

`StatComm` et `StatTypCli` diffèrent surtout par la clé de regroupement (client/commercial vs
type client) : un `Traitement` paramétré par une fonction de clé est envisageable, mais les
anomalies divergentes (A01 ici, STATTYPCLI-A01) doivent être tranchées d'abord.

### Réduction de portée

- `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` : aucun appelant externe (vérifié par `grep`,
  aucun appel dynamique ; `"Traitement"` n'apparaît que comme libellé de bouton) → `Private`.
  Les handlers `dte_KeyPress`, `Btn_Click`, `dte_GotFocus` restent `Public`.

### Séparation traitement / GUI

- Extraire de `Traitement` une fonction `CalculTotal(sDeb, sFin, sDebN1, sFinN1, iSource,
  bDetail)` sans accès aux contrôles ; le handler lit les contrôles, gère le curseur, les
  messages et l'ouverture de `VisStatComm`. Cette fonction devient testable en gb.test sur une
  base Docker.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Total` : table temporaire (`CREATE TEMPORARY TABLE`, propre à la connexion) ou table par
  poste/session, déclarée dans `db_control.csv` si elle reste physique.
- `remmofac`/`remartfac` en `varchar(10)` : passage en `DECIMAL` (supprime les `Try Val()`).
- Un seul `SELECT … GROUP BY` (client ou commercial) avec `SUM(totfac)` remplacerait toute la
  boucle, si les montants étaient numériques et les tables `HistoFac`/`HistoFacM` unifiées.
