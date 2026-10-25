# PdfWriter — Dépendances

> Source : `.src/Reports/PdfWriter.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/PdfWriter.class` — classe
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `SetLeftMargin`, `GetLeftMargin`, `SetTopMargin`, `GetTopMargin`, `SetRightMargin`, `GetRightMargin`, `GetCompression`, `SetTitle`, `GetTitle`, `SetSubject`, `GetSubject`, `SetAuthor`, `GetAuthor`, `SetCreator`, `GetCreator`, `SetTextColor`, `GetLineWidth`, `AddFont`, `AddLink`, `SetLink`, `RoundedRect`, `RoundedRect2`, `GetStringLimit`, `RotatedText`, `RotatedImage`, `SetColumnWidths`, `SetColumnAligns`, `Bookmark`, `CreateIndex`, `DashedRect`, `PieChart`, `BarDiagram`, `SetDash`, `MultiCellBlt`, `GetW`, `GetH`, `Polygon`, `Cube`, `Curve2`, `RegularPolygon2`, `StarPolygon2`, `Star`, `LinearGradient`, `RadialGradient`, `CoonsPatchMesh`, `UPC_A`, `Code39`, `i25`, `Codabar`, `ScaleY`, `ScaleXY`, `MirrorH`, `MirrorV`, `MirrorP`, `MirrorL`, `TranslateX`, `TranslateY`, `SkewX`, `SkewY`, `CircularText`, `_Barcode2`, `MultiRiga`, `Lnm`, `MultiRect`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Rect2`, `SetFontSize`, `Text`, `Circle`, `Circle2`, `Ellipse`, `Ellipse2`, `Sector`, `SetLegends`, `Polygon2`, `Clip`, `Gradient`, `StartTransform`, `ScaleX`, `Scale`, `Translate`, `Rotate`, `Skew`, `Transform`, `StopTransform`, `_Arc`, `_rotate`, `_Point`, `_Line`, `_Curve`, `_GetCheckDigit`, `_TestCheckDigit`, `_checksum_code39`, `_encode_code39_ext`, `_draw_code39`, `Cell2`, `Line2`, `SetLineStyle`, `SetDrawColor`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/ArchivesTck.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Caisse/Bordereaux.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Caisse/Caisse.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Caisse/Moulinage.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Caisse/Reports/Cfacture.class` | `<type>`, `AddPage`, `Cell`, `GetFormat`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetMargins`, `SetXY`, `SetY` |
| `.src/Caisse/Reports/Cticket.class` | `<type>`, `AddPage`, `Cell`, `SetFont`, `SetXY` |
| `.src/Compta/Impressions/Anomalies.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/BalanceM.module` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/BordereauxC.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/Echeancier.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/EcrM.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/EdImpayes.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/EdNjustifiees.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/EdNlettrees.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/EditcompteA.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/EditcompteM.module` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/FTVA.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/Imp_Bilan.module` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/Imp_Sig.module` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/Jourcent.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/JournauxA.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/JournauxM.module` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/Plancomptable.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Impressions/RubImp.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Pointage.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Relances/FEditrel.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Relances/FRelCompte.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Relances/FRelFacture.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Relances/Ligcli.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Utils/ImpJdv.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Compta/Utils/ImpSage.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Depots/Edsdepots.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Depots/ImpDepots.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Etiquettes/Eticli.class` | `Open`, `Output` |
| `.src/Gestion/Etiquettes/Etigond.class` | `Open`, `Output` |
| `.src/Gestion/Etiquettes/EtiqPromo.class` | `Open`, `Output` |
| `.src/Gestion/Etiquettes/EtiqRecpt.class` | `Open`, `Output` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `Open`, `Output` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `Open`, `Output` |
| `.src/Gestion/Etiquettes/Etiqfbtarif.class` | `Open`, `Output` |
| `.src/Gestion/Facturation/Facturergbl.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdArt1.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdArt2.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdArt3.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdClient.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdDocs.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdFam.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdFour.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdMat.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdPrep.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdRup.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/EdStk.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Edbr.module` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Edcom.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Edmo.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Edpaiement.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Edregul.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Edregulprdc.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Impressions/Traites.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Lcr/Attribution.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Lcr/Bordrx.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Lcr/CLcr.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Gestion/Lcr/Glcr.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Lcr/Lcr.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Lcr/Preparation.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ecarts.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Ednsaisis.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Fin-annee/Geninv.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Tournant/EcartsT.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdinvT.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Stock/Inventaires/Tournant/GeninvT.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Gestion/Tables/FClient.class` | `Open`, `Output` |
| `.src/Gestion/Tables/FFournisseur.class` | `Open`, `Output` |
| `.src/Gestion/option/Tregie.class` | `<type>`, `AddPage`, `AliasNbPages`, `Cell`, `Open`, `Output`, `SetFont`, `SetXY` |
| `.src/Reports/Carticles.class` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Reports/Cbalances.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Reports/Cbilan.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cbordereaux.class` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Reports/Cclients.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Ccompta.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cdocuments.class` | `<type>`, `AddPage`, `Cell`, `EAN13`, `Image`, `Line`, `MultiCell`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cdocuments2.class` | `<type>`, `AddPage`, `Cell`, `EAN13`, `Image`, `Line`, `MultiCell`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cdocuments3.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cecheancier.class` | `<type>`, `AddPage`, `Cell`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Reports/Cetiquettes.class` | `<type>`, `AddPage`, `Cell`, `EAN13`, `Line`, `Rect`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY` |
| `.src/Reports/Chistoriques.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Clivre.class` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cmat.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Reports/Creleve.class` | `<type>`, `AddPage`, `Cell`, `Image`, `Line`, `MultiCell`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY` |
| `.src/Reports/Cresultat.class` | `<type>`, `AddPage`, `Cell`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Reports/Csig.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Cstocks.class` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `.src/Reports/Ctraites.class` | `<type>`, `AddPage`, `Cell`, `SetFillColor`, `SetFont`, `SetXY` |
| `.src/Reports/Htickets.class` | `<type>`, `AddPage`, `Cell`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `.src/Statistiques/Histovmo.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Statistiques/RelMoprod.class` | `AliasNbPages`, `Footer`, `Open`, `Output` |
| `.src/Statistiques/RelvMo.class` | `AliasNbPages`, `Footer`, `Open`, `Output` |
| `.src/Statistiques/VisHitCartes.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Statistiques/VisStatClimo.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Statistiques/VisStatComArt.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Statistiques/VisStatComm.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Statistiques/VisStatFour.class` | `AliasNbPages`, `Open`, `Output` |
| `.src/Statistiques/VisStatTypCli.class` | `AliasNbPages`, `Open`, `Output` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriterFont` | `Font` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`SetLeftMargin`, `GetLeftMargin`, `SetTopMargin`, `GetTopMargin`, `SetRightMargin`, `GetRightMargin`, `SetAutoPageBreak`, `SetDisplayMode`, `SetCompression`, `GetCompression`, `SetTitle`, `GetTitle`, `SetSubject`, `GetSubject`, `SetAuthor`, `GetAuthor`, `SetCreator`, `GetCreator`, `Close`, `Header`, `SetDrawColor`, `SetTextColor`, `GetStringWidth`, `GetLineWidth`, `Line2`, `Rect2`, `AddFont`, `SetFontSize`, `AddLink`, `SetLink`, `Link`, `Text`, `AcceptPageBreak`, `Write`, `Ln`, `GetX`, `SetX`, `GetY`, `RoundedRect`, `RoundedRect2`, `GetStringLimit`, `RotatedText`, `RotatedImage`, `SetColumnWidths`, `SetColumnAligns`, `Circle`, `Circle2`, `Ellipse`, `Ellipse2`, `Bookmark`, `CreateIndex`, `DashedRect`, `Sector`, `PieChart`, `BarDiagram`, `SetLegends`, `SetDash`, `MultiCellBlt`, `GetW`, `GetH`, `Polygon`, `Polygon2`, `Cube`, `SetLineStyle`, `Curve2`, `RegularPolygon2`, `StarPolygon2`, `Star`, `LinearGradient`, `RadialGradient`, `CoonsPatchMesh`, `Clip`, `Gradient`, `UPC_A`, `Code39`, `i25`, `Codabar`, `StartTransform`, `ScaleX`, `ScaleY`, `ScaleXY`, `Scale`, `MirrorH`, `MirrorV`, `MirrorP`, `MirrorL`, `TranslateX`, `TranslateY`, `Translate`, `Rotate`, `SkewX`, `SkewY`, `Skew`, `Transform`, `StopTransform`, `CircularText`, `_enddoc`, `_endpage`, `Cell2`, `MultiRiga`, `Lnm`, `MultiRect`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Usage par les sous-classes** : les 23 sous-classes `Inherits PdfWriter` appellent les membres
  hérités par `Me.X` ; `deps.py` les compte (lignes « `<type>`, `AddPage`, `Cell`… » du tableau),
  ce que confirme le relevé par
  `output/claude/2026-10-24_rework/phase1/reports/tools/pdf_usage.py` (tableau dans architecture.md) :
  membres réellement utilisés = `_new`, `SetMargins`, `AliasNbPages`, `Open`, `AddPage`, `Footer`,
  `PageNo`, `SetFillColor`, `SetLineWidth`, `Line`, `Rect`, `SetFont`, `Cell`, `MultiCell`, `Image`,
  `SetY`, `SetXY`, `Output`, `EAN13`, `GetFormat`. La liste « portée réductible » du bloc AUTO est
  donc juste pour les autres membres, mais `Rect`, `GetFormat` et `SetMargins` ne doivent jamais
  passer `Private` (un `Private` du parent est invisible de la sous-classe : vérifié).
- **Faux négatifs de code mort** : `Row`, `SetColumnWidths`/`SetColumnAligns` (via `Row`),
  `_checkPageBreak`, `_nbLines`, `GetX`, `GetY`, `Ln` ne sont pas signalés `unused` alors qu'ils ne
  sont atteints que par du code mort (« Row » est confondu avec `GridView.Row` ; `Ln` avec le
  paramètre `ln` de `Cell`). `Header` est mort (crochet commenté l.565). `Close` n'est appelé que par
  `Output` (le `Close` de `Tregie` est celui du formulaire).
- **Surcharges** : `_new` dans les 23 sous-classes (sans paramètre : les 3 arguments de `New` vont à
  `PdfWriter._new`) ; `Footer` dans `Carticles`, `Cbordereaux`, `Chistoriques`, `Cmat`, `Htickets`.
  `RelvMo` et `RelMoprod` appellent `pdf.Footer()` sur un `Cdocuments` sans surcharge : appel vide.
- **Appel dynamique** : aucun. **Membre inexistant** : `Me.seto` dans `Cticket.class:24` (compile,
  « Unknown symbol » à l'exécution ; `Cticket` jamais instancié).
- **Appel direct** : `Tregie` instancie `PdfWriter` et appelle `Open`, `AliasNbPages`, `AddPage`,
  `SetFont`, `SetXY`, `Cell`, `Output` ; il passe des `Float` à `Cell` (paramètre `String`) :
  conversion implicite non localisée (« 1.5 », point décimal ; vérifié gbs3).
- **Constructeur** : formats utilisés `A4` (~80), `dymog` (5), `dymoc` (2), `80mm` (2), variables
  (`Etiqart` : `PageA[0]` de la configuration ; `Moulinage` : `Format`) ; orientation `Portrait`,
  `P`, `p`, `l`. Un format de configuration inconnu lève `Error.Raise("Unknown page format")`.
- **Signaux deps.py** : `arity_errors`, `handlers_inactifs`, `replay_dynamic`, `replay_missing` vides
  (classe sans `.form`). `unused` (64) et `unused_transitive` (34) vérifiés par grep : tous morts, à
  l'exception de `SetDrawColor`/`Rect2`/`Text`… qui ne sont appelés que par d'autres membres morts
  (même traitement). `scope_reducible` : voir ci-dessus.
- **Composants** : `gb.compress` (`Compress`, zlib), `gb.image` (`Image.Load` dans `_parsejpg`).
- **Dépendance** vers [`PdfWriterFont`](../PdfWriterFont.class/dependencies.md) (`Font`) ; pas de
  dépendance circulaire.
- **Ordre de rework** : `PdfWriterFont` d'abord (indépendant), puis `PdfWriter` ; les étapes qui
  touchent l'API (réduction de portée, suppression) passent avant tout rework des 23 gabarits ; la
  classe intermédiaire éventuelle (commonalisation des gabarits) vient après. Chaque étape repasse
  les tests de génération de `PdfWriter` et les tests PDF des gabarits (`CFACTURE-T*`, `CETIQUETTES-T*`,
  `CCOMPTA-T*`…).
