# PdfWriter — Tests

> Source : `.src/Reports/PdfWriter.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul pur (aucune base, aucun contrôle graphique) : les tests unitaires sont de type
`gbtest`. Ils créent un `PdfWriter` (ou une sous-classe de test minimale `Inherits PdfWriter`, pour
vérifier l'accès par `Me.`), produisent le document par `Output(fichier, False)` (ou `"S"`, tant que la
destination existe) et comparent la **sortie normalisée** à la référence. Les valeurs attendues sont
produites en phase 2 dans le clone **Laurux non modifié** (tests de caractérisation : anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PDFWRITER-T01 | gbtest | `_new` : formats, orientations, unités | a3, a4, a5, 80mm, letter, legal, dymoc, dymog × P/L × mm/pt ; format, unité et orientation invalides | `/MediaBox` de référence ; texte d'erreur `Error.Raise` | `tests/constructeur/` | implémenté |
| PDFWRITER-T02 | gbtest | Encodage de `Cell` | jeu de chaînes : ASCII, `Éléments à côté`, euro final / médian, `’ – — …`, `Œ œ Š Ÿ`, `ê î û É`, `°`, `( ) \` | octets de l'opérande `Tj` et texte `pdftotext` de référence (¤, accents supprimés, mojibake figés) | `tests/encodage_cell/` | implémenté |
| PDFWRITER-T03 | gbtest | Alignements et `GetStringWidth` | `Cell` R/C/L/FJ/`"l"`/`" L "` sur « A », « ABC », « Réglée », chaîne vide | abscisses `Td` de référence (anomalie A02 figée) | `tests/alignement/` | implémenté |
| PDFWRITER-T04 | gbtest | Bordures et remplissage de `Cell` | border `True`/`False`/`"LTRB"`/`"LR"`/`""`/`1` × fill `True`/`False` × `SetFillColor` gris/RVB | opérateurs `re`/`m l S`/`f`/`B` de référence | `tests/bordures/` | implémenté |
| PDFWRITER-T05 | gbtest | `MultiCell` | texte long accentué, `\n`, mot plus long que la largeur, align J/L/C, border `False`/`True` | nombre de lignes, `Tw`, positions | `tests/multicell/` | implémenté |
| PDFWRITER-T06 | gbtest | Saut de page automatique et alias | 200 `Cell(190, 5)` en A4 P et L, puis `AliasNbPages` + « page {nb} » | nombre de pages, dernière ordonnée par page, `{nb}` remplacé | `tests/saut_page/` | implémenté |
| PDFWRITER-T07 | gbtest | Compression des pages | page vide, 1 cellule, 2 cellules, 40 cellules, `SetCompression(False)` | flux de référence ; page 1 cellule non compressée + `/FlateDecode` (A04 figée) | `tests/compression/` | implémenté |
| PDFWRITER-T08 | gbtest | `Image` | JPEG RVB/gris/CMJN, PNG RVB/RVBA/palette/tRNS/entrelacé, GIF, fichier absent, sans extension, même image deux fois | XObject de référence ou texte d'erreur figé (cf. CFACTURE-A03) | `tests/images/` | implémenté |
| PDFWRITER-T09 | gbtest | `EAN13` | `3760123456789`, 12 chiffres, clé fausse, caractère non numérique, vide | nombre de `re f` (255 pour le 1er cas), aucun tracé si longueur ≠ 13 | `tests/ean13/` | implémenté |
| PDFWRITER-T10 | gbtest | Tracés et couleurs | `Line` avec coordonnées décimales, `Rect` F/FD/D, `SetLineWidth`, `SetFillColor(r)` et `(r, g, b)` | opérateurs et coordonnées (troncature Integer figée) | `tests/traces/` | implémenté |
| PDFWRITER-T11 | gbtest | `SetFont` | helvetica/arial/courier/times × ""/B/I/BI/U, taille 0, police inconnue, `serif BI` | `/BaseFont`, `Tf` ; erreurs figées | `tests/polices/` | implémenté |
| PDFWRITER-T12 | gbtest | `SetMargins` | `SetMargins(10, 30)` puis `Cell(0, 5, "x", True)` ; `SetMargins(100, 100)` en 80 mm | largeur du cadre (marge droite = 30, A07 figée) | `tests/marges/` | implémenté |
| PDFWRITER-T13 | gbtest | `Output` et sérialisation | dest `False`, `"S"`, `""`, `True` ; document sans `AddPage` | fichier identique au tampon ; xref cohérente (`qpdf --check` si disponible) ; erreur pour `True` | `tests/output/` | implémenté |
| PDFWRITER-T14 | gbtest | Performance | 8 000 cellules (≈ 143 pages A4) + 10 EAN13 | durée de référence (`gbx3 -p`), environ 0,03 s mesuré | `tests/perf_document/` | implémenté |
| PDFWRITER-T15 | replay | Gabarits réels | éditions représentatives déjà prévues dans les gabarits : ticket A4/80 mm (`Cfacture`), étiquettes EAN13 (`Cetiquettes`), journal (`Ccompta`), relevé avec logo (`Creleve`) | PDF normalisé identique ; aucune table modifiée | `tests/gabarits_pdf/` | à faire : test propre à la classe à écrire ; aujourd'hui couvert seulement par des tests d'autres classes (couvert par les scénarios existants Compta/frelcompte_edition_tous (Creleve), Reports/ccompta_journaux et ccompta_jourcent (Ccompta), Gestion/etiq*_* (Cetiquettes, EAN13) et le module CfactureTest (ticket A4/80 mm) ; texte pdftotext comparé) — règle du 2026-11-14 : les tests d'une classe sont portés par la classe |

## Détail des tests

- **Normalisation** (`check_output.py`, commun avec les gabarits, cf. CFACTURE-T*) : décompression
  des flux `/FlateDecode` (en tolérant un flux non compressé, cas A04), masquage de
  `/CreationDate (D:…)`, recalcul ou suppression de la table `xref` et de `startxref` (décalages
  modifiés par le masquage). Variante plus robuste pour T02/T05 : texte extrait par `pdftotext -layout`
  (paquet poppler-utils), qui reflète ce que voit l'utilisateur.
- **Génération des références** : un module de test exécuté dans le clone Laurux non modifié produit
  les PDF dans `tests/<nom>/expected/` ; `gen_input.py` génère les images de T08 (Pillow : RVB, RVBA,
  palette, tRNS, JPEG gris/CMJN, GIF) et la liste de chaînes de T02. Faisabilité vérifiée pendant la
  phase 1 par un projet jouet (copie de `PdfWriter`/`PdfWriterFont` + gb.image, gb.image.io,
  gb.compress) : résultats consignés dans `output/claude/2026-10-24_rework/phase1/reports/`.
- **Locale** : `Format` et `Str` étant localisés, les tests tournent en `LANG=fr_FR.UTF-8` (comme
  l'application) et une passe en `LANG=C` vérifie que `_stringFloat` neutralise la locale (le
  `Str` de la palette PNG ne l'est pas : sans objet tant que A05 bloque les PNG à palette).
- **Erreurs** : les cas qui lèvent `Error.Raise` ou une erreur Gambas sont testés par `Try` et
  comparaison de `Error.Text` (aucun `Message`, aucune GUI : compatibles gb.test).
- **Sous-classes** : T01-T13 instancient aussi une sous-classe de test `Inherits PdfWriter` dont le
  `_new()` est vide, pour garantir que les réductions de portée (PDFWRITER-010) ne retirent aucun
  membre appelé par `Me.` ; les gabarits réels sont couverts par leurs propres tests et par T15.
- **Couverture visée** : 100 % des lignes conservées après les étapes 002-007 (les extensions mortes
  ne sont pas testées : elles sont supprimées).
- **Non testable automatiquement** : le rendu visuel (centrage, JPEG CMJN, impression à 2 mm du bord)
  ; contrôle manuel dans un lecteur PDF lors de la validation des anomalies.
- **Module gb.test** : `.src/Tests/Reports/PdfWriterTest.test`, valeurs attendues dans `.hidden/Tests/Reports/assets/PdfWriterTest/expected.txt`. Texte `pdftotext -layout`, `pdfinfo`, md5 du PDF non compressé masqué, et `Ops()` qui relève les lignes d'opérateurs du flux (Tj, Td, re, m/l/S, rg/g, Tf, Q…). Images : JPEG `Fonds_Laurux/Laurux1.jpg`, PNG RGB `.src/Images/monnaie/b100.png`, RGBA `.app.png`, palette `Icones/calculator.png`, GIF `Icones/Larus.gif`, JPEG nommé .png `.src/Images/monnaie/p2.png`. T14 : 8 000 cellules + 10 EAN13, 143 pages, durée vérifiée < 10 s (pas de durée de référence figée).
