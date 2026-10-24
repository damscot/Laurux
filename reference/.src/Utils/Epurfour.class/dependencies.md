# Epurfour — Dépendances

> Source : `.src/Utils/Epurfour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Epurfour.class` — classe
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

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `.src/Communs/Prgm.class:67`.
- Données effacées utilisées notamment par `Dcfour` (doublons de références fournisseurs) et par les
  commandes fournisseurs.
