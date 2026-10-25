# VisStatTypCli — Dépendances

> Source : `.src/Statistiques/VisStatTypCli.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Statistiques/VisStatTypCli.class` — classe, formulaire associé `VisStatTypCli.form`
- Handlers GUI détectés : 8
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Liste`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Statistiques/StatTypCli.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Chistoriques` | `<type>`, `Entete`, `Footer`, `Level0F`, `Level1C`, `Level4C`, `Level5C`, `Lines`, `level2C` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `son` |
| `StatTypCli` | `<type>` |
| `Utils` | `Coulfd`, `Fcolr`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Affichage`, `Sens_Aff`, `total`, `Dtn0`, `Dtn1`, `Tri`, `sens`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul appelant** : `StatTypCli.Traitement` (`StatTypCli.class:271`, 5 arguments conformes,
  puis `hForm.Show()`). « Portée réductible » de `Affichage`, `Sens_Aff`, `total`, `Dtn0`,
  `Dtn1`, `Tri`, `sens` confirmée par `grep`.
- **`replay_missing` : `Liste`** (pas de `Liste_Click`) : ne pas cliquer dans la grille.
- Chistoriques : `Level1C`, `level2C` (8 paramètres), `Level4C`, `Level5C` (6 paramètres,
  `Totnn1` Float converti en `String`), `Lines`, `Footer` : arités conformes.
- Rework conjoint avec `StatTypCli` (structure de `Total`).
