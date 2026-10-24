# Expart — Dépendances

> Source : `.src/Utils/Exports-Imports/Expart.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/Expart.class` — classe, formulaire associé `Expart.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `Utils` | `Find_nbdec`, `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Fmenu.class:2212` (`Menu281_Click`) ; deps.py ne
  détecte pas `Classe.Show`.
- `lpad()` : traduit en `substr` pour SQLite par `DB_Connection.Exec` (liste des regex d'AGENTS.md).
- Aucun appel dynamique ni dépendance circulaire.
