# EdPrep — Dépendances

> Source : `.src/Gestion/Impressions/EdPrep.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdPrep.class` — classe, formulaire associé `EdPrep.form`
- Handlers GUI détectés : 5

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cdocuments` | `<type>`, `BasPageP`, `EnteteP`, `Level1D`, `Level2D`, `Level2DLG`, `Level2DLG2`, `LinesLG`, `LinesP` |
| `Cdocuments3` | `<type>`, `BasPage`, `Basep`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level2b`, `adresse`, `adresse2`, `cadre`, `carre` |
| `DB_Connection` | `Exec` |
| `Editeur` | `Prog_Editeur` |
| `Impression` | `Facture` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_AdrlivBL`, `Fiches_AdrlivC`, `Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_Four`, `Fiches_Ligbl`

### Membres Public sans usage externe détecté (portée réductible ?)

`donnees1`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:2451` (`Menu325_Click`).
- « Portée réductible » `donnees1` confirmée (appelé seulement par `Button3_Click`, y compris sous
  `Try`).
- `Impression.Facture` (existant, `Impression.module:27`) : imprime directement le PDF des bons ;
  ce fichier n'utilise ni `Impression.Prog_Editeur` ni `Start.Soc` (IMPRESSION-A03 sans objet ici).
- Utilise `Cdocuments` (`EnteteP`, `Level1d`, `level2d`, `level2DLG`, `level2DLG2`, `LinesLG`,
  `LinesP`, `BaspageP`) et `Cdocuments3` (`Entete`, `Entete2`, `cadre`, `adresse`, `adresse2`,
  `Level1`, `Level2`, `Level2b`, `carre`, `Basep`, `BasPage`).
- Tables : `Fiches_AdrlivC`, `Fiches_AdrlivBL`, `Fiches_Ligbl`, `Fiches_Art`, `Fiches_Four` en dur
  dans la partie « bons ».
