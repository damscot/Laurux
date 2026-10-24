# LauruxMaj — Tests

> Source : `.src/Communs/LauruxMaj.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Par consigne utilisateur, les migrations ne sont pas refactorisées : un seul test de non-régression,
de type replay, vérifie la mise à jour complète depuis la base de la version taguée précédente.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LAURUXMAJ-T01 | replay | Mise à jour depuis une base précédente (3.68 → 3.69) | `Laurux01.sql` du tag `v3.68.8` (`git show v3.68.8:Laurux01.sql`, `version = 3.68`, latin1/MyISAM) ; `Laurux.conf` de test avec `/dbase/Maj=1`, société `01` ; lancement `./Laurux -c <conf>` puis fermeture | `Fiches_Parametres.version = 3.69` ; schéma obtenu (dump `--no-data` normalisé) comparé au schéma de `Laurux01.sql` de HEAD ; export `DB_Sanity` comparé à `db_control.csv` de HEAD ; écarts figés dans `expected/` | `tests/maj_depuis_base_precedente/` | à faire |

## Détail des tests

- **Préparation** : base MariaDB jetable (Docker, `reference/tools/db/`), import du `Laurux01.sql` du tag
  `v3.68.8`. `HOME` pointe vers un répertoire temporaire (la migration écrit `~/SauveV368/`, peut
  copier `~/.config/gambas3/Laurux3.conf` et lance `xdg-open` : neutraliser `xdg-open` dans le `PATH`).
  `v3.68.4` (dernier tag ancêtre de HEAD, `version = 3.68` aussi) peut servir de seconde base de départ.
- **Déroulé** : la migration se déclenche à l'ouverture de `Fmenu` (connexion, choix de société). Les
  dialogues possibles sont rejoués par le log (`./Laurux -l`) ou par frappes simulées : question
  « conversion UTF8 déjà effectuée », avertissements des comptes `419100`/`419700`/`468700` existants,
  journal d'OD absent. Les `ProgBar` sont non bloquantes.
- **Comparaisons** :
  1. `SELECT version FROM Fiches_Parametres` = `3.69` ;
  2. schéma : `mysqldump --no-data --skip-comments` de la base migrée et de `Laurux01.sql` (HEAD)
     importé dans une seconde base, normalisés (ordre des colonnes, `AUTO_INCREMENT=n`, noms de
     contraintes) puis comparés par table ;
  3. structure : export CSV de `DB_Sanity` (`Refresh_Data("db_control.csv", <sortie>)`) comparé à
     `db_control.csv` de HEAD.
- **Valeurs attendues** : générées dans le clone **Laurux non modifié** ; les écarts connus sont figés
  dans `expected/` (caractérisation) : index historiques résiduels (`id_*` de `HistoFac`/`HistoFacM`/
  `HisEntTickets`, `date`/`numero2`/`compte2` de `MvtM*`), types `HistoFac.mtreg`, ordre des colonnes.
  Le test est vert si le diff entre les deux clones (`Laurux` et `Laurux_reworked`) est vide.
- **SQLite** : base dérivée du même `Laurux01.sql` de `v3.68.8` via `Laurux01_to_sqlite.sh` de HEAD,
  comparée à `Laurux01.sqlite` de HEAD. Faisable techniquement, mais le comportement actuel est que le
  dispatcher échoue au `SET NAMES` du prologue (à confirmer) : le test fige alors « version inchangée
  3.68 + message d'erreur », il ne valide pas une migration SQLite.
- **Non testable** : les chemins historiques (< 3.60, version dans `Laurux.conf`), faute de base de
  référence (les tags commencent à `v3.67.11`, sans `Laurux01.sql` exploitable avant `v3.68.0`) ; le
  cas `Maj = 0` et l'arrêt sur moulinage non effectué ne sont pas couverts (décision utilisateur).
