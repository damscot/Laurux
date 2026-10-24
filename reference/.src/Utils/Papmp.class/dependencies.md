# Papmp — Dépendances

> Source : `.src/Utils/Papmp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Papmp.class` — classe
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
| `Prgm` | `<hérité>` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `.src/Communs/Prgm.class:68` (saisie manuelle « Papmp » dans « Appel programme »).
- **Non détecté par deps.py** : dépendance inverse vers la fenêtre `Prgm` (`Prgm.Mouse`, l.10 et
  l.18) → dépendance circulaire `Prgm` ↔ `Papmp`.
- Duplication exacte avec `RazArt.class:34-41`.
