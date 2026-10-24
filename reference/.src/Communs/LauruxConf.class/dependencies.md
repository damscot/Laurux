# LauruxConf — Dépendances

> Source : `.src/Communs/LauruxConf.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/LauruxConf.class` — classe, formulaire associé `LauruxConf.form`
- Handlers GUI détectés : 6

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Cmenu.class` | `<hérité>` |
| `.src/Caisse/Preferences.class` | `<hérité>` |
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Fsoc.class` | `Createbase` |
| `.src/Compta/Utils/Dup.class` | `Createbase` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Close`, `Exec` |
| `Doc` | `Open` |
| `Fmenu` | `<hérité>` |
| `Majversion` | `Version` |
| `Start` | `LocalSettings`, `MainWindow`, `Restart`, `Societe`, `UnLock`, `son` |
| `Utils` | `Fill_DataBase`, `MysqlServeur`, `Observers`, `RemotePort`, `SshHost`, `SshPassphrase`, `SshPassw`, `SshPort`, `SshUser`, `db`, `fermeTunnel`, `monteTunnel` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Societes`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (`grep -rn LauruxConf .src`) : `Fmenu.class:528` (`Config`, modal),
  `Fmenu.class:1631`/`1635` (`Menu166_Click`, non modal), `Cmenu.class:269`,
  `Caisse/Preferences.class:233`, et `Createbase` depuis `Fsoc.class:476` et
  `Compta/Utils/Dup.class:89` (`AsCurrent = False`).
- **Effet de bord caché** : l'appel `LauruxConf.Createbase(…)` crée l'auto-instance du
  formulaire ; `_new` s'exécute (balayage des bases, lecture de la configuration) sans que la
  fenêtre soit affichée. `Createbase` utilise ensuite les contrôles `Login`, `Password`, `Host`,
  `Port`, `Bssh` de cette instance cachée.
- `Majversion.Version` (l. 190, 404) : lecture de l'auto-instance du **formulaire** `Majversion`.
  La valeur n'est renseignée que si `Majversion.RecupVersion` a déjà été appelé
  (`Fmenu.class:188` au démarrage) ; sinon chaîne vide.
- **Fichier de configuration** : clés écrites ici et lues ailleurs : `/dbase/*` par `Utils.glb`
  (`Utils.module:93-129`) et `Start.module` ; `/dbase/Con-ssh` par `Utils.glb` et `Start.module:112`
  (la clé `/dbase/ssh/Con-ssh` écrite par `Button1_Click` n'est lue nulle part).
- **Tables** : `Fiches_Societes` via `Cbase.Table("TabSoc")` et en dur dans `Createbase`
  (`<Base>.Fiches_Societes`). `CREATE DATABASE` via `Connection.Databases.Add`.
- **Fichier embarqué** : `Laurux01.sql` (racine du projet, lu par `Utils.Fill_DataBase`).
- **Commandes externes** : `mysql` (l. 278 et via `Fill_DataBase`), `ssh` (via `monteTunnel`).
- Aucun appel dynamique. Pas de portée réductible (deps.py confirme).
- **Ordre de rework** : après `Utils` (UTILS-014, UTILS-015) ; en même temps que `Fsoc` (helpers
  `OuvreBase` et `BasesLaurux`) ; `Dup` dépend de `Createbase` (signature conservée).
