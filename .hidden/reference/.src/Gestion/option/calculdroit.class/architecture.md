# calculdroit — Architecture

> Source : `.src/Gestion/option/calculdroit.class`

## Vue d'ensemble

`calculdroit` est la **première version du calcul des droits sur les alcools** (option
« boissons ») : un objet construit pour un article et une quantité, qui calcule en `Float` les
volumes, le droit, la cotisation sécurité sociale et leurs TVA, et expose les éléments de la régie
(libellé, type, compte, code TVA…). Sans formulaire ni héritage. C'est la version la plus utilisée
(14 fichiers : facturation `ObjFacB`/`facopt`, stock `Mvtex`/`ValidBR`/`Validinv`, éditions
`Caleditcmat`/`EditStkDepart`/`Edart4`, fiches `artopt`/`Tregie`/`TarArt`, `Saisiedecons`). La
version objet [`calculdroit1`](../calculdroit1.class/architecture.md) (héritière de `LPrix`)
applique les mêmes règles ; voir sa section « Duplication avec `calculdroit` » (7 lignes
textuellement communes, 3 `SELECT` identiques).

Règle métier telle que le code l'applique (`_new`, régie `Fiches_regie` gérée par
[`Tregie`](../Tregie.class/architecture.md)) :

- `vol` (cl par unité), `deg` (% vol), `qte` (nombre d'unités, `Variant`, virgule acceptée) ;
- volume total `vol = qte × vol / 100` (litres) ; volume d'alcool pur `volap = qte × vol/100 ×
  deg/100` (seulement si la régie a `ap`, sinon 0) ;
- droit = `volap` (si `ap`) ou `vol` × `tauxa / 100` (tauxa en € par hl) ;
- TVA du droit = droit × taux de la TVA de la régie (`ttva`) ;
- cotisation sécurité sociale, seulement si `degres` est renseigné et `deg > degres` :
  `secu = (volap ou vol) × tauxss / 100`, `volumess` = l'assiette retenue ; TVA de la sécu au taux
  `Fiches_Parametres.tvass` ;
- `tva` = TVA droit + TVA sécu ; les lectures `droit`, `secu`, `tva`, `tvadroit`, `tvasec` sont
  arrondies à 2 décimales (`Utils.arrondi`).

Nature globale : **calcul + SQL**, avec deux `Message.Error` (couplage GUI) dans `_new`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$fdroit` | var | Private |  | Float | 5 |
| `$fsecu` | var | Private |  | Float | 6 |
| `$vol` | var | Private |  | Float | 7 |
| `$volap` | var | Private |  | Float | 8 |
| `$ftva` | var | Private |  | Float | 9 |
| `$ftvad` | var | Private |  | Float | 10 |
| `$ftxtvad` | var | Private |  | Float | 11 |
| `$ftvas` | var | Private |  | Float | 12 |
| `$ftxtvas` | var | Private |  | Float | 13 |
| `$slib` | var | Private |  | String | 14 |
| `$stype` | var | Private |  | String | 15 |
| `$scptreg` | var | Private |  | String | 16 |
| `$scodetva` | var | Private |  | String | 17 |
| `$bsuspendu` | var | Private |  | Boolean | 18 |
| `$bdrsurfac` | var | Private |  | Boolean | 19 |
| `$sfam` | var | Private |  | String | 20 |
| `$scodedr` | var | Private |  | String | 21 |
| `$fvolumess` | var | Private |  | Float | 22 |
| `droit` | property | Public |  | Float | 24 |
| `secu` | property | Public |  | Float | 25 |
| `tva` | property | Public |  | Float | 26 |
| `tvadroit` | property | Public |  | Float | 27 |
| `tvasec` | property | Public |  | Float | 28 |
| `lib` | property | Public |  | String | 29 |
| `volap` | property | Public |  | Float | 30 |
| `vol` | property | Public |  | Float | 31 |
| `type` | property | Public |  | String | 32 |
| `cptreg` | property | Public |  | String | 33 |
| `codetva` | property | Public |  | String | 34 |
| `suspendu` | property | Public |  | Boolean | 35 |
| `drsurfac` | property | Public |  | Boolean | 36 |
| `famille` | property | Public |  | String | 37 |
| `tauxtvadr` | property | Public |  | String | 38 |
| `tauxtvass` | property | Public |  | String | 39 |
| `volumess` | property | Public |  | Float | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 43-98 | Public | 15 | 51 | 0 | méthode spéciale |
| `droit_Read` | 100-104 | Private | 1 | 3 | 0 |  |
| `droit_Write` | 106-112 | Private | 1 | 5 | 0 |  |
| `secu_Read` | 114-118 | Private | 1 | 3 | 0 |  |
| `secu_Write` | 120-126 | Private | 1 | 5 | 0 |  |
| `tva_Read` | 128-132 | Private | 1 | 3 | 0 |  |
| `lib_Read` | 134-138 | Private | 1 | 3 | 0 |  |
| `volap_Read` | 140-144 | Private | 1 | 3 | 0 |  |
| `vol_Read` | 146-150 | Private | 1 | 3 | 0 |  |
| `type_Read` | 152-156 | Private | 1 | 3 | 0 |  |
| `cptreg_Read` | 158-162 | Private | 1 | 3 | 0 |  |
| `codetva_Read` | 164-168 | Private | 1 | 3 | 0 |  |
| `suspendu_Read` | 170-174 | Private | 1 | 3 | 0 |  |
| `drsurfac_Read` | 176-180 | Private | 1 | 3 | 0 |  |
| `famille_Read` | 182-186 | Private | 1 | 3 | 0 |  |
| `tvadroit_Read` | 188-192 | Private | 1 | 3 | 0 |  |
| `tvasec_Read` | 194-198 | Private | 1 | 3 | 0 |  |
| `tauxtvadr_Read` | 200-204 | Private | 1 | 3 | 0 |  |
| `tauxtvadr_Write` | 206-212 | Private | 1 | 5 | 0 |  |
| `tauxtvass_Read` | 214-218 | Private | 1 | 3 | 0 |  |
| `tauxtvass_Write` | 220-226 | Private | 1 | 5 | 0 |  |
| `code_Read` | 228-232 | Private | 1 | 3 | 0 |  |
| `volumess_Read` | 234-238 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Constructeur

- **`_new(dra, vol, deg, qte As Variant, Optional fam)`** (CC 15) [portée : nécessaire, 17 appels
  `New Calculdroit(…)` dans 12 fichiers] [nature : mixte, partie extractible : tout sauf les deux
  `Message.Error`]. Remplace `,` par `.` dans `qte` si c'est une chaîne (conversion implicite
  `String` → `Float` non localisée : vérifié avec `gbs3`, `"1,5" × x` lève « Type mismatch »).
  Sort sans rien calculer si `dra` est vide (toutes les valeurs à 0). SQL :
  `SELECT * FROM Fiches_regie WHERE code = &1` ; `SELECT * FROM Fiches_Tvaav WHERE code_tva = &1`
  (TVA de la régie) ; si la sécu s'applique, `SELECT taux_tva FROM Fiches_Parametres, Fiches_Tvaav
  WHERE code_tva = tvass`. Erreurs : `Message.Error("Probleme de TVA sur régie …")` puis `Return`
  (droit déjà nul) ; `Message.Error("probléme TVA sur sécurité social…")` (la sécu reste calculée,
  sa TVA vaut 0) ; `Message.Error("Probleme sur n° régie …")` si la régie est absente. Mémorise
  ensuite libellé, type, compte, code TVA, `suspendu`, `drfac`, code de régie.
  ⚠️ Le taux de TVA est relu par `Val(Replace(taux_tva, ".", ","))` (dépend de la locale française).

### Propriétés (lecture)

Toutes [portée : nécessaire] [nature : calcul] ; appelants dans `dependencies.md`.

- **`droit`**, **`secu`**, **`tva`**, **`tvadroit`**, **`tvasec`** : montants arrondis à 2 décimales.
- **`vol`**, **`volap`**, **`volumess`** : volumes non arrondis (litres).
- **`lib`**, **`type`** (`A`/`B`/`V`), **`cptreg`**, **`codetva`**, **`code`**, **`famille`** :
  données de la régie ou du paramètre `fam`.
- **`suspendu`**, **`drsurfac`** : régime de la régie (`Fiches_regie.suspendu`, `drfac`).
- **`tauxtvadr`**, **`tauxtvass`** : taux de TVA **en fraction** (0,20) formatés `"0.00"`
  (deux décimales seulement : un taux de 5,5 % s'affiche `0,06`, à confirmer).

### Propriétés (écriture)

- **`droit_Write`**, **`secu_Write`** : remplacent le montant et recalculent la TVA correspondante et
  `tva` (utilisées par `ObjFacB` pour cumuler des lignes, à confirmer).
- **`tauxtvadr_Write`**, **`tauxtvass_Write`** : `Val(Replace(value, ".", ","))` **sans division par
  100** : la valeur attendue est une fraction (symétrique de la lecture) ; recalculent les TVA.

## État global utilisé

- `Utils.db.Exec`, `Utils.arrondi`.
- Tables : `Fiches_regie` (créée par `modfichier.fichierboisson`, absente de `db_control.csv`),
  `Fiches_Tvaav`, `Fiches_Parametres` (`tvass` ajoutée par `modfichier`). Noms en dur.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` (CC 15) : extraire `LireRegie(dra)` (3 `SELECT`) et `CalculVolumes`/`CalculSecu` privés ;
  les `Message.Error` restent dans `_new` (même ordre, même texte).
- `Cbase.Table("TabTvav")` / `Cbase.Table("TabParam")` (SQL identique).

### Commonalisation avec d'autres fichiers

- Lecture de la régie et des deux taux de TVA commune avec
  [`calculdroit1.LecDra`](../calculdroit1.class/architecture.md) (rework CALCULDROIT1-006).
- Les 22 accesseurs triviaux `*_Read` peuvent devenir `Property Read … Use $membre` (syntaxe
  Gambas 3, déjà employée par `ticpe`) sans changement d'API.
- Fusion avec `calculdroit1` : **non proposée** sans tests d'équivalence (arrondis à 2 décimales sur
  le total ici, 4 décimales unitaires là-bas).

### Réduction de portée

Aucune : chaque propriété a au moins un lecteur externe (`deps.py` et `grep`).

### Séparation traitement / GUI

Les deux `Message.Error` de `_new` (régie, TVA) : calcul pur dans une fonction privée renvoyant un
code d'erreur, message affiché par `_new` à l'identique.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_regie` et les colonnes `art_dra`, `art_volm`, `art_deg`, `tvass` dans
  `db_control.csv` et les bases de référence.
- Stocker les taux de TVA en décimal (déjà `decimal`) et éviter la conversion par chaîne.
