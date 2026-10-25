# EdFam — Dépendances

> Source : `.src/Gestion/Impressions/EdFam.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/EdFam.class` — classe, formulaire associé `EdFam.form`
- Handlers GUI détectés : 10
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colfam_Click`, `Colfam2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cdocuments` | `<type>`, `BasPage`, `EnteteN`, `Level1FAM`, `Level2FAM`, `Lines` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Fam`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.class:811` (`Menu54_Click`, `EdFam.Show`).
- `replay_dynamic` : `Colfam_Click`, `Colfam2_Click` (grilles `ColumnView`) appelés par
  `ReplayObserver` via `Object.Call` → doivent rester `Public` (REPLAYOBSERVER-A06).
- « Portée réductible » `Button2_Click` : confirmé, `Button2` appartient au groupe `Btn` du
  `.form` ; seul appel : `Btn_Click` (grep).
- Utilise `Cdocuments` (`EnteteN`, `Level1FAM`, `Level2FAM`, `Lines`, `Baspage`), `Visualiseur`,
  `Doc.Open`.
