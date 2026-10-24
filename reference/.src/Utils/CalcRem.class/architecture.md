# CalcRem — Architecture

> Source : `.src/Utils/CalcRem.class`

## Vue d'ensemble

`CalcRem` est un **utilitaire de maintenance** (formulaire : « Ce programme va recalculer les
remises MO et articles à partir des lignes de factures », boutons Lancer/Quitter). Il recalcule,
pour chaque facture de l'historique `Fiches_HistoFac`, les totaux de remise main-d'œuvre
(`remmofac`) et articles (`remartfac`) à partir des lignes `Fiches_HistoLigfac` :
remise = Σ (`brut_ligfac` − `netht_ligfac`) par type de ligne `M` ou `A`.

Il n'est accessible que par le lanceur de programmes `Prgm` (menu Admin, saisie du nom
`CalcRem`, `Prgm.class:61`).

Nature : **mixte** (le calcul est dans le handler du bouton).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-7 | Public | 1 | 3 | 0 | méthode spéciale |
| `Button3_Click` | 9-13 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_KeyPress` | 15-19 | Public | 3 | 3 | 0 | handler GUI |
| `Button2_Click` | 21-53 | Public | 7 | 30 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Centre le formulaire. Ne charge pas
  le son (`Music.Load` absent).
- **`Button3_Click()`** [handler] : fermeture.
- **`Button2_KeyPress()`** [handler] : Entrée/Retour → `Button2_Click`.
- **`Button2_Click()`** (CC 7) [portée : nécessaire, handler] [nature : mixte, calcul extractible].
  1. `SELECT * FROM Cbase.Table("TabHisLigFac") ORDER BY num_ligfac` (toutes les lignes, en mémoire).
  2. Parcours `Repeat … Until MoveNext()` avec rupture sur `num_ligfac` : à chaque changement de
     facture, `SELECT` de l'entête dans `Cbase.Table("TabHisFac")` puis `UPDATE … SET remmofac,
     remartfac WHERE numfac = &3` (montants passés par `Utils.PointBase`).
  3. Cumul par ligne : type `M` → `Remmo`, type `A` → `Remart` (conversion
     `Val(Utils.cpoint(...))`, cumul stocké dans une `String`).
  4. `Music.Play` (sans `Music.Load` ni test de `Start.son`) puis « Traitement terminé ! ».
  ⚠️ **La dernière facture n'est jamais mise à jour** : l'`UPDATE` n'a lieu qu'au changement de
  numéro, il n'y a pas de traitement après la boucle.
  ⚠️ Les cumuls Float sont convertis implicitement en chaîne sans arrondi (ex. `0.30000000000000004`)
  et écrits dans des colonnes `varchar(10)` (`db_control.csv:762-763`) : troncature, voire erreur
  « Data too long » en mode strict MariaDB (à confirmer).
  Les factures de rétrocession (`Fiches_HistoFacM`/`Fiches_HistoLigfacM`) ne sont pas traitées.
  Le `Me.Mouse = Mouse.Wait` est positionné après la requête principale (la plus longue).

## État global utilisé

- `Utils.db`, `Cbase.Table("TabHisLigFac")`, `Cbase.Table("TabHisFac")`, `Utils.PointBase`,
  `Utils.cpoint`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire le calcul dans une fonction `RecalculeRemises() As Integer` (nombre de factures mises à
  jour) sans accès aux contrôles.
- Le `SELECT` d'entête avant chaque `UPDATE` est inutile (un `UPDATE` sans ligne correspondante ne
  fait rien) ; à conserver tant que le log SQL sert de référence de replay.

### Commonalisation avec d'autres fichiers

- Le calcul de `remmofac`/`remartfac` existe aussi à l'enregistrement d'une facture
  (`ObjFacB.class:1039`, `Moulinage.class:2761-2762`) : une fonction commune « remises d'une
  facture » garantirait la cohérence entre la saisie et ce recalcul.
- Même patron « utilitaire Admin lancé par `Prgm` » que [`Calcsolde`](../Calcsolde.class/architecture.md).

### Réduction de portée

- Aucune : seuls des handlers et le constructeur sont publics.

### Séparation traitement / GUI

- Voir `RecalculeRemises()` ci-dessus ; le handler garde la souris d'attente, le son et le message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `remmofac`/`remartfac` sont des `varchar(10)` dans `Fiches_HistoFac` alors que la migration
  historique (`LauruxMaj.module:1294-1295`) les créait en `decimal(12,2)` : un retour au type
  décimal supprimerait les problèmes de format et de troncature.
- Le recalcul tiendrait en un seul `UPDATE … JOIN (SELECT num_ligfac, SUM(…) … GROUP BY
  num_ligfac)` côté base.
