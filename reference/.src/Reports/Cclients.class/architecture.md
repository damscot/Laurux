# Cclients — Architecture

> Source : `.src/Reports/Cclients.class`

## Vue d'ensemble

`Cclients` est le **gabarit PDF des listes de tiers** (`Inherits PdfWriter`, voir
[PdfWriter](../PdfWriter.class/architecture.md)) : liste des clients (`EdClient`), liste des
fournisseurs en paysage (`EdFour`), et listes des clients créés par les imports comptables
(`ImpJdv` pour le journal des ventes, `ImpSage` pour l'import Sage).

Il fournit deux jeux de cadre de page : portrait (`Entete`, `Lines`, `BasPage`, largeur 206 mm)
et paysage (`EnteteP`, `LinesP`, `BasPageP`, largeur 292 mm), plus les en-têtes et lignes des
clients (`Level1`/`Level2`, deux lignes par tiers), des clients Sage (`Level2S`) et des
fournisseurs (`Level1F`/`Level2F`, une ligne). Rendu pur : aucune base, aucun calcul.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-14 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 16-18 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 21-29 | Public | 1 | 7 | 3 |  |
| `EnteteP` | 32-40 | Public | 1 | 7 | 1 |  |
| `Level1` | 43-60 | Public | 1 | 16 | 3 |  |
| `Level2` | 64-83 | Public | 1 | 18 | 2 |  |
| `Level2S` | 86-100 | Public | 1 | 13 | 1 |  |
| `Level1F` | 103-117 | Public | 1 | 13 | 1 |  |
| `Level2F` | 121-135 | Public | 1 | 13 | 1 |  |
| `Lines` | 138-144 | Public | 1 | 5 | 3 |  |
| `BasPage` | 147-153 | Public | 1 | 5 | 4 |  |
| `LinesP` | 156-162 | Public | 1 | 5 | 1 |  |
| `BasPageP` | 165-171 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes [nature : GUI].

- **`_new()`** [portée : nécessaire (spéciale)] : copie `Start.R/G/B` dans `R`/`G`/`B` (utilisés par
  `Entete`/`EnteteP`, pas de `SetFillColor` ici).
- **`_free()`** — vide, **code mort**.
- **`Entete(ent)`** / **`EnteteP(ent)`** [portée : nécessaire] : `AddPage`, titre Helvetica **gras**
  16 (gras italique dans les autres gabarits), fond couleur du thème, sur 206 mm (portrait) ou
  292 mm (paysage) à x = 2.
- **`Level1()`** [portée : nécessaire (`EdClient`, `ImpJdv`, `ImpSage`)] : en-tête sur deux lignes
  (y = 20 et 25) ; la cellule « Code » occupe les deux lignes (hauteur 10), les autres 5 mm.
  Les colonnes de la 2e ligne (adresse 1, adresse 2, ville, portable, remise article)
  correspondent à la 2e ligne de `Level2`.
- **`Level2(code, intitule, prenom, adr1, adr2, cp, ville, TelBur, TelPble, rmo, rart, PosY,
  reglt)`** [portée : nécessaire] : deux lignes de 4 mm (y = `PosY` et `PosY + 5`) ; la 2e ligne
  commence par le mode de règlement `reglt` sous le code. ⚠️ `reglt` est le **13e paramètre,
  obligatoire**, alors qu'`ImpJdv` n'en passe que 12 (`ImpJdv.class:205`) : erreur « Not enough
  arguments » à la première création de client lors d'un import du journal des ventes
  (IMPJDV-A04, CCLIENTS-A01 ; signal `arity_errors` d'`ImpJdv`). `EdClient` passe bien 13
  arguments.
- **`Level2S(code, intitule, adr1, adr2, cp, ville, dom, codebanque, codeguichet, numcompte,
  PosY)`** [portée : nécessaire (`ImpSage`)] : variante Sage ; `dom`, `codebanque` et
  `codeguichet` ne sont **pas imprimés** (`ImpSage` passe d'ailleurs `""`) ; `numcompte` est
  imprimé sous le code.
- **`Level1F()`** / **`Level2F(…)`** [portée : nécessaire (`EdFour`)] : 9 colonnes sur 292 mm,
  une ligne de 4 mm par fournisseur.
- **`Lines(PosY As String)`** / **`LinesP(PosY As String)`** [portée : nécessaire] : `SetXY(7, PosY)`
  sans effet visible, épaisseur 0,1, trait de 2 à 206 mm (resp. 292 mm). `PosY` typé `String`.
- **`BasPage()`** / **`BasPageP()`** [portée : nécessaire] : pied « Page n/{nb} - date -
  Impression demandée par … » centré sur 206 mm (resp. 292 mm) à 10 mm du bas. `EdFour` termine
  son document paysage par `BasPage` au lieu de `BasPageP` (EDFOUR-A01, défaut de l'appelant).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` ; `User.Name`, `Date(Now)` (pied).
- Aucun accès SQL.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_free`.
- Factoriser les couples portrait/paysage : `Entete`/`EnteteP`, `Lines`/`LinesP`,
  `BasPage`/`BasPageP` ne diffèrent que par la largeur → une méthode de la base commune avec la
  largeur en paramètre ; les 6 noms publics restent et délèguent.
- `Level2S` : retirer les trois paramètres jamais imprimés (`dom`, `codebanque`, `codeguichet`),
  avec mise à jour des 3 appels d'`ImpSage` (même PDF).
- En-têtes et lignes via `EnteteColonnes`/`LigneColonnes` (helpers proposés par
  [Carticles](../Carticles.class/architecture.md)) ; la cellule « Code » double hauteur de
  `Level1` reste un appel `Cell` explicite.

### Commonalisation avec d'autres fichiers

- Base commune `PdfLaurux` (CARTICLES-004) : `TitrePage`, `PiedDePage(largeur)`, `Trait`,
  couleur du thème. `BasPage` est le même code que celui de [Cstocks](../Cstocks.class/architecture.md)
  à la largeur près (206 au lieu de 190) ; le couple portrait/paysage existe aussi dans
  [Cdocuments](../Cdocuments.class/architecture.md) et [Cdocuments2](../Cdocuments2.class/architecture.md)
  (pied sur 190 et 288 mm).
- Les listes de tiers d'`EdClient` et `EdFour` partagent le squelette « liste paginée avec trait
  entre les lignes » ; même proposition `DebutEdition`/`SautDePageSi` que dans
  [Cstocks](../Cstocks.class/architecture.md) (CSTOCKS-006), à appliquer dans un second temps.

### Réduction de portée

- Aucune : les 11 méthodes non spéciales ont un appelant externe.

### Séparation traitement / GUI

- Sans objet (rendu pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
