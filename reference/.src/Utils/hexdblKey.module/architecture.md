# hexdblKey — Architecture

> Source : `.src/Utils/hexdblKey.module`

## Vue d'ensemble

Module **exporté** (`Export`), repris du « gambas-database-manager » de Benoît Minisini (licence GPL v3,
copyright Charlie Reinl 2009), qui **obscurcit** des chaînes : XOR octet par octet avec une clé
répétée et la constante 13, puis encodage hexadécimal. Laurux l'utilise pour stocker les mots de
passe dans `Laurux.conf` (base de données, SSH, vendeurs, administration, messagerie) et pour dériver
des codes (répertoires FTP de `FacturefmA`, `FClient`, `Site`).

Ce n'est **pas** un chiffrement : la clé est en dur dans le code (`"Laurux"` dans 29 appels,
`"LauruX2012"` dans 6), et l'opération est réversible par quiconque lit les sources.

Nature : **calcul pur**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Crypt` | 28-39 | Public | 4 | 10 | 16 |  |
| `Crypting` | 41-54 | Private | 3 | 11 | 0 |  |
| `ToHexaString` | 56-66 | Private | 2 | 8 | 0 |  |
| `FromHexaString` | 68-78 | Private | 2 | 8 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Crypt(sAction, sStrInput, sCryptKey) As String`** [portée : nécessaire] [nature : calcul].
  Normalise l'action (`Upper`, retrait de `"CRYPT"`) : `"de"`/`"decrypt"` → `Crypting(FromHexaString(
  entrée))`, `"en"`/`"encrypt"` → `ToHexaString(Crypting(entrée))`. Action inconnue → valeur de retour
  vide. `Catch` vide : toute erreur (par exemple une chaîne hexadécimale invalide, de longueur
  impaire) renvoie `""` silencieusement ; une clé vide provoque une erreur (`Asc` sur une chaîne vide,
  à confirmer) donc `""`.
- **`Crypting(sStr, sCryptKey)`** [Private] [nature : calcul]. `Chr$(Asc(s, i) Xor Asc(clé, j) Xor 13)`
  avec clé cyclique. Opère sur des **octets** (une lettre accentuée UTF-8 donne deux octets) :
  réversible.
- **`ToHexaString(sStr)`** [Private]. Chaque octet → 2 chiffres hexadécimaux majuscules.
- **`FromHexaString(sStr)`** [Private]. Inverse, par `Val("&H" & paire)`.

## État global utilisé

Aucun.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer la normalisation `Upper(Replace(Upper(sAction), Upper("crypt"), ""))` et le `Select` sur
  `Upper("de")` par des constantes ; comportement identique pour `"de"`, `"en"`, `"decrypt"`,
  `"encrypt"` (et toute casse).

### Commonalisation avec d'autres fichiers

- Les clés `"Laurux"` et `"LauruX2012"` sont répétées dans 16 fichiers : deux constantes
  `Public Const CLE_CONF`, `CLE_SSH` (dans ce module) éviteraient les fautes de frappe. À faire avec
  le rework de chaque appelant (même chaîne, aucun changement de comportement).

### Réduction de portée

- `Crypting`, `ToHexaString`, `FromHexaString` sont déjà `Private`. `Export` : à conserver tant que
  le composant est susceptible d'être réutilisé (aucun effet dans une application).

### Séparation traitement / GUI

- Sans objet (calcul pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les mots de passe stockés en base (vendeurs, `Fiches_Vendeurs` ?) et dans `Laurux.conf` devraient
  être hachés (vérification) ou confiés à un trousseau système (secrets réutilisés), plutôt
  qu'obscurcis. Changement de format des données stockées : migration nécessaire.
