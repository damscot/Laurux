# Cbilan — Architecture

> Source : `.src/Reports/Cbilan.class`

## Vue d'ensemble

`Cbilan` est le **gabarit PDF du bilan comptable** (`Inherits PdfWriter`, A4 portrait), utilisé
uniquement par [Imp_Bilan](../../Compta/Impressions/Imp_Bilan.module/architecture.md)
(`New Cbilan("Portrait", "mm", "A4")`, ligne 649). L'appelant parcourt la table de travail
`centralisation` et choisit le niveau selon le type de rubrique (`T` titre → `Level0` + `Level3`,
`E`/`C`/`D`/`R`/`G` → `Level1`, `L` → `Level1L`, `S`/`O` → `Level1S`).

Contrairement aux autres gabarits comptables, les niveaux `Level1*` contiennent de la **logique de
présentation des montants** : calcul du net (`imp1 − imp2`), remplacement des zéros, choix de la
colonne selon le côté du bilan (`Sens = "A"` actif, sinon passif). Les couleurs sont fixes (gris
223), pas celles du thème.

Colonnes (définies par `Level3`) — actif : Détail des postes (x = 24, 80 mm), Montant brut,
Amortissements/Provisions, colonne N (x = 160) ; passif : Détail des postes (x = 34, 108 mm),
colonne N (x = 142). La colonne N-1 (`dte2`) n'est jamais imprimée.

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
| `Level0` | 32-45 | Public | 1 | 12 | 1 |  |
| `Level1` | 48-77 | Public | 17 | 28 | 1 |  |
| `Level1L` | 79-110 | Public | 16 | 30 | 1 |  |
| `Level1A` | 113-119 | Public | 3 | 5 | 0 | portée réductible ? |
| `Level1S` | 121-154 | Public | 15 | 32 | 1 |  |
| `Level2` | 156-171 | Public | 5 | 14 | 0 | portée réductible ? |
| `Level3` | 173-198 | Public | 6 | 24 | 1 |  |
| `Lines` | 201-206 | Public | 1 | 4 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Méthodes spéciales et communes

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : `R = G = B = 223` (gris fixe,
  identique à `Csig._new`). **`_free()`** : vide.
- **`BasPage()`** [portée : nécessaire] [nature : GUI] : pied de page standard (identique à
  `Ccompta.BasPage`).
- **`Level0(titre, periode, detail, ste)`** [portée : nécessaire] [nature : GUI] : **nouvelle page**
  (`AddPage`) ; titre 16 pt dans un bandeau gris, période et société centrées (200 mm). `detail`
  est inutilisé (déjà relevé dans `Imp_Bilan`).
- **`Level3(dte, dte2, posy, Sens)`** [portée : nécessaire] [nature : GUI] : en-tête des colonnes
  (« Détail des postes », « Montant », « Amortissements », `dte`, puis « brut » / « Provisions » sous
  les deux premières colonnes de l'actif). `dte2` inutilisé (colonne N-1 absente).
- **`Lines(PosY As String)`** [portée : nécessaire] [nature : GUI] : filet de 24 à 188 mm.

### Lignes de rubrique

- **`Level1(intitrub, p5, imp1, imp2, imp3, imp4, Posy, Sens)`** (CC 17, max du fichier)
  [portée : nécessaire, `Imp_Bilan:689-796`] [nature : mixte, calcul extractible : montant net] :
  intitulé gras ; à l'actif, montant brut `imp1` (`Format$(…, ",#")`, sous `Try`) ; puis colonne N =
  net calculé :
  1. `imp2` vide ou `"0"` → `imp2 = imp1` ;
  2. sinon `imp2 = Val(imp1) − Val(imp2)` (Float converti en chaîne, point décimal) ;
  3. `imp2` redevenu `"0"` → `imp2 = imp1` ⚠️ : un poste **totalement amorti** (net = 0) affiche
     son montant **brut** dans la colonne N (CBILAN-A01) ;
  4. `"0"` → `""`, impression `Format$(Val(Utils.cpoint(imp2)), ",#")` sous `Try`.
  `p5`, `imp3`, `imp4` sont inutilisés. Un `Try Me.cell(…)` dont la conversion échoue (`Val("")`)
  n'imprime **rien** et n'avance pas l'abscisse : les lignes d'entête `E` (montants vides) n'ont
  donc aucune cellule de montant.
- **`Level1L(…)`** (CC 16) [portée : nécessaire, `Imp_Bilan:682`] [nature : mixte] : ligne de détail
  (police normale) ; à l'actif, brut puis amortissements `imp2` (si non nul) ; net =
  `Abs(Val(imp1)) − Val(imp2)` ⚠️ (valeur absolue du brut, contrairement à `Level1` et `Level1S`, à
  confirmer : CBILAN-A02) ; sinon même remplacement que `Level1`.
- **`Level1S(…)`** (CC 15) [portée : nécessaire, `Imp_Bilan:755`, `772`] [nature : mixte] :
  sous-total / total : bandeau gris (`posy − 0.8`, 164 mm), intitulé aligné à droite, brut et
  amortissements à l'actif, net comme `Level1` (même défaut du net nul).
- **`Level1A(imp3, Posy)`** [nature : GUI] : montant d'amortissement à x = 154 — **jamais appelé**
  (code mort).
- **`Level2(intitrub, compte, cpt, p5, imp1, imp2, posy, Sens)`** [nature : GUI] : ligne de compte
  détaillée — **jamais appelée** (code mort ; `Imp_Bilan` n'imprime pas le détail des comptes).

Les trois `Level1*` répètent le même squelette (positions selon `Sens`, brut, amortissements, net,
`"0"` → `""`) avec des variantes : forte duplication, CC cumulée 48.

## État global utilisé

- `Utils.cpoint` (conversion `.` → `,` avant `Val` en locale française), `User.Name`, `Now`.
- Aucune lecture de `Start` (couleurs fixes).
- État hérité de `PdfWriter` : la couleur de remplissage reste le gris 223 (fixée par `Level0`,
  `Level1S`, `Level3`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1A`, `Level2` (morts) et `_free`.
- Factoriser les trois `Level1*` : helpers privés `PositionX(Sens, xA, xP)`, `CelluleMontant(w,
  valeur)` (le `Try Me.cell(…, Format$(Val(Utils.cpoint(v)), ",#") …)` répété 9 fois) et une
  fonction de calcul du net qui reproduit **exactement** chacune des trois variantes (paramètre
  `avec_abs`). CC 48 → ≤ 15 visé, rendu identique.
- `Lines(PosY As String)` → `Integer`.

### Commonalisation avec d'autres fichiers

- `Level0` ≈ `Csig.Level0` (largeur 200 au lieu de 290) ≈ `Cresultat.Level0` (sans bandeau) :
  méthode commune `TitreEtat(titre, periode, ste, largeur, rempli)` dans la base `PdfLaurux`
  (voir [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- `_new` = `Csig._new` (gris 223) ; `BasPage` = pied de page standard (8 copies).
- Calcul du net et formatage `",#"` : mêmes règles dans [Csig](../Csig.class/architecture.md)
  (`Level1L`/`Level1S` morts) et [Cresultat](../Cresultat.class/architecture.md).

### Réduction de portée

- Aucune pour les méthodes vivantes (appelées par `Imp_Bilan`). `Level1A` et `Level2` : suppression.

### Séparation traitement / GUI

- Extraire `NetBilan(imp1, imp2, avec_abs) As String` (calcul pur, testable en gb.test) des trois
  `Level1*` ; les niveaux ne gardent que les positions et les `cell`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
