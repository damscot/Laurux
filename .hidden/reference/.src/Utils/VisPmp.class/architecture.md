# VisPmp — Architecture

> Source : `.src/Utils/VisPmp.class` · Form : `VisPmp.form`

## Vue d'ensemble

Programme de contrôle « **PMP négatifs** » : écrit dans `~/Pmp.txt` les articles dont `art_pmp < 0`
(`code;désignation;prix de revient;pmp`) puis ouvre le fichier dans l'éditeur. Lancé par « Appel
programme » (`Prgm`, programme `Pmp`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 3-9 | Public | 1 | 5 | 0 | méthode spéciale |
| `Button3_Click` | 11-15 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 17-50 | Public | 5 | 30 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [spéciale] [GUI]. `Utils.Observers(Me)`, centrage, `VisPmp.SetFocus` (la fenêtre).
- **`Button3_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [mixte]. Ouvre `~/Pmp.txt`, `SELECT * FROM TabArt WHERE art_pmp <
  &1` (0) ; si résultat : une ligne par article, curseur, musique si `Start.Son`, « Traitement
  terminé. », `Me.Close`, `Editeur.Prog_Editeur`, **puis** `Close #HFil`. Sinon « Il n'existe aucun
  pmp inférieur à zéro. » (fichier créé vide). Le commentaire l.28 parle de « clients » (copie).
  Partie extractible : `ListerPmpNegatifs(sFichier) As Integer`.

## État global utilisé

- `Start.Son`, `Utils.db`, `Utils.Observers`, `Cbase.Table("TabArt")`, `Editeur.Prog_Editeur`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Corriger le commentaire l.28.

### Commonalisation avec d'autres fichiers

- [`Dcfour`](../Dcfour.class/architecture.md) : même squelette (18 lignes normalisées communes, 60 %
  de ce fichier) ; helper commun `RapportTexte` proposé dans `Dcfour`.

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ListerPmpNegatifs(sFichier As String) As Integer`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
