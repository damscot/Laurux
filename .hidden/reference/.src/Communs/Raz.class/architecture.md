# Raz — Architecture

> Source : `.src/Communs/Raz.class` (+ `Raz.form`)

## Vue d'ensemble

`Raz` est un utilitaire de **remise à « non stocké » de tous les articles** (`art_stocke = 0` dans
`Fiches_Art`). Le libellé du `.form` demande de faire une sauvegarde avant. Il est lancé uniquement
par [`Prgm`](../Prgm.class/architecture.md) (nom `Raz`), en modal.

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Button1_Click` | 3-20 | Public | 4 | 15 | 0 | handler GUI |
| `Button2_Click` | 22-26 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Button1_Click()`** [handler] [mixte]. « Lancer » : `Message.Warning` avec « OK » / « Non » ; sur
  « OK », `SELECT art_code, art_stocke FROM Cbase.Table("TabArt")` puis, pour **chaque** article,
  `Update TabArt SET art_stocke = '0' WHERE art_code = &1` (une requête par article, sans
  transaction), curseur d'attente, `Message.Info("Traitement terminé !")` et `Me.Raise` (la fenêtre
  reste ouverte). Si la table est vide, rien n'est affiché.
- **`Button2_Click()`** [handler] [GUI]. Ferme.

## État global utilisé

- `Utils.db.Exec`, `Cbase.Table("TabArt")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la boucle par un seul `UPdate … SET art_stocke = &1` sans `WHERE` (même état final de la
  base ; SQL modifié, dump identique). Garder le `SELECT` préalable pour conserver le comportement
  « rien n'est affiché si aucun article ».

### Commonalisation avec d'autres fichiers

- Même famille que les scripts de masse de `Prgm` (`Epurfour` vide `art_cfour`, `Papmp` recopie le
  PMP) : voir le module `Maintenance` proposé par [PAPMP-003](../../Utils/Papmp.class/rework.md).

### Réduction de portée

- Rien (handlers).

### Séparation traitement / GUI

- `RazStocke() As Boolean` privé (SQL), le handler gardant question, curseur et messages.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
