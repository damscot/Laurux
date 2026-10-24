# RenumBl — Dépendances

> Source : `.src/Utils/RenumBl.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/RenumBl.class` — classe
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
| `Utils` | `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_HistoLigfac`, `Fiches_Ligbl`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `.src/Communs/Prgm.class:111` (saisie manuelle « RenumBl »).
- Tables : `Fiches_HistoLigfac`, `Fiches_Bl`, `Fiches_Ligbl` (via `Cbase.Table`) ; colonnes
  `pu_ligbl`… en `varchar(12)` (`db_control.csv:1079-1085`).
- Dernière modification git : version 3.63.
