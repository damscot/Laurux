# Cstocks — Architecture

> Source : `.src/Reports/Cstocks.class`

## Vue d'ensemble

`Cstocks` est le **gabarit PDF des éditions d'inventaire et de stock par dépôt**
(`Inherits PdfWriter`, voir [PdfWriter](../PdfWriter.class/architecture.md)). Il sert de squelette
d'édition paginée commun à :

- l'inventaire de fin d'année et l'inventaire tournant (`.src/Gestion/Stock/Inventaires`) :
  feuille de comptage (`Geninv`, `GeninvT`), valorisation de l'inventaire (`Edinv`, et les écrans
  morts `Edinv1`, `EdinvT`), articles non saisis (`Ednsaisis`, `EdnsaisisT`), écarts (`Ecarts`,
  `EcartsT`) ;
- le stock et les mouvements des dépôts (`.src/Gestion/Depots`) : `ImpDepots`, `Edsdepots`.

Chaque écran ouvre `New Cstocks("Portrait", "mm", "A4")`, appelle `Open`/`AliasNbPages`, puis la
séquence `Entete` → en-tête `Level1x` → lignes `Level2x` → (saut de page : `BasPage`, `Entete`,
`Level1x`) → total `Level3x` ou `Lines` → `BasPage` → `Output`. Les seuils de saut de page
(270, 280, 283 ou 288 mm) et la position de reprise sont propres à chaque écran.

Rendu pur : aucune base, aucun calcul ; valeurs déjà formatées par l'appelant. Contrairement à
[Carticles](../Carticles.class/architecture.md), la couleur de fond n'est pas fixée dans `_new`
mais à chaque en-tête (`SetFillColor(R, G, B)`), d'où les membres `R`/`G`/`B` réellement utilisés.

| Édition (appelant) | En-tête | Lignes | Total |
|---|---|---|---|
| Valorisation (`Edinv`, `Edinv1`, `EdinvT`) | `Level1`, `Entetefam` (rupture famille) | `Level2` | `level3fam` (sous-total famille), `Level3` |
| Feuille de comptage (`Geninv`, `GeninvT`) | `Level1G` | `Level2G` + `Lines` | — |
| Non saisis (`Ednsaisis`, `EdnsaisisT`) | `Level1NS` | `Level2NS` | `Level3NS` |
| Écarts (`Ecarts`, `EcartsT`) | `Level1E` | `Level2E` | `Level3E` |
| Stock d'un dépôt chiffré / non chiffré (`ImpDepots`) | `Level3D` / `Level1D` | `Level4D` / `Level2D` | `Lines` |
| Mouvements des dépôts (`Edsdepots`) | `Level1M` | `Level2M` | `Lines` |

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 4 |
| `G` | var | Private |  | Integer | 5 |
| `B` | var | Private |  | Integer | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-14 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 16-18 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 20-28 | Public | 1 | 7 | 11 |  |
| `Entetefam` | 30-38 | Public | 1 | 7 | 2 |  |
| `BasPage` | 41-48 | Public | 1 | 6 | 11 |  |
| `Lines` | 51-57 | Public | 1 | 5 | 4 |  |
| `Level1` | 60-74 | Public | 1 | 12 | 3 |  |
| `Level2` | 77-90 | Public | 1 | 11 | 3 |  |
| `Level1G` | 93-107 | Public | 1 | 12 | 2 |  |
| `Level2G` | 110-123 | Public | 1 | 11 | 2 |  |
| `Level3` | 126-141 | Public | 1 | 13 | 3 |  |
| `level3fam` | 143-154 | Public | 1 | 9 | 2 |  |
| `Level1NS` | 156-169 | Public | 1 | 11 | 2 |  |
| `Level2NS` | 172-184 | Public | 1 | 10 | 2 |  |
| `Level3NS` | 187-202 | Public | 1 | 13 | 2 |  |
| `Level1E` | 205-221 | Public | 1 | 14 | 2 |  |
| `Level2E` | 224-239 | Public | 1 | 13 | 2 |  |
| `Level3E` | 242-257 | Public | 1 | 13 | 2 |  |
| `Level1D` | 261-272 | Public | 1 | 9 | 1 |  |
| `Level2D` | 275-285 | Public | 1 | 8 | 1 |  |
| `Level3D` | 288-302 | Public | 1 | 12 | 1 |  |
| `Level4D` | 304-317 | Public | 1 | 11 | 1 |  |
| `Level1M` | 322-336 | Public | 1 | 12 | 1 |  |
| `Level2M` | 339-352 | Public | 1 | 11 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et cadre de page

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : copie `Start.R/G/B` dans les
  membres privés `R`/`G`/`B` (pas de `SetFillColor` ici).
- **`_free()`** — vide, **code mort**.
- **`Entete(sEntete)`** [portée : nécessaire, 11 appelants] [nature : GUI] : `AddPage`, titre
  Helvetica gras italique 16 sur 206 mm à x = 2, y = 5, fond couleur du thème.
- **`BasPage()`** [portée : nécessaire, 11 appelants] [nature : GUI] : pied « Page n/{nb} - date -
  Impression demandée par … » (copie du `Footer` de `Carticles`, sous un autre nom ; déclaré
  `Function` sans type de retour). `Edsdepots` l'oublie au saut de page des entrées (pied absent
  sur ces pages, comportement de l'appelant).
- **`Lines(PosY As String)`** [portée : nécessaire] [nature : GUI] : `SetXY(7, PosY)` sans effet
  visible, épaisseur 0,1, trait de 2 à 208 mm. `PosY` typé `String` (appelants : `Integer`).

### Inventaire valorisé

- **`Level1()`** [portée : nécessaire] : en-tête Code / Intitulé / Quantité / Prix unitaire /
  Valeur PA / Valeur PMP à x = 3, y = 15, hauteur 6.
- **`Level2(code, designation, qtecomptee, pu, Pht, Pmp, PosY)`** [portée : nécessaire] : ligne,
  police 8, quantité alignée à gauche.
- **`Entetefam(cle, fam, posy)`** / **`level3fam(cle, fam, totpa, totpmp, posy)`** [portée :
  nécessaire (`Edinv`, `Edinv1`)] : bandeau de famille (police gras italique 10, hauteur 4) et
  sous-total ; dans `level3fam`, la cellule « Total famille … » (175 mm depuis x = 2) est
  recouverte de 163 à 177 mm par les deux cellules de valeurs (x = 163).
- **`Level3(Totpa, Totpmp, PosY)`** [portée : nécessaire] : en-têtes « Valeur PA »/« Valeur PMP »
  à x = 163, puis 8 mm plus bas « Total inventaire » à x = 120 et les deux totaux suivis d'un
  espace. Modifie son paramètre `PosY` (passage par valeur : sans effet pour l'appelant).

### Feuille de comptage, non saisis, écarts

- **`Level1G()` / `Level2G(Nlig, code, designation, casier, qteStock, qtecomptee, PosY)`** :
  6 colonnes (n° de ligne, code, intitulé, casier, stock informatique, quantité comptée).
- **`Level1NS()` / `Level2NS(…)` / `Level3NS(…)`** : non saisis, 5 colonnes à x = 10 ; total
  « Total des non saisis » (même schéma que `Level3`, abscisses 150/110).
- **`Level1E()` / `Level2E(…)` / `Level3E(…)`** : écarts, 8 colonnes, police 8 (en-tête) et 7
  (lignes, total) ; total « Total des écarts » (abscisses 172/140).

Toutes : [portée : nécessaire] [nature : GUI].

### Dépôts

- **`Level1D()` / `Level2D(code, intitule, qte, Posy)`** : stock non chiffré, 3 colonnes à x = 36.
- **`Level3D()` / `Level4D(code, intitule, pvht, Tva, pvttc, qte, posy)`** : stock chiffré,
  6 colonnes à x = 10 ; l'en-tête de la colonne taxe est le libellé société
  `Start.LocalSettings["/Soc<XX>/Taxe"]`, aligné à gauche (les autres sont centrés).
- **`Level1M()` / `Level2M(code, intitule, dater, qtem, depot, com, Posy)`** : mouvements,
  6 colonnes à x = 2.

Toutes : [portée : nécessaire] [nature : GUI].

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (lus dans `_new`, appliqués à chaque en-tête).
- `Start.LocalSettings["/Soc" & Start.Societe & "/Taxe"]` (`Level3D`).
- `User.Name`, `Date(Now)` (pied de page, à masquer dans les tests).
- Aucun accès SQL.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_free`. Les 7 couples en-tête/ligne et les 3 totaux (`Level3`, `Level3NS`,
  `Level3E`, même schéma à des abscisses près) passent par les helpers `EnteteColonnes` /
  `LigneColonnes` (CARTICLES-005) et un helper `TotalPaPmp(xEntete, xLibelle, largeurLibelle,
  libelle, largeur, taille, totpa, totpmp, PosY)`.
- **Squelette d'édition paginée** (relevé par les inventaires : [Ecarts](../../Gestion/Stock/Inventaires/Fin-annee/Ecarts.class/architecture.md),
  [EcartsT](../../Gestion/Stock/Inventaires/Tournant/EcartsT.class/architecture.md),
  [Ednsaisis](../../Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class/architecture.md),
  [EdnsaisisT](../../Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class/architecture.md),
  [Edinv](../../Gestion/Stock/Inventaires/Fin-annee/Edinv.class/architecture.md),
  [Geninv](../../Gestion/Stock/Inventaires/Fin-annee/Geninv.class/architecture.md), et les dépôts
  [ImpDepots](../../Gestion/Depots/ImpDepots.class/architecture.md),
  [Edsdepots](../../Gestion/Depots/Edsdepots.class/architecture.md)) : chaque écran recopie le
  bloc « `If PosY >= seuil Then BasPage, Entete(titre), Level1x, PosY = reprise` ». Proposition :
  `DebutEdition(sTitre, iEntete)` (mémorise le titre et le type d'en-tête, imprime `Entete` +
  en-tête) et `SautDePageSi(PosY, iSeuil, iReprise, Optional bPied = True) As Integer` (renvoie la
  nouvelle position). Le type d'en-tête est une énumération (`Ent_Inventaire`, `Ent_Comptage`,
  `Ent_NonSaisis`, `Ent_Ecarts`, `Ent_DepotChiffre`, `Ent_Depot`, `Ent_Mouvements`) plutôt qu'un
  `Object.Call` sur un nom. `bPied = False` conserve le comportement d'`Edsdepots` (entrées sans
  pied). Les seuils et positions de reprise restent ceux de chaque écran : PDF identique.

### Commonalisation avec d'autres fichiers

- Base commune `PdfLaurux` (CARTICLES-004) : `Entete` → `TitrePage`, `BasPage` →
  `PiedDePage(190)`, `Lines` → `Trait(y, 2, 208)`, couleur du thème. `BasPage` est le même code
  que [Cclients](../Cclients.class/architecture.md) (largeur 206) et que les gabarits comptables
  ([Cbalances](../Cbalances.class/architecture.md), [Ccompta](../Ccompta.class/architecture.md)).
- Les totaux PA/PMP (`Level3`, `Level3NS`, `Level3E`, `level3fam`) et `Carticles.Level5`
  (stock chiffré) impriment la même paire « Total PA / Total PMP » : un seul helper `TotalPaPmp`.
- `Level3D`/`Level4D` (stock chiffré d'un dépôt) et `Level1MO` de `Carticles` lisent le même
  libellé de taxe `/Soc<XX>/Taxe`.

### Réduction de portée

- Aucune : toutes les méthodes ont au moins un appelant externe vivant (`Edinv1` et `EdinvT` sont
  morts, mais `Edinv` utilise les mêmes méthodes : rien ne devient mort si EDINV1-A01 et
  EDINVT-A01 sont validées).

### Séparation traitement / GUI

- Sans objet (rendu pur). Les montants sont formatés par les appelants.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
