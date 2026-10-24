# Calcsolde — Architecture

> Source : `.src/Utils/Calcsolde.class`

## Vue d'ensemble

`Calcsolde` **recalcule les soldes comptables** du plan comptable `Fiches_Comptes` à partir des
écritures validées de `Fiches_Mvt` :

- `solde` = Σ `montantd` − Σ `montantc` des écritures validées du compte ;
- `soldep` (solde pointé, comptes de trésorerie) = même somme sur les écritures **pointées** ou sur
  l'écriture de report à nouveau clôturée du journal d'à-nouveaux (`Fiches_Parametres.jdr`,
  libellé `"Report a nouveau"`).

C'est un formulaire (bouton « Lancer » / « Quitter », groupe `Btn`) ouvert par le menu
(`Fmenu.class:969`, `Menu76_Click`), après l'import FEC (`impfec.class:58`) et par le lanceur
`Prgm` (`Prgm.class:60`). Sa méthode `Calcul` est aussi appelée **en statique** par `Pointage`
(`Pointage.class:728`) après suppression d'un relevé, ce qui instancie le formulaire caché.

Nature : **calcul** pour `Calcul`, **mixte** pour `Button2_Click`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$depart` | var | Private |  | Boolean | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 29-36 | Public | 2 | 6 | 0 | méthode spéciale |
| `form_Open` | 40-46 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 51-63 | Public | 3 | 8 | 0 | handler GUI |
| `Button2_Click` | 68-94 | Public | 6 | 23 | 0 | portée réductible ? |
| `Calcul` | 97-129 | Public | 8 | 27 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(depart)`** [portée : nécessaire (spéciale)] [nature : mixte]. Si `depart = True`, lance le
  calcul dès la construction (`Button2_Click`, sans message final). ⚠️ Aucun appelant ne passe
  `True` (grep `Calcsolde(` : aucun `New Calcsolde(...)`) : branche morte.
- **`form_Open()`** [handler] : `Music.Load`, centrage, `Utils.Observers`.
- **`Btn_Click()`** [portée : nécessaire, handler du groupe `Btn` — faux positif de `deps.py`]
  [nature : GUI] : `Tag` 1 → `Button2_Click`, 2 → fermeture.
- **`Button2_Click()`** [portée : nécessaire] [nature : mixte]. Souris d'attente, lecture de
  `jdr` (`SELECT jdr FROM Fiches_Parametres`), parcours de tous les comptes
  (`ORDER BY cast(compte_cc AS char)`, tri alphabétique d'un entier), `Calcul(compte, comptr_cc,
  jan)` pour chacun, message « Traitement terminé » (sauf `$depart`), fermeture.
  `If IsNull(compt) Then Continue` est mort (`compte_cc` est `int NOT NULL`, `db_control.csv`).
- **`Calcul(compt, Treso, jan)`** (CC 8) [portée : nécessaire — `Pointage`] [nature : calcul].
  1. `SELECT (sum(montantd)-sum(montantc)) AS solde FROM Fiches_Mvt WHERE compte = &1 AND
     validee = 1`.
  2. Solde Null (aucune écriture validée) → `solde = LPrix(0).D` ; sinon `LPrix(solde).D`
     (arrondi à 2 décimales, séparateur point).
  3. Si `Treso` (paramètre `comptr_cc`, entier converti en booléen) **et** `jan` non vide :
     `SELECT … AS soldepointee … WHERE compte = &1 AND ((cloturee = 1 AND jour = &3 AND libelle =
     'Report a nouveau') OR pointee = 1)`, puis `UPDATE soldep` (0 si Null).
  ⚠️ `soldep` n'est pas recalculé quand `solde` est Null (compte sans écriture validée) : un ancien
  `soldep` peut subsister.
  ⚠️ **Appel depuis `Pointage`** : `Calcsolde.Calcul(Cpt.Text, True)` sans 3ᵉ argument → `jan = ""`
  → **`soldep` n'est jamais recalculé** après la suppression d'un relevé, alors que c'est le solde
  pointé qui change.
  Tables en dur (`Fiches_Mvt`, `Fiches_Comptes`), sans `Cbase.Table`. Seul `Fiches_Mvt` (exercice
  courant, à confirmer) est lu, pas `Fiches_Mvt1..5`.

## État global utilisé

- `Utils.db`, `Utils.MouseProcessing/MouseDefault`, `Utils.Observers`, `Start.Musique`.
- `LPrix(…).D` pour le format décimal de la base.
- Instance automatique du formulaire lors de l'appel statique depuis `Pointage`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Sortir `Calcul` et la boucle de `Button2_Click` dans un module de calcul (ou des fonctions
  statiques) pour que `Pointage` n'instancie plus un formulaire : dans le **même fichier** pour ce
  plan, en marquant `Calcul` `Static` (aucune donnée d'instance utilisée).
- Supprimer le paramètre `depart` et la branche associée (aucun appelant).
- `Cbase.Table("TabMvt")`, `Cbase.Table("TabComptes")` à la place des noms en dur.

### Commonalisation avec d'autres fichiers

- `.src/Compta/Utils/Recalcsolde.module` (fonction `Calc()`) porte un nom proche : à comparer en
  phase 3 (doublon fonctionnel possible, non vérifié).
- Les soldes sont aussi mis à jour de façon incrémentale par la saisie d'écritures (`Saisecrit`,
  `Tresor`) : la formule de `solde`/`soldep` gagnerait à être unique.
- Même patron « utilitaire lancé par `Prgm` » que [`CalcRem`](../CalcRem.class/architecture.md).

### Réduction de portée

- `Calcul` reste `Public` (appelé par `Pointage`). `Btn_Click` est un handler. Aucune réduction.

### Séparation traitement / GUI

- `Button2_Click` : extraire `RecalculeTout()` (lecture de `jdr` + boucle) sans souris ni message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les soldes stockés (`solde`, `soldep`) sont des agrégats dénormalisés : une vue
  `SUM(...) GROUP BY compte` supprimerait le besoin de recalcul.
- Un drapeau « report à nouveau » explicite remplacerait le test sur le libellé
  `"Report a nouveau"`.
