# RenumBl — Architecture

> Source : `.src/Utils/RenumBl.class`

## Vue d'ensemble

Script de **réparation ponctuelle** destiné à renuméroter les factures en cas de doublon dans la
table des BL (erreur « duplicate » en clôture mensuelle). Il effectue en réalité **trois mises à jour
massives sans confirmation ni transaction** :
1. toutes les lignes de `Fiches_HistoLigfac` reçoivent `typel_ligfac = "A"` ;
2. tous les BL facturés de `Fiches_Bl` sont renumérotés `"20" & Mid$(numfac, 2, 2) & n°séquentiel`
   et reçoivent `dtefac = datebl` ;
3. toutes les lignes de `Fiches_Ligbl` reçoivent `tx_ligbl = "4"` et des montants reformatés.

Lancé par « Appel programme » (`Prgm`, programme `RenumBl`). Nature : **calcul (SQL)**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 4-52 | Public Static | 8 | 29 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (`Static Public`) [portée : nécessaire (`Prgm.class:111`)] [nature : calcul].
  - Étape 1 : `SELECT * FROM TabHisLigFac ORDER BY numlig_ligfac` puis, **pour chaque ligne**,
    `UPdate TabHisLigFac SET typel_ligfac = "A" WHERE num_ligfac = &1` (toutes les lignes de la
    facture à chaque itération : requêtes redondantes). Les types de ligne d'origine (commentaires
    `C`, etc.) sont **perdus**.
  - Étape 2 : `SELECT * FROM TabBl ORDER BY numfac` ; pour chaque BL avec `numfac` non nul, compteur
    `numero` sur 6 chiffres et `UPdate TabBl SET numfac = &3, dtefac = &4 WHERE numfac = &1 AND numbl
    = &2`. La numérotation repart de 000001 pour toute la table ; `Mid$(numfac, 2, 2)` suppose un
    ancien format de numéro (à confirmer). La variable `numfac` est affectée sans être utilisée.
  - Étape 3 : `SELECT * FROM TabLigbl ORDER BY numlig_ligbl` puis, pour chaque ligne, `UPdate TabLigbl
    SET tx_ligbl = "4", pu/qte/brut/rem/netht/nettc = Format$(Val(Utils.cpoint(x)), "0.00") WHERE
    num_ligbl = &1` : **toutes** les lignes du BL reçoivent les montants de la ligne courante (la
    clause `WHERE` ne porte que sur le numéro de BL), le dernier passage l'emporte. `Format$` produit
    le séparateur décimal de la locale (virgule en français) dans des colonnes `varchar(12)`.
  - Un grand bloc commenté (l.38-50) est un reliquat.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Cbase.Table("TabHisLigFac" | "TabBl" | "TabLigbl")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune réécriture sans comportement nouveau n'a d'intérêt : le script est destructeur. Proposition
  principale : **le supprimer** et retirer l'entrée de `Prgm` (anomalie A01, validation utilisateur).
- À défaut : supprimer le bloc commenté et la variable `numfac` inutilisée.

### Commonalisation avec d'autres fichiers

- La numérotation des factures relève de `Gestion/Facturation` (et du module mort
  [`VerifNumfac`](../VerifNumfac.module/architecture.md)) ; aucune mise en commun recommandée pour un
  script destiné à disparaître.

### Réduction de portée

- Aucune.

### Séparation traitement / GUI

- Déjà sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une contrainte d'unicité sur `Fiches_Bl.numfac` (hors valeurs nulles) empêcherait les doublons que
  ce script tente de réparer.
- Stocker les montants de `Fiches_Ligbl` en `DECIMAL` éviterait les formats dépendants de la locale.
