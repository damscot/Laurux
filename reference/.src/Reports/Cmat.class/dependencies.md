# Cmat — Dépendances

> Source : `.src/Reports/Cmat.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cmat.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Ligne`, `Ligne2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Impressions/EdMat.class` | `<type>`, `Entete`, `Footer`, `Level1`, `Level2` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Ligne`, `Ligne2`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique vérifié** : `EdMat` (`Dim pdf As Cmat`, `New Cmat("Portrait", "mm", "A4")`,
  bouton d'impression). Liste de l'heuristique complète.
- **Code mort vérifié** : `Ligne`, `Ligne2` (aucun `pdf.Ligne` dans `EdMat`, aucune chaîne
  dynamique) ; les autres `Ligne`/`Ligne2` du projet appartiennent à `Carticles` ou sont des
  contrôles (`ImpartParam.Ligne2`) ou un membre (`ObjFac.ligne2`).
- **Duplication** : `_new`, `_free`, `Footer`, `Ligne`, `Ligne2` identiques à ceux de
  `Carticles` ; `Entete` identique à `Carticles.EnteteTC` (x = 2).
- **Appelant** : `EdMat` n'appelle pas `Entete` si aucune des cases « vendus »/« en stock »
  n'est cochée, puis appelle `Level1` sans page ouverte (scénario EDMAT-T03, défaut de l'appelant).
- Aucun appel dynamique, aucune dépendance circulaire. **Ordre de rework** : après la base
  `PdfLaurux` (CARTICLES-004).
