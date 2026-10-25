# Cdocuments2 — Dépendances

> Source : `.src/Reports/Cdocuments2.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cdocuments2.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `EnteteN`, `EnteteP`, `Lines`, `LinesP`, `Entete2`, `Logo2`, `Level1`, `Level2`, `Level3`, `Level3bis`, `Level1R`, `Level2R`, `Level3R`, `Level4R`, `Level4RB`, `Level4`, `Level1F`, `Level1DP`, `Level2F`, `Level2Fa`, `Level3F`, `Level4F`, `Level4aF`, `Level4bF`, `Level5F`, `Level6F`, `Level7F`, `Level8F`, `Level9F`, `Level10F`, `Level11F`, `Level12F`, `Level13F`, `LevelM`, `Level2M`, `Level14F`, `Level15F`, `Level16F`, `Level1br`, `Level2br`, `Level3br`, `EnteteD`, `Level1D`, `Level2D`, `BasPage`, `BasPageP`, `Level1FAM`, `Level2FAM`, `Level1RL`, `Level2RL`, `Level5RL`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Entete`, `Logo`, `Colonnes`, `Signature`, `SignatureD`, `SignatureD2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/Facture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `EAN13`, `Image`, `Line`, `MultiCell`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `LocalSettings`, `R`, `Societe` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`EnteteN`, `EnteteP`, `Lines`, `LinesP`, `Entete`, `Entete2`, `Logo2`, `Logo`, `Level1`, `Level2`, `Level3`, `Level3bis`, `Level1R`, `Level2R`, `Level3R`, `Level4R`, `Level4RB`, `Level4`, `Level1F`, `Level1DP`, `Level2F`, `Level2Fa`, `Level3F`, `Colonnes`, `Level4F`, `Level4aF`, `Level4bF`, `Level5F`, `Level6F`, `Level7F`, `Level8F`, `Level9F`, `Level10F`, `Level11F`, `Level12F`, `Level13F`, `LevelM`, `Level2M`, `Level14F`, `Signature`, `Level15F`, `Level16F`, `SignatureD`, `SignatureD2`, `Level1br`, `Level2br`, `Level3br`, `EnteteD`, `Level1D`, `Level2D`, `BasPage`, `BasPageP`, `Level1FAM`, `Level2FAM`, `Level1RL`, `Level2RL`, `Level5RL`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucune instanciation** : `grep -rn -i cdocuments2 .src` ne trouve que la déclaration
  `Private pdf2 As Cdocuments2` (`Facture.class:200`) ; `pdf2` n'est utilisé nulle part dans
  `Facture.class`. La création `New Cdocuments2("landscape", "mm", "A4")` a été retirée par le
  commit `a2e027f1` (2019-07-12). Aucune chaîne `"Cdocuments2"` (pas de `Class.Load` ni
  `Object.New`).
- **Faux négatif de `deps.py`** : `jamais_reference` vaut `false` parce qu'une déclaration de
  type (`<type>`) compte comme une référence ; la classe est pourtant inutilisée. Toutes ses
  méthodes sont signalées `unused` ou `unused_transitive` (`Entete`, `Logo`, `Colonnes`,
  `Signature`, `SignatureD`, `SignatureD2` ne sont appelées que par d'autres méthodes mortes),
  et `_new`/`_free` ne sont jamais exécutées.
- **Suppression** : la classe n'a pas de `.form` ; sa suppression est un rework [code mort]
  (comme FOURCONSDROI-001), à faire dans le même commit que la suppression de la déclaration de
  `Facture.class:200` (modification d'une ligne dans un gros fichier legacy).
- Aucune dépendance circulaire, aucun appel dynamique, aucune table.
- Ordre de rework : indépendant ; à faire avant le socle PDF commun (CDOCUMENTS-005) pour ne pas
  migrer une classe morte.
