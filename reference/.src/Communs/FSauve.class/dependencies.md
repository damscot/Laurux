# FSauve — Dépendances

> Source : `.src/Communs/FSauve.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/FSauve.class` — classe, formulaire associé `FSauve.form`
- Handlers GUI détectés : 7

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<hérité>` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `Mmysql` | `Init`, `Process_List` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Observers`, `db` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant vérifié** : `Fmenu.class:817` (`Menu57_Click`, `FSauve.Show()`), sans protection par
  mot de passe (contrairement à `FRestore`).
- **Commandes externes** non vues par deps.py : `mysqldump`, `cp`, `mysqladmin` + `gksu` (via
  `Mmysql.Process_List`), `gksu`/`kdesu` + `sudo /etc/init.d/mysql` (via `Mmysql.Init`).
- **Composant** : `gb.compress` (`Compress`, type `zlib`).
- **Fichiers produits** : `<rep>/<base>.sql`, `<rep>/<base>.sql.gz`, `<rep>/Laurux.conf` —
  contrat avec `FRestore` (lecture) et `Expbase` (envoi par courriel du `.sql`/`.sql.gz`).
- Aucune table référencée directement : le dump couvre toute la base `Utils.db.Name`.
- **Ordre de rework** : après `Utils` (UTILS-014), `Mmysql`, `Expbase` (EXPBASE-004) ; en même
  temps que `FRestore` et `SauvesAuto` (helpers communs).
