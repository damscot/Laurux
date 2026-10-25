# PdfWriter — Synthèse

> Source : `.src/Reports/PdfWriter.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Moteur PDF de toutes les éditions de Laurux. Portage Gambas de **FPDF 1.53** (« PDFWriter 0.0.2 »,
Luigi Carlotto, 2007, GPL2) avec une vingtaine d'extensions fpdf.org, et des ajouts locaux (formats
Dymo et 80 mm, polices « Serif », bloc d'encodage, EAN13 réécrit, `Cell2`/`MultiRiga`). Un objet = un
document : le contenu des pages est accumulé en opérateurs PDF puis sérialisé par `Output`.

## Points clés

- Classe de base de **23 gabarits** (`Inherits PdfWriter`), utilisée directement par `Tregie`.
  Seuls 20 membres servent réellement : `_new`, `SetMargins`, `AliasNbPages`, `Open`, `AddPage`,
  `Footer`, `PageNo`, `SetFillColor`, `SetLineWidth`, `Line`, `Rect`, `SetFont`, `Cell`,
  `MultiCell`, `Image`, `SetY`, `SetXY`, `Output`, `EAN13`, `GetFormat`.
- Environ **60 % du fichier est du code mort** (géométrie, dégradés, transformations, signets,
  tableaux, Code39/i25/Codabar, ajouts Laurux non branchés, `Write` cassée, `AddFont` inopérante).
- Héritage Gambas (vérifié) : appel hérité obligatoirement par `Me.` ; un `Private` du parent est
  invisible de la sous-classe ; un appel nu dans le parent ne voit pas les surcharges. En-tête et pied
  de page automatiques désactivés : les appelants appellent `pdf.Footer()`.
- Polices standard PDF uniquement (`/WinAnsiEncoding`), largeurs de [PdfWriterFont](../PdfWriterFont.class/summary.md).
- Aucun accès base, aucun état global ; composants gb.compress et gb.image.

## Dépendances principales

- Utilise : `PdfWriterFont.Font`, `Compress` (gb.compress), `Image.Load` (gb.image).
- Utilisé par : 23 sous-classes (Reports, `Cfacture`, `Cticket`, `CLcr`) et ~85 écrans d'impression
  (`Open`, `AliasNbPages`, `Output`, `Footer`), `Tregie`.

## Risques

- **Encodage** (vérifié par génération et `pdftotext`) : euro au milieu d'un texte → « ¤ » ; texte
  finissant par « € » ou contenant ’ – … → accents supprimés (« Reglee ») ou mojibake (« Ã® ») ;
  Œ/œ/Š/Ÿ → « ¼ ½ ¦ ¾ ».
- **Mesure du texte fausse** (`Asc(s, 0)`, octets UTF-8) : alignements droite/centre décalés sur
  1 218 appels ; `MultiCell` coupe les lignes accentuées trop tôt.
- **Images** : PNG avec alpha, à palette (test inversé) ou tRNS refusés ; GIF, fichier absent → erreur
  non interceptée (CFACTURE-A03) ; JPEG gris/CMJN déclarés RVB.
- Page très courte non compressée mais déclarée `/FlateDecode` → page illisible.
- EAN13 : barres tracées 2 à 5 fois ; code ≠ 13 chiffres ignoré sans erreur.
- `SetMargins` (`$rMargin = t`), seuil de saut de page `+ 18` (2 mm du bord), types `Integer`
  (traits, taille de police).
- Toute modification change potentiellement toutes les éditions : tests PDF normalisés obligatoires.

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

## Tests

15 tests prévus (PDFWRITER-T01 à T15) : 14 `gbtest` (constructeur, encodage, alignement, bordures,
`MultiCell`, saut de page, compression, images, EAN13, tracés, polices, marges, sortie, performance)
et 1 `replay` sur des gabarits réels. Comparaison du PDF normalisé (flux décompressés,
`/CreationDate` et xref masqués) ou du texte `pdftotext`. Faisabilité vérifiée en phase 1 par un
projet jouet ; performance : 143 pages en ≈ 0,03 s.

## Rework

11 étapes sans changement du PDF produit (PDFWRITER-001 à 011) : documentation, suppression du code
mort en 6 familles, découpage de `Cell`/`MultiCell`, helpers de coordonnées, réduction de portée de
13 membres, étude d'une classe intermédiaire pour les gabarits. 10 anomalies (PDFWRITER-A01 à A10)
soumises à validation : encodage, mesure du texte, `MultiCell`, compression, images, EAN13, marges,
seuil de saut de page, typage Integer, destination « D ».
