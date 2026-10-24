# Numtostring — Architecture

> Source : `.src/Utils/Numtostring.module`

## Vue d'ensemble

Module de **conversion d'un montant en toutes lettres** (français), adapté d'un code d'origine
espagnole (noms `palabraPlural`, `monedaPlural`, commentaires en espagnol). `Convertir(valeur,
devise)` sépare la partie entière et les centimes et assemble « *n* devise et *m* centime(s) » ;
`Num2Text(n)` écrit un entier en lettres de façon récursive.

Utilisé pour le « total document en lettres » des factures (`ObjFac`) et pour le solde en lettres
des relevés de relance (`FRelFacture`). Un module quasi homonyme existe pour la caisse,
`.src/Caisse/numtostring.module` (`nbtostring`, `Calc_unite`, `Calc_Dizaine`), mais **il n'est pas
compilé** : les deux noms ne diffèrent que par la casse et un seul `.gambas/NUMTOSTRING` est produit,
celui-ci (vérifié avec gbc3/gbx3 et `strings`, corrigé après le lot Caisse, NUMTOSTRING_CAISSE-A01).

Nature globale : **calcul pur** (aucun accès base, aucun contrôle).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Convertir` | 3-52 | Public | 14 | 47 | 2 |  |
| `palabraPlural` | 54-58 | Public | 1 | 3 | 0 | portée réductible ? |
| `Num2Text` | 64-179 | Public | 58 | 94 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Convertir(valor As Float, devise As String) As String`** [portée : nécessaire] [nature : calcul].
  Devise par défaut `"euro"` si `Null`. Négatif → préfixe `"Moins "` et valeur absolue.
  `i = Int(valor)`, `r = (valor - i) * 100`.
  - `i = 0` : renvoie « *r* centime(s) » suivi d'un espace ; **`r` n'est pas arrondi** dans cette
    branche (0,29 → `r` = 28,999… puis conversion en `Long` dans `Num2Text`, résultat à confirmer).
  - `i > 0` et `r = 0` : « *i* devise ».
  - sinon `r = Int(Round(r, -1))` (arrondi au dixième puis **troncature**) et « *i* devise et *r*
    centime(s) ».
  - Aucune valeur renvoyée (donc `""`) pour 0, pour `0 < r < 1` et quand `r` tronqué vaut 0.
  Le singulier/pluriel ne joue que sur `r = 1` / `i = 1` ; `palabraPlural` ne pluralise plus rien.
- **`palabraPlural(texto)`** [portée : réductible (aucun appelant externe, grep)] [nature : calcul].
  Renvoie `texto` inchangé (le `& "s"` est commenté).
- **`Num2Text(value As Long) As String`** (CC la plus élevée) [portée : nécessaire] [nature : calcul].
  Table explicite de 0 à 20 et des dizaines, puis récursion : 71-79 et 91-99 via `10 + value Mod 10`,
  « et un » pour 21…61 **et 81** (« quatre vingt et un »), centaines, milliers, millions jusqu'à
  10¹². Écarts à l'orthographe : pas de traits d'union, pas de « s » à vingt/cent, `1000` →
  `"mille "` (espace final), `1 000 000` → `"un million zéro"`, millions suivis de deux espaces.
  Ligne 137 (`value = 800`) inatteignable (déjà traitée l.130). Valeurs entre 10¹² et 2·10¹² : aucun
  retour ; ≥ 2·10¹² : `""`. Valeurs négatives : non gérées (récursion incohérente).

## État global utilisé

- Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la cascade de 30 `If value = n Then Return …` par un tableau `["zéro", "un", …,
  "dix neuf"]` et un tableau des dizaines ; CC divisée par ~4, résultats identiques.
- Supprimer la ligne morte l.137 et les blocs commentés l.88-97.
- Traduire les noms et commentaires espagnols (documentation).

### Commonalisation avec d'autres fichiers

- [`Caisse/numtostring.module`](../../Caisse/numtostring.module/architecture.md) réimplémente la même
  fonction (`nbtostring`, appelée par `Caisse.Imp_Cheque`, `Caisse.class:5064-5069`) avec ses propres
  règles, mais n'est pas compilé : ces appels visent ce module-ci, qui n'a pas `nbtostring`, et
  l'impression d'un chèque en caisse échoue (NUMTOSTRING_CAISSE-A01). Un seul module de conversion
  devrait servir les deux usages (appeler `Numtostring.Num2Text` depuis la caisse). Les sorties diffèrent
  probablement (orthographe) : la fusion nécessite des tests de caractérisation des deux modules
  et la validation utilisateur pour l'orthographe retenue.
- `FRelFacture.Solde` (`Compta/Relances/FRelFacture.class:445`) recombine `Num2Text` à la main ; il
  n'est plus appelé (appel commenté l.426).
- **Attention à la casse** : `Utils/Numtostring` et `Caisse/numtostring` ne diffèrent que par la
  majuscule. Vérifié : un seul des deux est compilé (celui-ci), donc `FRelFacture.class:464`
  (`numtostring.Num2Text`) vise bien ce module ; l'appel est de toute façon du code mort.

### Réduction de portée

- `palabraPlural` → `Private`.

### Séparation traitement / GUI

- Sans objet (calcul pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
