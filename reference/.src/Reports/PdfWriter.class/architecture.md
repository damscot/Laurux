# PdfWriter — Architecture

> Source : `.src/Reports/PdfWriter.class`

## Vue d'ensemble

`PdfWriter` est le **moteur PDF** de Laurux : toutes les éditions PDF (factures, journaux, balances,
étiquettes, relevés, tickets…) passent par lui. C'est un **portage Gambas de FPDF 1.53** (bibliothèque
PHP d'Olivier Plathey, 2004), réalisé par Luigi Carlotto sous le nom « PDFWriter », **version 0.0.2 du
2007-10-10, licence GPL2** (en-tête l.3-79, projet SourceForge `pdfwriter`). Les versions ultérieures du
portage (0.0.3 pour Gambas 2.5, 0.0.4 avec en-têtes et pieds de page par événements) n'ont **pas** été
reprises. Le portage intègre une vingtaine d'extensions publiées sur fpdf.org (signets, rectangles
arrondis, rotations, tableaux, cercles, index, secteurs, diagrammes, pointillés, polygones, cube,
figures géométriques, étoile, dégradés, codes-barres EAN13/UPC/Code39/i25/Codabar, transformations,
texte circulaire), listées dans l'en-tête avec leurs auteurs.

Modèle : un objet = un document. Le contenu de chaque page est accumulé en texte (opérateurs PDF) dans
`$pages[]` par `_out`, puis `Output` → `Close` → `_enddoc` sérialise le tout dans `$buffer` (en-tête,
pages compressées zlib, polices, images, dictionnaire de ressources, info, catalogue, table xref) et
l'écrit dans un fichier. Unité utilisateur (mm en pratique) convertie en points par `$k`. Les polices
sont les **polices standard PDF** uniquement (pas d'incorporation), avec des tables de largeurs fournies
par [`PdfWriterFont`](../PdfWriterFont.class/architecture.md) ; codage `/WinAnsiEncoding`.

### Modifications locales (Laurux) par rapport au portage

Le fichier a été importé déjà modifié (commit `5d9a8696`) ; la version d'origine n'étant pas disponible
hors ligne, les écarts suivants sont établis par comparaison avec FPDF 1.53 et l'historique git :

| Modification | Lignes | Origine |
|---|---|---|
| Formats `dymoc` (25 × 25 mm) et `dymog` (88 × 35 mm) pour étiquettes Dymo | `_new` | import |
| Format `80mm` (210 × 841,89 pt, soit 74 × 297 mm), variable `$form`, `GetFormat()` | `_new`, 2270 | `f442d721` (2018, caisse Laurux-Pos) |
| Polices de base « Serif » (4 styles) | `_new` 241-244 | import |
| `PageBreakTrigger = h - margin + 18` (FPDF : `h - margin`) | 395 | import (à confirmer) |
| Bloc d'encodage « golia » (UTF-8 → ISO-8859-15/1 + table de remplacement) dans `Cell` | 1076-1127 | import (commentaires italiens) |
| Crochets `Me.Header()`/`Me.Footer()` commentés dans `AddPage`/`Close` ; `Header(sEntete)` avec paramètre | 515, 543, 565, 587 | import |
| `_Barcode` EAN13 réécrit (tables de motifs) ; ancien renommé `_Barcode2` avec `Print` de débogage | 4436-4544 | `c55b00ec` (2016), `562c3d24` |
| Ajouts en fin de fichier : `Cell2`, `MultiRiga`, `Lnm`, `MultiRect` (`$lasthmulti`) | 4590-4910 | import, **jamais utilisés** |
| Commits `087d438a`, `99276ae7`, `a941b097`, `fe105192` | – | indentation seulement |

### Sous-classes et appelants

23 classes `Inherits PdfWriter` (gabarits d'édition) : `Cfacture`, `Cticket` (Caisse/Reports), `CLcr`
(Gestion/Lcr), et dans `.src/Reports` : `Carticles`, `Cbalances`, `Cbilan`, `Cbordereaux`, `Cclients`,
`Ccompta`, `Cdocuments`, `Cdocuments2`, `Cdocuments3`, `Cecheancier`, `Cetiquettes`, `Chistoriques`,
`Clivre`, `Cmat`, `Creleve`, `Cresultat`, `Csig`, `Cstocks`, `Ctraites`, `Htickets`. `Tregie` instancie
`PdfWriter` directement. Environ 85 écrans créent un gabarit (`New Cxxx("Portrait", "mm", "A4")`), puis
appellent `Open`, `AliasNbPages`, les méthodes de niveau du gabarit (`Entete`, `Level1`, `BasPage`…),
`Footer` et `Output(fichier, False)`.

Règles Gambas vérifiées (projet jouet, `gbc3`/`gbx3`) et qui conditionnent tout rework :
- une sous-classe **doit** appeler un membre hérité par `Me.` (un appel nu ne compile pas) ;
- un membre `Private` du parent est **invisible** de la sous-classe (erreur « Unknown symbol » à
  l'exécution, la compilation passe) ;
- dans le parent, un appel nu (`Footer()`, `AcceptPageBreak()`) exécute la version **du parent** ;
  seul `Me.Footer()` atteint la surcharge. Les crochets étant commentés, les pieds de page sont
  dessinés par les appelants (`pdf.Footer()`, 34 appels) ;
- `Me.seto` (`Cticket.class:24`, membre inexistant) compile et lève « Unknown symbol 'seto' » à
  l'exécution ; `Cticket` n'est jamais instancié (voir [Cticket](../../Caisse/Reports/Cticket.class/architecture.md)).

Membres de `PdfWriter` réellement utilisés (relevé `output/…/phase1/reports/tools/pdf_usage.py`, appels
`Me.X` dans les 23 sous-classes et `pdf.X` chez les appelants) :

| Membre | Sous-classes | Appelants externes |
|---|---|---|
| `_new(orientation, unit, form)` | les 23 (surchargent `_new()` sans paramètre) | ~85 `New` |
| `AddPage`, `SetFont`, `Cell`, `SetXY` | 23 | `Tregie` |
| `SetFillColor` | 22 | – |
| `PageNo` | 20 | – |
| `SetY` | 19 | – |
| `Line` | 18 | – |
| `SetLineWidth` | 14 | – |
| `Image` | 7 (`Carticles`, `Cbordereaux`, `Cdocuments`, `Cdocuments2`, `Cfacture`, `Clivre`, `Creleve`) | – |
| `MultiCell` | 3 (`Cdocuments`, `Cdocuments2`, `Creleve`) | – |
| `EAN13` | 3 (`Cdocuments`, `Cdocuments2`, `Cetiquettes`) | – |
| `Rect` | `Cetiquettes` | – |
| `SetMargins`, `GetFormat` | `Cfacture` | – |
| `Footer` | surchargé par `Carticles`, `Cbordereaux`, `Chistoriques`, `Cmat`, `Htickets` | 34 appels `pdf.Footer()` |
| `Open`, `AliasNbPages`, `Output` | – | ~85 écrans |

Tous les autres membres `Public` (une centaine) n'ont **aucun** utilisateur.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Version` | const | Public |  |  | 81 |
| `PDFVersion` | const | Public |  |  | 82 |
| `$page` | var | Private |  | Integer | 85 |
| `$n` | var | Private |  | Integer | 86 |
| `$offsets` | var | Private |  | Integer[] | 87 |
| `$buffer` | var | Private |  | String | 88 |
| `$pages` | var | Private |  | String[] | 89 |
| `$state` | var | Private |  | Integer | 90 |
| `$compress` | var | Private |  | Boolean | 91 |
| `$DefOrientation` | var | Private |  | String | 92 |
| `$CurOrientation` | var | Private |  | String | 93 |
| `$OrientationChanges` | var | Private |  | Boolean[] | 94 |
| `$k` | var | Private |  | Float | 95 |
| `$form` | var | Private |  | String | 96 |
| `$fwPt` | var | Private |  | Float | 97 |
| `$fhPt` | var | Private |  | Float | 98 |
| `$fw` | var | Private |  | Float | 99 |
| `$fh` | var | Private |  | Float | 100 |
| `$wPt` | var | Private |  | Float | 101 |
| `$hPt` | var | Private |  | Float | 102 |
| `$w` | var | Private |  | Float | 103 |
| `$h` | var | Private |  | Float | 104 |
| `$lMargin` | var | Private |  | Float | 105 |
| `$tMargin` | var | Private |  | Float | 106 |
| `$rMargin` | var | Private |  | Float | 107 |
| `$bMargin` | var | Private |  | Float | 108 |
| `$cMargin` | var | Private |  | Float | 109 |
| `$x` | var | Private |  | Float | 110 |
| `$y` | var | Private |  | Float | 111 |
| `$lasth` | var | Private |  | Integer | 112 |
| `$LineWidth` | var | Private |  | Float | 113 |
| `$CoreFonts` | var | Private |  | Collection | 114 |
| `$fonts` | var | Private |  | Collection | 115 |
| `$FontFiles` | var | Private |  | Collection | 116 |
| `$diffs` | var | Private |  | Boolean[] | 117 |
| `$images` | var | Private |  | Collection | 118 |
| `$PageLinks` | var | Private |  | Collection | 119 |
| `$links` | var | Private |  | Collection | 120 |
| `$FontFamily` | var | Private |  | String | 121 |
| `$FontStyle` | var | Private |  | String | 122 |
| `$underline` | var | Private |  | Boolean | 123 |
| `$CurrentFont` | var | Private |  | Collection | 124 |
| `$FontSizePt` | var | Private |  | Integer | 125 |
| `$FontSize` | var | Private |  | Float | 126 |
| `$DrawColor` | var | Private |  | String | 127 |
| `$FillColor` | var | Private |  | String | 128 |
| `$TextColor` | var | Private |  | String | 129 |
| `$ColorFlag` | var | Private |  | Boolean | 130 |
| `$ws` | var | Private |  | Float | 131 |
| `$AutoPageBreak` | var | Private |  | Boolean | 132 |
| `$PageBreakTrigger` | var | Private |  | Float | 133 |
| `$InFooter` | var | Private |  | Boolean | 134 |
| `$ZoomMode` | var | Private |  | Variant | 135 |
| `$LayoutMode` | var | Private |  | String | 136 |
| `$title` | var | Private |  | String | 137 |
| `$subject` | var | Private |  | String | 138 |
| `$author` | var | Private |  | String | 139 |
| `$keywords` | var | Private |  | String | 140 |
| `$creator` | var | Private |  | String | 141 |
| `$AliasNbPages` | var | Private |  | String | 142 |
| `$angle` | var | Private |  | Integer | 143 |
| `$columnWidths` | var | Private |  | Float[] | 144 |
| `$columnAligns` | var | Private |  | String[] | 145 |
| `$outlines` | var | Private |  | Object[] | 146 |
| `$OutlineRoot` | var | Private |  | Integer | 147 |
| `$legends` | var | Private |  | String[] | 148 |
| `$wLegend` | var | Private |  | Float | 149 |
| `$sum` | var | Private |  | Float | 150 |
| `$NbVal` | var | Private |  | Integer | 151 |
| `$gradients` | var | Private |  | Object[] | 152 |
| `$lasthmulti` | var | Private |  | Integer | 153 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 161-322 | Public | 15 | 118 | 0 | méthode spéciale |
| `SetMargins` | 334-342 | Public | 2 | 6 | 1 |  |
| `SetLeftMargin` | 344-350 | Public | 3 | 4 | 0 | portée réductible ? |
| `GetLeftMargin` | 353-358 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetTopMargin` | 360-365 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetTopMargin` | 368-373 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetRightMargin` | 375-380 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetRightMargin` | 383-388 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetAutoPageBreak` | 390-397 | Public | 1 | 5 | 0 | portée réductible ? |
| `SetDisplayMode` | 399-417 | Public | 4 | 15 | 0 | portée réductible ? |
| `SetCompression` | 419-424 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetCompression` | 427-432 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetTitle` | 434-439 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetTitle` | 442-447 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetSubject` | 449-454 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetSubject` | 457-462 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetAuthor` | 464-469 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetAuthor` | 472-477 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetCreator` | 479-484 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetCreator` | 487-492 | Public | 1 | 3 | 0 | portée réductible ? |
| `AliasNbPages` | 494-499 | Public | 1 | 3 | 74 |  |
| `Open` | 501-506 | Public | 1 | 3 | 83 |  |
| `Close` | 508-522 | Public | 3 | 6 | 0 | portée réductible ? |
| `AddPage` | 524-585 | Public | 11 | 44 | 24 |  |
| `Header` | 587-596 | Public | 1 | 7 | 0 | portée réductible ? |
| `Footer` | 598-601 | Public | 1 | 2 | 2 |  |
| `PageNo` | 603-608 | Public | 1 | 3 | 20 |  |
| `SetDrawColor` | 610-622 | Public | 6 | 10 | 0 | portée réductible ? |
| `SetFillColor` | 624-637 | Public | 6 | 11 | 22 |  |
| `SetTextColor` | 639-651 | Public | 5 | 10 | 0 | portée réductible ? |
| `GetStringWidth` | 653-668 | Public | 2 | 13 | 0 | portée réductible ? |
| `SetLineWidth` | 670-676 | Public | 2 | 4 | 14 |  |
| `GetLineWidth` | 679-684 | Public | 1 | 3 | 0 | portée réductible ? |
| `Line` | 692-700 | Public | 1 | 6 | 18 |  |
| `Line2` | 708-717 | Public | 2 | 7 | 0 | portée réductible ? |
| `Rect` | 725-742 | Public | 3 | 15 | 1 |  |
| `Rect2` | 757-810 | Public | 20 | 50 | 0 | portée réductible ? |
| `AddFont` | 812-871 | Public | 11 | 56 | 0 | portée réductible ? |
| `SetFont` | 873-934 | Public | 15 | 54 | 24 |  |
| `SetFontSize` | 936-944 | Public | 3 | 6 | 0 | portée réductible ? |
| `AddLink` | 946-954 | Public | 1 | 5 | 0 | portée réductible ? |
| `SetLink` | 956-963 | Public | 3 | 5 | 0 | portée réductible ? |
| `Link` | 965-979 | Public | 2 | 11 | 0 | portée réductible ? |
| `Text` | 981-992 | Public | 4 | 8 | 0 | portée réductible ? |
| `AcceptPageBreak` | 994-999 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cell` | 1001-1158 | Public | 34 | 144 | 24 |  |
| `MultiCell` | 1160-1270 | Public | 40 | 97 | 3 |  |
| `Write` | 1272-1344 | Public | 11 | 65 | 0 | portée réductible ? |
| `Image` | 1346-1386 | Public | 12 | 35 | 7 |  |
| `Ln` | 1388-1395 | Public | 2 | 4 | 0 | portée réductible ? |
| `GetX` | 1397-1402 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetX` | 1404-1409 | Public | 2 | 3 | 0 | portée réductible ? |
| `GetY` | 1411-1416 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetY` | 1418-1424 | Public | 2 | 4 | 19 |  |
| `SetXY` | 1426-1432 | Public | 1 | 4 | 24 |  |
| `Output` | 1434-1469 | Public | 11 | 28 | 83 |  |
| `RoundedRect` | 1481-1533 | Public | 7 | 50 | 0 | portée réductible ? |
| `RoundedRect2` | 1547-1606 | Public | 11 | 57 | 0 | portée réductible ? |
| `GetStringLimit` | 1612-1622 | Public | 3 | 9 | 0 | portée réductible ? |
| `RotatedText` | 1625-1632 | Public | 1 | 5 | 0 | portée réductible ? |
| `RotatedImage` | 1635-1642 | Public | 1 | 5 | 0 | portée réductible ? |
| `SetColumnWidths` | 1644-1649 | Public | 1 | 3 | 0 | portée réductible ? |
| `SetColumnAligns` | 1651-1656 | Public | 1 | 3 | 0 | portée réductible ? |
| `Row` | 1659-1696 | Public | 6 | 28 | 0 |  |
| `Circle` | 1704-1708 | Public | 1 | 3 | 0 | portée réductible ? |
| `Circle2` | 1721-1725 | Public | 1 | 3 | 0 | portée réductible ? |
| `Ellipse` | 1734-1777 | Public | 4 | 41 | 0 | portée réductible ? |
| `Ellipse2` | 1791-1868 | Public | 13 | 74 | 0 | portée réductible ? |
| `Bookmark` | 1875-1892 | Public | 2 | 15 | 0 | portée réductible ? |
| `CreateIndex` | 1896-1930 | Public | 4 | 28 | 0 | portée réductible ? |
| `DashedRect` | 1939-1968 | Public | 8 | 27 | 0 | portée réductible ? |
| `Sector` | 1980-2061 | Public | 9 | 75 | 0 | portée réductible ? |
| `PieChart` | 2071-2124 | Public | 7 | 49 | 0 | portée réductible ? |
| `BarDiagram` | 2136-2192 | Public | 6 | 51 | 0 | portée réductible ? |
| `SetLegends` | 2195-2216 | Public | 3 | 19 | 0 | portée réductible ? |
| `SetDash` | 2223-2231 | Public | 3 | 7 | 0 | portée réductible ? |
| `MultiCellBlt` | 2238-2252 | Public | 1 | 8 | 0 | portée réductible ? |
| `GetW` | 2255-2260 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetH` | 2263-2268 | Public | 1 | 3 | 0 | portée réductible ? |
| `GetFormat` | 2270-2274 | Public | 1 | 3 | 1 |  |
| `Polygon` | 2281-2308 | Public | 6 | 25 | 0 | portée réductible ? |
| `Polygon2` | 2319-2378 | Public | 15 | 57 | 0 | portée réductible ? |
| `Cube` | 2384-2438 | Public | 2 | 49 | 0 | portée réductible ? |
| `SetLineStyle` | 2456-2510 | Public | 14 | 52 | 0 | portée réductible ? |
| `Curve2` | 2523-2548 | Public | 6 | 23 | 0 | portée réductible ? |
| `RegularPolygon2` | 2566-2581 | Public | 4 | 13 | 0 | portée réductible ? |
| `StarPolygon2` | 2600-2626 | Public | 5 | 24 | 0 | portée réductible ? |
| `Star` | 2637-2670 | Public | 7 | 31 | 0 | portée réductible ? |
| `LinearGradient` | 2682-2692 | Public | 4 | 8 | 0 | portée réductible ? |
| `RadialGradient` | 2707-2717 | Public | 4 | 8 | 0 | portée réductible ? |
| `CoonsPatchMesh` | 2749-2822 | Public | 13 | 64 | 0 | portée réductible ? |
| `Clip` | 2825-2844 | Public | 1 | 15 | 0 | portée réductible ? |
| `Gradient` | 2847-2866 | Public | 1 | 15 | 0 | portée réductible ? |
| `EAN13` | 2878-2882 | Public | 1 | 3 | 3 |  |
| `UPC_A` | 2894-2898 | Public | 1 | 3 | 0 | portée réductible ? |
| `Code39` | 2992-3052 | Public | 10 | 49 | 0 | portée réductible ? |
| `i25` | 3064-3118 | Public | 9 | 44 | 0 | portée réductible ? |
| `Codabar` | 3131-3179 | Public | 5 | 46 | 0 | portée réductible ? |
| `StartTransform` | 3185-3190 | Public | 1 | 3 | 0 | portée réductible ? |
| `ScaleX` | 3196-3200 | Public | 1 | 3 | 0 | portée réductible ? |
| `ScaleY` | 3206-3210 | Public | 1 | 3 | 0 | portée réductible ? |
| `ScaleXY` | 3216-3220 | Public | 1 | 3 | 0 | portée réductible ? |
| `Scale` | 3223-3236 | Public | 5 | 10 | 0 | portée réductible ? |
| `MirrorH` | 3241-3249 | Public | 2 | 7 | 0 | portée réductible ? |
| `MirrorV` | 3254-3258 | Public | 1 | 3 | 0 | portée réductible ? |
| `MirrorP` | 3264-3268 | Public | 1 | 3 | 0 | portée réductible ? |
| `MirrorL` | 3275-3280 | Public | 1 | 4 | 0 | portée réductible ? |
| `TranslateX` | 3284-3288 | Public | 1 | 3 | 0 | portée réductible ? |
| `TranslateY` | 3292-3296 | Public | 1 | 3 | 0 | portée réductible ? |
| `Translate` | 3301-3306 | Public | 1 | 3 | 0 | portée réductible ? |
| `Rotate` | 3312-3326 | Public | 3 | 12 | 0 | portée réductible ? |
| `SkewX` | 3332-3336 | Public | 1 | 3 | 0 | portée réductible ? |
| `SkewY` | 3342-3346 | Public | 1 | 3 | 0 | portée réductible ? |
| `Skew` | 3353-3370 | Public | 7 | 15 | 0 | portée réductible ? |
| `Transform` | 3373-3382 | Public | 1 | 8 | 0 | portée réductible ? |
| `StopTransform` | 3386-3391 | Public | 1 | 3 | 0 | portée réductible ? |
| `CircularText` | 3402-3467 | Public | 12 | 54 | 0 | portée réductible ? |
| `_putpages` | 3475-3555 | Private | 13 | 71 | 0 |  |
| `_putfonts` | 3557-3655 | Private | 23 | 87 | 0 |  |
| `_putimages` | 3657-3705 | Private | 12 | 44 | 0 |  |
| `_putxobjectdict` | 3707-3715 | Private | 2 | 6 | 0 |  |
| `_putresourcedict` | 3717-3741 | Private | 4 | 20 | 0 |  |
| `_putresources` | 3743-3761 | Private | 1 | 12 | 0 |  |
| `_putinfo` | 3763-3773 | Private | 6 | 9 | 0 |  |
| `_putcatalog` | 3775-3803 | Private | 9 | 24 | 0 |  |
| `_putheader` | 3805-3810 | Private | 1 | 3 | 0 |  |
| `_puttrailer` | 3812-3818 | Private | 1 | 5 | 0 |  |
| `_enddoc` | 3820-3858 | Public | 2 | 31 | 0 | portée réductible ? |
| `_beginpage` | 3860-3893 | Private | 5 | 30 | 0 |  |
| `_endpage` | 3895-3905 | Public | 2 | 7 | 0 | portée réductible ? |
| `_newobj` | 3907-3914 | Private | 1 | 5 | 0 |  |
| `_dounderline` | 3916-3929 | Private | 1 | 11 | 0 |  |
| `_parsejpg` | 3931-3965 | Private | 5 | 30 | 0 |  |
| `_parsepng` | 3967-4096 | Private | 23 | 121 | 0 |  |
| `_freadint` | 4098-4110 | Private | 1 | 10 | 0 |  |
| `_textstring` | 4112-4117 | Private | 1 | 3 | 0 |  |
| `_escape` | 4119-4124 | Private | 1 | 3 | 0 |  |
| `_putstream` | 4126-4132 | Private | 1 | 5 | 0 |  |
| `_out` | 4134-4143 | Private | 2 | 7 | 0 |  |
| `_stringFloat` | 4145-4149 | Private | 1 | 3 | 0 |  |
| `_Arc` | 4152-4163 | Private | 1 | 9 | 0 |  |
| `_rotate` | 4165-4190 | Private | 5 | 23 | 0 |  |
| `_checkPageBreak` | 4192-4199 | Private | 2 | 5 | 0 |  |
| `_nbLines` | 4201-4247 | Private | 11 | 44 | 0 |  |
| `_putbookmarks` | 4251-4303 | Private | 12 | 45 | 0 |  |
| `_Point` | 4309-4313 | Private | 1 | 3 | 0 |  |
| `_Line` | 4319-4323 | Private | 1 | 3 | 0 |  |
| `_Curve` | 4331-4340 | Private | 1 | 8 | 0 |  |
| `_putshaders` | 4343-4400 | Private | 7 | 53 | 0 |  |
| `_GetCheckDigit` | 4403-4418 | Private | 4 | 13 | 0 |  |
| `_TestCheckDigit` | 4421-4434 | Private | 3 | 11 | 0 |  |
| `_Barcode` | 4436-4483 | Private | 10 | 43 | 0 |  |
| `_Barcode2` | 4486-4544 | Private | 8 | 49 | 0 |  |
| `_checksum_code39` | 4546-4558 | Private | 2 | 10 | 0 |  |
| `_encode_code39_ext` | 4560-4578 | Private | 3 | 16 | 0 |  |
| `_draw_code39` | 4580-4588 | Private | 3 | 6 | 0 |  |
| `Cell2` | 4590-4729 | Public | 25 | 121 | 0 | portée réductible ? |
| `MultiRiga` | 4731-4868 | Public | 45 | 118 | 0 | portée réductible ? |
| `Lnm` | 4870-4894 | Public | 6 | 20 | 0 | portée réductible ? |
| `MultiRect` | 4896-4910 | Public | 12 | 13 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

Sauf mention contraire : nature **calcul** (aucun contrôle graphique, aucun SQL, aucun état global du
projet) ; portée **réductible** pour les membres sans utilisateur, la plupart étant même du **code mort**.
« [utilisé] » renvoie au tableau ci-dessus. Les coordonnées sont en unité utilisateur, l'origine en haut
à gauche ; `_out` écrit une ligne d'opérateurs PDF dans la page courante (ou dans `$buffer` hors page).

### G01 — Construction et paramètres du document

- **`_new(orientation = "P", unit = "mm", form = "A4")`** [portée : nécessaire] (CC 15). Initialise
  l'état (collections de polices, images, liens ; `$page = -1` : pages numérotées à partir de 0 ;
  `$offsets = [0, 0]` réservés aux objets 1 et 2). Déclare 18 polices de base dont 4 « Serif » non
  standard. Échelle `$k` (pt, mm, cm, in ; sinon `Error.Raise`). Formats a3, 80mm, a4, a5, letter,
  legal, dymoc, dymog (sinon `Error.Raise("Unknown page format")`, cas `Etiqart` dont le format vient
  de la configuration `PageA`). Orientation p/portrait, l/landscape. Marges 1 cm, marge de cellule
  1 mm, trait 0,2 mm, puis `SetAutoPageBreak(True, 2 cm)`, `SetDisplayMode("fullwidth")`,
  `SetCompression(True)`.
- **`SetMargins(l, t, r = -1)`** [portée : nécessaire, `Cfacture`]. ⚠️ **Anomalie l.340** : `$rMargin = t`
  au lieu de `r` (FPDF) ; le paramètre `r` calculé n'est jamais utilisé. Sans effet pour le seul
  appelant (`Cfacture`, format 80mm : `SetMargins(100, 100)`, l = t), et la marge droite ne sert qu'à
  `Cell(0, …)`/`MultiCell(0, …)`, que personne n'appelle avec une largeur nulle.
- **`SetLeftMargin`/`SetTopMargin`/`SetRightMargin`** et **`GetLeftMargin`/`GetTopMargin`/`GetRightMargin`**
  : accesseurs simples, code mort.
- **`SetAutoPageBreak(auto, margin)`** [réductible, appelé par `_new` seulement] : fixe
  `$PageBreakTrigger = $h - margin + 18` ⚠️ (ajout local : en A4, saut de page quand `y + h > 295 mm`,
  soit 2 mm du bord, dans la zone non imprimable de nombreuses imprimantes). `_beginpage` recalcule
  ce seuil **sans** le `+ 18` lors d'un changement d'orientation (chemin jamais emprunté : aucun
  appelant ne passe d'orientation à `AddPage`).
- **`SetDisplayMode(zoom, layout)`** [réductible] : mode d'ouverture du lecteur ; `Error.Raise` sur
  chaîne inconnue. **`SetCompression`** [réductible] ; **`GetCompression`** mort.
- **`SetTitle`/`SetSubject`/`SetAuthor`/`SetCreator`** et leurs `Get*` : métadonnées, jamais renseignées
  (code mort) ; `$keywords` n'a même pas de mutateur.
- **`AliasNbPages(alias = "{nb}")`** [nécessaire] : déclarée `Function` sans type (Variant) et sans
  `Return`. L'alias est remplacé par le nombre de pages dans `_putpages`.
- **`GetFormat()`** [nécessaire, `Cfacture`] : déclarée `Sub … As String` (accepté par Gambas).
  **`GetW`/`GetH`** : mortes.

### G02 — Cycle de vie du document et des pages

- **`Open()`** [nécessaire] : `$state = 1`. **`Close()`** [réductible : appelé seulement par `Output`]
  : ajoute une page si aucune, `_endpage`, `_enddoc` ; idempotent (`$state = 3`).
- **`AddPage(orientation = "")`** [nécessaire] (CC 11) : mémorise police, couleurs et trait, ferme la
  page courante (`_endpage`), ouvre la suivante (`_beginpage`), réémet `2 J`, l'épaisseur de trait, la
  police (`_beginpage` vide `$FontFamily`, ce qui force `SetFont` à réémettre `Tf`) et les couleurs.
  Les appels `Me.Footer()`/`Me.Header()` sont **commentés** : aucun en-tête ni pied automatique.
  Le second `If (family) Then Me.SetFont` est redondant avec le premier (sans effet, la police est
  déjà sélectionnée).
- **`Header(sEntete)`** : implémentation par défaut (titre « Arial BI 20 » + filet), jamais appelée ;
  code mort. **`Footer()`** [nécessaire] : vide ; surchargé par 5 gabarits et appelé par 34
  appelants. ⚠️ `RelvMo` et `RelMoprod` appellent `pdf.Footer()` sur un `Cdocuments`, qui ne le
  surcharge pas : appel sans effet.
- **`PageNo()`** [nécessaire] : `$page + 1`.
- **`AcceptPageBreak()`** [réductible] : `$AutoPageBreak`. Appelée **nue** par `Cell` et `Lnm` : une
  surcharge dans une sous-classe ne serait pas prise en compte (aucune n'existe).
- **`Output(name, dest)`** [nécessaire] (CC 11) : `Close` si besoin ; `dest` Boolean → `"D"`/`"F"` ;
  `"F"` écrit le fichier (`Open … For Write Create`, `Write #f, $buffer, Len($buffer)`), `"S"` renvoie
  le tampon, `"I"` l'imprime sur la sortie standard. `"D"` (donc `dest = True`) n'est pas géré :
  `Error.Raise("Incorrect output destination")`. Les 87 appels du projet passent `False`.
- **`_beginpage(orientation)`** [Private] : ajoute une page, remet `x`/`y` aux marges ; gère le
  changement d'orientation (`$OrientationChanges`). **`_endpage()`** [Public réductible] : referme une
  rotation en cours (`$angle`), `$state = 1`. **`_enddoc()`** [Public réductible] : assemble le
  document (G12).

### G03 — Couleurs et tracés de base

- **`SetDrawColor(r, g, b)`** [réductible ; utilisé seulement par `SetLineStyle`, mort],
  **`SetFillColor(r, g, b)`** [nécessaire], **`SetTextColor(r, g, b)`** [mort] : niveau de gris si
  `g = -1` ou noir, sinon RVB ; `$ColorFlag` signale une couleur de texte différente du remplissage.
- **`SetLineWidth(width)`** [nécessaire] ; **`GetLineWidth`** mort.
- **`Line(x1, y1, x2, y2)`** [nécessaire] : ⚠️ paramètres **`Integer`** (FPDF : réels) : les
  coordonnées sont **tronquées** (vérifié : 2,7 → 2). Seul `Cfacture` passe des valeurs calculées
  (`210 * $xratio` = 136,5 → 136 en 80 mm).
- **`Rect(x, y, w, h, style)`** [nécessaire, `Cetiquettes` et `_Barcode`] : `F` remplit, `FD`/`DF`
  remplit et trace, sinon trace.
- **`SetDash(b, w)`** : pointillés, mort.

### G04 — Polices et mesure du texte

- **`SetFont(family, style, size)`** [nécessaire] (CC 15) : `arial` → `helvetica` ; style `U` →
  soulignement ; `IB` → `BI` ; taille **`Integer`** (pas de demi-point : les appelants arrondissent
  avec `Round($fratio * 10)`). Au premier usage d'une police de base, charge ses largeurs
  (`PdfWriterFont.Font(family [& style pour times/helvetica])`) dans `$fonts`. Police inconnue →
  `Error.Raise("Undefined font")`. ⚠️ `"serif", "BI"` → `PdfWriterFont.serifBI()` **inexistante**
  (erreur d'exécution, voir PdfWriterFont). Polices employées dans le projet : helvetica (404 appels),
  arial (6), courier (4).
- **`SetFontSize(size)`** : mort (transitivement : appelé par `CreateIndex`).
- **`AddFont(family, style, filename)`** (CC 11) : **non fonctionnel** (type, nom, descripteur jamais
  renseignés ; aucun fichier de police lu) et jamais appelé : code mort, ainsi que les branches
  `Type1`/`TrueType` et `$FontFiles`/`$diffs` de `_putfonts`.
- **`GetStringWidth(s)`** [réductible ; utilisé par `Cell` (alignements R/C/FJ, liens), `_dounderline`,
  extensions] : ⚠️ **anomalie l.664** : boucle `For i = 0 To l - 1` avec `Asc(s, i)` ; or `Asc(s, 0)`
  vaut 0 (vérifié gbs3). La largeur calculée est donc `cw[0]` (278 en Helvetica) + la largeur de tous
  les octets **sauf le dernier**. De plus elle porte sur les **octets UTF-8** (é = 195 + 169, lus
  comme « Ã » + « © »). Mesures : « A » → 0,98 mm au lieu de 2,35 mm ; « ABC » → 278 + 667 + 667.
  Effet visible : les textes alignés à droite (`"R"`, 404 appels) ou centrés (`"C"`, 814 appels) sont
  décalés, d'autant plus que le texte est court ou accentué.
- **`GetStringLimit(s, d)`** : troncature avec « … », morte.

### G05 — Écriture de texte et position courante

- **`Cell(w, h, txt, border, ln, align, fill, slink)`** [nécessaire] (CC 34, LOC 144). Saut de page
  automatique si `y + h > PageBreakTrigger` (rétablit l'abscisse et l'espacement des mots) ; largeur
  0 → jusqu'à la marge droite ; bordure : `Boolean` (rectangle `re`, rempli si `fill`) ou chaîne
  `"LTRB"` (segments). ⚠️ Écarts FPDF latents : une bordure **Integer** (`1`) est ignorée, et `fill`
  est ignoré quand la bordure est une chaîne (aucun appelant concerné : 1 889 appels avec un
  Boolean, 17 avec `""`/`" "`). Alignement `R`, `C`, `FJ` (justification forcée par `Tw`), sinon
  gauche (`"l"`, `" L "` tombent dans ce cas) ; échappement `\`, `(`, `)` ; **encodage** (section
  suivante) ; soulignement ; lien (`slink`, jamais utilisé) ; avance `x` ou passe à la ligne (`ln`).
  `$lasth` est `Integer` (hauteur tronquée, sans usage hors `Ln`).
- **`MultiCell(w, h, txt, border, align, fill)`** [nécessaire] (CC 40) : découpe le texte en lignes
  (séparateurs espace, `\n`) d'après `cw[Asc(c)]`, appelle `Cell(…, ln = 2)` par ligne, justification
  par `Tw`. ⚠️ Le parcours est **par octet** (`Mid` et `Asc` octet) : un caractère accentué compte
  pour deux largeurs Latin-1 (« Ã » + second octet), donc les lignes accentuées sont coupées trop tôt ;
  un mot plus long que la ligne peut être coupé **au milieu d'une séquence UTF-8**, ce qui fait échouer
  la conversion de `Cell` (voir encodage). `b = 0` affecte `"0"` à une `String` (sans effet).
- **`Write(h, txt, slink)`** : texte en flux, **morte et cassée** : `Mid(s, 0, 1)` lève « Bad
  argument » dès le premier caractère (vérifié gbs3).
- **`Text(x, y, txt)`** : texte positionné sans conversion d'encodage ; mort (transitivement).
- **`MultiCellBlt`** : puce + `MultiCell`, morte.
- **`Ln(h)`** [réductible, utilisé par `Row`/`CreateIndex` morts] ; **`GetX`/`SetX`/`GetY`**
  [réductibles, usage interne] ; **`SetY(y)`** et **`SetXY(x, y)`** [nécessaires] : `SetY` remet `x`
  à la marge gauche ; valeurs négatives comptées depuis le bord bas/droit.
- **`_dounderline(x, y, txt)`** [Private] : rectangle de soulignement (largeur via `GetStringWidth`,
  donc fausse elle aussi).

#### Encodage des caractères (UTF-8 → PDF)

Les chaînes Gambas sont en UTF-8 ; les polices de base sont déclarées `/WinAnsiEncoding` (CP1252,
dans `_putfonts`). `Cell` (l.1076-1127) applique :

1. si le **dernier** caractère n'est pas `€` : `Try Conv(txt, "UTF-8", "ISO-8859-15")` ;
   sinon : `Try Conv(txt, "UTF-8", "ISO-8859-1")`, qui échoue toujours puisque `€` n'existe pas en
   Latin-1 ;
2. si la conversion a échoué (`If Error`) : sur la chaîne **restée en UTF-8**, remplacement de 27
   caractères CP1252 de la plage 0x80-0x9F par leur octet (`€` → `Chr(128)`, `’` → 146, `–` → 150,
   `Œ` → 140…), et de quelques lettres **par la lettre sans accent** (`é è` → `e`, `à â` → `a`,
   `ç` → `c`, `ì` → `i`, `ò ô` → `o`, `ù` → `u`, `°` → `o`) ; `£` et `§` → octet Latin-1.

Résultats vérifiés (génération réelle puis `pdftotext`) :

| Texte | Rendu |
|---|---|
| `Éléments à côté, réglée` | correct (ISO-8859-15 = CP1252 pour les lettres accentuées) |
| `Total 12,50 €` (euro final) | correct (`Chr(128)`) |
| `Prix : 12,50 € TTC` (euro **non final**) | `12,50 ¤ TTC` : en ISO-8859-15 l'euro est 0xA4, qui vaut `¤` en WinAnsi |
| `Réglée à l'échéance 10 €` | `Reglee a l'echeance 10 €` : accents supprimés |
| `Œuvre déjà payée – reste dû` (`–` hors ISO-8859-15) | `deja payee – reste dÃ»` : accents supprimés, `û` en mojibake |
| `Côté île réglée — 5 €` | `Cote Ã®le reglee — 5 €` : `î` en mojibake |

Cas qui produisent un texte faux : euro suivi d'autres caractères (`¤`) ; toute chaîne qui se termine
par `€` ou contient un caractère hors ISO-8859-15 (`’ “ ” – — … • ™`, fréquents dans les copier-coller
de désignations) → perte des accents `é è à â ç ô ù ì ò`, et mojibake (deux caractères « Ã… ») pour
les autres accentuées (`ê ë î ï û ü É È À Ç Ê Ô`…) ; `Š š Ž ž Œ œ Ÿ` sont mal placés après une
conversion ISO-8859-15 réussie (positions 0xA6-0xBE différentes de CP1252 ; vérifié :
« Œuvre cœur Šarka Ÿves » → « ¼uvre c½ur ¦arka ¾ves ») ; une séquence UTF-8 coupée par `MultiCell`. Une conversion directe
`Conv(txt, "UTF-8", "WINDOWS-1252")` avec repli caractère par caractère corrigerait l'ensemble
(anomalie PDFWRITER-A01). `GetStringWidth` et `MultiCell` mesurant les octets UTF-8, il faut convertir
**avant** de mesurer (A02, A03). `Cell2` (mort) applique la table sans `Conv` (é → 233 correct, mais
`ê â ô…` restent en UTF-8). `Text` et les métadonnées (`_textstring`) ne convertissent rien.

### G06 — Liens

- **`AddLink`/`SetLink`** : liens internes, morts. **`Link(x, y, w, h, slink)`** [réductible] :
  appelé par `Cell`/`Image` seulement si `slink` est renseigné (jamais) ; paramètres `Integer`.
  ⚠️ `_putpages` indexe `l` déclaré `Float` (`l[0]`) pour un lien interne : erreur probable si un lien
  interne était posé (chemin mort).

### G07 — Images

- **`Image(filename, x, y, w, h, type, slink)`** [nécessaire] (CC 12) : type déduit de l'extension
  (sinon `Error.Raise("Image file has no extension…")`) ; `jpg`/`jpeg` → `_parsejpg`, `png` →
  `_parsepng`, autre → `Error.Raise("Unsupported image type")`. Image mise en cache par nom de
  fichier ; dimensions à 72 dpi ou proportionnelles. Aucune erreur n'est interceptée : c'est la cause
  de **CFACTURE-A03** (logo absent ou GIF/BMP → impression du ticket interrompue).
- **`_parsejpg(filename)`** [Private] : contrôle l'existence et l'**extension** (pas le contenu), lit le
  fichier (`File.Load`) et ses dimensions par `Image.Load` (gb.image). ⚠️ l.3949 : `data.Depth = 2`
  n'est jamais vrai (profondeur en bits par pixel) : un JPEG en niveaux de gris ou CMJN est déclaré
  `/DeviceRGB` (rendu incorrect probable, à confirmer visuellement).
- **`_parsepng(filename)`** [Private] (CC 23, LOC 121) : lecture des blocs PNG. Résultats vérifiés :
  PNG RVB 8 bits sans transparence : correct ; ⚠️ PNG avec **canal alpha** (cas courant d'un logo) :
  « Alpha channel not supported » ; PNG **à palette** : « Missing palette » à tort, car le test l.4079
  `IsNull(pal) = ""` est **vrai quand la palette est présente** (vérifié gbs3) ; PNG avec bloc `tRNS` :
  « Class 'Array' is not creatable » (l.4056-4061, `New Array` affecté à une `String`) ; entrelacé :
  erreur sans fermer le fichier. Défauts masqués par les précédents : palette tronquée de 4 octets
  (`Left(buf, n - 4)`, l.4050) et nombre de couleurs formaté par `Str` localisé (`253,666…`, l.3674).
  Fichier absent : erreur Gambas « File or directory does not exist ».
- **`_freadint`** [Private] : entier 32 bits gros-boutiste. **`RotatedImage`** : morte.

### G08 — Codes-barres

- **`EAN13(x, y, barcode, h = 16, w = 0,35)`** [nécessaire : `Cdocuments`, `Cdocuments2`,
  `Cetiquettes`] → **`_Barcode`** [Private] (réécrit en 2016) : motifs L/G/R d'après le premier chiffre.
  ⚠️ l.4474 : la boucle `For k = 1 To 7` redessine **toutes** les barres pour chaque « 1 » des 7
  premiers modules : chaque barre est tracée 2 à 5 fois (vérifié : 255 rectangles pour 51 barres).
  Rendu identique, fichier plus gros. Un code de longueur ≠ 13 (EAN-8, UPC à 12 chiffres, code
  vide) n'est **pas dessiné, sans erreur** ; la clé de contrôle n'est ni calculée ni vérifiée ; un
  caractère non numérique donne `Val()` nul (comportement à confirmer). Le texte sous le code n'est pas
  imprimé (les gabarits l'impriment eux-mêmes).
- **`UPC_A`** : morte et inopérante (`_Barcode` ignore `length` ≠ 13). **`_Barcode2`** (ancienne
  version avec `Print` de débogage), **`_GetCheckDigit`**, **`_TestCheckDigit`** (`==` et priorité de
  `Mod` : test faux), **`Code39`**, **`i25`**, **`Codabar`**, **`_checksum_code39`**,
  **`_encode_code39_ext`**, **`_draw_code39`** : code mort.

### G09 — Extensions graphiques (code mort)

`RoundedRect`, `RoundedRect2`, `Circle`, `Circle2`, `Ellipse`, `Ellipse2`, `Sector`, `PieChart`,
`BarDiagram`, `SetLegends`, `Polygon`, `Polygon2`, `Cube`, `SetLineStyle`, `Curve2`,
`RegularPolygon2`, `StarPolygon2`, `Star`, `Line2`, `Rect2`, `DashedRect`, et les primitives privées
`_Arc`, `_Point`, `_Line`, `_Curve`. Aucun utilisateur. Variables associées : `$legends`, `$wLegend`,
`$sum`, `$NbVal`. `DashedRect` dessine des segments de 1 unité par `Line` (Integer) ; `PieChart`/
`BarDiagram` forcent la police Courier.

### G10 — Dégradés, transformations et rotations (code mort)

`LinearGradient`, `RadialGradient`, `CoonsPatchMesh`, `Clip`, `Gradient` et `_putshaders` (objets
`/Shading`, `$gradients`) ; `StartTransform`, `ScaleX`, `ScaleY`, `ScaleXY`, `Scale`, `MirrorH`,
`MirrorV`, `MirrorP`, `MirrorL`, `TranslateX`, `TranslateY`, `Translate`, `Rotate`, `SkewX`, `SkewY`,
`Skew`, `Transform`, `StopTransform`, `CircularText`, `RotatedText` et `_rotate` (`$angle`, refermé par
`_endpage`). `_putshaders` est appelé par `_putresources` mais n'écrit rien quand `$gradients` est vide.

### G11 — Tableaux, signets et index (code mort)

`SetColumnWidths`, `SetColumnAligns`, `Row` (faux négatif de `deps.py` : « Row » confondu avec
`GridView.Row`), `_checkPageBreak`, `_nbLines` ; `Bookmark`, `CreateIndex` (⚠️ boucle infinie si un
titre dépasse : `Mid(txt, 1)` ne raccourcit pas la chaîne), `_putbookmarks` (`$outlines`,
`$OutlineRoot`, branche `/Outlines` de `_putcatalog`).

### G12 — Sérialisation du document (Private, sauf `_enddoc`/`_endpage`)

- **`_putpages`** (CC 13) : remplace l'alias du nombre de pages (si `$AliasNbPages` non vide), écrit
  chaque page (`/MediaBox` si orientation changée, annotations de lien) et son contenu, compressé par
  `Compress` (gb.compress, type `zlib`) si `$compress`. ⚠️ l.3533 : `cmp.String` sans `AllowGrow`
  renvoie la source **non compressée** quand la compression n'apporte rien (contenu très court), mais
  le flux est quand même déclaré `/Filter /FlateDecode` : la page est **illisible** (vérifié :
  « Unknown compression method in flate stream » pour une page d'une seule cellule ; correct dès deux
  cellules). Puis l'objet 1 (`/Pages`, `/Kids`, `/Count`).
- **`_putfonts`** (CC 23) : un objet `/Font /Type1` par police de base, `/Encoding /WinAnsiEncoding`
  sauf Symbol/ZapfDingbats ; branches d'encodages différentiels et d'incorporation inaccessibles
  (`AddFont` mort).
- **`_putimages`** (CC 12) : un XObject par image (`/DCTDecode` pour JPEG, `/FlateDecode` + prédicteur
  PNG), palette éventuelle ; libère les données.
- **`_putxobjectdict`**, **`_putresourcedict`**, **`_putresources`** : dictionnaire de ressources
  (objet 2). **`_putinfo`** : `/Producer (PdfWriter 0.2)` et `/CreationDate` = `Now` (à masquer dans
  les comparaisons de tests). **`_putcatalog`** : `/OpenAction` selon le zoom, `/PageLayout`.
  **`_putheader`** : `%PDF-1.3`. **`_puttrailer`**.
- **`_enddoc`** [Public réductible] : enchaîne les précédents, la table `xref` (décalages en octets,
  `Len` étant en octets : correct) et `startxref`.
- **`_newobj`**, **`_textstring`**, **`_escape`**, **`_putstream`**, **`_out`** (concatène à la page
  courante ou à `$buffer`), **`_stringFloat(v, f)`** (`Format` localisé puis `,` → `.`).

### G13 — Ajouts Laurux en fin de fichier (code mort)

- **`Cell2`** : copie de `Cell` sans saut de page automatique et avec la table de remplacement
  appliquée sans `Conv` (voir encodage).
- **`MultiRiga`** (CC 45) : copie de `MultiCell` qui écrit par `Cell2`, mémorise la hauteur dans
  `$lasthmulti` (5 lignes au plus : au-delà `hriga` reste 0) puis revient à l'ordonnée de départ.
- **`Lnm`** : saut de ligne de la hauteur `$lasthmulti` ; `k` jamais initialisé (`0 Tw` émis).
- **`MultiRect`** : 11 rectangles de colonnes de hauteur `$lasthmulti`.

Ces quatre méthodes forment une ébauche de tableau à cellules multilignes, jamais branchée.

## État global utilisé

Aucun état global du projet (`Start`, `Utils`, `Variables`), aucun accès à la base, aucun contrôle
graphique. Dépendances de composants : **gb.compress** (`Compress`, pilote zlib) pour les flux,
**gb.image** (`Image.Load`) pour les JPEG. Classe statique `PdfWriterFont`. Locale : `Format` et
`Str` sont localisés (virgule décimale en français) ; `_stringFloat` corrige `Format`, pas `Str`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **Supprimer le code mort** par familles (G08 hors EAN13, G09, G10, G11, G13, `Write`, `AddFont`,
  métadonnées, accesseurs de marges) : environ 3 000 lignes sur 4 910, sans effet sur le PDF produit
  (les branches de sérialisation correspondantes n'écrivent rien quand les collections sont vides).
  Chaque famille fait l'objet d'une étape séparée, testée par comparaison des PDF.
- **`Cell`** : extraire `_TraceBordure(w, h, border, fill)` et `_EncodeTexte(txt)` (bloc d'encodage),
  sans changer les octets produits (CC 34 → ≤ 12). `MultiCell` : extraire la mise à jour de la bordure,
  dupliquée deux fois.
- Un helper `_Pt(v)` = `_stringFloat(v * $k, "0.00")` et `_PtY(v)` = `_stringFloat(($h - v) * $k,
  "0.00")` réduirait de moitié la taille des fonctions de tracé (sortie identique).
- `AddPage` : supprimer le second bloc de restauration de police (redondant).

### Commonalisation avec d'autres fichiers

- Les 23 gabarits ([Cfacture](../../Caisse/Reports/Cfacture.class/architecture.md),
  [Ccompta](../Ccompta.class/architecture.md), [Creleve](../Creleve.class/architecture.md),
  [Cdocuments](../Cdocuments.class/architecture.md), [Cbordereaux](../Cbordereaux.class/architecture.md),
  [CLcr](../../Gestion/Lcr/CLcr.class/architecture.md)…) répètent `newPage`, `BasPage`, `Logo`,
  `_new` (lecture de `Start.R/G/B`) avec de légères variantes. Une classe intermédiaire
  `PdfLaurux Inherits PdfWriter` (couleurs du thème, logo protégé, pied de page paginé) est à étudier
  en phase 3, avec des tests de caractérisation PDF par gabarit (les textes diffèrent).
- Le chargement de logo protégé (`Exist` + type supporté avant `Image`) est à factoriser dans cette
  classe intermédiaire ou dans `PdfWriter` (correction de CFACTURE-A03 = anomalie, voir A05).
- Les tables de largeurs de [PdfWriterFont](../PdfWriterFont.class/architecture.md) sont recalculées à
  chaque document : cache statique (voir PDFWRITERFONT-002).

### Réduction de portée

- Restent `Public` (utilisés par les sous-classes via `Me.` ou par les appelants) : `_new`,
  `SetMargins`, `AliasNbPages`, `Open`, `AddPage`, `Footer`, `PageNo`, `SetFillColor`,
  `SetLineWidth`, `Line`, `Rect`, `SetFont`, `Cell`, `MultiCell`, `Image`, `SetY`, `SetXY`,
  `Output`, `EAN13`, `GetFormat`, ainsi que les constantes `Version`/`PDFVersion` (à vérifier).
- Réductibles en `Private` après suppression du code mort : `Close`, `SetAutoPageBreak`,
  `SetDisplayMode`, `SetCompression`, `GetStringWidth`, `AcceptPageBreak`, `Link`, `GetX`, `SetX`,
  `GetY`, `Ln`, `_enddoc`, `_endpage`. Attention : une sous-classe future ne pourrait plus les
  appeler ; `Private` interdit aussi la surcharge (`AcceptPageBreak` est un point d'extension FPDF,
  mais il est appelé nu, donc non surchargeable aujourd'hui).

### Séparation traitement / GUI

Sans objet : aucune interaction graphique. `Image.Load` (gb.image) ne sert qu'à lire les dimensions
d'un JPEG ; une lecture des marqueurs SOF éviterait cette dépendance (changement de comportement
possible sur les JPEG exotiques : à classer en anomalie si entrepris).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : `PdfWriter` n'accède pas à la base. À plus long terme, le remplacement du moteur par une
  bibliothèque maintenue (portage FPDF 1.8x avec polices TrueType UTF-8, ou génération par
  `gb.pdf`/`gb.report2`) supprimerait les défauts d'encodage, mais change le PDF produit : hors
  périmètre du rework.
