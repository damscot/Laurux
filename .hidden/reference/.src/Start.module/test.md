# Start — Tests

> Source : `.src/Start.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module de démarrage : la plupart des comportements ne s'observent qu'en lançant l'exécutable.
Les tests `replay` ci-dessous sont des **scénarios de ligne de commande** pilotés par Python
(`runner.py`) : lancement de `./Laurux` avec un `HOME` isolé, une configuration de test (`-c`), une
base MariaDB jetable et un affichage virtuel (Xvfb), puis comparaison de la sortie standard, du code
de sortie, du fichier de configuration, du fichier `~/Laurux.lock` et, si besoin, du dump de la base.
Les tests `gbtest` portent sur les fonctions sans GUI (après extraction pour certaines).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| START-T01 | replay | `--version-full` | `./Laurux --version-full` avec `branch.txt`/`sha1.txt` connus, puis sans ces fichiers | 3 lignes (nom + version, branche, SHA1 ; valeurs `BRANCH_REPO_GIT_Laurux`/`SHA1_REPO_GIT_Laurux` sans fichier) ; code de sortie | `tests/cli_version/` | à faire : sortie console (3 lignes) non comparée par le runner ; « --version-full » quitte avant le rejeu |
| START-T02 | replay | `-c` fichier absent ; arguments restants | `-c /inexistant.conf` ; `./Laurux --version-full extra1` | message « Impossible de Trouver le fichier de conf fourni » + code de sortie ; ligne `Arg: extra1` | `tests/cli_config/` | implémenté (scénario start_cli_config : « -c /inexistant.conf » ajouté après le -c imposé, arrêt avant connexion : sql.log vide, @Laurux.conf sans [Coul] ; cas « --version-full extra1 » non couvert : sortie console non comparée) |
| START-T03 | replay | `-t list` | base `Laurux01.sql`, conf de test, Xvfb | lignes `Internal Test for Class LPrix: LPrix` et `… LScript: LScript`, bandeaux, code de sortie | `tests/cli_test_list/` | à faire : option « -t » retirée en phase 2 (PLAN §4.0, remplacée par -T, harnais non testé : règle 17 bis) |
| START-T04 | replay | `-t all` et code de sortie | idem ; `-t all` | sortie complète de `LPrix`/`LScript` ; **code de sortie réel figé** (0 attendu par `TESTING.md`, 130 si `SIGINT` non intercepté : START-A02) ; dump base (migration éventuelle par `Fmenu`) | `tests/cli_test_all/` | à faire : option « -t » retirée en phase 2 (PLAN §4.0, remplacée par -T) |
| START-T05 | replay | `-t <Classe>` | `-t LPrix` ; `-t LPrix,LScript` ; `-t Inconnue` | `LScript => SKIPPED` ; les deux jouées ; les deux `SKIPPED`, aucun signalement de la classe inconnue | `tests/cli_test_classe/` | à faire : option « -t » retirée en phase 2 (PLAN §4.0, remplacée par -T) |
| START-T06 | replay | `-s` / `--societe` | conf avec `/Soc=01`, `/dbase/Prefixe=pre_` ; `-s 2` | `/Soc=02`, `/dbase/Name=pre_Laurux02` dans la conf après sortie ; titre de `Fmenu` | `tests/cli_societe/` | implémenté (scénario start_cli_societe : sql.log cd_sc = '02' ; Laurux.conf non comparé) |
| START-T07 | replay | Verrou au démarrage | `~/Laurux.lock` : absent ; PID vivant (`sleep` lancé par le test) ; PID mort ; fichier vide | sans dialogue ; dialogue « Ne pas ouvrir / Ouvrir » (deux choix) ; verrou remplacé ; dialogue « fichier de lock vide » ; contenu final du verrou | `tests/verrou_demarrage/` | à faire : verrou ~/Laurux.lock préexistant non préparable par un scénario (HOME de test vidé) ; dialogue « Ne pas ouvrir / Ouvrir » |
| START-T08 | gbtest | `Lock`/`UnLock` (puis `RetirePid` après START-004) | verrou vide, `"<id>"`, `"111 <id>"`, `"<id> 222"`, `"5<id> 7"` (sous-chaîne) | contenu du fichier après chaque appel, suppression si vide ; cas sous-chaîne figé (START-A04) | `tests/verrou_unlock/` | implémenté |
| START-T09 | gbtest | `Coul` | `Start.LocalSettings` sur un fichier temporaire : `/Coul/Others`=`255;232;199;`, `/Coul/Coulfonds`=`255;252;216;` ; puis valeurs à virgules ; puis clés absentes | `R,G,B,R2,G2,B2` attendus ; repli écrit dans `R2/G2/B2` figé (START-A03) ; valeurs conservées si clés absentes | `tests/couleurs_coul/` | implémenté |
| START-T10 | replay | Couleurs par défaut | conf sans `/Coul/Fnets` ; conf complète ; conf avec `/son` invalide | diff de la section `[Coul]` après démarrage/fermeture (23 clés, valeurs exactes) ; aucun changement pour la conf complète ; cas `/son` figé | `tests/couleurs_defaut/` | implémenté (scénarios start_couleurs_defaut, start_couleurs_completes, start_couleurs_son_invalide : conf + @Laurux.conf ; cas /son invalide figé, START-A06) |
| START-T11 | replay | Rejeu `-r` | log de référence de N lignes `;GUI;` (ouverture puis fermeture d'un écran) ; `-r --logfile` ; fichier absent | N événements rejoués, aucune erreur d'indice ; message « ne peut pas etre rejoué » + code de sortie | `tests/cli_replay/` | implémenté (scénario start_cli_replay ; cas « fichier absent » non couvert) |
| START-T12 | replay | Rejeu après redémarrage | log contenant un changement de configuration (`LauruxConf`, `Start.Restart`) puis des événements | événements rejoués après redémarrage (comportement actuel figé, START-A01) | `tests/replay_redemarrage/` | à faire : redémarrage non atteignable (erreur fatale du journal fermé par Utils.db.Close en mode -l, voir START-T17 xfail) |
| START-T13 | replay | `--restore` | `--restore Laurux01.sql` sur une base modifiée ; fichier absent ; conf avec `/dbase/Prefixe` | dump identique à `Laurux01.sql` importé ; « Erreur: Impossible de trouver le fichier » ; base restaurée = `Laurux<XX>` sans préfixe (figé) | `tests/cli_restore/` | implémenté (scénario start_cli_restore, cas nominal ; fichier absent et préfixe : message console non comparé) |
| START-T14 | replay | `-d`, `-l`, `--logfile`, purge debug | `~/tmp/Debug/ancien.log` présent ; `-d 4,5 -l --logfile rel.log` | ancien log supprimé ; `rel.log` créé sous `$PWD` ; niveaux de `LLog` (via `DB_Log`) | `tests/cli_logs/` | à faire : ~/tmp/Debug/ancien.log non préparable (HOME de test vidé, fichiers d'entrée copiés dans /tmp/laurux-test seulement), --logfile imposé par Run_Scenario, ~/tmp/Debug vide au démarrage (aucun Utils.Log), niveaux -d non observables |
| START-T15 | replay | Réplication inactive | `/dbase/Con-ssh=1`, `/Soc01/Replique=1`, `/Soc01/Breplique=1`, `mysql` factice dans le `PATH` | `Message.Error` « La réplication est inactive ! » puis fin sans fenêtre principale | `tests/replication_demarrage/` | à faire : Message.Error « La réplication est inactive » émis par Main avant Lancement, donc avant le démarrage du rejeu : boîte non fermable, délai dépassé (code 124 en 20 s, essai du 2026-11-12 avec conf /dbase/Con-ssh, /Soc01/Replique, /Soc01/Breplique)  — bloqué par le harnais : START-A09 (créer le minuteur de rejeu avant le premier Message.* de Main), REPLAYOBSERVER-A07 pour la capture ; correction différée (décision utilisateur du 2026-11-12) |
| START-T16 | replay | Démarrage caisse `-p` | `/Soc01/caisse/Ncai="3;…"`, `choixtouches` 0 puis 1, `/caisse/Font` | `Cmenu` ouvert ; `Start.$tcai` = `"0"` puis `"3"` (lu par `Cmenu`) ; pas de `FTips` | `tests/cli_caisse/` | implémenté (scénario start_cli_caisse : Cmenu, Ncai absent ; cas Ncai/choixtouches renseignés non couverts) |
| START-T17 | replay | Redémarrage et changement de société | `LauruxConf` validé (non modal) ; `Fsoc.Soclist_Click` | deux itérations de `Main` (titre, société) ; profondeur d'appel non observable, fin propre ; code de sortie | `tests/redemarrage/` | xfail : erreur fatale (journal DB_Connection fermé par Utils.db.Close, mode -l) dans LauruxConf.Form_Close, pas de seconde itération (start_redemarrage) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** avec la même commande et
  le même `HOME` isolé ; les anomalies START-A01 à A05 sont figées telles quelles.
- **Environnement** : `HOME` temporaire (le module écrit `~/Laurux.lock`, `~/tmp/Debug`, et
  `FSauve`/`Fmenu` peuvent lire `~/.config`) ; `PWD` contrôlé pour `branch.txt`, `sha1.txt` et
  `--logfile` relatif ; Xvfb obligatoire dès que `Lancement` crée une fenêtre (T03-T17).
- **Dialogues modaux** (`Message.Warning` du verrou, réplication) : pilotés par un log de rejeu ou
  par `xdotool` ; à défaut, test manuel documenté dans le répertoire.
- **gb.test** : T08 et T09 manipulent l'état global (`Start.LocalSettings`, fichier verrou de
  `User.Home`) ; chaque test sauvegarde puis restaure cet état. `Application.Id` n'est pas
  paramétrable : T08 couvre le cas sous-chaîne seulement après l'extraction de `RetirePid`
  (START-004).
- **Non testable automatiquement** : profondeur de pile de l'appel récursif `Fsoc` → `Start.Main`
  (seul le résultat fonctionnel est comparé) ; comportement de `ps -p` avec plusieurs PID (dépend
  de la version de procps, noté dans T07).

### Implémentation (phase 2, 2026-11-11)

- gb.test : `.src/Tests/Communs/StartTest.test` (T08, T09 ; attendus `.hidden/Tests/Communs/assets/StartTest/`).
  T08 couvre aussi le cas sous-chaîne (`"5<id> 7"` → `"57"`, START-A04) sans extraction : le PID du processus
  de test est connu à l'exécution et remplacé par `<id>` dans les valeurs vérifiées ; le verrou est sauvegardé
  et restauré par `_Setup`/`_Teardown`.
- Scénarios (`.hidden/Tests/Communs/assets/`) : `start_cli_societe` (T06, `"societe": "02"`, jeu
  `fsoc_deux_bases`), `start_cli_replay` (T11), `start_cli_restore` (T13, args `--restore Laurux01.sql`, jeu
  `start_cli_restore`), `start_cli_caisse` (T16, args `-p`), `start_redemarrage` (T17, xfail, code 125).
- Le harnais (`Run_Tests`, `Run_Scenario`, `Home_Test`, `Env_Home`, `Fin_Home`) n'est pas testé (AGENTS.md 17 bis).
- Constat (candidat anomalie) : `DB_Connection.Close` ferme le journal (`log.Close`) ; en mode `-l` (tous les
  rejeux), toute écriture suivante dans le journal (requête après réouverture, événement GUI) provoque
  l'erreur fatale « Uninitialized or already closed handler! » : le redémarrage (T12, T17) n'est pas atteignable.

### Implémentation (vague 2 bis, 2026-11-12 : clés conf / fichiers de meta.json)

- START-T10 : `start_couleurs_defaut` (configuration de test sans [Coul] : 21 clés écrites, `Coulfonds`/`Others`
  écrites deux fois), `start_couleurs_completes` (21 clés /Coul via `conf`, valeurs non par défaut : inchangées),
  `start_couleurs_son_invalide` (mêmes clés + `/son`=`abc`, rangé par gb.settings dans [General] : les 21 clés
  sont réécrites par défaut, START-A06 figée). Les trois comparent `@Laurux.conf` ; sortie par Paramètres › Quitter.
- START-T02 : `start_cli_config` (args `-c /inexistant.conf extra1` ; la dernière occurrence de `-c` l'emporte sur
  celle du harnais). Message console et ligne `Arg:` non comparés.
- START-T15 : essai avec `conf` (`/dbase/Con-ssh`, `/Soc01/Replique`, `/Soc01/Breplique` à 1) : `ControlTunnel`
  échoue (commande `mysql` mal formée, aucune ligne `YES`), la boîte `Message.Error` s'ouvre avant `Lancement`
  (le minuteur du rejeu n'est pas encore créé) : délai dépassé (124). Reste à faire.
- START-T14 : `~/tmp/Debug` est créé vide au démarrage (aucun appel `Utils.Log` sur le chemin Fmenu → Quitter) ;
  pas de fichier à comparer par `fichiers`. Reste à faire.

