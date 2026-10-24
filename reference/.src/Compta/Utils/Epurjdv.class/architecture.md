# Epurjdv — Architecture

> Source : `.src/Compta/Utils/Epurjdv.class` · Form : `Epurjdv.form`

## Vue d'ensemble

Fenêtre « Epuration du JDV » (journal des ventes), écrite en 2008 : elle devait clore une période
du JDV en **faisant tourner les tables d'écritures** (`Fiches_Mvt` → `Fiches_Mvt1` → … →
`Fiches_Mvt5`, la plus ancienne étant supprimée), recréer une table `Fiches_Mvt` vide, y recopier
(option « Conserver les écritures non lettrées ») les lignes 411 non lettrées ou postérieures à la
clôture, puis décaler les dates de clôture de `Fiches_Parametres`.

**Code mort** : aucun appelant (`grep -rniw Epurjdv .src` ne trouve que le fichier lui-même ; pas
d'entrée dans `Fmenu.form`, pas d'appel par nom dans `Prgm`). La table `Fiches_Mvt` qu'elle
recréerait n'est de plus pas conforme au schéma de référence (`db_control.csv` : colonnes
`export` et `control` absentes, types et index différents). Sa suppression (couple
`.class` + `.form`) est proposée en anomalie EPURJDV-A01.

Nature globale : **mixte** (SQL destructeur dans un handler de bouton).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dtpc` | var | Private |  | String | 29 |
| `Dpc` | var | Private |  | String | 30 |
| `datec` | var | Private |  | String | 31 |
| `datec2` | var | Private |  | String | 32 |
| `dtepc` | var | Private |  | String | 33 |
| `jour` | var | Private |  | String | 34 |
| `son` | var | Private |  | Integer | 35 |
| `Dtecl` | var | Private |  | String | 36 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 38-45 | Public | 1 | 5 | 0 | méthode spéciale |
| `Form_Open` | 47-74 | Public | 4 | 25 | 0 | handler GUI |
| `Aff_date` | 76-88 | Public | 2 | 11 | 0 | portée réductible ? |
| `Button3_Click` | 90-94 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 96-206 | Public | 18 | 106 | 0 | handler GUI |
| `Sauve` | 208-220 | Public | 2 | 10 | 0 | portée réductible ? |
| `Button2_Click` | 222-226 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. `Utils.Observers`, musique,
  centrage.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : mixte]. `SELECT * FROM
  Fiches_Parametres` (sans test `Available`) ; calcule la période proposée à partir de `dteclec1`
  (via `Aff_date`), la date de fin (`dteclec`), `datec` (période en cours `dtepec`, remplacée par le
  mois courant si `dtepp` est vide : test sur une autre colonne que celle lue, à confirmer) et la
  nouvelle date de clôture `Dtecl` (année + 1, préfixe « 20 » en dur).
- **`Aff_date()`** [portée : réductible] [nature : GUI]. Mois suivant de `dtepc` et affichage dans
  `datecl` / `dateprc`.
- **`Button3_Click()`** [handler] : fermeture.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : mixte, CC 18]. Seulement si
  `/dbase/Host` vaut `localhost` ou `127.0.0.1` et si la période est postérieure à la clôture, après
  confirmation :
  1. `Sauve()` (dump) ;
  2. `DROP TABLE IF EXISTS Fiches_Mvt5`, puis `ALTER TABLE Fiches_MvtN RENAME Fiches_MvtN+1`
     (syntaxe sans `TO`, refusée par SQLite) ;
  3. `CREATE TABLE Fiches_Mvt (...)` avec `Utils.db.AutoIncrement("lind")` et `Engine()` : DDL hors
     `LauruxMaj`, non conforme à `db_control.csv` ;
  4. `SELECT * FROM Fiches_Mvt1 WHERE left(compte,3) = '411' AND collectif IS NULL ORDER BY numero` :
     pour chaque ligne postérieure à la clôture ou non lettrée, et si la case est cochée,
     `INSERT INTO Fiches_Mvt` (renumérotation séquentielle, `numerodef = " "`) et
     `DELETE FROM Fiches_Mvt1 WHERE numero = <numéro précédent>` (le dernier numéro n'est jamais
     supprimé, ligne commentée l.187) ; seules les lignes 411 sont recopiées, sans leur contrepartie ;
  5. `Csolde.Recalc_solde()` ;
  6. `UPDATE Fiches_Parametres SET dteclec…dteclec5, dtetdec, dtefedec, numecriture*` (décalage des
     dates de clôture) et `/Soc<XX>/Numdoc_exprt = "0"`.
- **`Sauve()`** [portée : réductible] [nature : traitement]. `mysqldump -h <host> -u <login>
  -p<mdp> Laurux --add-drop-table > ~/Laurux_<AAAA>.sql` (base `Laurux` en dur au lieu de
  `Utils.db.Name`, port ignoré, mot de passe en ligne de commande), puis compression zlib en
  `~/Laurux.<AAAA>.gz`.
- **`Button2_Click()`** [handler] : `Doc.Open("Epurationjdv")`.

## État global utilisé

- `Start.LocalSettings` (`/dbase/Host`, `/Soc<XX>/Numdoc_exprt`), `Start.Son`, `Start.Musique`,
  `Start.Societe`.
- `Utils.db` (Exec, AutoIncrement, Engine, Login, Password), `Utils.Cdate_Aff`,
  `Utils.Cdate_Comp`, `Utils.Cdate_Dbase`, `Csolde.Recalc_solde`.
- Tables : `Fiches_Mvt`, `Fiches_Mvt1` à `Fiches_Mvt5` (DDL), `Fiches_Parametres`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet tant que la fenêtre n'est pas atteignable ; si l'utilisateur décide de la conserver
  (refus d'EPURJDV-A01), le minimum est : `Sauve` → `Utils.DumpBase`, `Cbase.Table` pour les
  tables, portée `Private` de `Aff_date`/`Sauve`.

### Commonalisation avec d'autres fichiers

- `Sauve` : ligne `mysqldump` construite à la main, comme dans
  [`ImpJdv`](../ImpJdv.class/architecture.md), [`ImpSage`](../ImpSage.class/architecture.md) et
  [`SauvesAuto`](../../../Communs/SauvesAuto.module/architecture.md) → helper `Utils.DumpBase`
  (SAUVESAUTO-003).
- La rotation `Fiches_Mvt` → `Fiches_Mvt5` existe aussi dans la clôture
  ([`FClotureAn`](../../Clotures/FClotureAn.class/architecture.md), via `CopieTable`) ; si la
  fenêtre est conservée, elle doit réutiliser ce mécanisme plutôt qu'un `CREATE TABLE` local.

### Réduction de portée

- `Aff_date`, `Sauve` → `Private` (aucun appelant externe, vérifié par `grep`).

### Séparation traitement / GUI

- Sans objet si suppression ; sinon extraire `Epure(bConserve) As Integer` sans contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La rotation physique de 6 tables de même structure (`Fiches_Mvt` à `Fiches_Mvt5`) serait
  remplacée par une table unique avec une colonne d'exercice ; l'épuration deviendrait un simple
  changement d'exercice.
