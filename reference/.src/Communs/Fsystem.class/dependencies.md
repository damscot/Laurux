# Fsystem — Dépendances

> Source : `.src/Communs/Fsystem.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Fsystem.class` — classe, formulaire associé `Fsystem.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<hérité>` |
| `Utils` | `db` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Fmenu.class:2146` (`Fsystem.show`).
- Dépendances non visibles par `deps.py` : le script `report.sh` (racine du dépôt, aussi cité dans
  `DEPENDANCES.md`), `/bin/sh` et les commandes appelées par le script (`awk`, `uname`, `gbx3`…),
  `Utils.db.Version`.
- Aucune table, aucun appel dynamique.
