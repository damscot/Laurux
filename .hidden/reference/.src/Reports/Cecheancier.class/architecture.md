# Cecheancier — Architecture

> Source : `.src/Reports/Cecheancier.class`

## Vue d'ensemble

`Cecheancier` est un **gabarit PDF mort** (`Inherits PdfWriter`, 63 lignes) : aucune classe ne
l'instancie ni ne cite son nom (`deps.py` : `jamais_reference`, confirmé par grep ; aucun
chargement dynamique). Il n'a pas de `.form`. L'historique git ne montre **aucun** appelant depuis
l'import initial du code (`5d9a8696`) : l'échéancier comptable
([Echeancier](../../Compta/Impressions/Echeancier.class/architecture.md)) utilise les niveaux `E`
de [Ccompta](../Ccompta.class/architecture.md).

L'en-tête du fichier contient un commentaire parasite `' Gambas module file` (ligne 3) après
`' Gambas class file`.

Toutes les méthodes sont `Public`, `[nature : GUI]` et sans appelant : la classe entière est à
supprimer (CECHEANCIER-001).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 5 |
| `G` | var | Private |  | Integer | 6 |
| `B` | var | Private |  | Integer | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 10-16 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 18-20 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 22-30 | Public | 1 | 7 | 0 | portée réductible ? |
| `BasPage` | 33-40 | Public | 1 | 6 | 0 | portée réductible ? |
| `Level0` | 42-48 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level2` | 52-63 | Public | 1 | 10 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

| Fonction | Rendu | Remarques |
|---|---|---|
| `_new()` / `_free()` | couleurs `Start.R/G/B` / vide | `_new` identique à 11 gabarits |
| `Entete(sEntete)` | `AddPage` + titre 16 pt, 206 mm | identique à `Cbalances.Entete`, `CLcr.Entete` et au `EnteteN` de `Creleve`/`Ctraites`/`Cdocuments*` |
| `BasPage()` | pied de page standard | identique à `Ccompta.BasPage` |
| `Level0(nom, dateedition)` | ligne de titre centrée | ≈ `Cbalances.Level0` sans société |
| `Level2(code, intitule, NumFac, Reglt, dater, Montant, PosY)` | ligne d'échéance (6 colonnes) | |

## État global utilisé

- `Start.R/G/B`, `User.Name`, `Now` — sans effet (classe jamais chargée).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le fichier `.src/Reports/Cecheancier.class` (pas de `.form`) : rework [code mort].

### Commonalisation avec d'autres fichiers

- Sans objet après suppression ; à supprimer avant la création de la base commune `PdfLaurux`
  (PDFWRITER-011) pour ne pas compter ses doublons.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
