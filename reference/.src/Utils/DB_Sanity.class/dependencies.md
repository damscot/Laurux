# DB_Sanity — Dépendances

> Source : `.src/Utils/DB_Sanity.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/DB_Sanity.class` — classe, formulaire associé `DB_Sanity.form`
- Handlers GUI détectés : 13
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `GridView1`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<type>`, `Exec`, `IsType`, `type_mysql`, `type_sqlite3` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `Societe` |
| `Utils` | `db` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Refresh_Data`, `Refresh_Data_Missing`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Communs/Fmenu.class:2566` (`Menu142_Click` : `New DB_Sanity(Utils.db)` puis
  `ShowModal`). `deps.py` peut ne pas le relier aux membres car seul le constructeur est appelé.
- **`.form` associé** : `DB_Sanity.form` (contrôles `GridView1`, `Quitter`, `Export_CSV`, `Expected`,
  `Nettoyer`, `Corriger`, `Panel1`, `AllTab`, `Controlled`, `Supplem`, `Missing`, `Control`,
  `ControlledFailed`). Les 13 handlers sont intouchables.
- **Portée réductible confirmée** : `Refresh`, `Refresh_Data`, `Refresh_Data_Missing` (aucun usage
  hors du fichier, aucun nom en chaîne littérale).
- **Tables** : aucune table métier ; toutes les tables de la base sont parcourues via
  `DB_Con.Tables`. Tables système : `information_schema.TABLES`. Le DDL de correction peut toucher
  **n'importe quelle table** listée dans `db_control.csv`.
- **Fichier de données** : `db_control.csv` (racine du dépôt, lu dans le répertoire courant) ; il est
  aussi la référence citée par AGENTS.md pour toute évolution de schéma.
- **Dépendances** : `DB_Connection` (`Tables`, `Exec`, `IsType`, `Commit`), `ProgBar`
  (`Avancement`, `Close`), `Start.Societe`.
- **Ordre de rework** : après `DB_Connection` (utilise `IsType`/`Exec`) ; indépendant du lot
  log/replay.
