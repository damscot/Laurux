# VisPmp — Dépendances

> Source : `.src/Utils/VisPmp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/VisPmp.class` — classe, formulaire associé `VisPmp.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Editeur` | `Prog_Editeur` |
| `Start` | `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

`Fiches_Art`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Prgm.class:65` (`If Prog = "Pmp" Then VisPmp.Show`) —
  le nom du programme (`Pmp`) diffère du nom de la classe.
- Effet de bord : `~/Pmp.txt` ; éditeur externe via `Editeur.Prog_Editeur`.
