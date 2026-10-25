# PdfWriter — Rework

> Source : `.src/Reports/PdfWriter.class` · Message de commit (phase 4) : `reference/.src/Reports/PdfWriter.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 3403 |
| Lignes de commentaire | 964 |
| Fonctions | 160 |
| Fonctions Public | 123 |
| Complexité cyclomatique totale | 791 |
| Complexité max (fonction) | 45 (`MultiRiga`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 3403 | 791 | 45 | 0 | 123 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Principe : le PDF produit (normalisé, `/CreationDate` masqué, flux décompressés) doit rester
**identique octet pour octet** pour les tests T01-T14 et pour les tests PDF des 23 gabarits. Les
membres utilisés par les sous-classes (`Me.X`) gardent leur nom, leur signature et leur portée `Public`.

- [ ] PDFWRITER-001 — [documentation] En-tête en français : origine (PDFWriter 0.0.2 de L. Carlotto,
  portage de FPDF 1.53, GPL2), tableau des modifications locales, contrat d'encodage (UTF-8 → CP1252,
  limites), liste des membres utilisés par les sous-classes, règles d'héritage Gambas (`Me.`, `Private`
  invisible, appel nu non surchargeable) ; commentaires `'''` sur les membres conservés · appelants :
  aucun · tests : T01-T14 · sources : [PdfWriter.class:_new](../../../../.src/Reports/PdfWriter.class#L161-L322), [PdfWriter.class:Cell](../../../../.src/Reports/PdfWriter.class#L1001-L1158)
- [ ] PDFWRITER-002 — [code mort] Supprimer les extensions graphiques (G09) : `RoundedRect`,
  `RoundedRect2`, `Circle`, `Circle2`, `Ellipse`, `Ellipse2`, `Sector`, `PieChart`, `BarDiagram`,
  `SetLegends`, `Polygon`, `Polygon2`, `Cube`, `SetLineStyle`, `Curve2`, `RegularPolygon2`,
  `StarPolygon2`, `Star`, `Line2`, `Rect2`, `DashedRect`, `SetDash`, `SetDrawColor`, `_Arc`, `_Point`,
  `_Line`, `_Curve` et les variables `$legends`, `$wLegend`, `$sum`, `$NbVal` · appelants : aucun
  (vérifié dans les 23 sous-classes) · tests : T01-T14 · sources : [PdfWriter.class:RoundedRect](../../../../.src/Reports/PdfWriter.class#L1481-L1533),
  [PdfWriter.class:Ellipse2](../../../../.src/Reports/PdfWriter.class#L1791-L1868), [PdfWriter.class:PieChart](../../../../.src/Reports/PdfWriter.class#L2071-L2124), [PdfWriter.class:SetLineStyle](../../../../.src/Reports/PdfWriter.class#L2456-L2510),
  [PdfWriter.class:_Curve](../../../../.src/Reports/PdfWriter.class#L4331-L4340)
- [ ] PDFWRITER-003 — [code mort] Supprimer dégradés, transformations et rotations (G10) :
  `LinearGradient`, `RadialGradient`, `CoonsPatchMesh`, `Clip`, `Gradient`, `_putshaders` et le bloc
  `/Shading` de `_putresourcedict` (`$gradients`), `StartTransform`, `ScaleX`, `ScaleY`, `ScaleXY`, `Scale`, `MirrorH`, `MirrorV`, `MirrorP`,
  `MirrorL`, `TranslateX`, `TranslateY`, `Translate`, `SkewX`, `SkewY`, `Skew`, `Transform`,
  `StopTransform`, `Rotate`,
  `CircularText`, `RotatedText`, `RotatedImage`, `_rotate`, `Text`, et `$angle` (le test de
  `_endpage` devient inutile) · appelants : aucun · tests : T01-T14 · sources :
  [PdfWriter.class:LinearGradient](../../../../.src/Reports/PdfWriter.class#L2682-L2692), [PdfWriter.class:_putshaders](../../../../.src/Reports/PdfWriter.class#L4343-L4400), [PdfWriter.class:StartTransform](../../../../.src/Reports/PdfWriter.class#L3185-L3190),
  [PdfWriter.class:CircularText](../../../../.src/Reports/PdfWriter.class#L3402-L3467), [PdfWriter.class:_rotate](../../../../.src/Reports/PdfWriter.class#L4165-L4190), [PdfWriter.class:_endpage](../../../../.src/Reports/PdfWriter.class#L3895-L3905)
- [ ] PDFWRITER-004 — [code mort] Supprimer les codes-barres inutilisés (G08 hors EAN13) : `UPC_A`,
  `Code39`, `i25`, `Codabar`, `_Barcode2` (avec ses `Print` de débogage), `_GetCheckDigit`,
  `_TestCheckDigit`, `_checksum_code39`, `_encode_code39_ext`, `_draw_code39`, ainsi que les variables
  inutilisées `bars` et `l` de `_Barcode` (signature inchangée) · appelants : aucun · tests : T09 · sources : [PdfWriter.class:Code39](../../../../.src/Reports/PdfWriter.class#L2992-L3052),
  [PdfWriter.class:_Barcode2](../../../../.src/Reports/PdfWriter.class#L4486-L4544), [PdfWriter.class:_draw_code39](../../../../.src/Reports/PdfWriter.class#L4580-L4588)
- [ ] PDFWRITER-005 — [code mort] Supprimer tableaux, signets et index (G11) : `SetColumnWidths`,
  `SetColumnAligns`, `Row`, `_checkPageBreak`, `_nbLines`, `Bookmark`, `CreateIndex`,
  `_putbookmarks`, `$columnWidths`, `$columnAligns`, `$outlines`, `$OutlineRoot` et la branche
  `/Outlines` de `_putcatalog` (jamais émise) · appelants : aucun · tests : T01-T14 · sources :
  [PdfWriter.class:Row](../../../../.src/Reports/PdfWriter.class#L1659-L1696), [PdfWriter.class:CreateIndex](../../../../.src/Reports/PdfWriter.class#L1896-L1930), [PdfWriter.class:_putbookmarks](../../../../.src/Reports/PdfWriter.class#L4251-L4303),
  [PdfWriter.class:_putcatalog](../../../../.src/Reports/PdfWriter.class#L3775-L3803)
- [ ] PDFWRITER-006 — [code mort] Supprimer les ajouts Laurux jamais branchés (G13) `Cell2`,
  `MultiRiga`, `Lnm`, `MultiRect`, `$lasthmulti`, ainsi que `Write` (cassée), `MultiCellBlt`,
  `GetStringLimit`, `Header` (crochet commenté) et les lignes commentées `'Me.Footer()`/`'Me.Header()`
  · appelants : aucun · tests : T01-T14 · sources : [PdfWriter.class:Cell2](../../../../.src/Reports/PdfWriter.class#L4590-L4729),
  [PdfWriter.class:MultiRiga](../../../../.src/Reports/PdfWriter.class#L4731-L4868), [PdfWriter.class:Lnm](../../../../.src/Reports/PdfWriter.class#L4870-L4894), [PdfWriter.class:MultiRect](../../../../.src/Reports/PdfWriter.class#L4896-L4910),
  [PdfWriter.class:Write](../../../../.src/Reports/PdfWriter.class#L1272-L1344), [PdfWriter.class:Header](../../../../.src/Reports/PdfWriter.class#L587-L596)
- [ ] PDFWRITER-007 — [code mort] Supprimer les accesseurs et options jamais appelés :
  `SetLeftMargin`, `SetTopMargin`, `SetRightMargin`, `GetLeftMargin`, `GetTopMargin`,
  `GetRightMargin`, `GetCompression`, `SetTitle`/`GetTitle`, `SetSubject`/`GetSubject`,
  `SetAuthor`/`GetAuthor`, `SetCreator`/`GetCreator` (les `If Not IsNull($title)…` de `_putinfo`
  n'émettent rien et deviennent inutiles), `SetTextColor`, `GetLineWidth`, `SetFontSize`, `GetW`,
  `GetH`, `AddLink`, `SetLink` ; `AddFont` (non fonctionnelle) avec les branches `Type1`/`TrueType`,
  `$FontFiles` et `$diffs` de `_putfonts` · appelants : aucun · tests : T01, T11, T13 · sources :
  [PdfWriter.class:SetLeftMargin](../../../../.src/Reports/PdfWriter.class#L344-L350), [PdfWriter.class:GetCreator](../../../../.src/Reports/PdfWriter.class#L487-L492), [PdfWriter.class:AddFont](../../../../.src/Reports/PdfWriter.class#L812-L871),
  [PdfWriter.class:_putfonts](../../../../.src/Reports/PdfWriter.class#L3557-L3655), [PdfWriter.class:_putinfo](../../../../.src/Reports/PdfWriter.class#L3763-L3773)
- [ ] PDFWRITER-008 — [complexité] `Cell` : extraire `_TraceBordure(w, h, border, fill)` et
  `_EncodeTexte(txt)` (bloc d'encodage l.1076-1127 recopié **à l'identique**, `Try`/`If Error`
  compris) ; `MultiCell` : extraire la mise à jour de bordure dupliquée (CC 34 → ≤ 12, 40 → ≤ 25 visés)
  · appelants : aucun (signatures inchangées) · tests : T02-T05 · sources : [PdfWriter.class:Cell](../../../../.src/Reports/PdfWriter.class#L1001-L1158),
  [PdfWriter.class:MultiCell](../../../../.src/Reports/PdfWriter.class#L1160-L1270)
- [ ] PDFWRITER-009 — [complexité] Helpers privés `_Pt(v)` et `_PtY(v)` pour
  `_stringFloat(v * $k, "0.00")` / `_stringFloat(($h - v) * $k, "0.00")`, utilisés par `Cell`, `Line`,
  `Rect`, `Image`, `_dounderline` (sortie identique) ; suppression du second bloc de restauration de
  police d'`AddPage` (redondant) · appelants : aucun · tests : T01-T10 · sources :
  [PdfWriter.class:AddPage](../../../../.src/Reports/PdfWriter.class#L524-L585), [PdfWriter.class:Line](../../../../.src/Reports/PdfWriter.class#L692-L700), [PdfWriter.class:Rect](../../../../.src/Reports/PdfWriter.class#L725-L742),
  [PdfWriter.class:_stringFloat](../../../../.src/Reports/PdfWriter.class#L4145-L4149)
- [ ] PDFWRITER-010 — [réduction de portée] `Close`, `SetAutoPageBreak`, `SetDisplayMode`,
  `SetCompression`, `GetStringWidth`, `AcceptPageBreak`, `Link`, `GetX`, `SetX`, `GetY`, `Ln`,
  `_enddoc`, `_endpage` → `Private` (après 002-007 ; aucun utilisateur dans les 23 sous-classes ni
  ailleurs, vérifié par grep de `Me.X` et `pdf.X`). Restent `Public` : `_new`, `SetMargins`,
  `AliasNbPages`, `Open`, `AddPage`, `Footer`, `PageNo`, `SetFillColor`, `SetLineWidth`, `Line`,
  `Rect`, `SetFont`, `Cell`, `MultiCell`, `Image`, `SetY`, `SetXY`, `Output`, `EAN13`, `GetFormat` ·
  appelants : aucun · tests : T01-T14 + tests PDF des gabarits · sources : [PdfWriter.class:Close](../../../../.src/Reports/PdfWriter.class#L508-L522),
  [PdfWriter.class:GetStringWidth](../../../../.src/Reports/PdfWriter.class#L653-L668), [PdfWriter.class:AcceptPageBreak](../../../../.src/Reports/PdfWriter.class#L994-L999), [PdfWriter.class:_enddoc](../../../../.src/Reports/PdfWriter.class#L3820-L3858)
- [ ] PDFWRITER-011 — [commonalisation] Étude (phase 3) d'une classe intermédiaire
  `PdfLaurux Inherits PdfWriter` regroupant `newPage`/`BasPage`/`Logo`/couleurs du thème des 23
  gabarits ; à n'exécuter qu'avec les tests de caractérisation PDF de chaque gabarit, car les textes
  diffèrent · appelants : les 23 sous-classes · tests : tests PDF des gabarits · sources :
  [PdfWriter.class:AddPage](../../../../.src/Reports/PdfWriter.class#L524-L585), [Cfacture.class:_new](../../../../.src/Caisse/Reports/Cfacture.class#L11-L47), [Ccompta.class:_new](../../../../.src/Reports/Ccompta.class#L8-L14)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction. Toutes
modifient le PDF produit par les 23 gabarits.

- [ ] PDFWRITER-A01 — [anomalie] Encodage de `Cell` : euro non final rendu « ¤ » (ISO-8859-15) ;
  chaîne terminée par « € » ou contenant un caractère hors ISO-8859-15 (’ “ ” – — … •) → accents
  é è à â ç ô ù supprimés et autres accentuées en mojibake (« Ã® ») ; Œ œ Š š Ž ž Ÿ mal placés
  (« ¼uvre »). Correction : `Conv(txt, "UTF-8", "WINDOWS-1252")` avec repli par caractère (« ? »)
  · tests : T02 · sources : [PdfWriter.class:1079](../../../../.src/Reports/PdfWriter.class#L1079), [PdfWriter.class:1086](../../../../.src/Reports/PdfWriter.class#L1086), [PdfWriter.class:1114](../../../../.src/Reports/PdfWriter.class#L1114)
- [ ] PDFWRITER-A02 — [anomalie] `GetStringWidth` : `Asc(s, 0)` = 0 (largeur de `cw[0]` ajoutée,
  dernier octet omis) et mesure des octets UTF-8 → textes alignés à droite (404 appels) ou centrés
  (814) décalés. Correction : mesurer la chaîne convertie en CP1252, indices 1 à `Len` · tests : T03 ·
  sources : [PdfWriter.class:664](../../../../.src/Reports/PdfWriter.class#L664), [PdfWriter.class:GetStringWidth](../../../../.src/Reports/PdfWriter.class#L653-L668)
- [ ] PDFWRITER-A03 — [anomalie] `MultiCell` mesure et découpe par octet UTF-8 : lignes accentuées
  coupées trop tôt, coupure possible au milieu d'un caractère (texte faux après conversion) ·
  tests : T05 · sources : [PdfWriter.class:1224](../../../../.src/Reports/PdfWriter.class#L1224), [PdfWriter.class:MultiCell](../../../../.src/Reports/PdfWriter.class#L1160-L1270)
- [ ] PDFWRITER-A04 — [anomalie] Page au contenu très court écrite non compressée mais déclarée
  `/FlateDecode` (`Compress.String` sans `AllowGrow`) : page illisible. Correction : `AllowGrow` ou
  filtre conditionnel · tests : T07 · sources : [PdfWriter.class:3533](../../../../.src/Reports/PdfWriter.class#L3533), [PdfWriter.class:_putpages](../../../../.src/Reports/PdfWriter.class#L3475-L3555)
- [ ] PDFWRITER-A05 — [anomalie] Images : PNG avec alpha refusé ; PNG à palette refusé à tort
  (`IsNull(pal) = ""` vrai quand la palette existe) ; PNG avec `tRNS` → « Class 'Array' is not
  creatable » ; palette tronquée et `Str` localisé ; JPEG gris/CMJN déclarés `/DeviceRGB` ; aucune
  erreur interceptée (logo absent ou GIF → édition interrompue, CFACTURE-A03). Correction possible en
  deux temps : PNG (palette, tRNS) puis repli « image ignorée » à décider avec l'utilisateur ·
  tests : T08 · sources : [PdfWriter.class:Image](../../../../.src/Reports/PdfWriter.class#L1346-L1386), [PdfWriter.class:3949](../../../../.src/Reports/PdfWriter.class#L3949), [PdfWriter.class:4012](../../../../.src/Reports/PdfWriter.class#L4012),
  [PdfWriter.class:4050](../../../../.src/Reports/PdfWriter.class#L4050), [PdfWriter.class:4056](../../../../.src/Reports/PdfWriter.class#L4056), [PdfWriter.class:4079](../../../../.src/Reports/PdfWriter.class#L4079), [PdfWriter.class:3674](../../../../.src/Reports/PdfWriter.class#L3674)
- [ ] PDFWRITER-A06 — [anomalie] `_Barcode` (EAN13) : barres retracées 2 à 5 fois (boucle
  `For k = 1 To 7`, rendu identique, PDF plus gros) ; code de longueur ≠ 13 ignoré sans erreur ; clé de
  contrôle non vérifiée · tests : T09 · sources : [PdfWriter.class:4474](../../../../.src/Reports/PdfWriter.class#L4474), [PdfWriter.class:4453](../../../../.src/Reports/PdfWriter.class#L4453),
  [PdfWriter.class:_Barcode](../../../../.src/Reports/PdfWriter.class#L4436-L4483)
- [ ] PDFWRITER-A07 — [anomalie] `SetMargins` affecte la marge haute à la marge droite
  (`$rMargin = t`) ; sans effet pour le seul appelant (`Cfacture`, l = t) mais faux en général ·
  tests : T12 · sources : [PdfWriter.class:340](../../../../.src/Reports/PdfWriter.class#L340), [Cfacture.class:26](../../../../.src/Caisse/Reports/Cfacture.class#L26)
- [ ] PDFWRITER-A08 — [anomalie] Seuil de saut de page `h - marge + 18` (contenu jusqu'à 2 mm du
  bord en A4) et recalcul sans `+ 18` dans `_beginpage` lors d'un changement d'orientation · tests :
  T06 · sources : [PdfWriter.class:395](../../../../.src/Reports/PdfWriter.class#L395), [PdfWriter.class:3889](../../../../.src/Reports/PdfWriter.class#L3889)
- [ ] PDFWRITER-A09 — [anomalie] Typage `Integer` hérité du portage : `Line`/`Link` (coordonnées
  tronquées au mm, cas `Cfacture` 80 mm : 136,5 → 136), `SetFont` (taille entière), `$lasth` ; écarts
  FPDF latents de `Cell` (bordure Integer ignorée, `fill` ignoré avec bordure chaîne) · tests : T04,
  T10 · sources : [PdfWriter.class:Line](../../../../.src/Reports/PdfWriter.class#L692-L700), [PdfWriter.class:SetFont](../../../../.src/Reports/PdfWriter.class#L873-L934), [PdfWriter.class:Cell](../../../../.src/Reports/PdfWriter.class#L1001-L1158)
- [ ] PDFWRITER-A10 — [anomalie] `Output(…, True)` (destination « D ») lève « Incorrect output
  destination » au lieu d'un comportement défini ; aucun appelant actuel (87 × `False`) · tests :
  T13 · sources : [PdfWriter.class:Output](../../../../.src/Reports/PdfWriter.class#L1434-L1469)
