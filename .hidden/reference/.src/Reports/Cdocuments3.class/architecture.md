# Cdocuments3 — Architecture

> Source : `.src/Reports/Cdocuments3.class`

## Vue d'ensemble

`Cdocuments3` est le **gabarit PDF du bon de préparation de commande** (A4 portrait), dérivé de
[`PdfWriter`](../PdfWriter.class/architecture.md). Son seul appelant est
[`EdPrep`](../../Gestion/Impressions/EdPrep.class/architecture.md) (`EdPrep.class:184-305`) :
pour chaque commande client (`Fiches_Bl` de type `C`), `EdPrep` imprime un en-tête (intitulé
global `/intitule`, « Bon de préparation », numéro), deux cadres d'adresses (client et livraison),
l'en-tête de colonnes, une ligne par article avec deux cases à cocher (« Reçue », « Reliquat »),
les commentaires de ligne, puis un pied « reliquat / expéditeur / colis / date d'expédition » et
le pied de page standard. Le PDF (`Filename2`) est envoyé directement à l'imprimante
(`Impression.Facture(Filename2, 1)`).

Malgré son nom, la classe n'est pas une variante de [`Cdocuments`](../Cdocuments.class/architecture.md) :
seulement 45 lignes communes (ratio 0,08, `output/claude/2026-10-24_rework/phase1/tools/dup.py`).
`_new` et `BasPage` sont **identiques** à ceux de `Cdocuments` ; `Lines` diffère par la largeur
(302 mm, trait plus long que la page portrait).

Nature : **GUI (dessin PDF)**, sans SQL. 14 méthodes, toutes `Public`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
| `R2` | var | Private |  | Integer | 6 |
| `G2` | var | Private |  | Integer | 7 |
| `B2` | var | Private |  | Integer | 8 |
| `Coln` | var | Private |  | Boolean | 9 |
<!-- /AUTO:declarations -->

Variables d'instance sans mot-clé (donc `Private`) : `R`, `G`, `B` (fond de l'en-tête de
colonnes), `R2`, `G2`, `B2` (affectées par `_new`, jamais lues), `Coln` (jamais utilisée).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 12-26 | Public | 2 | 13 | 0 | méthode spéciale |
| `Lines` | 30-36 | Public | 1 | 5 | 0 | portée réductible ? |
| `Entete` | 39-46 | Public | 1 | 6 | 1 |  |
| `Entete2` | 48-56 | Public | 1 | 7 | 1 |  |
| `cadre` | 58-70 | Public | 1 | 11 | 1 |  |
| `adresse` | 72-95 | Public | 1 | 22 | 1 |  |
| `adresse2` | 97-112 | Public | 1 | 14 | 1 |  |
| `Level1` | 115-130 | Public | 1 | 14 | 1 |  |
| `Level2` | 132-153 | Public | 2 | 20 | 1 |  |
| `Level2b` | 155-167 | Public | 2 | 10 | 1 |  |
| `carre` | 169-183 | Public | 1 | 11 | 1 |  |
| `Level3` | 186-192 | Public | 1 | 5 | 0 | portée réductible ? |
| `Basep` | 195-204 | Public | 1 | 8 | 1 |  |
| `BasPage` | 206-212 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les méthodes sont [nature : GUI] et n'émettent aucun SQL.

- **`_new()`** [portée : nécessaire (spéciale)] : couleurs du thème `Start.R/G/B`, `Start.R2/G2/B2`
  (repli sur `R/G/B` si `R2 = 0`). Code identique à `Cdocuments._new`.
- **`Entete(ent)`** [portée : nécessaire] : **seule méthode qui appelle `AddPage`** ; écrit
  `ent` (intitulé de l'entreprise) en gras 10 à (6, 8).
- **`Entete2(numero)`** [portée : nécessaire] : « Bon de préparation » et le numéro de commande
  à x = 120 mm. Ne crée pas de page.
- **`cadre()`** [portée : nécessaire] : deux rectangles 6-80 × 26-60 et 120-200 × 26-60 mm.
- **`adresse(intitule, adr1, adr2, burdist, tel, tel3, fax, mel)`** [portée : nécessaire] :
  titre « Coordonnées client » à y = 20 puis 8 lignes au pas de 4 mm (y = 26 à 54).
- **`adresse2(intitule, adr1, adr2, burdist)`** [portée : nécessaire] : « Adresse de livraison »
  à y = 20 puis 4 lignes au pas de 5 mm à partir de y = 32.
- **`Level1()`** [portée : nécessaire] : en-tête de colonnes à y = 80 (Référence, Casier,
  Fournisseur, Intitulé, Qté Stk, Qté C, Qté R, Reçue, Reliquat ; 202 mm) sur fond `R,G,B`.
- **`Level2(code, casier, fournisseur, intitule, qtes, qtec, qter, PosY, i)`**
  [portée : nécessaire] : ligne d'article, fond alterné gris/blanc selon la parité de `i`,
  fournisseur tronqué à 18 caractères, deux cellules vides pour la saisie manuelle. Le premier
  `SetFont(…, 8)` est aussitôt remplacé par `SetFont(…, 7)`.
- **`Level2b(libelle, PosY, i)`** [portée : nécessaire] : ligne de commentaire (200 mm, 175
  caractères). `EdPrep` force `i = 1` avant l'appel : le fond est toujours blanc.
- **`carre(posy)`** [portée : nécessaire] : deux cases de 4 mm (x = 186 et 198), dans les
  colonnes « Reçue » et « Reliquat ».
- **`Basep()`** [portée : nécessaire] : pied de bon à 24 mm du bas (`SetXY(4, -24)`,
  ordonnée négative interprétée depuis le bas par `PdfWriter.SetY`).
- **`BasPage()`** [portée : nécessaire] : pied « Page n/{nb} – date – Impression demandée par
  <utilisateur> » ; identique à `Cdocuments.BasPage`. Déclarée `Function` sans type.
- **`Lines(PosY)`** [portée : réductible, code mort] : trait de 302 mm ; aucun appel
  (`EdPrep` n'appelle pas `pdf2.Lines`).
- **`Level3(total, Posy)`** [portée : réductible, code mort] : « Total du bon de préparation » ;
  aucun appel.

Particularités d'appel de `PdfWriter.Cell` : `Entete`, `Entete2`, `adresse`, `adresse2` passent
une bordure `String` vide (`""` ou `" "`) et un alignement `" L "` avec espaces. Dans
`PdfWriter.Cell`, une bordure `String` sans lettre `L/T/R/B` ne trace rien et un alignement
inconnu tombe dans le cas par défaut (gauche) : le rendu est le même qu'avec `False` et `"L"`.

## État global utilisé

- `Start.R/G/B/R2/G2/B2` (dans `_new`) ; `User.Name` et `Now` (dans `BasPage`).
- Aucun `Start.LocalSettings` (l'intitulé `/intitule` est lu par `EdPrep`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Méthode `EntetePage(ent, numero, client As String[], livraison As String[])` regroupant la
  séquence `Entete` → `Entete2` → `cadre` → `adresse` → `adresse2` → `Level1`, répétée trois
  fois dans `EdPrep` (lignes 213-245, 267-271, 284-289). La séquence de la ligne 267 n'appelle
  pas `Entete` (donc pas `AddPage`) : l'unifier change le comportement (CDOCUMENTS3-A01).
- `adresse`/`adresse2` : boucle sur un tableau de lignes au pas de 4 ou 5 mm ; normaliser les
  arguments `Cell` (`False`, `"L"`) sans changement de rendu.

### Commonalisation avec d'autres fichiers

- Socle PDF commun `PdfLaurux` (PDFWRITER-011 ; `_new`, `BasPage`) avec [`Cdocuments`](../Cdocuments.class/architecture.md)
  (CDOCUMENTS-005) et les autres classes `C*` qui impriment le même pied de page.

### Réduction de portée

- Aucune méthode utilisée n'est réductible (toutes appelées par `EdPrep`). `Lines` et `Level3`,
  sans appelant, sont supprimées (CDOCUMENTS3-002).

### Séparation traitement / GUI

- Sans objet : aucun calcul ni lecture de réglage.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
