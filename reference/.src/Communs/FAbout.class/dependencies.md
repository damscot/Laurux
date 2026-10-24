# FAbout — Dépendances

> Source : `.src/Communs/FAbout.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/FAbout.class` — classe, formulaire associé `FAbout.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `version_branch`, `version_sha1` |
| `Utils` | `Observers` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:735` (`Fabout.Show`, casse différente du nom de fichier `FAbout`).
- Les valeurs affichées dépendent des fichiers `sha1.txt` et `branch.txt` écrits par le `Makefile`
  (via `Start.Main`) : un replay doit masquer ces deux champs ou fixer ces fichiers.
- Aucune table, aucun appel dynamique.
