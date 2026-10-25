# Ctraites — Architecture

> Source : `.src/Reports/Ctraites.class`

## Vue d'ensemble

`Ctraites` est un **gabarit PDF mort** (`Inherits PdfWriter`, 30 lignes) : une seule méthode utile,
`EnteteN`, et aucune classe ne l'instancie ni ne cite son nom (`deps.py` : `jamais_reference`,
confirmé par grep et par l'historique git, aucun appelant depuis l'import initial `5d9a8696`). Pas
de `.form`. Les traites sont imprimées par les niveaux `T` de
[Ccompta](../Ccompta.class/architecture.md) (`Gestion/Impressions/Traites`, `Lcr.Imp_Traites`) et
par [CLcr](../../Gestion/Lcr/CLcr.class/architecture.md).

La classe est à supprimer (CTRAITES-001).

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
| `_new` | 8-15 | Public | 1 | 6 | 0 | méthode spéciale |
| `_free` | 17-19 | Public | 1 | 2 | 0 | méthode spéciale |
| `EnteteN` | 22-30 | Public | 1 | 7 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [nature : GUI] : `R`, `G`, `B` = `Start.R/G/B` puis `SetFillColor` (identique à
  `Creleve._new`, `Chistoriques`, `Cmat`, `Carticles`). **`_free()`** : vide.
- **`EnteteN(ent)`** [nature : GUI] : `AddPage` + bandeau titre 16 pt, 206 mm — jamais appelé ;
  corps identique à `Creleve.EnteteN`, `Cdocuments.EnteteN`, `Cdocuments2.EnteteN`.

Aucune méthode n'a d'appelant : `[portée : réductible]` sans objet (suppression).

## État global utilisé

- `Start.R/G/B` — sans effet (classe jamais chargée).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le fichier `.src/Reports/Ctraites.class` (pas de `.form`) : rework [code mort].

### Commonalisation avec d'autres fichiers

- Sans objet après suppression ; à faire avant la création de la base commune `PdfLaurux`
  (PDFWRITER-011).

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
