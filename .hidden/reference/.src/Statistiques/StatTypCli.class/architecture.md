# StatTypCli — Architecture

> Source : `.src/Statistiques/StatTypCli.class`

## Vue d'ensemble

`StatTypCli` est l'écran de **critères et de calcul** du « Chiffre d'affaires par type clients
(sur factures archivées exclusivement) » (menu Statistiques › « Chiffre d'affaire type client »,
`Fmenu.Menu176_Click`, `StatTypCli.Show` : auto-instance non modale). Même structure que
[`StatComm`](../StatComm.class/architecture.md) (ratio de similarité 0,80) : période
`DteN0`/`Dten1`, source `Fact`/`Face`/`Facn` (`HBox3` masquée sans option matériel), bouton
**Traitement** qui remplit la table de travail `Total` (une ligne par type client
`Fiches_Typec`, `*******`/« Indéfini » pour les clients sans type) puis ouvre
[`VisStatTypCli`](../VisStatTypCli.class/architecture.md).

Nature globale : **mixte** (calcul SQL et lecture des contrôles dans `Traitement`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | VisStatTypCli | 28 |
| `dte1` | var | Private |  | String | 29 |
| `dte2` | var | Private |  | String | 30 |
| `Tot` | var | Private |  | Integer | 31 |
| `son` | var | Private |  | Integer | 32 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-57 | Public | 2 | 20 | 0 | méthode spéciale |
| `dte_KeyPress` | 59-80 | Public | 9 | 18 | 0 | handler GUI |
| `dateN1` | 82-89 | Public | 1 | 6 | 0 | portée réductible ? |
| `Btn_Click` | 91-103 | Public | 3 | 9 | 0 | handler GUI |
| `dte_GotFocus` | 108-114 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LF` | 119-133 | Public | 3 | 13 | 0 | portée réductible ? |
| `dteN1_LF` | 138-159 | Public | 6 | 20 | 0 | portée réductible ? |
| `Traitement` | 161-277 | Public | 25 | 112 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie des dates

- **`_New()`**, **`dte_KeyPress()`**, **`dateN1()`**, **`Btn_Click()`**, **`dte_GotFocus()`**,
  **`dteN0_LF()`**, **`dteN1_LF()`** : **identiques** à celles de
  [`StatComm`](../StatComm.class/architecture.md) (voir sa description) : lecture de `dteclec1`
  dans `Fiches_Parametres`, `Utils.Observers(Me)` une fois, période par défaut du mois suivant la
  dernière clôture à aujourd'hui, calcul N-1 par chaîne (`dateN1`, [portée : réductible]
  [nature : calcul]), normalisation des dates (`dteN0_LF`/`dteN1_LF`, [portée : réductible]
  [nature : GUI]), handlers de groupe `Dte`/`Btn` ([handlers, `Public` obligatoire] [nature :
  GUI]). `Tot = 40` et `Frmt` jamais relus.

### Calcul

- **`Traitement()`** (CC 25, max) [portée : réductible] [nature : mixte].
  1. `DROP TABLE IF EXISTS Total` puis `CREATE TABLE Total (cdtypclifac Char(8) NOT NULL,
     nmtypclifac Char(25), brutfac, rmfac, totfac, totfacn1 Decimal(12,2), PRIMARY KEY
     (cdtypclifac))` + `Engine()`.
  2. Période N : `SELECT * FROM Fiches_HistoFac` / `Fiches_HistoFacM` / `union` (noms en dur)
     sur `datefac`.
  3. Par facture : `SELECT * FROM Fiches_Cli WHERE cli_code = cdclifac` puis, si `cli_typec`
     non nul, `SELECT * FROM Fiches_Typec WHERE code = cli_typec` — **aucun des deux n'est testé
     `Available`** (l. 203-207) : client ou type supprimé → erreur d'exécution
     (STATTYPCLI-A03). Remises `remmofac`/`remartfac` par `Try Val()` + repli ; `TotA =
     Val(cpoint(totfac))` ; `BrutA = TotA + remises` ; cumul dans `Total` (`UPdate` dont le
     paramètre `&3` = `pnmclifac` est passé mais non utilisé, ou `INSERT`).
  4. **N-1 dans la boucle des factures N** : pour **chaque facture N** du client, toutes les
     factures N-1 du même client (`SELECT * FROM Fiches_HistoFac WHERE cdclifac = &3 AND datefac
     …`) sont ajoutées à `totfacn1` du type (l. 239-255). Un client ayant k factures en N voit
     son N-1 compté **k fois** (STATTYPCLI-A01) ; un client sans facture en N n'a pas de N-1.
     Le N-1 lit toujours `Fiches_HistoFac` seule, même si `Face`/`Fact` est choisi
     (STATTYPCLI-A02). `If IsNull(TotA)` (Float) est toujours faux.
  5. `SELECT * FROM Total` : vide → « Aucune donnée pour cette période ! », sinon `New
     VisStatTypCli(Me, Start.Societe, son, dteN0, dteN1)`.
  Tables : `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Cli`, `Fiches_Typec` (toutes en dur),
  `Total`.

### Sources de ventes

Factures archivées seulement (libellé du `.form`) : pas de BL en cours ni de tickets, comme
`StatComm` et `StatComArt`, à la différence de `StatClimo` (BL inclus). Le N-1 ignore les
factures d'entretien alors que `StatComm` les prend (tableau comparatif dans
[StatComm](../StatComm.class/architecture.md)).

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/Coul/Fnets"]` (inutilisé), `Start.Societe`,
  `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.Cdate_calc/aff/Dbase`, `Utils.cpoint`,
  `Utils.SetEditColor`, `Utils.FColr`.
- Table de travail partagée `Total` (STATTYPCLI-A04 ; [STATCAI-A04](../../Caisse/Statcai.class/rework.md)
  cite `StatTypCli.class:188`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Sortir le calcul N-1 de la boucle N (une seule passe sur les factures N-1, après correction
  de A01), accumulation en mémoire puis `INSERT` (SQL modifié, dump identique une fois A01
  tranchée).
- Remplacer les noms de tables en dur par `Cbase.Table("TabHisFac"/"TabHisFacm"/"TabCli"/
  "TabTypec"/"TabParam")` (texte SQL identique).
- Supprimer `Tot`, `Frmt`, `If IsNull(TotA)`, `TotA + 0`, l'argument inutilisé `&3`.

### Commonalisation avec d'autres fichiers

- Socle `StatCommun.module` décrit dans [StatComm](../StatComm.class/architecture.md) :
  `PeriodeN1`, `DateSaisie`, `TotalCree`, `Factures(iSource, …)`. `StatTypCli` partage 172
  lignes avec `StatComm`, 132 avec [`StatComArt`](../StatComArt.class/architecture.md), 143 avec
  [`StatClimo`](../StatClimo.class/architecture.md), 127 avec [`StatFour`](../StatFour.class/architecture.md).
- Le calcul des remises (`remmofac` + `remartfac` par `Try Val()` + repli) est copié dans
  `StatComm` : fonction `StatCommun.RemisesFacture(rFac) As Float`.

### Réduction de portée

- `dateN1`, `dteN0_LF`, `dteN1_LF`, `Traitement` → `Private` (aucun appelant externe, vérifié).

### Séparation traitement / GUI

- Extraire `CalculTotal(sDeb, sFin, sDebN1, sFinN1, iSource)` sans contrôles ; `Traitement`
  conserve curseur, messages et ouverture de `VisStatTypCli`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Total` temporaire ou par poste ; remises en `DECIMAL` ; un `SELECT … JOIN Fiches_Cli …
  GROUP BY cli_typec` remplacerait la boucle.
