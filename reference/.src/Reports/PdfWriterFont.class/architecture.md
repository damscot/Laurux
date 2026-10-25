# PdfWriterFont — Architecture

> Source : `.src/Reports/PdfWriterFont.class`

## Vue d'ensemble

`PdfWriterFont` fournit les **tables de largeurs des caractères** (en millièmes d'em, 256 valeurs
indexées par le code d'octet WinAnsi) des polices standard PDF utilisées par
[`PdfWriter`](../PdfWriter.class/architecture.md). Il fait partie du même portage (« PDFWriterFont
0.0.2 », Luigi Carlotto, 2007, GPL2, conversion des fichiers `font/*.php` de FPDF 1.53).

Classe sans état : toutes les fonctions sont `Static Public`. Le seul point d'entrée utilisé est
`Font(name)`, appelé par `PdfWriter.SetFont` (et par `AddFont`, mort) au premier usage d'une police
dans un document ; il aiguille par `Select Case` vers une fonction par police, qui construit et
renvoie un `Integer[]` neuf à chaque appel.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Font` | 11-58 | Public Static | 19 | 44 | 1 |  |
| `courier` | 60-70 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `courierB` | 72-82 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `courierI` | 84-94 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `courierBI` | 96-106 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `serif` | 108-118 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `serifB` | 120-130 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `serifI` | 132-142 | Public Static | 2 | 8 | 0 | portée réductible ? |
| `helvetica` | 144-176 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `helveticaB` | 178-210 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `helveticaI` | 212-244 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `helveticaBI` | 246-278 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `symbol` | 280-312 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `times` | 314-346 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `timesB` | 348-380 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `timesBI` | 382-414 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `timesI` | 416-448 | Public Static | 1 | 30 | 0 | portée réductible ? |
| `zapfdingbats` | 450-482 | Public Static | 1 | 30 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Font(name)`** [portée : nécessaire, `PdfWriter`] [nature : calcul] (CC 19) : 18 `Case`
  (`courier`, `courierB`, `courierI`, `courierBI`, `helvetica`, `helveticaB`, `helveticaBI`,
  `helveticaI`, `symbol`, `times`, `timesB`, `timesBI`, `timesI`, `serif`, `serifB`, `serifI`,
  `serifBI`, `zapfdingbats`) ; nom inconnu → `Error.Raise("Could not include font definition")`.
  ⚠️ **Anomalie** : le `Case "serifBI"` appelle `PdfWriterFont.serifBI()`, **fonction inexistante** :
  `SetFont("serif", "BI")` compile mais lève « Unknown symbol » à l'exécution (aucun appelant
  actuel : le projet n'utilise que helvetica, arial → helvetica, et courier). La comparaison est
  sensible à la casse, mais `PdfWriter` construit toujours les clés en minuscules + style majuscule.
  `Dim i As New Integer[]` crée un tableau aussitôt remplacé (inutile).
- **`courier`, `courierB`, `courierI`, `courierBI`** [réductible] [calcul] : boucle de 256 × 600
  (police à chasse fixe). Quatre fonctions identiques ; `PdfWriter.SetFont` n'ajoute d'ailleurs le
  style au nom de fichier que pour times et helvetica, donc seule `courier()` est atteinte.
- **`serif`, `serifB`, `serifI`** [réductible] [calcul] : 256 × 600, soit les largeurs de Courier,
  pour une police « Serif » qui **n'est pas** une police de base PDF (le lecteur la remplace par une
  police de substitution : les largeurs ne correspondent pas au rendu). Seule `serif()` est atteinte
  (même règle de style que Courier) ; jamais utilisée par le projet.
- **`helvetica`, `helveticaB`, `helveticaI`, `helveticaBI`, `times`, `timesB`, `timesI`,
  `timesBI`, `zapfdingbats`** [réductible] [calcul] : 26 `v.Insert([...])` de 10 valeurs (la
  dernière de 6) = 256 valeurs. Comparées aux métriques AFM Adobe des 14 polices de base (fichiers
  `pdfcorefonts/*.afm` de matplotlib, codage CP1252) par
  `output/claude/2026-10-24_rework/phase1/reports/tools/afm_compare.py` : **identiques**, sauf
  ⚠️ `helvetica[0xD8]` (« Ø ») = **39778** au lieu de 778 (faute de frappe). Impact réel nul
  aujourd'hui : `PdfWriter` mesure les octets UTF-8 et l'octet 0xD8 n'apparaît pas dans un texte
  français ; il deviendrait visible (largeur ×51, alignement aberrant) après correction de
  PDFWRITER-A02 pour un texte contenant « Ø ».
- **`symbol`** [réductible] [calcul] : ⚠️ table **corrompue** : 254 valeurs seulement, la valeur
  « 987603 » fusionne deux largeurs (987 et 603) à l'index 0xAE, ce qui décale les 80 valeurs
  suivantes (53 écarts avec l'AFM sur les codes définis) ; un caractère d'octet 254 ou 255 lèverait
  « Out of bounds ». Police jamais utilisée.

## Génération à partir des fichiers AFM

Les tables peuvent être **générées** : chaque fichier AFM donne, par glyphe, son nom (`N`) et sa
largeur (`WX`) ; on associe chaque octet 0-255 au caractère CP1252 (`bytes([b]).decode("cp1252")`),
puis au nom de glyphe Adobe (`fontTools.agl.UV2AGL`), avec `space` pour 0xA0 et `hyphen` pour 0xAD ;
les codes non définis (0x00-0x1F, 0x7F, 0x81, 0x8D, 0x8F, 0x90, 0x9D) n'ont pas de glyphe : le
générateur doit reprendre les valeurs actuelles (non comparées par le script). Symbol et ZapfDingbats utilisent le code
natif `C` de l'AFM. L'option `--gen` du script produit le code Gambas (`v.Insert([...])`) de
helvetica (codes non définis mis à 278 dans cette démonstration). Les AFM sont disponibles localement
(`/usr/share/matplotlib/mpl-data/fonts/pdfcorefonts/`, aussi distribués par Adobe, ghostscript ou
reportlab). Une génération supprimerait les fautes de saisie mais **change les valeurs** de 0xD8
(helvetica) et de symbol : c'est une anomalie, pas un rework.

## État global utilisé

Aucun. Pas d'accès base, pas de GUI, pas de configuration.

## Propositions d'amélioration

### Réécriture / refactorisation

- Les 7 fonctions « 256 × 600 » (`courier*`, `serif*`) sont identiques : une fonction privée
  `Fixe(largeur)` suffit ; `Font` peut aiguiller les 8 noms vers elle (valeurs inchangées).
- Remplacer les 26 `Insert` par une constante littérale `[ … ]` unique par police (même contenu), ou
  par une chaîne `"278,278,…"` découpée par `Split` : lecture et comparaison plus simples.
- **Cache** : `Font` reconstruit le tableau à chaque document ; une `Collection` statique privée
  indexée par nom renverrait le même tableau (les appelants ne le modifient pas : `PdfWriter` le lit
  seulement). Gain négligeable (génération complète de 143 pages mesurée à ≈ 0,03 s) : à ne faire
  qu'avec la factorisation.

### Commonalisation avec d'autres fichiers

- Aucune autre table de métriques dans le projet. Si `PdfWriter` évolue vers des polices TrueType
  (hors périmètre), cette classe disparaîtrait.

### Réduction de portée

- Les 17 fonctions par police ne sont appelées que par `Font` (vérifié par grep : aucun
  `PdfWriterFont.<police>` hors de ce fichier) → `Static Private`. `Font` reste `Static Public`
  (appelée par `PdfWriter`).

### Séparation traitement / GUI

Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
