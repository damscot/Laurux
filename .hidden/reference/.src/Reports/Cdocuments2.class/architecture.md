# Cdocuments2 — Architecture

> Source : `.src/Reports/Cdocuments2.class`

## Vue d'ensemble

`Cdocuments2` est une **copie ancienne de [`Cdocuments`](../Cdocuments.class/architecture.md)**
(`Inherits PdfWriter`) adaptée à une facture en **deux exemplaires côte à côte sur une page A4
paysage** : la plupart des méthodes de la famille facture (`Entete`, `Entete2`, `Logo`,
`Level1F`, `Level2F`, `Level3F`, `Level4aF`, `Level4bF`, `Level6F`, `Level7F`, `Level9F`,
`Level10F`, `Level15F`…) écrivent chaque élément deux fois, la seconde copie décalée d'environ
146 mm (x = 150 à 154 mm, ou 224/228 mm pour le destinataire et le logo), avec des polices plus
petites (5 à 8 points).

**La classe n'est plus instanciée** : la seule création (`New Cdocuments2("landscape", "mm",
"A4")` dans `Facture.class`) a été supprimée par le commit `a2e027f1` (2019-07-12,
« Factorisation des éditions de facture »), qui a confié les éditions de facture au report
[`Editfac`](../Editfac.class/architecture.md). Il ne reste qu'une déclaration inutilisée
`Private pdf2 As Cdocuments2` (`Facture.class:200`). `deps.py` ne signale pas la classe comme
jamais référencée (`jamais_reference = false`) parce que cette déclaration de type compte comme
une référence.

Mesure de duplication (`output/claude/2026-10-24_rework/phase1/tools/dup.py`, lignes de code
normalisées) : 528 lignes communes avec `Cdocuments` (926 / 986 lignes, ratio 0,55),
34 avec `Cdocuments3` (ratio 0,06). Par fonction : 25 identiques à `Cdocuments`, 32 homonymes
différentes, 2 propres à `Cdocuments2` (`_free`, `SignatureD2`).

Nature globale : **GUI (dessin PDF)**, sans SQL ni état global modifié. 59 méthodes, toutes
`Public`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
| `Coln` | var | Private |  | Boolean | 6 |
<!-- /AUTO:declarations -->

Variables d'instance sans mot-clé (donc `Private`) : `R`, `G`, `B` (couleur du thème, seule
couleur ; pas de `R2/G2/B2` contrairement à `Cdocuments`), `Coln`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-15 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 17-19 | Public | 1 | 2 | 0 | méthode spéciale |
| `EnteteN` | 22-30 | Public | 1 | 7 | 0 | portée réductible ? |
| `EnteteP` | 33-41 | Public | 1 | 7 | 0 | portée réductible ? |
| `Lines` | 44-50 | Public | 1 | 5 | 0 | portée réductible ? |
| `LinesP` | 53-59 | Public | 1 | 5 | 0 | portée réductible ? |
| `Entete` | 61-181 | Public | 12 | 117 | 0 | portée réductible ? |
| `Entete2` | 184-228 | Public | 2 | 41 | 0 | portée réductible ? |
| `Logo2` | 230-243 | Public | 5 | 11 | 0 | portée réductible ? |
| `Logo` | 245-268 | Public | 7 | 21 | 0 | portée réductible ? |
| `Level1` | 271-281 | Public | 1 | 9 | 0 | portée réductible ? |
| `Level2` | 284-299 | Public | 2 | 14 | 0 | portée réductible ? |
| `Level3` | 302-326 | Public | 4 | 23 | 0 | portée réductible ? |
| `Level3bis` | 328-334 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level1R` | 337-344 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level2R` | 347-357 | Public | 1 | 9 | 0 | portée réductible ? |
| `Level3R` | 360-369 | Public | 1 | 8 | 0 | portée réductible ? |
| `Level4R` | 372-378 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level4RB` | 381-387 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level4` | 390-398 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level1F` | 401-424 | Public | 1 | 22 | 0 | portée réductible ? |
| `Level1DP` | 427-433 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level2F` | 436-503 | Public | 27 | 66 | 0 | portée réductible ? |
| `Level2Fa` | 506-521 | Public | 1 | 14 | 0 | portée réductible ? |
| `Level3F` | 524-549 | Public | 8 | 24 | 0 | portée réductible ? |
| `Colonnes` | 551-588 | Public | 1 | 36 | 0 | portée réductible ? |
| `Level4F` | 591-600 | Public | 2 | 8 | 0 | portée réductible ? |
| `Level4aF` | 603-612 | Public | 2 | 8 | 0 | portée réductible ? |
| `Level4bF` | 615-623 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level5F` | 626-634 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level6F` | 637-673 | Public | 7 | 35 | 0 | portée réductible ? |
| `Level7F` | 676-716 | Public | 11 | 39 | 0 | portée réductible ? |
| `Level8F` | 719-728 | Public | 2 | 7 | 0 | portée réductible ? |
| `Level9F` | 731-744 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level10F` | 747-824 | Public | 31 | 70 | 0 | portée réductible ? |
| `Level11F` | 827-836 | Public | 1 | 8 | 0 | portée réductible ? |
| `Level12F` | 839-846 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level13F` | 849-861 | Public | 5 | 11 | 0 | portée réductible ? |
| `LevelM` | 864-888 | Public | 2 | 22 | 0 | portée réductible ? |
| `Level2M` | 891-897 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level14F` | 900-910 | Public | 1 | 9 | 0 | portée réductible ? |
| `Signature` | 913-924 | Public | 4 | 9 | 0 | portée réductible ? |
| `Level15F` | 927-944 | Public | 1 | 16 | 0 | portée réductible ? |
| `Level16F` | 946-960 | Public | 1 | 11 | 0 | portée réductible ? |
| `SignatureD` | 963-974 | Public | 4 | 9 | 0 | portée réductible ? |
| `SignatureD2` | 976-987 | Public | 4 | 9 | 0 | portée réductible ? |
| `Level1br` | 991-1024 | Public | 1 | 31 | 0 | portée réductible ? |
| `Level2br` | 1028-1040 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level3br` | 1043-1049 | Public | 1 | 5 | 0 | portée réductible ? |
| `EnteteD` | 1052-1060 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level1D` | 1063-1076 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level2D` | 1079-1091 | Public | 1 | 11 | 0 | portée réductible ? |
| `BasPage` | 1094-1100 | Public | 1 | 5 | 0 | portée réductible ? |
| `BasPageP` | 1103-1109 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level1FAM` | 1112-1125 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level2FAM` | 1128-1141 | Public | 1 | 12 | 0 | portée réductible ? |
| `Level1RL` | 1145-1152 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level2RL` | 1155-1169 | Public | 2 | 13 | 0 | portée réductible ? |
| `Level5RL` | 1172-1178 | Public | 1 | 5 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les méthodes sont [portée : réductible] au sens où aucune n'a d'appelant (classe jamais
instanciée) et [nature : GUI] ; leur sort commun est la suppression (CDOCUMENTS2-001). Elles
sont décrites par rapport à `Cdocuments`.

### Identiques à `Cdocuments` (25)

`EnteteN`, `EnteteP`, `Lines`, `Level1`, `Level2`, `Level3`, `Level3bis`, `Level1R`,
`Level2R`, `Level3R`, `Level4R`, `Level4RB`, `Level4`, `Level1DP`, `Level13F`, `LevelM`,
`Level2M`, `Level14F`, `Signature`, `EnteteD`, `BasPage`, `BasPageP`, `Level1FAM`,
`Level2FAM`, `Level1RL` : voir [Cdocuments — architecture](../Cdocuments.class/architecture.md).

### Variantes « deux exemplaires » de la facture

- **`_new()`** : couleurs `Start.R/G/B` seulement. **`_free()`** : vide.
- **`Entete(… 18 paramètres)`** (sans `Libre`, contrairement à `Cdocuments.Entete`) : deux
  cadres société (6-70 et 152-214 mm), `Logo()` systématique, adresse dupliquée. Défauts de la
  copie de droite : ligne 107 imprime `ville` au lieu de `cap`, ligne 176 `mail` au lieu de
  `iban` ; `ape` n'est pas dupliqué. Sans effet : code jamais exécuté.
- **`Entete2(…)`** : deux cadres destinataire (76-140 et 222-282 mm).
- **`Logo()`** : logo 40 × 20 mm imprimé deux fois (x = 84 puis 228) ; même division
  `L / L2` que `Cdocuments.Logo` (voir CDOCUMENTS-A02). **`Logo2()`** : variante 40 × 40 mm.
- **`LinesP`** (300 mm au lieu de 302), **`Level1F`**, **`Level2F`**, **`Level2Fa`**,
  **`Level3F`**, **`Colonnes`**, **`Level4F`**, **`Level4aF`**, **`Level4bF`**, **`Level5F`**,
  **`Level6F`**, **`Level7F`**, **`Level8F`**, **`Level9F`**, **`Level10F`** (CC 31, maximum du
  fichier), **`Level11F`**, **`Level12F`**, **`Level15F`**, **`Level16F`**, **`SignatureD`**,
  **`SignatureD2`** (signature du second exemplaire) : mêmes rôles que dans `Cdocuments`, avec
  positions et polices réduites et duplication à droite.
- **`Level1br`**, **`Level2br`**, **`Level3br`**, **`Level1D`**, **`Level2D`** (9 paramètres
  au lieu de 12), **`Level2RL`**, **`Level5RL`** : variantes de mise en page des listes,
  divergentes de `Cdocuments` (polices, largeurs).

Absentes de `Cdocuments2` : `EnteteV`, `Level4V`, `LinesLG`, `Entete3`, `Logo3`, `Level1bis`,
`Level4D`, `Level1LV`, `Level2FAC`, `Level3FAC`, `Level10F2`, `Level10F3`, `Level2DLG`,
`Level2DLG2`, `Level4RL`.

## État global utilisé

- `Start.R/G/B` ; `Start.LocalSettings["/Soc" & Start.Societe & "/…"]` (`glogo`, `Logo`,
  `AutoEnt`, `Franchise`, `Taxe`, `Devis2`) ; `Variables.bRemise`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : la classe est sans appelant depuis 2019. Si l'impression en double exemplaire devait
  revenir, elle se ferait dans le report `Editfac` (deux pages ou `NumCopies`), pas en
  réactivant ce gabarit.

### Commonalisation avec d'autres fichiers

- Sans objet (suppression). Les 25 fonctions identiques existent déjà dans
  [`Cdocuments`](../Cdocuments.class/architecture.md).

### Réduction de portée

- Sans objet (suppression de la classe entière).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
