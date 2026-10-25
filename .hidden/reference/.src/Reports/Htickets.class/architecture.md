# Htickets — Architecture

> Source : `.src/Reports/Htickets.class`

## Vue d'ensemble

`Htickets` est le **gabarit PDF de réimpression d'un ticket de caisse archivé**
(`Inherits PdfWriter`, voir [PdfWriter](../PdfWriter.class/architecture.md)), utilisé uniquement
par [ArchivesTck](../../Archivages/ArchivesTck.class/architecture.md) (`Button4_Click`,
`~/tmp/Hticket.pdf`). Le ticket est imprimé sur une page A4 : en-tête société ligne par ligne
(`Entete2`), lignes du ticket et totaux (`Level4`, 4 colonnes code / intitulé / prix / quantité).

Rendu pur : aucune base, aucun calcul. Le gabarit ne gère **aucune pagination** ; l'appelant non
plus (voir HTICKETS-A01).

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
| `Entete` | 20-24 | Public | 1 | 3 | 1 |  |
| `Entete2` | 26-32 | Public | 1 | 5 | 1 |  |
| `Footer` | 35-42 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level4` | 45-54 | Public | 1 | 8 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes [nature : GUI].

- **`_new()`** [portée : nécessaire (spéciale)] : copie `Start.R/G/B` dans `R`/`G`/`B`, utilisés
  seulement par `Footer` (mort).
- **`_free()`** — vide, **code mort**.
- **`Entete()`** [portée : nécessaire] : `AddPage` seul (sans titre, contrairement aux autres
  gabarits).
- **`Entete2(Ent, PosX As String, PosY As String)`** [portée : nécessaire] : une ligne d'en-tête
  (gras italique 8, cellule de 206 mm à x = 2, y = `PosY`) ; **`PosX` est ignoré** (l'appelant
  passe 40). Les deux positions sont typées `String` (appelant : `Integer`).
- **`Footer()`** [portée : réductible] — **code mort** (signal `unused`, vérifié : `ArchivesTck`
  n'appelle jamais `pdf.Footer`) : pied « Page n/{nb} … » à 8 mm du bas, seule méthode qui
  utilisait `R`/`G`/`B`. Surcharge de `PdfWriter.Footer` (jamais appelée automatiquement).
- **`Level4(Code, Intitule, prix, qte, PosY)`** [portée : nécessaire] : ligne police 8, cellules de
  hauteur 8 (lignes espacées de 5 par l'appelant), tout aligné à gauche, prix compris.
  ⚠️ Au-delà de y ≈ 287 mm, `PdfWriter.Cell` déclenche le saut de page automatique : la ligne
  part en haut d'une nouvelle page, puis la ligne suivante (`SetXY(2, PosY + 5)`, toujours hors
  page) en déclenche un autre ; un ticket de plus de ~45 lignes produit **une page par ligne**
  supplémentaire (lecture du code de `PdfWriter.Cell`/`_beginpage`, à confirmer par HTICKETS-T02).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (pour `Footer`, mort).
- Aucun accès SQL (les lignes sont lues par `ArchivesTck` dans `Fiches_HisLigTickets`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_free`, `Footer`, puis `_new`, `R`, `G`, `B` devenus inutiles.
- `Entete2` : retirer `PosX` (mise à jour des 2 appels d'`ArchivesTck`) et typer `PosY` en
  `Integer`.

### Commonalisation avec d'autres fichiers

- La mise en page d'un ticket existe aussi pour la caisse (`Cticket`, `.src/Caisse/Reports`) et
  pour la facture de caisse (`Cfacture`) : un rendu commun « ticket » est envisageable en
  phase 3, mais les formats diffèrent (A4 ici, 80 mm en caisse) ; à étudier avec le lot Caisse.
- Base commune `PdfLaurux` : sans objet après suppression de `Footer` (seul `Entete` = `AddPage`).

### Réduction de portée

- `Footer` est supprimé (code mort) plutôt que rendu privé.

### Séparation traitement / GUI

- Sans objet (rendu pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
