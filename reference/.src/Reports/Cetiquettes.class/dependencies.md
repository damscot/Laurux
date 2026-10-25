# Cetiquettes — Dépendances

> Source : `.src/Reports/Cetiquettes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cetiquettes.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Etiquettes/Eticli.class` | `<type>`, `Cp`, `NewPage`, `Nom` |
| `.src/Gestion/Etiquettes/Etigond.class` | `<type>`, `Barcode`, `Code`, `IntituleA`, `IntituleB`, `NewPage`, `Poids`, `PrixHt`, `PrixTTC`, `PrixTTCB`, `Rectangle2`, `Refour`, `Tva`, `volm` |
| `.src/Gestion/Etiquettes/EtiqPromo.class` | `<type>`, `Barcode`, `Code`, `IntituleA`, `NewPage`, `PrixHt`, `PrixHtP`, `PrixTTC`, `PrixTTCP`, `Rectangle`, `Tva`, `volm` |
| `.src/Gestion/Etiquettes/EtiqRecpt.class` | `<type>`, `Barcode`, `Code`, `Codec`, `Intitule`, `IntituleA`, `Intitulec`, `NewPage`, `PrixHt`, `PrixTTC`, `Rectangle2`, `Tva`, `casier`, `casierc`, `stock`, `stockc` |
| `.src/Gestion/Etiquettes/Etiqart.class` | `<type>`, `Barcode`, `Code`, `IntituleA`, `NewPage`, `PrixTTC` |
| `.src/Gestion/Etiquettes/Etiqcasier.class` | `<type>`, `Barcode`, `Code`, `Codec`, `Intitule`, `Intitulec`, `NewPage`, `casier`, `casierc`, `stock`, `stockc` |
| `.src/Gestion/Etiquettes/Etiqfbtarif.class` | `<type>`, `Barcode`, `Code`, `Intitule`, `NewPage`, `PrixHt`, `PrixTTC`, `Rectangle`, `Tva`, `volm` |
| `.src/Gestion/Tables/FClient.class` | `<type>`, `Adrexp`, `Cp`, `CpC`, `NewPage`, `Nom`, `NomC` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>`, `Adrexp`, `Barcode`, `Cp`, `CpC`, `NewPage`, `Nom`, `NomC` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `EAN13`, `Line`, `Rect`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY` |
| `Start` | `B`, `G`, `R` |
| `Utils` | `cpoint` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn "As Cetiquettes\|New CEtiquettes"`) : 7 écrans de
  `Gestion/Etiquettes` (`Etiqart`, `Etigond`, `Etiqcasier`, `EtiqPromo`, `EtiqRecpt`,
  `Etiqfbtarif`, `Eticli`) et `FClient`, `FFournisseur` (`Gestion/Tables`), tous avec un membre
  `Private pdf As Cetiquettes`. Formats passés au constructeur de `PdfWriter` : `PageA[1]`,
  `"mm"`, `PageA[0]` (orientation et format lus dans le modèle de planche), `"Portrait", "mm",
  "A4"`, ou `"dymog"`/`"dymoc"` (rouleaux Dymo). Liste de l'heuristique complète ; les 29 méthodes
  sont toutes appelées (aucun `unused`).
- **Chaîne Zebra** : pour l'imprimante Zebra, plusieurs écrans utilisent `pdf` sans l'avoir créé
  (« Null object », ZEBRA-A01) : défaut des appelants, pas du gabarit.
- **Code-barres** : `Barcode` dépend de `PdfWriter.EAN13` (rien n'est imprimé si le code ne fait
  pas 13 caractères ; barres dessinées plusieurs fois : PDFWRITER-A06) et de `Utils.cpoint` + `Val` en locale
  française (les appelants passent des `Float` convertis en chaîne avec un point).
- **Positionnement** : les fonctions `pos_Etiq` des appelants (6 variantes V1 à V6, socle
  `PlancheEtiquettes`, ETIQART-010) calculent `posX`/`posY`/`fontratio` ; le gabarit les applique
  tels quels.
- Aucun appel dynamique, aucune dépendance circulaire. **Ordre de rework** : CETIQUETTES-002/003
  (helpers internes) indépendants ; CETIQUETTES-004 après la base `PdfLaurux` (CARTICLES-004) ;
  avant le socle `PlancheEtiquettes` (ETIQART-010) qui s'appuie sur ce gabarit.
