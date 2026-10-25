# RazClientd — Architecture

> Source : `.src/Archivages/RazClientd.class`

## Vue d'ensemble

`RazClientd` est l'écran **« Epuration des clients divers caisses »** (menu Epurations,
`Fmenu.Menu296`, fenêtre modale). Il supprime de `Fiches_Clid` les fiches dont la date de dernier
passage `ddate` est **strictement antérieure** à la date choisie dans `DateChooser1`, après une
question de confirmation et une sauvegarde `mysqldump`.

⚠️ **Écran sans objet aujourd'hui** : `Fiches_Clid` n'est plus écrite par aucun code. Le seul
lecteur, [`TriclientsD`](../../Caisse/Affichages/TriclientsD.class/architecture.md), est mort depuis
l'intégration de la caisse Laurux-Pos (commit `f442d721`, TRICLIENTSD-A01), et aucun `INSERT`
ni `UPdate` ne vise `TabClid`/`Fiches_Clid` (vérifié par `grep -rn 'TabClid\|Fiches_Clid' .src`,
hors `LauruxMaj`). La purge ne porte donc que sur des données historiques figées ; la table est vide
dans la base de référence `Laurux01`.

Opération destructive : aucune transaction, aucun garde-fou sur la date (date du jour par défaut, à
confirmer). La sauvegarde est écrite dans `~/Sauve/<Base>EffaceD.sql`, **le même fichier que
[`RazDevis`](../RazDevis.class/architecture.md)** (écrasement mutuel), alors que le libellé de l'écran
annonce `Laurux_EffaceCd.sql`.

Écran non instrumenté (`Utils.Observers` absent). Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-7 | Public | 1 | 3 | 0 | méthode spéciale |
| `Button2_Click` | 9-13 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 16-44 | Public | 6 | 21 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.
- **`Button1_Click()`** (CC 4) [portée : nécessaire (handler)] [nature : mixte, partie
  extractible : lecture + suppressions].
  1. Son, puis `Message.Question` ; rien n'est fait si « Non ».
  2. Si « Oui » : création de `~/Sauve`, `Shell "mysqldump --lock-tables=0 -h <Host> -u <Login>
     -p<Password> <Base> --add-drop-table > ~/Sauve/<Base>EffaceD.sql" Wait` (code retour ignoré).
  3. `SELECT * FROM <TabClid> where ddate < &1` (`Format$(DateChooser1.Value, "yyyymmdd")`), puis
     pour chaque ligne `delete FROM <TabClid> where lind = &1` (clé primaire auto-incrémentée :
     suppression exacte).
  4. `Syntheses.Message` + `Message.Info` (« N clients ont été effacés »).
  - Lignes 34-37 : commentaires d'une ancienne renumérotation de `lind` (code mort commenté).
  - Borne `<` stricte sur une colonne `date` : sous MySQL, les clients passés le jour choisi sont
    conservés. Sous SQLite, comparaison texte/entier (affinité NUMERIC) : purge sans effet pour des
    dates stockées en texte (RAZCLIENTD-A03, à confirmer).
  - Pas de table liée : `Fiches_Clid` n'est référencée par aucune autre table.

## État global utilisé

- `Start.son`, `Start.LocalSettings["/dbase/Host"]` ; `Utils.db` (`Login`, `Password`, `Name`,
  `Exec`) ; `Cbase.Table("TabClid")` ; `Syntheses.Message` ; `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Un seul `DELETE FROM <TabClid> WHERE ddate < &1` précédé d'un `SELECT COUNT(*)` (SQL modifié, dump
  identique).
- Supprimer les commentaires de renumérotation (l. 34-37).

### Commonalisation avec d'autres fichiers

- Même squelette que [`RazRlvb`](../RazRlvb.class/architecture.md),
  [`RazDevis`](../RazDevis.class/architecture.md), [`RazHistoFac`](../RazHistoFac.class/architecture.md),
  [`RazHistoFbl`](../RazHistoFbl.class/architecture.md), [`RazHistoTk`](../RazHistoTk.class/architecture.md) :
  module d'aide `Epuration` (voir RAZRLVB-006) et `Utils.DumpBase` (SAUVESAUTO-003).
- Ces commonalisations n'ont de sens que si l'écran est conservé (voir RAZCLIENTD-A01).

### Réduction de portée

- Aucune : `_new` et les handlers restent `Public`.

### Séparation traitement / GUI

- Fonction privée `Purge(sDateLimite) As Integer` appelée par `Button1_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Supprimer la table `Fiches_Clid` (et sa clé `TabClid`) par une migration `LauruxMaj`, après la
  suppression de `TriclientsD` et de cet écran : plus aucun code ne l'alimente.
