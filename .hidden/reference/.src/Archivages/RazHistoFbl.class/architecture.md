# RazHistoFbl — Architecture

> Source : `.src/Archivages/RazHistoFbl.class`

## Vue d'ensemble

`RazHistoFbl` est l'écran **« Epuration des BL fournisseurs »** (sous-menu Epurations,
`Fmenu.Menu261`, modal ; aussi `Prgm` avec le nom `efb`, non modal). Il supprime les **bons de
réception fournisseurs** dont la date `ddate` est strictement antérieure à la date choisie : en-têtes
`Fiches_Entrecpt` (clé `TabEntrecpt`) et lignes `Fiches_Ligrecpt` (clé `TabLigrecpt`). Ces réceptions
sont saisies par `Achat`/`commande1` et validées (rapprochement facture, écritures) par
[`ValidBR`](../../Gestion/Stock/ValidBR.class/architecture.md)/`ValidBR1` (`validee = 1`).

Opération destructive : question, sauvegarde `mysqldump` dans `~/Sauve/<Base>EffaceB.sql`,
`ProgBar` interruptible ; ni transaction ni garde-fou.

⚠️ **Défaut majeur** : la clé de `Fiches_Entrecpt` est `(four, numrecpt)` (n° de BL **du
fournisseur**), mais les deux `DELETE` filtrent sur `numrecpt` seul. Une réception d'un **autre
fournisseur** portant le même numéro est supprimée avec ses lignes, **quelle que soit sa date**
(RAZHISTOFBL-A01, même famille que EDREGUL-A01 / MOULINAGE-A10).

Autres effets : les réceptions **non validées** (`validee = 0`, BL pas encore rapprochés d'une
facture) sont purgées comme les autres (A03, à confirmer) ; le recalcul de stock
[`Cstock`](../../Utils/Cstock.module/architecture.md) somme `Fiches_Ligrecpt` depuis le dernier
inventaire : une purge postérieure au dernier inventaire fausse le stock recalculé (A03).

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
| `Button1_Click` | 16-45 | Public | 7 | 27 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre la fenêtre.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme la fenêtre.
- **`Button1_Click()`** (CC 5) [portée : nécessaire (handler)] [nature : mixte, partie
  extractible : lecture + suppressions].
  1. Son, `Message.Question` ; rien si « Non ».
  2. `~/Sauve`, `Shell "mysqldump … > ~/Sauve/<Base>EffaceB.sql" Wait` (code retour ignoré).
  3. `SELECT * FROM <TabEntrecpt> where ddate < &1` (`Format$(DateChooser1.Value, "yyyymmdd")`).
  4. `ProgBar` (rafraîchie tous les 10) ; pour chaque réception :
     `delete FROM <TabLigrecpt> where numrecpt = &1` puis `delete FROM <TabEntrecpt> where numrecpt = &1`
     (sans `four`, A01). Si deux fournisseurs ont le même numéro **avant** la date, le second
     passage ne trouve plus rien mais compte quand même (`nb` surévalué).
  5. `Syntheses.Message` (« Bons de réception ») et `Message.Info` (« BL fournisseurs ») : libellés
     différents pour le même compte.
  - Borne `<` stricte sur `ddate` (`datetime`) : sous MySQL, les réceptions du jour choisi sont
    conservées. Sous SQLite : purge sans effet pour des dates stockées en texte (A04, à confirmer).
  - Pas de filtre sur `validee` (A03).

## État global utilisé

- `Start.son`, `Start.LocalSettings["/dbase/Host"]` ; `Utils.db` ; `Cbase.Table` ;
  `Syntheses.Message` ; `ProgBar` ; `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Lire `four` avec `numrecpt` (déjà présent dans le `SELECT *`) : nécessaire à la correction de A01 ;
  sans correction, aucun gain de structure n'est possible sans changer le SQL.

### Commonalisation avec d'autres fichiers

- Squelette commun aux six `Raz*` (module `Epuration`, RAZRLVB-006 ; `PurgeEnteteLignes`, voir
  [`RazHistoTk`](../RazHistoTk.class/architecture.md)) et `Utils.DumpBase` (SAUVESAUTO-003).
  La clé composite `(four, numrecpt)` impose que `PurgeEnteteLignes` accepte plusieurs colonnes de
  lien, ou que ce fichier garde sa boucle.

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Fonction privée `Purge(sDateLimite) As Integer`, SQL identique.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Identifiant technique de réception (auto-incrément) référencé par `Fiches_Ligrecpt`, au lieu de la
  clé `(four, numrecpt)` recopiée avec `daterecpt` dans chaque ligne.
- Instantané de stock à la date de purge (ou inventaire automatique) pour que `Cstock` ne dépende
  plus de l'historique complet des réceptions.
