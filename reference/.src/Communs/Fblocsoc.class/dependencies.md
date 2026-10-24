# Fblocsoc — Dépendances

> Source : `.src/Communs/Fblocsoc.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Fblocsoc.class` — classe, formulaire associé `Fblocsoc.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Start` | `LocalSettings`, `Societe` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Prgm.class:80` (`Fblocsoc.ShowModal()`).
- **Lecteurs de la clé `Blocsoc`** (dépendance par réglage, invisible pour `deps.py`) :
  `Fmenu.class:99` (masque `Menu26`), `LauruxConf.class:57, 104, 114, 148`.
- **`BlocsocMdp`** : écrit ici, **jamais lu** dans `.src`.
- Aucune table, aucun appel dynamique.
