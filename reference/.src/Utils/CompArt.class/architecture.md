# CompArt — Architecture

> Source : `.src/Utils/CompArt.class` · Form : `CompArt.form`

## Vue d'ensemble

Programme de **comparaison d'un fichier texte avec la table des articles** : chaque ligne
`code;libellé;…` dont le code n'existe pas dans `Fiches_Art` est recopiée (`code;libellé`) dans
`~/tmp/Diff.txt`, affiché par `Visualiseur.Prog` s'il n'est pas vide. Aucune écriture en base.
Lancé par « Appel programme » (`Prgm`, programme `CompArt`, `ShowModal`).

Nature globale : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-11 | Public | 1 | 3 | 0 | méthode spéciale |
| `Svs_Click` | 13-21 | Public | 2 | 7 | 0 | handler GUI |
| `Button1_Click` | 23-27 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 29-70 | Public | 10 | 39 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [spéciale] [GUI]. `Music.Load(Start.Musique)`.
- **`Svs_Click()`** [handler] [GUI]. `Dialog.OpenFile` → `ChemFic.Text`.
- **`Button1_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [mixte]. Musique **avant** traitement si `son` ; chemin vide →
  avertissement ; fichier existant : recrée `~/tmp/Diff.txt`, pour chaque ligne `SELECT * FROM
  Fiches_Art WHERE art_code = &1` (code brut, espaces compris) ; absent → `Lig2[0] & ";" & Lig2[1]`
  dans le rapport. Puis « Traitement terminé ! » et `Visualiseur.Prog` si au moins un manquant.
  `Close` exécutés aussi quand le fichier n'existe pas (erreur). Une ligne sans `;` fait échouer
  `Lig2[1]`. Partie extractible : `ComparerArticles(sSource, sRapport) As Integer`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Utils.db`, `Visualiseur.Prog`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Table via `Cbase.Table("TabArt")`.

### Commonalisation avec d'autres fichiers

- [`ImportStk`](../Exports-Imports/ImportStk.class/architecture.md) : **92 %** des lignes de
  `CompArt` sont communes (39 lignes) ; factorisation commune proposée dans `ImportStk`
  (`ParcourirFichierArticles` / `LireCsv` + `RapportDiff`). Les deux classes écrivent le même
  `~/tmp/Diff.txt`.

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- `ComparerArticles(sSource As String, sRapport As String) As Integer`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
