# StatComArt — Architecture

> Source : `.src/Statistiques/StatComArt.class`

## Vue d'ensemble

`StatComArt` est l'écran de **critères et de calcul** du CA « Articles par commercial (sur
factures archivées exclusivement) » (menu Statistiques › « CA articles/commerciaux »,
`Fmenu.Menu314_Click`, `StatComArt.Show()` : auto-instance non modale). Période `DteN0`/`Dten1`,
source `Fact`/`Face`/`Facn` (`HBox3` masquée et `Facn` forcé sans option matériel), bouton
**Traitement** : la table de travail `Total` reçoit une ligne par couple (article, commercial)
avec le net HT et la quantité cumulés sur les lignes article (`typel_ligfac = "A"`) des
factures des clients ayant un commercial, puis [`VisStatComArt`](../VisStatComArt.class/architecture.md)
est ouvert. Pas de comparaison N-1 (les dates N-1 sont calculées pour rien).

L'en-tête de commentaire porte le nom `StatComm.class` et le titre « Chiffre d'affaires par
commerciaux » (copie non mise à jour).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | VisStatcomArt | 27 |
| `dte1` | var | Private |  | String | 28 |
| `dte2` | var | Private |  | String | 29 |
| `Tot` | var | Private |  | Integer | 30 |
| `son` | var | Private |  | Integer | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-56 | Public | 2 | 20 | 0 | méthode spéciale |
| `dte_KeyPress` | 58-79 | Public | 9 | 18 | 0 | handler GUI |
| `dateN1` | 81-88 | Public | 1 | 6 | 0 | portée réductible ? |
| `Btn_Click` | 90-102 | Public | 3 | 9 | 0 | handler GUI |
| `dte_GotFocus` | 107-113 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LF` | 118-132 | Public | 3 | 13 | 0 | portée réductible ? |
| `dteN1_LF` | 137-158 | Public | 6 | 20 | 0 | portée réductible ? |
| `Traitement` | 160-229 | Public | 16 | 66 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie des dates

- **`_New()`**, **`dte_KeyPress()`**, **`Btn_Click()`**, **`dte_GotFocus()`**,
  **`dteN0_LF()`**, **`dteN1_LF()`** : identiques à [`StatComm`](../StatComm.class/architecture.md)
  (handlers `Public` obligatoires, `dteN0_LF`/`dteN1_LF` [portée : réductible] [nature : GUI]).
- **`dateN1()`** [portée : réductible] [nature : calcul] : calcule `dte1`/`dte2` (N-1)… **jamais
  lus** dans ce fichier : code mort fonctionnel (appelé par 3 fonctions sans effet utile).

### Calcul

- **`Traitement()`** (CC 16) [portée : réductible] [nature : mixte].
  1. `DROP TABLE IF EXISTS Total` + `CREATE TABLE Total (cdartfac Char(15) NOT NULL, lbartfac
     Char(35), nethtfac, qte, totfac Decimal(12,2), commercial Char(2), PRIMARY KEY (cdartfac,
     commercial))` + `Engine()` ; la colonne `totfac` n'est jamais écrite.
  2. Factures N : `Fiches_HistoFac` (`order by datefac`), `Fiches_HistoFacM`, ou `union`.
  3. Par facture : `SELECT cli_comm FROM <TabCli> WHERE cli_code = cdclifac` **sans test
     `Available`** (l. 191-192 : client supprimé → erreur, STATCOMART-A04) ; si `cli_comm` non nul,
     lignes `SELECT * FROM Fiches_HistoLigfac WHERE num_ligfac = numfac AND typel_ligfac = "A"`
     — **toujours dans `HistoLigfac`, même pour une facture d'entretien** (`Tab5` =
     `Fiches_HistoLigfacM` déclarée, jamais utilisée : STATCOMART-A02).
  4. Par ligne : `netht = Val(cpoint(netht_ligfac))`, `qte = Val(cpoint(qte_ligfac))` ;
     `SELECT * FROM Total WHERE cdartfac AND commercial` ; si présent : cumul et
     `UPdate Total SET cdartfac = &1, lbartfac = &2, nethtfac = &3, qte = &4 WHERE cdartfac = &1
     AND commercial = &4` avec les arguments `(code, libellé, netht, cli_comm, qte)` : **`qte`
     reçoit le code du commercial** (`&4`) au lieu de la quantité cumulée (`&5` non utilisé)
     (l. 202, STATCOMART-A01) ; sinon `INSERT` correct.
  5. `SELECT * FROM Total` vide → « Aucune donnée pour cette période ! », sinon `New
     VisStatComArt(Me, Start.Societe, son, dteN0, dteN1)`.
  Tables : `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_HistoLigfac` (en dur),
  `Cbase.Table("TabCli")`, `Total`. Volume : 1 requête client par facture + 2 par ligne.

### Sources de ventes

Factures archivées seulement (voulu) ; la ventilation par commercial suit le commercial
**actuel** du client (`cli_comm`), pas celui au moment de la vente. Comparaison avec les autres
écrans : [StatComm](../StatComm.class/architecture.md).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/Coul/Fnets"]` (inutilisé), `Start.Societe`,
  `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.Cdate_*`, `Utils.cpoint`,
  `Utils.SetEditColor`, `Utils.FColr`.
- Table de travail partagée `Total` (STATCOMART-A03).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `dte1`, `dte2`, `dateN1` et ses 3 appels, `Tot`, `Frmt`, `Tab5`, `netht = 0`.
- Noms de tables en dur → `Cbase.Table("TabHisFac"/"TabHisFacm"/"TabHisLigFac"/"TabParam")`.
- Accumulation en mémoire (clé article + commercial) puis `INSERT` : SQL modifié, dump identique
  **après** STATCOMART-A01 (sinon il faut reproduire `qte = commercial`).
- Corriger l'en-tête de commentaire (nom du fichier).

### Commonalisation avec d'autres fichiers

- Socle `StatCommun.module` (voir [StatComm](../StatComm.class/architecture.md)) : dates,
  `TotalCree`, `Factures(iSource, …)` et `LignesFacture(iSource, sNum, sType)` partagé avec
  [`StatClimo`](../StatClimo.class/architecture.md) (qui, lui, lit bien `HistoLigfacM`).
  `dup.py` : 134 lignes communes avec `StatComm` et `StatClimo`, 132 avec
  [`StatTypCli`](../StatTypCli.class/architecture.md), 117 avec [`StatFour`](../StatFour.class/architecture.md).

### Réduction de portée

- `dateN1` (supprimée), `dteN0_LF`, `dteN1_LF`, `Traitement` → `Private` (vérifié par `grep`).

### Séparation traitement / GUI

- Extraire `CalculTotal(sDeb, sFin, iSource)` sans contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Colonne `totfac` de `Total` inutile ; `Total` temporaire ou par poste.
- `qte_ligfac`/`netht_ligfac` en `varchar` : un `SUM` SQL direct (`GROUP BY code_ligfac,
  cli_comm`) serait possible avec des colonnes numériques.
- Mémoriser le commercial dans l'entête de facture pour une statistique historique fidèle.
