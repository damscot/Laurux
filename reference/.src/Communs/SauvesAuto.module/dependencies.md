# SauvesAuto — Dépendances

> Source : `.src/Communs/SauvesAuto.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/SauvesAuto.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `Sauvegarde` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `<hérité>` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `db` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

_Aucune._
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant vérifié** : `Fmenu.class:1228` (`form_close` de la fenêtre principale, condition
  `/Soc<XX>/Sauvauto` **et** `/dbase/Maj`). Aucun autre appel (`grep -rn SauvesAuto .src`).
- **Préférences écrites ailleurs** : `/Soc<XX>/Sauvauto`, `/Envoiftp`, `/Adrbase`, `/MdpFTP` par
  `Prefs.class` (l. 380-388, 690-691) ; `/Rep_Sauv` par `Prefs.class:613`.
- **Commandes et composants externes** non vus par deps.py : `mysqldump`, `gb.compress`,
  `gb.net.curl` (`FtpClient`), serveur FTP distant.
- **Fichiers produits** : `<rep>/<base>.sql` (restaurable par `FRestore`) et
  `<rep>/<base><0-6>.sql.gz` (rotation hebdomadaire, non restaurable directement).
- **Ordre de rework** : après `Utils` (UTILS-014) et `Expbase` (EXPBASE-004) ; SAUVESAUTO-003
  crée `Utils.DumpBase`, réutilisé ensuite par `FSauve` (FSAUVE-004).
