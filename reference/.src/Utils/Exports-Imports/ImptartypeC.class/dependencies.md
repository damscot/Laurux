# ImptartypeC — Dépendances

> Source : `.src/Utils/Exports-Imports/ImptartypeC.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/ImptartypeC.class` — classe, formulaire associé `ImptartypeC.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `cpoint`, `db` |

### Tables SQL référencées

`Fiches_TarTypcli`, `Fiches_Typec`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Prgm.class:85` (`ImptartypeC.ShowModal()`).
- Tables en dur `Fiches_Typec`, `Fiches_TarTypcli` correctement détectées.
- Aucun appel dynamique ni dépendance circulaire.
