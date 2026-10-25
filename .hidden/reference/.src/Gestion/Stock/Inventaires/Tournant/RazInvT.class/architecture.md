# RazInvT — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class`

## Vue d'ensemble

Écran de **suppression de l'inventaire tournant en cours** : après confirmation, il supprime la
table de travail `Fiches_InvT` (`DROP TABLE IF EXISTS`). Aucun contrôle n'est fait sur l'état de
l'inventaire. Ouvert en modal par
[`Fmenu.Menu233_Click`](../../../../../Communs/Fmenu.class/architecture.md) (`Fmenu.class:1983`).

Copie de [RazInv](../../Fin-annee/RazInv.class/architecture.md) (11 lignes de code communes sur 13,
3 fonctions homonymes sur 3) : seules la clé `Cbase` (`TabInvT`) et la question changent.
L'historique `Fiches_HisInvT` des inventaires tournants **validés** n'est pas touché.

`Fiches_InvT` est créée par [GeninvT](../GeninvT.class/architecture.md) et supprimée aussi par
[ValidinvT](../ValidinvT.class/architecture.md) à la fin de la validation : après une validation,
cet écran n'a plus rien à supprimer.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

Aucune variable membre.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-8 | Public | 1 | 4 | 0 | méthode spéciale |
| `Button2_Click` | 10-14 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 16-23 | Public | 3 | 6 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Me.Center`, `Utils.Observers(Me)`.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. « Quitter ».
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Question « Attention!
  Vous allez effacer l'inventaire tournant en cours », puis `Try Utils.db.Exec("drop Table IF exists
  " & Cbase.Table("TabInvT"))` et « Inventaire effacé ! » inconditionnel (même défaut que
  RAZINV-A01). Partie extractible : le `DROP`.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabInvT")`, `Utils.Observers`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire le `DROP` dans une fonction privée (même SQL).

### Commonalisation avec d'autres fichiers

- Socle commun `Inventaire.Supprimer(sType)` avec [RazInv](../../Fin-annee/RazInv.class/architecture.md),
  [Geninv](../../Fin-annee/Geninv.class/architecture.md), [GeninvT](../GeninvT.class/architecture.md)
  et [ValidinvT](../ValidinvT.class/architecture.md) (même `DROP` en fin de validation).

### Réduction de portée

- Aucune (méthode spéciale et handlers).

### Séparation traitement / GUI

- Voir ci-dessus.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table permanente unique `Fiches_Inv` avec `inv_type` (voir
  [RazInv](../../Fin-annee/RazInv.class/architecture.md)).
