# Dcfour — Dépendances

> Source : `.src/Utils/Dcfour.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Dcfour.class` — classe, formulaire associé `Dcfour.form`
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

- **Faux négatif** : ouverte par `.src/Communs/Prgm.class:66` (`If Prog = "Dcfour" Then Dcfour.Show`).
- `Editeur.Prog_Editeur` (`Gestion/Impressions/Editeur.module:10`) lance un éditeur externe.
- Effet de bord : `~/Doublon.txt`.
