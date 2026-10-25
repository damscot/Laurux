# Cmat — Architecture

> Source : `.src/Reports/Cmat.class`

## Vue d'ensemble

`Cmat` est le **gabarit PDF de la liste des matériels** (`Inherits PdfWriter`, voir
[PdfWriter](../PdfWriter.class/architecture.md)), utilisé uniquement par l'édition
[EdMat](../../Gestion/Impressions/EdMat.class/architecture.md) (`~/tmp/Tarif2.pdf` : matériels
vendus, en stock ou tous). Il comprend un titre (`Entete`), un pied (`Footer`), un en-tête de
colonnes (`Level1`) et une ligne de détail (`Level2`) : code, intitulé, marque, type, n° de série,
propriétaire, PV HT, PV TTC.

C'est une **copie réduite de [Carticles](../Carticles.class/architecture.md)** : `_new`, `_free`,
`Footer`, `Ligne` et `Ligne2` sont identiques au caractère près, `Entete` ne diffère que par
l'abscisse du titre (x = 2 ici, 40 dans `Carticles`). Rendu pur : aucune base, aucun calcul.

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
| `_new` | 9-16 | Public | 1 | 6 | 0 | méthode spéciale |
| `_free` | 18-20 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 22-29 | Public | 1 | 6 | 1 |  |
| `Footer` | 32-38 | Public | 1 | 5 | 1 |  |
| `Level1` | 41-54 | Public | 1 | 12 | 1 |  |
| `Level2` | 57-72 | Public | 1 | 13 | 1 |  |
| `Ligne` | 74-78 | Public | 1 | 3 | 0 | portée réductible ? |
| `Ligne2` | 80-84 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes [nature : GUI].

- **`_new()`** [portée : nécessaire (spéciale)] : copie `Start.R/G/B` dans `R`/`G`/`B` (utilisés
  seulement ici) puis `SetFillColor`.
- **`_free()`** — vide, **code mort**.
- **`Entete(sEntete)`** [portée : nécessaire] : `AddPage`, titre gras italique 16 sur 206 mm à
  x = 2, y = 5.
- **`Footer()`** [portée : nécessaire] : pied « Page n/{nb} - date - Impression demandée par … »
  (surcharge de `PdfWriter.Footer`, appelée explicitement par `EdMat`).
- **`Level1()`** [portée : nécessaire] : en-tête de 8 colonnes (206 mm) à x = 2, y = 16, police 9.
- **`Level2(code, intitule, marque, type, serie, proprietaire, pvht, pvttc, PosY)`** [portée :
  nécessaire] : ligne police 8, hauteur 5, prix alignés à droite. Le paramètre `type` porte le
  nom d'un mot-clé de Gambas (accepté par le compilateur).
- **`Ligne(PosY)`**, **`Ligne2(PosY)`** — **code mort** (aucun appel, vérifié par `grep` : `EdMat`
  n'appelle ni l'un ni l'autre ; signaux `unused` et « portée réductible » de l'heuristique).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` ; `User.Name`, `Date(Now)` (pied).
- Aucun accès SQL (les données sont lues par `EdMat` dans `Fiches_Materiels`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_free`, `Ligne`, `Ligne2` et les membres `R`/`G`/`B`.
- `Level1`/`Level2` via `EnteteColonnes`/`LigneColonnes` (CARTICLES-005).

### Commonalisation avec d'autres fichiers

- Base commune `PdfLaurux` (CARTICLES-004) : après passage à `Inherits PdfLaurux`, `Cmat` ne
  garde que `Entete` (délégation à `TitrePage`), `Footer` (délégation à `PiedDePage(190)`),
  `Level1` et `Level2`.
- Alternative : fusionner `Cmat` dans [Carticles](../Carticles.class/architecture.md) (méthodes
  `Level1Mat`/`Level2Mat`) ; écartée tant que `Carticles.Entete` place le titre à x = 40
  (CARTICLES-A02) : la fusion changerait le titre de la liste des matériels.

### Réduction de portée

- Aucune : `Ligne`/`Ligne2` sont supprimés plutôt que rendus privés.

### Séparation traitement / GUI

- Sans objet (rendu pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
