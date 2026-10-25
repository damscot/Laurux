# StatClimo — Architecture

> Source : `.src/Statistiques/StatClimo.class`

## Vue d'ensemble

`StatClimo` est l'écran de **critères et de calcul** du « Chiffre d'affaires produits/mo par
client » (menu Statistiques › « Chiffre d'affaire produits-Mo par client »,
`Fmenu.Menu117_Click` ; `Menu201_Click` l'ouvre aussi mais `Menu201` est un élément sans texte,
vraisemblablement un séparateur jamais cliqué). Période `DteN0`/`Dten1`, source
`Fact`/`Face`/`Facn` (`HBox3` masquée sans option matériel) et case **« Inclure les BL »**
(`Bl`, cochée par défaut). **Traitement** remplit `Total` (une ligne par client : brut et remise
des lignes article `A` et main d'oeuvre `M`) à partir des **lignes** des factures archivées
**et** des BL/factures en cours de `Fiches_Bl`/`Fiches_BlM`, puis ouvre
[`VisStatClimo`](../VisStatClimo.class/architecture.md). Pas de N-1.

C'est le seul écran de la famille qui intègre les documents en cours (`Fiches_Bl`), comme
[`TBord`](../TBord.class/architecture.md) (hors lot) ; `StatComm`, `StatTypCli` et `StatComArt`
se limitent aux factures archivées (tableau comparatif dans [StatComm](../StatComm.class/architecture.md)).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | VisStatClimo | 27 |
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
| `Traitement` | 161-308 | Public | 37 | 139 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie des dates

- **`_New()`**, **`dte_KeyPress()`**, **`Btn_Click()`**, **`dte_GotFocus()`**,
  **`dteN0_LF()`**, **`dteN1_LF()`** : identiques à [`StatComm`](../StatComm.class/architecture.md)
  (handlers `Public` obligatoires ; `dteN0_LF`/`dteN1_LF` [portée : réductible] [nature : GUI]).
- **`dateN1()`** [portée : réductible] [nature : calcul] : calcule `dte1`/`dte2`, **jamais lus**
  ici (pas de N-1) : code mort fonctionnel.

### Calcul

- **`Traitement()`** (CC 37, max) [portée : réductible] [nature : mixte].
  1. `DROP TABLE IF EXISTS Total` + `CREATE TABLE Total (cdclifac Char(8) NOT NULL, nmclifac
     Char(25), pnmclifac Char(25), TotA, TotM, RemP, RemMo Decimal(12,2), PRIMARY KEY
     (cdclifac))` + `Engine()`.
  2. **Factures archivées** : entêtes `Fiches_HistoFac` / `Fiches_HistoFacM` / `union` ; pour
     chaque facture, lignes `Fiches_HistoLigfac` / `Fiches_HistoLigfacM` / `union` des deux
     **sur le même numéro** (`Fact` : une facture `HistoFac` récupère aussi les lignes d'une
     facture d'entretien de même numéro, et réciproquement ; `UNION` supprime en plus les lignes
     strictement identiques — STATCLIMO-A03). Lignes `A` : `TotA += Val(cpoint(brut))`, `RemP +=
     brut − netht` ; lignes `M` : même calcul **sans `cpoint`** (`Val(brut_ligfac)`, l. 222-223) :
     un montant stocké avec un point (`"12.50"`) donne `Val = Null` et une erreur « Type
     mismatch » (vérifié avec gbs3 en locale fr_FR, STATCLIMO-A04). Cumul par client
     (`SELECT` puis `UPdate` ou `INSERT`, nom et prénom de l'entête).
  3. **Documents en cours** (`Fiches_Bl` / `Fiches_BlM` / `union`) :
     - `Bl` coché (commentaire « Sans les BL », inversé) : `WHERE datebl >= &1 AND datebl <= &2
       AND type = &3 OR type = &4` avec `"F"`, `"B"` : sans parenthèses, la condition vaut
       `(période ET type F) OU type B` → **tous les BL de type `B`, quelle que soit leur date**
       (l. 247-249, STATCLIMO-A01) ;
     - `Bl` décoché : type `F` dans la période.
     Lignes `Fiches_Ligbl`/`Fiches_LigblM`/`union` (mêmes remarques), calcul A/M avec `cpoint`,
     cumul sur `cdclibl`.
  4. `SELECT * FROM Total` vide → message, sinon `New VisStatClimo(Me, Start.Societe, son,
     dteN0, dteN1)`.
  Tables : `Fiches_HistoFac(M)`, `Fiches_HistoLigfac(M)`, `Fiches_Bl(M)`, `Fiches_Ligbl(M)`,
  `Fiches_Parametres` (toutes en dur), `Total`. Le recouvrement entre factures en cours (`type =
  "F"` dans `Fiches_Bl`) et factures archivées n'est pas contrôlé : double comptage possible si
  une facture archivée reste aussi en `Fiches_Bl` (à confirmer avec le cycle de facturation).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/Coul/Fnets"]` (inutilisé), `Start.Societe`,
  `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.Cdate_*`, `Utils.cpoint`,
  `Utils.SetEditColor`, `Utils.FColr`.
- Table de travail partagée `Total` (STATCLIMO-A05).

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser le calcul A/M d'un ensemble de lignes (dupliqué pour factures et BL) dans
  `CumulLignes(rLig, sSuffixe, …)` ; préserver l'absence de `cpoint` sur les lignes `M` des
  factures tant que A04 n'est pas tranchée.
- Supprimer `dte1`, `dte2`, `dateN1`, `Tot`, `Frmt`, les commentaires de code.
- Noms de tables en dur → `Cbase.Table("TabHisFac"/"TabHisFacm"/"TabHisLigFac"/"TabHisLigFacm"/
  "TabBl"/"TabBlM"/"TabLigbl"/"TabLigblM"/"TabParam")`.
- Corriger le commentaire inversé « Sans les BL » / « avec les BL ».

### Commonalisation avec d'autres fichiers

- Socle `StatCommun.module` ([StatComm](../StatComm.class/architecture.md)) : dates,
  `TotalCree`, `Factures(iSource, …)`, `LignesFacture(iSource, sNum)` (partagé avec
  [`StatComArt`](../StatComArt.class/architecture.md)) et `Documents(iSource, bAvecBl, …)`
  partagé avec [`TBord`](../TBord.class/architecture.md). `dup.py` : 121 à 149 lignes communes
  avec les autres `Stat*`.

### Réduction de portée

- `dteN0_LF`, `dteN1_LF`, `Traitement` → `Private` ; `dateN1` supprimée (code mort).

### Séparation traitement / GUI

- Extraire `CalculTotal(sDeb, sFin, iSource, bAvecBl)` sans contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Montants des lignes en `DECIMAL` (supprime `cpoint`/`Val`) ; `SUM … GROUP BY` client.
- Numérotation distincte ou table unique pour factures et factures d'entretien (lève
  l'ambiguïté de l'`union` par numéro).
