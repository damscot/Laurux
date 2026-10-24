# Mmysql — Dépendances

> Source : `.src/Utils/Mmysql.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Mmysql.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/FRestore.class` | `Init`, `Process_List` |
| `.src/Communs/FSauve.class` | `Init`, `Process_List` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<hérité>` |
| `Start` | `LocalSettings` |
| `Utils` | `db` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep : `Mmysql.Process_List` → `Communs/FSauve.class:59`,
  `Communs/FRestore.class:117` ; `Mmysql.Init` → `Communs/FSauve.class:130`,
  `Communs/FRestore.class:222`.
- Dépendances externes non vues par `deps.py` : programmes `gksu`, `kdesu`, `sudo`, `mysqladmin`,
  script `/etc/init.d/mysql` ; répertoire `~/tmp`.
- Aucun appel dynamique, aucun cycle. Rework indépendant, mais à coordonner avec UTILS-014 (helper
  de ligne de commande MySQL).
