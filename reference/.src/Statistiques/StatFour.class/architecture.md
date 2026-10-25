# StatFour — Architecture

> Source : `.src/Statistiques/StatFour.class`

## Vue d'ensemble

`StatFour` est l'écran de **critères et de calcul** du « Chiffre d'affaire fournisseur » (menu
Statistiques › « Chiffre d'affaire fournisseur », `Fmenu.Menu169_Click`, `StatFour.show` :
auto-instance non modale). C'est le seul écran de la famille qui porte sur les **achats** : il
cumule le montant des réceptions `Fiches_Entrecpt` (champ `montant`, colonne `ddate`) par
fournisseur sur la période N et sur la même période N-1, dans la table de travail `Total`
(`cdfour`, `nmfour`, `montant`, `montant1`), puis ouvre
[`VisStatFour`](../VisStatFour.class/architecture.md). Pas de choix de source (pas de `HBox3`).

Variante du squelette commun : les messages passent par `Balloon.Warning` (au lieu de
`Message.Warning`), le son est commenté, et la date du jour de repli est formatée
`"dd/mm/yyyy"` (au lieu de `"dd.mm.yyyy"`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | VisStatFour | 29 |
| `Dte1` | var | Private |  | String | 30 |
| `Dte2` | var | Private |  | String | 31 |
| `Tot` | var | Private |  | Integer | 32 |
| `son` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-53 | Public | 1 | 15 | 0 | méthode spéciale |
| `Dte_KeyPress` | 55-76 | Public | 9 | 18 | 0 | handler GUI |
| `DateN1` | 78-85 | Public | 1 | 6 | 0 | portée réductible ? |
| `Btn_Click` | 87-99 | Public | 3 | 9 | 0 | handler GUI |
| `Dte_GotFocus` | 104-110 | Public | 1 | 5 | 0 | handler GUI |
| `DteN0_LF` | 115-129 | Public | 3 | 13 | 0 | portée réductible ? |
| `DteN1_LF` | 134-154 | Public | 5 | 18 | 0 | portée réductible ? |
| `Traitement` | 156-236 | Public | 17 | 77 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie des dates

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte] : comme
  [`StatComm`](../StatComm.class/architecture.md) (`dteclec1`, `Calc_mois`, `Observers` une fois),
  sans `Music.Load` ni option matériel ; `Tot` et `Frmt` jamais relus.
- **`Dte_KeyPress()`**, **`Btn_Click()`**, **`Dte_GotFocus()`** [handlers, `Public` obligatoire]
  [nature : GUI] : identiques aux autres `Stat*` (casse différente du nom, sans effet en Gambas).
- **`DateN1()`** [portée : réductible] [nature : calcul] : `Dte1`/`Dte2` = année − 1 (identique).
- **`DteN0_LF()` / `DteN1_LF()`** [portée : réductible] [nature : GUI] : comme les autres, mais
  repli `Format$(Now, "dd/mm/yyyy")` (format incohérent avec le reste de l'écran, branche
  vraisemblablement jamais atteinte : `Cdate_aff` ne renvoie pas `"00.00.0:00"` à confirmer) et
  `Balloon.Warning` si la fin précède le début ; `If son Then 'Music.Play` vide.

### Calcul

- **`Traitement()`** (CC 17, max) [portée : réductible] [nature : mixte].
  1. `DROP TABLE IF EXISTS Total` + `CREATE TABLE Total (cdfour Char(8) NOT NULL, nmfour
     Char(50), montant Decimal(12,2), montant1 Decimal(12,2), PRIMARY KEY (cdfour))` + `Engine()`.
  2. `SELECT * FROM Fiches_Entrecpt WHERE ddate >= &1 AND ddate <= &2` (toutes les réceptions,
     **validées ou non** : `validee` n'est pas filtré, intention à confirmer).
  3. Pour **chaque réception N** : `Montant = montant` (Decimal NULL → erreur de type probable) ;
     cumul par `UPDATE` ou, à la première réception du fournisseur, lecture du nom
     (`SELECT * FROM Fiches_Four WHERE fo_code = four`) et `INSERT`. `Nmfour` n'est **pas remis
     à zéro** : un fournisseur supprimé reçoit le nom du fournisseur précédent (STATFOUR-A03).
  4. **Toujours dans la boucle N** : `SELECT * FROM Fiches_Entrecpt WHERE four = &3 AND ddate`
     dans la période N-1, et chaque réception N-1 est **ajoutée** à `montant1` : le N-1 d'un
     fournisseur est compté autant de fois qu'il a de réceptions en N (l. 196-213,
     STATFOUR-A01). La branche `INSERT INTO Total (cdfour, montant1, nmfour) VALUES (&1, &2)`
     (3 colonnes, 2 valeurs : SQL invalide) est **inatteignable** (la ligne vient d'être créée).
     Sans réception N-1 : `UPDATE … montant1 = 0`.
  5. `SELECT * FROM Total` vide → `Message.Warning`, sinon `New VisStatfour(Me, Start.Societe,
     Son, DteN0, DteN1)`.
  Tables : `Fiches_Entrecpt`, `Fiches_Four`, `Fiches_Parametres` (en dur), `Total`.

## État global utilisé

- `Start.LocalSettings["/Coul/Fnets"]` (inutilisé), `Start.Societe`, `Start.Son`.
- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.Cdate_*`, `Utils.SetEditColor`,
  `Utils.FColr`.
- Table de travail partagée `Total` (STATFOUR-A05).

## Propositions d'amélioration

### Réécriture / refactorisation

- Calculer N et N-1 en deux passes indépendantes (après STATFOUR-A01), cumul en mémoire puis
  `INSERT` (SQL modifié, dump identique une fois A01 tranchée).
- Supprimer la branche `INSERT` inatteignable, `Tot`, `Frmt`, les `If son Then` vides,
  `montant1 = Montant1 + 0`.
- Noms de tables en dur → `Cbase.Table("TabEntrecpt"/"TabFour"/"TabParam")`.

### Commonalisation avec d'autres fichiers

- Socle `StatCommun.module` (voir [StatComm](../StatComm.class/architecture.md)) : dates
  (`DateSaisie` doit accepter la variante `Balloon` : le handler garde l'affichage),
  `TotalCree`, `PeriodeN1`. `dup.py` : 117 à 127 lignes communes avec les 4 autres `Stat*`.
- Le schéma « montant N / montant N-1 / % » est le même que [`StatTypCli`](../StatTypCli.class/architecture.md)
  (même défaut A01) : une fonction commune `CumulN1(…)` corrigerait les deux.

### Réduction de portée

- `DateN1`, `DteN0_LF`, `DteN1_LF`, `Traitement` → `Private` (vérifié par `grep`).

### Séparation traitement / GUI

- Extraire `CalculTotal(sDeb, sFin, sDebN1, sFinN1)` sans contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Total` temporaire ou par poste ; un `SELECT four, SUM(montant) … GROUP BY four` par période
  suffirait (`montant` est déjà décimal).
