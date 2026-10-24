# Papmp — Architecture

> Source : `.src/Utils/Papmp.class`

## Vue d'ensemble

Script de maintenance **statique** : après confirmation, recopie le prix de revient (`art_prvt`) dans
le PMP (`art_pmp`) de **tous** les articles. Lancé par « Appel programme » (`Prgm`, programme
`Papmp`). Le message annonce « Pamp = prix d'achat » alors que c'est `art_prvt` (prix de revient)
qui est copié — même écart que la case `Chk2` de [`RazArt`](../RazArt.class/architecture.md).

Nature globale : **mixte** (SQL + `Message` + curseur de la fenêtre `Prgm`).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 3-23 | Public Static | 4 | 18 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (`Static Public`) [portée : nécessaire (`Prgm.class:68`)] [nature : mixte].
  `Message.Question` ; si « Oui » : `Prgm.Mouse = Mouse.Wait`, `SELECT * FROM TabArt`, puis pour
  chaque article `UPdate TabArt SET art_pmp = &1 WHERE art_code = &2` (`art_prvt`, `art_code`).
  Le curseur n'est remis à `Default` et « Traitement terminé » n'est affiché que s'il y a des
  articles. La variable `pmp` est affectée sans être lue. Couplage direct au formulaire `Prgm`
  (`Prgm.Mouse`).

## État global utilisé

- `Utils.db`, `Cbase.Table("TabArt")`, auto-instance de la fenêtre `Prgm`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la variable `pmp`.
- Une seule requête `UPdate TabArt SET art_pmp = art_prvt` (même résultat en base ; log SQL
  différent : comparaison par dump).

### Commonalisation avec d'autres fichiers

- Boucle identique à `RazArt.Button1_Click` (`Chk2`) : fonction commune `PmpEgalPrvt()` (voir
  RAZART-004).
- Les scripts de maintenance de `Prgm` (`Papmp`, [`Epurfour`](../Epurfour.class/architecture.md),
  [`HistoCom`](../HistoCom.class/architecture.md), [`RecupN`](../RecupN.class/architecture.md),
  [`RenumBl`](../RenumBl.class/architecture.md)) sont chacun une classe à une méthode `run` : ils
  pourraient être regroupés dans un module `Maintenance.module` (appels `Prgm` mis à jour dans le même
  commit).

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `PmpEgalPrvt()` sans `Message` ni `Prgm.Mouse` ; `run` garde la question, le curseur et le message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
