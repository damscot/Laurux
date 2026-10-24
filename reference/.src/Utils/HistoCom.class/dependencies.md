# HistoCom — Dépendances

> Source : `.src/Utils/HistoCom.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/HistoCom.class` — classe
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_HistoLigfac`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `.src/Communs/Prgm.class:106-110` (message et fermeture gérés par `Prgm`).
- Table `Fiches_HistoLigfac` via `Cbase.Table("TabHisLigFac")`.
