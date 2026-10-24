# Deblockbl — Architecture

> Source : `.src/Communs/Deblockbl.class` (+ `Deblockbl.form`)

## Vue d'ensemble

`Deblockbl` est un petit écran de maintenance censé **débloquer un document** resté verrouillé
(verrou d'édition dans `Fiches_Docactif`) à partir de son numéro. Il est lancé uniquement par
[`Prgm`](../Prgm.class/architecture.md) (nom `Deblockbl`). Le libellé du `.form` avertit des
conséquences possibles sur le stock et les statistiques.

⚠️ La suppression vise une colonne `numerobl` qui **n'existe pas** dans `Fiches_Docactif` (colonnes
réelles : `doc_type`, `doc_num`, `user_name`, `process_id`, `machine_id`, `host_id`, `userdb_name`
d'après `db_control.csv`) : l'écran ne peut débloquer aucun document (DEBLOCKBL-A01). La gestion
normale des verrous est faite par [`DocActif`](../DocActif.class/architecture.md)
(`Is_Lock`, `Get_Lock`, `Free_Lock`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-7 | Public | 1 | 3 | 0 | méthode spéciale |
| `Button2_Click` | 9-26 | Public | 3 | 15 | 0 | handler GUI |
| `Button1_Click` | 28-32 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [spéciale] [GUI]. Focus sur `TextBox1`.
- **`Button2_Click()`** [handler] [mixte]. « Débloquer » : si le numéro est saisi,
  `SELECT * FROM Fiches_Bl WHERE numbl = &1` ; s'il existe, `DELETE FROM Fiches_Docactif WHERE
  numerobl = &1` (colonne inexistante → erreur SQL affichée par `DB_Connection.Exec`, à confirmer),
  puis `Message.Info("Le document numéro … est débloqué")` et fermeture ; sinon « Ce numéro de
  document n'existe pas ! » et resélection. Tables en dur (pas de `Cbase.Table`). Seuls les BL /
  factures de `Fiches_Bl` sont reconnus.
- **`Button1_Click()`** [handler] [GUI]. Ferme.

## État global utilisé

- `Utils.db.Exec`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabBl")` et `Cbase.Table("TabActif")` au lieu des noms en dur (SQL identique).

### Commonalisation avec d'autres fichiers

- Le déblocage devrait passer par [`DocActif.Free_Lock`](../DocActif.class/architecture.md) (même
  table, bonnes colonnes) ; cela change le SQL **et** le comportement : voir DEBLOCKBL-A01.
- `Prgm` `RazDocactif` vide toute la table : les deux outils couvrent le même besoin (un document /
  tous les documents).

### Réduction de portée

- Rien (spéciale et handlers).

### Séparation traitement / GUI

- `DocumentExiste(sNum) As Boolean` et `Debloque(sNum)` privés ; le handler garde messages et focus.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune nécessaire : la table a déjà la bonne clé (`doc_type`, `doc_num`).
