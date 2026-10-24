# LLog — Dépendances

> Source : `.src/Utils/LLog.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/LLog.class` — classe, hérite de `ComplexLogger`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Log`, `Level_Id`, `Level_Name`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Start.module` | `console`, `file` |
| `.src/Utils/DB_Log.class` | `<type>`, `Critical`, `Max`, `console`, `file` |
| `.src/Utils/Utils.module` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Log_Event` |
| `Start` | `ConsoleLogLevel`, `FileLogLevel` |
| `Utils` | `db` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Log`, `Level_Id`, `Level_Name`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Instanciation** : uniquement `Utils/Utils.module:1680` (`Utils.Log`), stockage dans
  `Start.LLogColl` (`Start.module:62,93`).
- **Appels via Collection non typée** (non vus par `deps.py`) : `Start.LLogColl[Name].Log(...)`
  (`Utils.module:1684`) ; `.Enabled`, `.Handlers[...]`, `.Level_Name`, `.Level_Id` dans
  `DB_Log.class:249-284`. La « portée réductible » proposée pour `Level_Id`/`Level_Name` est un
  **faux positif**.
- **Appelants indirects** : tous les fichiers qui appellent `Utils.Log(Me, …)` (10 occurrences, dont
  `LScript.class:30,47,53`, `Affichages/TriArticles.class:85`).
- **Constantes** : `LLog.console`/`LLog.file` utilisés par `Start.module:91-92` et `DB_Log` ;
  `LLog.Critical`/`LLog.Max` par `DB_Log`.
- **Circularité** : `LLog` → `Utils.db` (`DB_Connection.Log_Event`) ; `Utils` → `LLog`.
- **Ordre de rework** : lot log/replay, après `DB_Connection` ; avant `DB_Log`.
