# Expclient — Dépendances

> Source : `.src/Utils/Exports-Imports/Expclient.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/Expclient.class` — classe, formulaire associé `Expclient.form`
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
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Cli`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Fmenu.class:1654` (`Menu170_Click`) ; deps.py ne
  détecte pas `Classe.Show`.
- Aucun appel dynamique ni dépendance circulaire.
