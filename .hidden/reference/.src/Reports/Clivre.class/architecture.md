# Clivre — Architecture

> Source : `.src/Reports/Clivre.class`

## Vue d'ensemble

`Clivre` est un **gabarit PDF mort** (`Inherits PdfWriter`) : aucune classe du projet ne
l'instancie ni ne cite son nom (`deps.py` : `jamais_reference` ; vérifié par `grep -rni
"\bClivre\b" .src .project` et absence de `Class.Load`/`Object.New` sur un nom construit). Il n'a
pas de `.form`.

Malgré son nom, il ne sert pas au livre comptable : les commentaires (« Entete ticket », « Entete
facture », « Adresse client sur bon de caisse », « ticketX ») montrent un gabarit de **tickets et
factures de caisse**. L'historique git confirme son dernier usage : `Caisse/Moulinage.class`
faisait `pdf = New Clivre("P", "mm", "A4")`, ligne supprimée par le commit `f442d721` (« La caisse
Laurux-Pos est intégrée dans Laurux », 2018). Ses fonctions ont été reprises par
[Cfacture](../../Caisse/Reports/Cfacture.class/architecture.md) (même `newPage`, `Logo` voisin) et
[Cticket](../../Caisse/Reports/Cticket.class/architecture.md).

Toutes les méthodes sont `Public`, `[nature : GUI]` (rendu pur) et **sans appelant** : le
`[portée : réductible]` est sans objet, la classe entière est à supprimer (CLIVRE-001).

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
| `newPage` | 20-24 | Public | 1 | 3 | 0 | portée réductible ? |
| `Entete` | 27-33 | Public | 1 | 5 | 0 | portée réductible ? |
| `Entete2` | 36-42 | Public | 1 | 5 | 0 | portée réductible ? |
| `Entete3` | 45-51 | Public | 1 | 5 | 0 | portée réductible ? |
| `Lines` | 54-60 | Public | 1 | 5 | 0 | portée réductible ? |
| `Lines2` | 63-69 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level2T` | 72-82 | Public | 1 | 9 | 0 | portée réductible ? |
| `Level1` | 85-104 | Public | 4 | 17 | 0 | portée réductible ? |
| `Level2` | 106-114 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level2E` | 117-126 | Public | 1 | 8 | 0 | portée réductible ? |
| `Level3` | 129-135 | Public | 1 | 5 | 0 | portée réductible ? |
| `Com` | 138-144 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level2F` | 147-157 | Public | 1 | 9 | 0 | portée réductible ? |
| `Level4` | 160-169 | Public | 1 | 8 | 0 | portée réductible ? |
| `Logo2` | 171-184 | Public | 5 | 11 | 0 | portée réductible ? |
| `Logo` | 186-207 | Public | 7 | 19 | 0 | portée réductible ? |
| `BasPage` | 210-216 | Public | 1 | 5 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

| Fonction | Rendu | Remarques |
|---|---|---|
| `_new()` / `_free()` | couleurs `Start.R/G/B` / vide | `_new` identique à 11 gabarits |
| `newPage()` | `AddPage()` | = `Cfacture.newPage` |
| `Entete(Ent, PosX, PosY, Bold)` | texte 10 pt à x = 4 | `PosX` et `Bold` inutilisés |
| `Entete2(Ent, PosX, PosY, Bold)` | texte 12 pt au style `Bold` à (`PosX`, `PosY`) | `PosX`, `PosY` en `String` |
| `Entete3(Ent, PosY, Bold)` | adresse client à x = 82 | |
| `Lines(PosY)` / `Lines2(PosY)` | filet 0-210 / 0-130 mm | `Lines` = `Cdocuments.Lines` = `Cdocuments2.Lines` |
| `Level2T(PosY)` | en-tête Code, Intitulé, Montant, Quantité | |
| `Level1(Code, Intitule, prix, qte, PosY, Typel)` | ligne de ticket ; type `K` : intitulé seul non tronqué | les branches `TA` et `Else` sont identiques |
| `Level2(Intitule, prix, qte, PosY)` | ligne de ticket X | |
| `Level2E(PosY)` | en-tête ticket X | |
| `Level3(Ent, PosY)` | titre ticket X, 12 pt gras | |
| `Com(Com, PosY)` | commentaire 8 pt | paramètre homonyme de la méthode |
| `Level2F(PosY)` | en-tête facture (Code, Intitulé, PU TTC, Qté) | |
| `Level4(Code, Intitule, prix, qte, PosY)` | ligne de facture | |
| `Logo2()` | logo société fixe 40 × 40 mm à (136, 7) | = `Cdocuments2.Logo2` |
| `Logo()` | logo proportionnel 80 × 40 mm | **identique à `Creleve.Logo`** (avec sa division par zéro, CRELEVE-A02) |
| `BasPage()` | pied de page 206 mm sans couleur | = `Cclients.BasPage` |

## État global utilisé

- `Start.R/G/B`, `Start.LocalSettings["/Soc<XX>/glogo"]`, `["/Soc<XX>/Logo"]`, `Start.Societe`,
  `User.Name`, `Now` — sans effet puisque la classe n'est jamais chargée.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le fichier `.src/Reports/Clivre.class` (pas de `.form` associé) : rework [code mort],
  aucun appelant à modifier.

### Commonalisation avec d'autres fichiers

- Sans objet après suppression. Pour mémoire, les corps identiques (`Logo` = `Creleve.Logo`,
  `Logo2` = `Cdocuments2.Logo2`, `BasPage` = `Cclients.BasPage`, `Lines` = `Cdocuments*.Lines`,
  `newPage` = `Cfacture.newPage`) faussent le décompte des doublons de la base commune
  `PdfLaurux` (voir [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)) :
  supprimer `Clivre` d'abord.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
