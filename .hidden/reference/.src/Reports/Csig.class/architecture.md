# Csig — Architecture

> Source : `.src/Reports/Csig.class`

## Vue d'ensemble

`Csig` est le **gabarit PDF des soldes intermédiaires de gestion** (SIG), en A4 **paysage**
(`New Csig("l", "mm", "A4")`, `Imp_Sig:257`). Il est piloté par
[Imp_Sig](../../Compta/Impressions/Imp_Sig.module/architecture.md), qui imprime trois colonnes :
Produits (x = 4 à 104), Charges (104 à 201) et S.I.G. (201 à 293), séparées par les filets
verticaux de `Lines3`.

La classe a été dérivée de [Cbilan](../Cbilan.class/architecture.md) (même `_new` à gris 223,
mêmes `Level1L`/`Level1A`/`Level1S` adaptés) : ces trois niveaux et `Level7` ne sont **plus
appelés**. Les niveaux vivants formatent eux-mêmes les montants (`Format$(Val(x), ",#")` sous
`Try`).

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
| `Level1` | 48-76 | Public | 5 | 14 | 1 |  |
| `Level2` | 78-94 | Public | 4 | 15 | 1 |  |
| `Level3` | 96-105 | Public | 1 | 8 | 1 |  |
| `Level1L` | 107-154 | Public | 24 | 44 | 0 | portée réductible ? |
| `Level1A` | 157-164 | Public | 3 | 6 | 0 | portée réductible ? |
| `Level1S` | 166-214 | Public | 25 | 46 | 0 | portée réductible ? |
| `Level7` | 217-227 | Public | 3 | 9 | 0 | portée réductible ? |
| `Lines` | 230-236 | Public | 1 | 5 | 1 |  |
| `Lines2` | 239-245 | Public | 1 | 5 | 1 |  |
| `Lines3` | 248-256 | Public | 1 | 7 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Méthodes spéciales et communes

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : `R = G = B = 223` (gris fixe,
  identique à `Cbilan._new`). **`_free()`** : vide.
- **`BasPage()`** [portée : nécessaire] [nature : GUI] : pied de page standard sur **290 mm**
  (variante paysage du pied de page commun).
- **`Level0(titre, periode, detail, ste)`** [portée : nécessaire] [nature : GUI] : **nouvelle page**,
  titre 16 pt en bandeau gris, période et société (290 mm). `detail` inutilisé.
- **`Level3(posy)`** [portée : nécessaire] [nature : GUI] : en-têtes « Produits », « Charge »,
  « S.I.G. » (bandeau gris, 10 pt).
- **`Lines(PosY)`**, **`Lines2(PosY)`**, **`Lines3(PosY)`** [portée : nécessaire] [nature : GUI] :
  filet horizontal pleine largeur (4-293), filet des deux premières colonnes (4-198), filets
  verticaux de y = 40 à `PosY` aux abscisses 4, 104, 201, 293. `Lines`/`Lines2` font un `SetXY(7,
  PosY)` préalable.

### Niveaux vivants

- **`Level1(intitrub, imp1, intitrub2, imp2, Posy)`** [portée : nécessaire, `Imp_Sig:289-438`]
  [nature : mixte, calcul extractible : formatage] : une ligne à deux colonnes (produit à gauche,
  charge à droite). Chaque montant passe par `Try imp = Format$(Val(imp), ",#")` puis `"0"` → `""`.
  ⚠️ `Val` est **localisé** et n'est pas précédé de `Utils.cpoint` : une valeur décimale au point
  (`"1234.56"`, forme d'une somme Float convertie en chaîne) donne `Val = Null`, `Format$` échoue,
  le `Try` laisse la chaîne **brute** à l'impression (vérifié avec gbs3 en `fr_FR.UTF-8`) ; un
  entier (`"1234"`) est formaté `1 234`. Les montants d'`Imp_Sig` sont en général arrondis par
  `Format$(…, "0")`, d'où une anomalie latente (CSIG-A01).
- **`Level2(intitrub, TotP, intitrub2, TotA, intitrubE, Sig, Posy)`** [portée : nécessaire,
  `Imp_Sig:411-420`] [nature : mixte] : ligne de totaux sur les trois colonnes (Total produits,
  Total charges, solde intermédiaire), même formatage que `Level1`, cellules bordées et remplies.

### Niveaux morts (jamais appelés)

- **`Level1L(…)`** (CC 24), **`Level1S(…)`** (CC 25, max du fichier) : variantes de
  `Cbilan.Level1L`/`Level1S` avec colonne N-1 et ratio d'évolution en %. `Level1L` contient un
  `imp4 = Val(…) − Val(…)` **hors `Try`** (ligne 141) qui lèverait une erreur sur une chaîne vide.
- **`Level1A(imp3, Posy)`** : amortissement à x = 114.
- **`Level7(intitrub, imp1, imp2, Posy)`** : ligne gras à deux montants (≈ `Cresultat.Level7`).

## État global utilisé

- `Utils.cpoint` (seulement dans les niveaux morts), `User.Name`, `Now`.
- Locale du processus (formatage `",#"` et `Val` localisés).
- Couleur de remplissage : gris 223 posé par `Level0`/`Level3` et conservé.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1L`, `Level1A`, `Level1S`, `Level7` et `_free` : −95 lignes, CC −55.
- Helper privé `MontantSig(s) As String` pour le `Try Format$(Val(s), ",#")` répété (5 fois dans
  les niveaux vivants), comportement identique (y compris la chaîne brute en cas d'échec).
- `Lines*(PosY As String)` → `Integer`.

### Commonalisation avec d'autres fichiers

- `_new` = `Cbilan._new` ; `Level0` ≈ `Cbilan.Level0` (largeur 290 au lieu de 200) ≈
  `Cresultat.Level0` → `TitreEtat(titre, periode, ste, largeur, rempli)` dans la base `PdfLaurux`
  (voir [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- `BasPage` : pied de page standard paramétré par la largeur (290).
- `MontantSig` = même formatage que `Cresultat.Level1`/`Level7` (même `Try Format$(Val(x), ",#")`) :
  helper commun possible dans la base.

### Réduction de portée

- Aucune pour les méthodes vivantes ; les quatre niveaux morts sont à supprimer.

### Séparation traitement / GUI

- `MontantSig` (calcul de présentation pur) séparé des `cell`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
