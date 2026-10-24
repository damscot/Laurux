# NetHandler — Dépendances

> Source : `.src/Utils/NetHandler.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/NetHandler.class` — classe, hérite de `LogHandler`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Open`, `Write`, `Close`, `GetOutput`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Utils/DB_Connection.class` | `<type>` |

### Utilise

_Aucune dépendance vers d'autres fichiers du projet._

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`Open`, `Write`, `Close`, `GetOutput`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Utils/DB_Connection.class:85` (`New NetHandler(remote_host, remote_port)`),
  ajouté au `ComplexLogger` sous la clé `"remote"`.
- **Appels faits par le framework** gb.logging (`Open` au `Begin`, `Write` à chaque `Log`, `Close`) et
  par `DB_Connection` via `logh["remote"].GetOutput()` / `.Level` (Collection non typée) : la liste
  « portée réductible » de `deps.py` (`Open`, `Write`, `GetOutput`) est entièrement un **faux positif**.
- **Composants** : `gb.net` (`Socket`, `Net.Connected`), `gb.logging` (`LogHandler`, `LogLevel`).
- **Configuration** : `/Soc<XX>/ServerLogIP`, `/Soc<XX>/ServerLogPort` (écrits par `Prefs.class`).
- **Ordre de rework** : indépendant ; à tester avec `DB_Connection` (lot log/replay).
