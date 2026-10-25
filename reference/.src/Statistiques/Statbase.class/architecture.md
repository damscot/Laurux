# Statbase — Architecture

> Source : `.src/Statistiques/Statbase.class`

## Vue d'ensemble

`Statbase` est l'écran « Statistiques utilisation base Laurux » (menu Statistiques,
`Fmenu.Menu250_Click`, `Statbase.ShowModal()` : auto-instance modale). Malgré son nom, ce
**n'est pas une classe de base** de la famille statistique : aucune classe n'en hérite (`grep
Inherits` : aucun résultat) et elle n'est référencée que par `Fmenu`. Elle affiche dix
compteurs (`SELECT Count(*)`) dans des `TextLabel` :

| Contrôle | Libellé du `.form` | Table comptée |
|---|---|---|
| `TextLabel1` | Nombre de produits | `Cbase.Table("TabArt")` = `Fiches_Art` |
| `TextLabel2` | Nombre de MO | `TabMo` = `Fiches_Mo` |
| `TextLabel3` | Nombre de clients | `TabCli` = `Fiches_Cli` |
| `TextLabel4` | Nombre de fournisseurs | `TabFour` = `Fiches_Four` |
| `TextLabel5` | Nombre de produits composés | `TabPrdComp` = `Fiches_PrdComp` |
| `TextLabel6` | Nombre de factures archivées | `TabHisFac` = `Fiches_HistoFac` (sans `Fiches_HistoFacM`) |
| `TextLabel7` | Nombre de tickets de caisse **archivés** | `TabEntTck` = `Fiches_EntTicketz` (tickets **en cours**) |
| `TextLabel8` | Nombre d'écritures sur l'exercice en cours | `TabMvt` = `Fiches_Mvt` |
| `TextLabel9` | Nombre de bl en cours | `TabBl` avec `type = "B"` |
| `TextLabel10` | Nombre de devis en cours | `TabBl` avec `type = "D"` |

Nature globale : **mixte** (SQL de lecture + affichage) ; aucune écriture en base.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-44 | Public | 1 | 29 | 0 | méthode spéciale |
| `Button2_Click` | 46-50 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : mixte]. Lit `/Coul/Focus` dans
  `Coulfc` et `/Coul/Fnets` dans `Frmt` (**jamais utilisés**), `Utils.Observers(Me)` une fois,
  puis 10 requêtes `SELECT Count(*) as nb FROM …` (les deux dernières paramétrées par `&1`) et
  affectation de `rStat!nb` à chaque `TextLabel`. Pas de test `Available` (un `COUNT(*)` renvoie
  toujours une ligne). Partie extractible : la liste des dix comptages.
- **`Button2_Click()`** [handler, « Quitter »] [nature : GUI] : `Me.Close`.

## État global utilisé

- `Start.LocalSettings["/Coul/Focus"]`, `["/Coul/Fnets"]` (lus, inutilisés).
- `Utils.FColr`, `Utils.Observers`, `Utils.db`, `Cbase.Table`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les 10 blocs par une table de correspondance (clé `Cbase`, filtre `type`, contrôle)
  parcourue en boucle ; même SQL émis, dans le même ordre.
- Supprimer `Coulfc`, `Frmt`.

### Commonalisation avec d'autres fichiers

- Aucune avec la famille `Stat*`/`VisStat*` (ni table `Total`, ni période). Un utilitaire
  `Utils.Compte(sCleTable, Optional sWhere, …) As Long` serait réutilisable ailleurs, mais aucun
  autre écran du lot ne fait de comptage simple : non proposé en rework.

### Réduction de portée

- Rien à réduire (`_new` et un handler).

### Séparation traitement / GUI

- `Compteurs() As Collection` (ou `Long[]`) sans contrôles, appelé par `_new` qui remplit les
  `TextLabel`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune nécessaire.
