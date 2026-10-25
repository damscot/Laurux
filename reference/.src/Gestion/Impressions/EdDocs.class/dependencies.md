# EdDocs — Dépendances

> Source : `.src/Gestion/Impressions/EdDocs.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdDocs.class` — classe, formulaire associé `EdDocs.form`
- Handlers GUI détectés : 17
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colcli_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cdocuments` | `<type>`, `BasPageP`, `EnteteP`, `Level1D`, `Level2D`, `Level2DLG`, `Level2DLG2`, `Level4D`, `LinesLG`, `LinesP` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Cdate_Aff`, `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Cli`, `Fiches_Ligbl`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_Clients`, `Select_Date`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:2086` (`Menu254_Click`).
- `replay_dynamic` : `Colcli_Click` → reste `Public`.
- « Portée réductible » confirmée par grep : `Aff_Clients` (appelé par `ToggleButton1/2_Click`),
  `Select_Date` (appelé par `Datej_DblClick`/`Datej2_DblClick`).
- `Cli`/`Cli2` appartiennent au groupe `Cmpt` du `.form` sans handler `Cmpt_*` dans la classe.
- Utilise `Cdocuments` (`EnteteP`, `Level1d`, `level2d`, `level2DLG`, `level2DLG2`, `LinesLG`,
  `LinesP`, `Level4D`, `BaspageP`) et `Visualiseur`.
