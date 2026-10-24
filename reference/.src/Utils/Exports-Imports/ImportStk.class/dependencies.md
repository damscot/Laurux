# ImportStk — Dépendances

> Source : `.src/Utils/Exports-Imports/ImportStk.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/ImportStk.class` — classe, formulaire associé `ImportStk.form`
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

- **Faux négatif** : ouverte par `.src/Communs/Prgm.class:87` (`If Prog = "ImportStk" Then
  ImportStk.ShowModal()`), saisie manuelle du nom du programme dans « Appel programme »
  (`Fmenu.Menu141_Click`/`Menu282_Click`).
- Effet de bord fichier : `~/tmp/Diff.txt` (même fichier que `CompArt`).
- Aucun appel dynamique ni dépendance circulaire. À reworker **avec `CompArt`** (factorisation commune).
