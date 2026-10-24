# CompArt — Dépendances

> Source : `.src/Utils/CompArt.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/CompArt.class` — classe, formulaire associé `CompArt.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `Utils` | `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Prgm.class:86` (`CompArt.ShowModal()`).
- Effet de bord : `~/tmp/Diff.txt` (répertoire `~/tmp` requis, partagé avec `ImportStk`).
- À reworker **avec `ImportStk`**.
