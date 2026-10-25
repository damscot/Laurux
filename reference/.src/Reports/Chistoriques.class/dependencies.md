# Chistoriques — Dépendances

> Source : `.src/Reports/Chistoriques.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Chistoriques.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Level1bis`, `Level2bis`, `Level1F`, `level2F`, `Level4F`, `Level5F`, `Level5AC`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/Histovmo.class` | `<type>`, `Entete`, `Footer`, `Level1`, `Level2` |
| `.src/Statistiques/VisHitCartes.class` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1H`, `Lines`, `level2H` |
| `.src/Statistiques/VisStatClimo.class` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1P`, `Level4P`, `Level5P`, `Lines`, `level2P` |
| `.src/Statistiques/VisStatComArt.class` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1A`, `Level5A`, `Lines`, `level2A` |
| `.src/Statistiques/VisStatComm.class` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1AC`, `Lines`, `level2AC` |
| `.src/Statistiques/VisStatFour.class` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1FO`, `Level4FO`, `Level5FO`, `Lines`, `level2FO` |
| `.src/Statistiques/VisStatTypCli.class` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1C`, `Level4C`, `Level5C`, `Lines`, `level2C` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `Line`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `G`, `R` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Level1bis`, `Level2bis`, `Level1F`, `level2F`, `Level4F`, `Level5F`, `Level5AC`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn "As Chistoriques\|New Chistoriques"`) : `Histovmo`,
  `VisHitCartes`, `VisStatClimo`, `VisStatComArt`, `VisStatComm`, `VisStatFour`, `VisStatTypCli`
  (`.src/Statistiques`), chacun dans son `Button2_Click` (« Imprimer »), avec
  `New Chistoriques("Portrait", "mm", "A4")` : les arguments vont au constructeur de `PdfWriter`.
  Liste de l'heuristique complète.
- **Code mort vérifié** (`grep -rniw`, aucune chaîne dynamique) : `Level1bis`, `Level2bis`,
  `Level5AC`. Pour `Level1F`, `level2F`, `Level4F`, `Level5F`, les homonymes trouvés par `grep`
  (`Facturergbl`, `EdFour`, `Caisse`) visent d'autres classes (`Cdocuments`, `Cclients`,
  `Cfacture`) : aucun appel sur un objet `Chistoriques`. Ces 7 méthodes sont les signaux `unused`
  et « portée réductible » de l'heuristique, traités en suppression (CHISTORIQUES-002).
- **Casse** : les appelants écrivent `Level1p`, `level5p`… (Gambas ignore la casse) ;
  l'heuristique les rattache correctement.
- **Types** : `VisStatClimo` passe des `Float` aux paramètres `String` de `level2P`
  (VISSTATCLIMO-A01) ; tous les appelants passent un `Integer` au `PosY As String` de `Lines`.
- **Formatage dans le gabarit** : `level2FO` dépend du format des colonnes de la grille de
  `VisStatFour` (virgule, colonne % vide si CA nul) : CHISTORIQUES-A01.
- Des documents existants pointent déjà vers cette architecture (`VisStatComm`,
  `VisHitCartes`) ; les liens restent valides.
- Aucun appel dynamique, aucune dépendance circulaire. **Ordre de rework** : après la base
  `PdfLaurux` (CARTICLES-004) ; avant le socle `ImprimeListe` des `VisStat*` (VISSTATCOMM).
