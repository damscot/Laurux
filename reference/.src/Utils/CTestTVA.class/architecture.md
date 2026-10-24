# CTestTVA — Architecture

> Source : `.src/Utils/CTestTVA.class`

## Vue d'ensemble

Classe utilitaire **statique** de calcul et de contrôle du **numéro de TVA intracommunautaire
français** : clé = `(12 + 3 × (SIREN mod 97)) mod 97`, numéro = `FR` + clé sur 2 chiffres + SIREN.
Le commentaire d'en-tête parle de « module » : la classe n'a que des membres `Static` et pourrait
être un `.module` (appels `CTestTVA.X` inchangés).

Utilisée par la fiche société (`Communs/Fsoc.class`) et la fiche fournisseur
(`Gestion/Tables/FFournisseur.class`). Nature globale : **calcul**, avec un `Message.Warning`.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `CleTVAIntra` | 6-10 | Public Static | 1 | 3 | 1 |  |
| `isIntraComValide` | 13-48 | Public Static | 6 | 26 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`CleTVAIntra(numsiren As String) As Integer`** [portée : nécessaire (`Fsoc.class:307`)] [nature :
  calcul]. Renvoie la clé (0 à 96). `CInt(numsiren)` lève une erreur si le SIREN n'est pas numérique
  ou dépasse la capacité d'un `Integer` (l'appelant `Fsoc` protège par `Try`). La clé est un entier :
  l'appelant concatène `"FR" & CStr(clé) & siren`, ce qui donne une clé sur **un** chiffre quand elle
  est inférieure à 10 (numéro invalide, voir anomalie A01).
- **`isIntraComValide(num As String, Optional siren As String) As Boolean`** [portée : nécessaire
  (`Fsoc.class:321`, `FFournisseur.class:654`)] [nature : mixte]. Nettoie (`UCase`, suppression des
  espaces), découpe : pays = 2 premiers caractères, clé d'origine = caractères 3-4 (chaîne), `fin` =
  à partir du 3ᵉ caractère. SIREN = paramètre nettoyé, sinon `Mid(fin, 3)`. Moins de 3 caractères →
  `Message.Warning` (couplage GUI) et `False`. Pays `FR` : recalcule la clé (formule **dupliquée** de
  `CleTVAIntra`) et renvoie `Len(fin) = 11 And Mid(fin, 3) = siren And clé_origine = clé`, la
  comparaison mêlant une chaîne (`"05"`) et un entier (5) — résultat à confirmer par test. Autre pays :
  pas de `Return` → `False`. SIREN non numérique (ex. clé alphanumérique) → erreur `CInt` non
  interceptée chez les appelants.

## État global utilisé

- Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- `isIntraComValide` appelle `CleTVAIntra(siren)` au lieu de recopier la formule.
- Transformer la classe en module `CTestTVA.module` (mêmes appels) ; nécessite de vérifier que rien
  ne l'instancie (`grep -rn "New CTestTVA" .src` : aucun résultat).

### Commonalisation avec d'autres fichiers

- `Fsoc` (l.300-325) et `FFournisseur` (l.650-660) dupliquent le nettoyage (`UCase(Replace(…, " ",
  ""))`, `Left$(…, 9)`) avant l'appel : une fonction `NumeroTVA(siren) As String` qui renverrait le
  numéro complet (avec clé sur 2 chiffres) éviterait la concaténation chez l'appelant (changement de
  comportement pour les clés < 10, voir A01).

### Réduction de portée

- Aucune (les deux fonctions sont appelées de l'extérieur).

### Séparation traitement / GUI

- Sortir le `Message.Warning` de `isIntraComValide` : fonction pure renvoyant `False`, l'appelant
  affichant le message (même texte, même moment).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
