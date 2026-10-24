# DB_Connection — Tests

> Source : `.src/Utils/DB_Connection.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`DB_Connection` est testable en gb.test sans GUI pour l'essentiel : il suffit d'ouvrir une connexion
de test (`Utils.db` sur la base Docker MariaDB, ou un fichier SQLite copié de `Laurux01.sqlite`). Les
valeurs attendues sont produites en exécutant les mêmes appels dans le clone **Laurux non modifié**
(sortie capturée dans `tests/<nom>/expected/`). Les anomalies sont figées (tests de caractérisation).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DB_CONNECTION-T01 | gbtest | Substitution `&N` via `Exec` (MySQL et SQLite) | chaînes avec `'`, `"`, `\`, accents ; Date ; Float ; Integer ; Boolean ; Null ; `&{10}` | SQL substitué relu dans le log (`Exec_SQL`) | `tests/subst_parametres/` | à faire |
| DB_CONNECTION-T02 | gbtest | Format de ligne `Exec_SQL`, `Edit`, `Create` | log actif, sans filtre ; 3 appels | 9 champs après normalisation (date, user, host, pid, backtrace) | `tests/format_log_sql/` | à faire |
| DB_CONNECTION-T03 | gbtest | Réécriture MySQL → SQLite (règles 0 à 14) | corpus de ~60 requêtes : `YEAR/MONTH/DAY/NOW/CONCAT/LEFT/RIGHT/MID/ISNULL/lpad/abs`, casse mixte, imbrications, `WHERE` ± `ORDER`, `Fiches_Bordereaux`, littéral `'BORDEREAU'`, `LOCK TABLES` | SQL réécrit capturé (log `.out` ou fonction pure après DB_CONNECTION-003) ; `Null` pour les verrous | `tests/sqlite_rewrite/` | à faire |
| DB_CONNECTION-T04 | gbtest | Résultats SQLite des fonctions réécrites | mêmes requêtes `SELECT` exécutées sur `Laurux01.sqlite` | lignes renvoyées (dump CSV), anomalies `LEFT` n-1 et `abs` comprises | `tests/sqlite_resultats/` | à faire |
| DB_CONNECTION-T05 | gbtest | Filtres de log | fichiers de filtres : vide, `Exec_SQL:SELECT`, `GUI:.*`, ligne sans `:`, regex invalide | `Is_Filtered` observé via présence/absence de lignes ; texte de `Get_Filter_Error` | `tests/filtres_log/` | à faire |
| DB_CONNECTION-T06 | gbtest | `GUI_Event` / `Log_Event` | objets factices (`Name`), valeurs avec `;`, `#`, `@`, `=` | ligne `GUI;…` figée | `tests/format_log_gui/` | à faire |
| DB_CONNECTION-T07 | gbtest | `Engine`, `IsType`, `AutoIncrement` | MySQL / SQLite ; `AutoIncrement("lind")`, `("id","BIGINT",20)` | chaînes de référence | `tests/dialecte/` | à faire |
| DB_CONNECTION-T08 | gbtest | `Exec` connexion fermée et erreur SQL | `Close` puis `Exec` ; requête invalide avec `Show_Backtrace` = False | `Null` ; erreur propagée (code d'erreur, pas de boîte) | `tests/exec_erreurs/` | à faire |
| DB_CONNECTION-T09 | gbtest | `Lockstock` | article stocké, qtés ± ; `pmp` vrai/faux ; stock nul ; article non stocké | quantité renvoyée ; `art_qte`, `art_pmp` en base | `tests/lockstock/` | à faire |
| DB_CONNECTION-T10 | gbtest | `LockIncrement` | compteur `INT`, compteur chaîne avec `p_form = "000000"`, table vide | résultat relu ; valeur en base ; message d'erreur (table vide) | `tests/lockincrement/` | à faire |
| DB_CONNECTION-T11 | gbtest | `RecArt` | code article, code fournisseur, réf. centrale, `*<code barre>`, inexistant ; option `B` | `art_code` renvoyé ou résultat vide | `tests/recart/` | à faire |
| DB_CONNECTION-T12 | gbtest | `Prepare`/`Set`/`Execute` (MySQL) | jeu de `VarMajTar` (`requ_cli`, `requ_typ`) avec un article de `Laurux01.sql` | lignes renvoyées (figer l'échec éventuel du `PREPARE` quoté) | `tests/requetes_preparees/` | à faire |
| DB_CONNECTION-T13 | gbtest | `CopieTable` | `Fiches_Mvt1` → table temporaire, MySQL puis SQLite | structure de la copie (MySQL) ; table absente sous SQLite (anomalie figée) | `tests/copie_table/` | à faire |
| DB_CONNECTION-T14 | gbtest | `Edit` / `Create9` | mise à jour d'un champ de `Fiches_Parametres` ; création d'une ligne `Fiches_Reglements` | dump des tables | `tests/edit_create/` | à faire |
| DB_CONNECTION-T15 | replay | Cycle complet log/replay | `./Laurux -l --logfile x.log` : ouverture fiche article, modification, fermeture ; puis `./Laurux -r --logfile x.log` | `x.log.out` : mêmes lignes `Exec_SQL` (normalisées) que `x.log` ; diff BDD vide | `tests/replay_cycle/` | à faire |
| DB_CONNECTION-T16 | gbtest | Performance d'`Exec` | 10 000 `SELECT` paramétrés, log inactif puis actif, MySQL et SQLite | durée de référence (`gbx3 -p`) | `tests/perf_exec/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : un module gb.test du clone de référence exécute les cas et
  écrit `id;valeur` dans `expected/` ; `check_output.py` compare en normalisant les champs
  variables du log (date, user, host, machine-id, pid, backtrace) par expression régulière.
- **Données** : `Laurux01.sql` importé dans MariaDB Docker pour MySQL ; copie de `Laurux01.sqlite`
  pour SQLite (la base est reconstruite avant chaque test). T09 à T11 utilisent les articles de
  `Laurux01.sql` ; un jeu dérivé ajoute un article à stock nul et un compteur chaîne.
- **`gen_input.py`** (T03) : génère le corpus de requêtes en combinant fonctions × casse × présence
  de `WHERE`/`ORDER` × noms de tables contenant `ORDER`.
- **Cas non testables en gb.test** : les `Message.Error` (règles lpad/left/right en erreur,
  `Show_Backtrace` vrai, `LockIncrement` en échec) ouvrent une boîte modale ; ils sont exclus ou
  rendus testables après la séparation traitement/GUI (DB_CONNECTION-003, 007). Le `NetHandler`
  distant demande un serveur `nc -l -k -p <port>` : test manuel documenté, ou fixture Python
  (socket d'écoute) en phase 2.
- **Couverture visée** : 100 % d'`Exec` (les deux moteurs), y compris chaque règle de réécriture.
