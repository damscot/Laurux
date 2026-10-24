# Impcpostaux — Dépendances

> Source : `.src/Utils/Exports-Imports/Impcpostaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/Impcpostaux.class` — classe, formulaire associé `Impcpostaux.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Cpostaux`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Fmenu.class:2230` (`Menu284_Click`) et
  `.src/Communs/Prgm.class:63`.
- Aucun appel dynamique ni dépendance circulaire.
