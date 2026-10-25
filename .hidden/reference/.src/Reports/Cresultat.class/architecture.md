# Cresultat — Architecture

> Source : `.src/Reports/Cresultat.class`

## Vue d'ensemble

`Cresultat` est le **gabarit PDF du compte de résultat** (`Inherits PdfWriter`, A4 portrait),
utilisé uniquement par [RubImp](../../Compta/Impressions/RubImp.class/architecture.md)
(`New Cresultat("Portrait", "mm", "A4")`, ligne 1003, sortie `~/tmp/Resultat.pdf`). Mise en page
sur 200 mm : intitulé (80 mm), deux colonnes de 20/30 mm pour compte et sous-compte, puis deux
colonnes de montants « Exercice N » et « Exercice N -1 » (30 mm chacune).

Classe courte (8 méthodes, toutes appelées), sans bandeau coloré : seule `BasPage` utilise la
couleur du thème (`SetFillColor`, sans remplissage effectif).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 5 |
| `G` | var | Private |  | Integer | 6 |
| `B` | var | Private |  | Integer | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-15 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 17-19 | Public | 1 | 2 | 0 | méthode spéciale |
| `BasPage` | 22-29 | Public | 1 | 6 | 1 |  |
| `Level0` | 32-44 | Public | 1 | 11 | 1 |  |
| `Level1` | 47-59 | Public | 3 | 11 | 1 |  |
| `Level7` | 62-72 | Public | 3 | 9 | 1 |  |
| `Level2` | 74-85 | Public | 1 | 10 | 1 |  |
| `Level3` | 87-96 | Public | 1 | 8 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : `R`, `G`, `B` = `Start.R/G/B`
  (identique à 11 autres gabarits). **`_free()`** : vide.
- **`BasPage()`** [portée : nécessaire, `RubImp:1044`, `1110`, `1120`] [nature : GUI] : pied de page
  standard (identique à `Ccompta.BasPage`).
- **`Level0(titre, periode, detail, ste)`** [portée : nécessaire] [nature : GUI] : **nouvelle page**,
  titre 16 pt, période et société centrés, **sans** bordure ni remplissage (différence avec
  `Cbilan.Level0`/`Csig.Level0`). `detail` inutilisé.
- **`Level3(dte, dte2, posy)`** [portée : nécessaire] [nature : GUI] : « Détail des postes » (12 pt)
  puis les deux libellés d'exercice alignés à droite.
- **`Level1(intitrub, p5, imp1, imp2, Posy)`** [portée : nécessaire, 9 appels] [nature : mixte,
  calcul extractible : formatage] : ligne de rubrique en gras ; `imp1`, `imp2` passent par
  `Try Format$(Val(x), ",#")` (`Val` localisé **sans** `Utils.cpoint` : une valeur décimale au point
  reste brute, comme dans [Csig](../Csig.class/architecture.md), CRESULTAT-A01). ⚠️ `p5` est
  imprimé **deux fois** (cellules de 30 mm sous les colonnes compte/sous-compte) ; `RubImp` ne
  l'affecte jamais (`Dim p5 As String`, ligne 489) : les deux cellules sont vides. L'appel
  `level1(intitrub, p5, p5, p5, Posy)` (rubrique `E` sans détail) imprime donc des montants vides.
- **`Level7(intitrub, imp1, imp2, Posy)`** [portée : nécessaire, `RubImp:1065`] [nature : mixte] :
  ligne de synthèse (intitulé sur 140 mm), même formatage que `Level1`.
- **`Level2(intitrub, compte, cpt, p5, imp1, imp2, posy)`** [portée : nécessaire, `RubImp:1070`]
  [nature : GUI] : ligne de compte en italique (intitulé, compte, sous-compte, `p5` vide, montants
  **non formatés**, tels que fournis par `RubImp`).

## État global utilisé

- `Start.R/G/B` (dans `_new`), `User.Name`, `Now` ; locale du processus (`Val`, `",#"`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `MontantResultat(s) As String` pour le `Try Format$(Val(s), ",#")` de `Level1` et
  `Level7` (comportement identique, chaîne brute en cas d'échec).
- Supprimer `_free`.

### Commonalisation avec d'autres fichiers

- `_new`, `BasPage` → base commune `PdfLaurux` (voir
  [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- `Level0` ≈ `Cbilan.Level0`/`Csig.Level0` sans bandeau : `TitreEtat(titre, periode, ste, 200,
  rempli = False)`.
- `Level7` ≈ `Csig.Level7` (mort) ; formatage `",#"` commun avec [Csig](../Csig.class/architecture.md).

### Réduction de portée

- Aucune : toutes les méthodes sont appelées par `RubImp`.

### Séparation traitement / GUI

- `MontantResultat` (formatage pur) séparé des `cell`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
