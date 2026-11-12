# Tests

## Tests unitaires : gb.test (`.src/Tests/<lot>/*.test`)

Depuis la phase 2 du rework (voir `.hidden/reference/PLAN.md` §4), les tests de logique sont des **modules gb.test**
(fichiers `.test`) rangés par lot dans `.src/Tests/<lot>/`, avec leurs données dans
`.hidden/Tests/<lot>/assets/<nom>/`. L'ancien harnais `Internal_Test` / `./Laurux -t` est **retiré** : les deux
classes qui l'implémentaient (`LPrix`, `LScript`) ont été converties en `Utils/LPrixTest.test` et
`Utils/LScriptTest.test`.

```bash
gbc3 -ag .                    # compile aussi les modules .test
./Laurux -T list              # liste : type, lot, classe, test (ID de test.md), chemin, description
./Laurux -T "list:CHANGEFOUR*"          # liste filtrée (même sélection que pour lancer)
./Laurux -T CHANGEFOUR-T05              # lance un test par son nom (ici un scénario GUI, voir plus bas)
./Laurux -T all               # tous les gb.test puis les scénarios validés ; code 0 = succès
./Laurux -T gbtest            # tous les gb.test ;  ./Laurux -T replay : tous les scénarios validés
./Laurux -T "LPRIX-T0*,Utils/impclient_*"   # jokers * ? [ ], entre guillemets
./Laurux -T LPrixTest         # un module ; « LPrixTest.Matrice » pour un seul test
gbx3 -T LPrixTest.T01ConversionEntree   # un seul test, directement (depuis le répertoire du projet)
```

**Un processus par test.** `./Laurux -T` et `runner.py gbtest` lancent chaque test dans son propre processus
(`gbx3 -T Module.Méthode`). `gbx3 -T "*"` (tous les tests dans un même processus) **n'est pas pris en charge**
pour la suite complète : les tests figent le comportement actuel, y compris l'état statique de l'application
(cumuls de `Csolde`, LPRIX-A01, gestionnaires de journal de `DB_Connection` fermés par un test…), et les résultats
dépendraient alors de l'ordre des tests (essai du 2026-11-09 : arrêt au 73e test). `TestKit.Begin` recharge
toutefois la configuration de test d'origine (copie temporaire de `Laurux-test.conf`) au début de chaque test.

`-T` exige les sources (`.src/Tests`) à côté de l'exécutable. Les tests gb.test n'ont accès qu'aux membres
`Public`. Les tests qui ouvrent la base attendent la base de test : voir « Redirection vers la base de test » et
« Modes d'exécution » ci-dessous.

### Valeurs attendues (tests de caractérisation)

Le module `TestKit` (`.src/Tests/Framework/TestKit.module`) compare chaque valeur à
`.hidden/Tests/<lot>/assets/<Module>/expected.txt` (`TestKit.Check("clé", valeur)`). Les valeurs attendues sont **produites dans le
clone de référence** (code d'origine) avec `LAURUX_TEST_RECORD=1`, jamais déduites de la lecture du code :
anomalies comprises, elles figent le comportement actuel. `TestKit.Init()` prépare l'état global attendu
hors de `Start.Main` (`Start.LocalSettings` depuis `Laurux-test.conf`, société, journaux).

```gambas
Public Sub _Desc()
  ' descriptions affichées par « ./Laurux -T list » (ignoré par gb.test : nom commençant par « _ »)
  TestKit.Desc("T01ConversionEntree", "`_New`/`_call` : conversions d'entrée")
End

Public Sub _Setup()
  TestKit.Begin("Utils", "LPrixTest")
End

Public Sub T01ConversionEntree()
  TestKit.Check("T01/L", LPrix("-3,1500", 1, LPrix.Arr_01).L)
End
```

Une méthode de test se nomme `Tnn<Objet>` (`nn` = numéro du test dans le test.md de la classe : identifiant
`<CLASSE>-Tnn`) et est décrite dans `_Desc()` ; `-T list` charge le module (`Class.Load`) et appelle `_Desc`,
sans lire le source.

### Runner de non-régression

`.src/Tests/Framework/runner.py` (Python 3, voir `.src/Tests/Framework/README.md`) pilote la base MariaDB
Docker de test, les tests gb.test et les scénarios GUI rejoués, et compare le clone retravaillé au clone de
référence.

### Assets de test

Les **modules gb.test** restent sous `.src/Tests/` (ils doivent être compilés avec le projet pour que `gbx3 -T`
les lance), avec le framework ; leurs **données** sont sous `.hidden/Tests/`, hors de `.src` : elles ne sont ni
chargées par l'IDE Gambas ni intégrées à l'archive `Laurux`. Les `.hidden/reference/…/test.md` décrivent les tests
(ils ne sont pas lus par le framework). Les fichiers générés (`list.md`, `results.json`, sorties des rejeux `-T`)
vont dans `output/tests/`, non versionné.

```
.src/Tests/
  <lot>/<Classe>Test.test             module gb.test : une méthode publique Tnn<Objet> par test du test.md
  TriTest.class, TriTest.form          banc d'essai manuel de TriGen
  Framework/                          (voir plus bas)
.hidden/Tests/
  <lot>/assets/<Classe>Test/
    expected.txt                       valeurs attendues de TestKit.Check (« clé<TAB>valeur »), produites dans ref
    …                                  fichiers d'entrée propres au module (ex. NetHandlerTest/serveur.py)
  <lot>/assets/<classe>_<nom>/         scénario GUI rejoué
    scenario.log                       événements « ;GUI; » au format du journal Laurux (-l)
    meta.json                          {"id", "classe", "objet", "description", "dataset", "date", "args", "societe",
                                        "timeout"[, "code_sortie", "xfail", "xfail_attendu"]}
                                       objet : description courte (-T list, list.md) ; description : détail
                                       cadence : écarts du rejeu en ms {"frappe", "focus", "traitement",
                                       "fenetre"} (voir « Cadencement »)
                                       timeout : délai en s (défaut 20) ; > 20 seulement avec
                                       "timeout_accord" (accord de l'utilisateur), sinon ramené à 20
                                       code_sortie : code attendu du rejeu (défaut 0 ; 3 = événement non
                                       rejouable ; 125 = erreur fatale figée, voir « Modes d'exécution »)
                                       tolerance_horodatage : écart toléré (s) entre horodatages attendu et
                                       obtenu (défaut 5 ; voir « Limites à connaître »)
                                       conf : surcharge de Laurux-test.conf propre au scénario,
                                       {"/section/clé": valeur} (ex. {"/Soc01/Admin": "1"})
                                       bases : bases supplémentaires créées ou modifiées par le scénario
                                       (ex. ["Laurux02"]), ajoutées à dump.sql (« -- base Laurux02 »)
                                       fichiers : fichiers produits comparés (fichiers/<chemin> des sorties) :
                                       chemin relatif au HOME de test, ou « @<nom> » pour un fichier des
                                       sorties de -T (@Laurux.conf : configuration finale ; @ouvrir.trace :
                                       appels Desktop.Open ; @outils.trace : outils externes factices ;
                                       @ftp.trace : commandes FTP reçues) ; « <fichier absent> » s'il
                                       n'existe pas
                                       ftp : faux serveur FTP lancé pour le rejeu, "ok" | "refus" | "absent"
                                       (voir « Outils externes factices ») ; « {ftp} » dans une valeur de
                                       conf est remplacé par son URL (ex. {"/Soc01/Adrbase": "{ftp}/sauve"})
                                       « {home} » (HOME de test du Laurux testé) et « {out} » (répertoire de
                                       sortie de -T, comparable par « @… ») : chemins portables entre poste
                                       et conteneur (normalisés en <home> à la comparaison)
    expected/                          produit par le rejeu dans ref : dump.sql (base normalisée), sql.log
                                       (requêtes Exec_SQL), console.txt, exit_code
    …                                  fichiers d'entrée du scénario (CSV à importer…) : copiés par -T dans
                                       /tmp/laurux-test/, saisis « /tmp/laurux-test/<fichier> »
.src/Tests/Framework/
    Laurux-test.conf                   configuration Laurux de test ([dbase] → base de test, Maj=0, son=0…)
    bin/                               enveloppes mysql, mysqldump, mariadb, mariadb-dump (port de test), faux
                                       programmes laurux-ouvrir (Desktop.Open), laurux-factice (+ liens),
                                       gammu, wput, et faux serveur FTP laurux-ftp
    dump_mask.json                     colonnes volatiles masquées dans dump.sql
    TestKit.module, runner.py, sandbox.py, harness.patch, harness_files.txt
```

**Jeux de données.** Un jeu de données (`<jeu>.sql` : `INSERT`/`UPDATE` appliqués après `Laurux01.sql`) est rangé
dans les assets du dépôt, jamais sous `.src` (il n'alourdit pas l'archive de l'application) et il est lu depuis la
racine du clone, pas depuis le système de fichiers de l'archive (`TestKit.JeuDeDonnees`) :

| Valeur (`"dataset"` de `meta.json`, `TestKit.OuvreBase("…")`) | Fichier |
|---|---|
| `<jeu>` | `.hidden/Tests/<lot>/assets/<test>/<jeu>.sql` : jeu propre au scénario ou au module gb.test |
| `<classe>_shared/<jeu>` | `.hidden/Tests/<lot>/assets/<classe>_shared/<jeu>.sql` : jeu partagé par plusieurs tests d'une classe |
| `<Lot>/<classe>_shared/<jeu>` | jeu partagé rangé dans un autre lot |

Un jeu utilisé par un seul test reste dans le répertoire de ce test ; dès qu'un second test l'utilise, il passe dans
`<classe>_shared/` (classe testée qui l'a créé). Ces répertoires ne contiennent ni `scenario.log` ni `expected.txt` :
ils ne sont pas des tests. `runner db reset --dataset <Lot>/<répertoire>/<jeu>` charge un jeu à la main.

Les deux clones lisent les **mêmes** tests et données : `runner.py harness apply` recopie `.src/Tests` et
`.hidden/Tests` dans le clone de référence. Un module de test retrouve ses fichiers par `Application.Path &/ ".hidden/Tests/<lot>/assets/…"`.

### Redirection vers la base de test

Aucun test ne touche la configuration ni la base de l'utilisateur (`~/.config/gambas3/Laurux.conf`) :

| Étape | gb.test (`TestKit`) | Rejeu GUI (`runner replay`) |
|---|---|---|
| Configuration | `TestKit.Init()` charge `$LAURUX_TEST_CONF`, sinon `Framework/Laurux-test.conf`, dans `Start.LocalSettings` | Laurux lancé avec `-c <copie de Laurux-test.conf>` |
| Hôte et port | `LAURUX_TEST_DB_HOST` (défaut `127.0.0.1`), `LAURUX_TEST_DB_PORT` (défaut `13306`) | le runner réécrit `Host`/`Port` de la copie de `Laurux-test.conf` |
| État initial | `TestKit.OuvreBase([jeu])` dans `_Setup` : suppression des autres bases (voir ci-dessous), `DROP`/`CREATE` de `Laurux01`, import de `Laurux01.sql`, puis du jeu de données des assets du test (voir « Jeux de données ») | `-T` (`Run_Scenario`) recrée la base de la même façon avant chaque rejeu (`"dataset"` de `meta.json`) |
| Connexion | `Utils.db` ouvert comme le fait `Fmenu` (`SET NAMES utf8mb4`, `sql_mode` de session) | celle de Laurux, d'après la configuration |
| Outils SQL lancés par Laurux | — | `Fmenu` lance `mysql -h <hôte>` sans port : les enveloppes de `Framework/bin`, en tête du `PATH`, ajoutent `-P $LAURUX_TEST_DB_PORT` |

Chaque test et chaque rejeu repart donc d'une base identique. La base de test est le conteneur MariaDB 10.11
du service `db` (`python3 .src/Tests/Framework/runner.py db up`, données en `tmpfs`) : `127.0.0.1:13306` vu du
poste, `db:3306` vu du conteneur runner ; un bac à sable N utilise le port `13306+N`.

**Bases laissées par un autre test.** Plusieurs écrans énumèrent toutes les bases du serveur (`Init_base`,
`LauruxConf`, `Dup`) : une base `Laurux02` ou `pre_Laurux01` créée par un test précédent changerait leur
`sql.log`. Avant chaque test (gb.test et rejeu), `TestKit.NettoieBases` (et `nettoie_bases` du runner pour
`db reset` / `record`) supprime donc **toutes les bases du serveur sauf `Laurux01` et les bases système**, mais
**seulement sur un serveur marqué comme serveur de test** : compte MariaDB verrouillé `laurux_serveur_test`
(aucune connexion possible, invisible pour Laurux), créé à chaque initialisation du conteneur de test par
`.hidden/Docker/mysql/test/90-marqueur-serveur-test.sql` (monté par `docker-compose.test.yml` seulement, donc aussi
quand compose recrée le conteneur ; jamais dans l'image applicative) et, pour un conteneur déjà lancé, par
`runner.py db up`. Un serveur non marqué (par
exemple un serveur réel désigné par `LAURUX_TEST_DB_PORT=3306`) n'est jamais nettoyé : avertissement « non marqué
comme serveur de test », bases conservées (seule `Laurux01` est recréée, comme avant). Ne crée jamais ce compte
sur un serveur qui contient des données réelles.

### Modes d'exécution

| | Dans un conteneur (référence) | Hors conteneur, sur le poste |
|---|---|---|
| Lancement | `LAURUX_DOCKER=1 runner.py list / gbtest / replay / compare / report` | `./Laurux -T …`, `./Laurux … -r --replay-exit`, ou `runner.py …` (sans `LAURUX_DOCKER`) |
| HOME de Laurux (`User.Home`) | `/home/laurux`, propre au conteneur, vidé à chaque test | HOME de test neuf par test (`-T`, runner : bibliothèque `libhome`, voir ci-dessous), supprimé après le test ; rejeu entièrement à la main : votre HOME réel |
| Affichage | Xvfb (invisible), `--display :0` pour le voir | votre écran (ou `xvfb-run -a`) |
| Date | `faketime` (`date` de `meta.json`, `runner gbtest --date`) | à fixer soi-même (`faketime -f "@AAAA-MM-JJ hh:mm:ss"`) |
| `Desktop.Open` | faux programme `laurux-ouvrir` (tracé) | idem pour les tests qui appellent `TestKit.OuvertureFactice` et pour les rejeux `-T` ; sinon portail D-Bus de votre session |
| Délai, blocage | délai de 20 s par test par défaut (code 124 ; `runner gbtest/report --timeout`, `"timeout"` de `meta.json` avec `"timeout_accord"` au-delà de 20 s), « Bail out! » de gb.test et erreur fatale de Laurux (`Classe.Méthode.ligne: …` sur la console, puis boîte d'erreur Gambas : code 125) arrêtent tout le groupe de processus | aucun : une boîte `Message.*` ou d'erreur attend votre clic |
| Parallélisme | un conteneur par bac à sable, rien de partagé | une base de test à la fois (même port) |

Les valeurs attendues sont enregistrées **dans le conteneur** : c'est le mode à utiliser pour valider. Le mode
hors conteneur sert à observer un test ou un rejeu à l'écran et à déboguer.

Prérequis communs : base de test démarrée et clones compilés.

```bash
cd /home/damscot/Laurux_reworked
R=.src/Tests/Framework/runner.py
python3 $R db up            # base MariaDB de test (127.0.0.1:13306)
python3 $R harness apply    # harnais et .src/Tests recopiés dans le clone de référence
python3 $R build            # gbc3 + gba3 des deux clones → ~/.cache/laurux-tests/<id>/{rework,ref}/Laurux
```

#### Dans un conteneur

```bash
export LAURUX_DOCKER=1                       # sans elle, les mêmes commandes s'exécutent sur l'hôte
# gb.test : un test, un module, une liste, ou tout (un processus par test)
# sélection : même syntaxe que ./Laurux -T (type, lot, classe, ID, chemin, Module[.Méthode], lot/nom, jokers)
python3 $R list "CHANGEFOUR*"                # tests retenus, colonnes de ./Laurux -T list
python3 $R gbtest DbSmokeTest.T01Version -v  # (alias : unit)
python3 $R gbtest "LPRIX-T0*,LTaxeTest"
python3 $R gbtest                            # tous les gb.test (défaut : *)
python3 $R gbtest VisualiseurTest --record   # (ré)enregistre les valeurs attendues dans ref, puis les recopie

# rejeu GUI : produit dump.sql, sql.log, console.txt, exit_code
python3 $R replay Communs/demarrage_quitter --out /tmp/rejeu       # rejeu sur rework : /tmp/rejeu/results.json et /tmp/rejeu/Communs_demarrage_quitter/
python3 $R replay Communs/demarrage_quitter --expected             # attendus du scénario (rejeu dans ref)
python3 $R compare Communs/demarrage_quitter                       # rework vs attendus → IDENTIQUE
python3 $R compare "Changefour*"                                   # plusieurs scénarios : progression et bilan
python3 $R compare replay                                          # tous les scénarios validés
python3 $R compare Communs/demarrage_quitter --live                # rework vs rejeu de ref à l'instant
python3 $R replay Communs/demarrage_quitter --display :0           # même rejeu, visible sur votre écran

# rapport, sans exécution : fusionne les exécutions (output/tests/runs/*) en output/tests/list.md,
# output/tests/results.json et le bloc « tests » de .hidden/reference/TODO.md
python3 $R report
python3 $R report output/tests/runs/2026111*-compare-* ~/.cache/laurux-sandbox/sb*/rework/output/tests/runs/*
```

#### Exécutions et rapport

L'exécution des tests et le rapport sont deux étapes distinctes :

1. **Exécution** : chaque appel à `gbtest`, `replay` ou `compare` écrit son **répertoire d'exécution** :
   - `--out DIR` (même option pour les trois commandes), sinon `$LAURUX_TEST_RUN`, sinon un nouveau
     `output/tests/runs/<AAAAMMJJ-hhmmss>-<commande>-<pid>/` ;
   - deux exécutions simultanées n'écrivent donc jamais au même endroit ;
   - `results.json` y est réécrit après chaque test : une exécution interrompue garde ses résultats.

   Ce qui est enregistré par test :

   | Commande | Statut | Obtenu | Attendu |
   |---|---|---|---|
   | `gbtest` | pass / fail / xfail / xpass (verdict de gb.test) | première valeur en échec | valeur attendue |
   | `replay` | `exécuté` (pas de verdict) | code de sortie ; chemin des sorties (`sorties` : `<répertoire d'exécution>/<lot>_<nom>/`) | — |
   | `compare` | pass / fail / xfail | `identique`, ou code et écarts du dump et du SQL (sorties : `<répertoire d'exécution>/<lot>_<nom>/`) | `dump et SQL identiques à ref` (ou `xfail_attendu`) |

   S'y ajoutent la durée, la date et la commande. `gbtest --record` et `replay --expected`, qui produisent des
   valeurs attendues, n'enregistrent pas de résultat.
2. **Rapport** : `report [RUN…]` n'exécute aucun test. Il fusionne les `results.json` indiqués (répertoires ou
   fichiers ; défaut : tous ceux de `output/tests/runs/`). Pour chaque test, il retient le verdict le plus récent ;
   un `replay` seul (sans verdict) ne remplace jamais un verdict. Il écrit ensuite :
   - `output/tests/results.json` (la fusion) ;
   - `output/tests/list.md`, avec la colonne « Dernier passage » (date et commande) ;
   - le bloc « tests » de `.hidden/reference/TODO.md`.

   Les tests qui n'existent plus sont retirés. Avec `--out DIR`, `results.json` et `list.md` sont écrits dans
   `DIR` et `TODO.md` n'est pas modifié (rapport partiel, par exemple pour un seul lot ou un seul bac).

**Plusieurs lots en parallèle (sous-agents).** Chaque sous-agent travaille dans son bac à sable (`sandbox.py`),
qui a sa propre base de test sur son port et ses propres archives. Il lance par exemple `gbtest "Compta*"` et
`compare "Compta*"`. Le rapport combine ensuite les exécutions de tous les bacs :
`report ~/.cache/laurux-sandbox/sb*/rework/output/tests/runs/*`. `sandbox.py collect` rapatrie aussi
`output/tests/runs/`. Sur une même copie de travail, deux exécutions simultanées ont des répertoires distincts,
mais partagent la base de test du port : n'en lancer qu'une à la fois par port.

#### Hors conteneur

gb.test par `./Laurux -T`. L'archive doit être à la racine du dépôt, à côté de `.src/Tests` :

```bash
gbc3 -ag . && gba3 -o Laurux .
./Laurux -T list
LAURUX_TEST_DB_PORT=13306 TZ=Europe/Paris ./Laurux -T DbSmokeTest.T01Version
LAURUX_TEST_DB_PORT=13306 TZ=Europe/Paris ./Laurux -T LPrixTest            # module entier
LAURUX_TEST_DB_PORT=13306 TZ=Europe/Paris xvfb-run -a ./Laurux -T all      # tout, sans fenêtre à l'écran
echo $?                                    # 0 = aucun échec, 1 = au moins un échec, 2 = test introuvable
```

`TZ=Europe/Paris` reproduit les dates des valeurs attendues.

#### Rejeu d'un scénario par `-T`

`./Laurux -T <lot>/<nom>` (`Start.Run_Scenario`, harnais) rejoue un scénario avec les paramètres de son
`meta.json` (lu avec `gb.util.web`) :

1. restaure `Laurux01.sql`, puis le jeu `"dataset"`, sur la base `$LAURUX_TEST_DB_HOST:$LAURUX_TEST_DB_PORT`
   (défaut `127.0.0.1:13306`, utilisateur `laurux`) : **la base `Laurux01` de ce serveur est écrasée** ;
2. écrit la configuration (`Laurux-test.conf`, hôte et port réécrits), copie les fichiers d'entrée du scénario dans
   `/tmp/laurux-test/` (même chemin sur le poste et dans le conteneur), place les enveloppes `Framework/bin` en tête du `PATH`, fixe `GB_DESKTOP_PORTAL_ENABLED=0` ;
3. lance un **processus Laurux fils** `-r --replay-exit -s <societe> <args>`, sous `faketime` à la `"date"` du
   scénario (si `faketime` est installé : Gambas ne peut pas décaler sa propre horloge, `libfaketime` agit au
   lancement du processus), limité par `timeout` (`"timeout"`, 20 s par défaut). Le processus `-T` ne pose pas le
   verrou `~/Laurux.lock` (il quitte avant) : seul le fils le pose ;
4. écrit dans `output/tests/<lot>_<nom>_<AAAAMMJJ-hhmmss>/` (ou `$LAURUX_TEST_OUT`) : `console.txt`, `replay.log`
   et `replay.log.out` (journal rejoué), `sql.log` (requêtes `Exec_SQL`), `dump.sql` (`mariadb-dump` brut),
   `exit_code`, `Laurux.conf`, `rejeu.sh` (script de lancement). Code de sortie de `-T` : 0 si le code du rejeu
   égale `"code_sortie"`.

Le fils tourne dans sa propre session (`setsid`) et tout son groupe est tué en fin de rejeu (Laurux intercepte
SIGTERM : `timeout` seul le laisserait vivant). Une erreur non interceptée (`Classe.Méthode.ligne: …` sur la
console, puis boîte d'erreur Gambas modale) arrête le rejeu 2 s après avec le code 125 ; le délai dépassé donne 124.

`-T` ne compare pas : `runner.py replay|compare` lance `Laurux -T <lot>/<nom>` (sous Xvfb, dans le conteneur avec
`LAURUX_DOCKER=1`), puis normalise le dump et compare aux attendus. Les sources des tests sont lues dans
`$LAURUX_TEST_ROOT` (racine d'un clone), sinon à côté de l'archive.

Sélection (`-T`, liste séparée par des virgules). Chaque test a les champs affichés par `-T list` :

| Champ | gb.test | scénario |
|---|---|---|
| type | `gbtest` | `replay` |
| lot | `Utils` | `Utils` |
| classe | module sans « Test » : `LPrix` | `"classe"` de `meta.json` : `Changefour` |
| test | ID du test.md, d'après `Tnn` de la méthode : `LPRIX-T03` | `"id"` de `meta.json` : `CHANGEFOUR-T05` |
| chemin | `.src/Tests/Utils/LPrixTest.test:T03Arrondi5` | `.hidden/Tests/Utils/assets/changefour_liste_doublon` |
| description | déclarée par le module : `TestKit.Desc("<Méthode>", "…")` dans son `Public Sub _Desc()` | `"objet"` de `meta.json` (sinon `"description"`) |

Un élément de sélection est `all` (tous les gb.test et tous les scénarios validés, c'est-à-dire ayant un
`expected/`) ou une valeur comparée, sans distinction de casse, à chacun de ces champs ainsi qu'à `Module.Méthode`,
`lot/nom` et au nom du module gb.test (`LPrixTest`) ; jokers `*`, `?`, `[ ]` (opérateur `Like`). Exemples :
`gbtest`, `replay`, `Utils`, `Changefour`, `CHANGEFOUR-T05`, `"LPRIX-T0*"`, `"*doublon*"`, `LPrixTest`,
`"Utils/impclient_*"`, `".hidden/Tests/*/assets/razart_*"`. Un scénario non validé n'est lancé que s'il est désigné exactement (test, chemin ou
`lot/nom`). `list:<sélection>` affiche la sélection sans la lancer.

Pour un scénario, seul le code de sortie est vérifié par `-T`.

```bash
LAURUX_TEST_DB_PORT=13306 TZ=Europe/Paris ./Laurux -T Communs/demarrage_quitter
LAURUX_TEST_DB_PORT=13306 TZ=Europe/Paris xvfb-run -a ./Laurux -T Utils/razart_refus,Utils/agenda_replay_creation
```

#### HOME de test hors conteneur (`libhome`)

Gambas lit `User.Home` et `User.Name` dans la base des comptes (`getpwuid`), pas dans `$HOME` : changer `$HOME`
ne suffit pas. Hors conteneur, `-T` (chaque test gb.test, et le Laurux fils de chaque rejeu) et le runner chargent
donc par `LD_PRELOAD` la bibliothèque `.src/Tests/Framework/libhome/libhome.c` (compilée au besoin par `gcc` dans
`/tmp/laurux-test/libhome-<uid>.so`), qui renvoie `$LAURUX_TEST_HOME` comme répertoire personnel et
`$LAURUX_TEST_USER` (`laurux`, comme dans le conteneur) comme nom de l'utilisateur courant. Chaque test reçoit un HOME
neuf (`~/tmp`, `~/.config/gambas3`) : verrou `Laurux.lock`, journaux `~/tmp/Debug`, GED `~/ged`, `~/Impressions`,
`~/.config/gambas3/<Application>-AutoParams-*.conf`… ne touchent jamais le HOME réel, et les valeurs attendues
(produites dans le conteneur) restent valables sur le poste. `libhome` se combine avec `faketime` (qui ajoute sa
propre bibliothèque à `LD_PRELOAD`).

Chaque processus de test reçoit aussi un **bus D-Bus de session privé** (`dbus-run-session`), arrêté avec lui (sans
lui, Qt/gb.desktop démarrent un `dbus-daemon` par `dbus-launch --autolaunch` qui survit au test), et
l'environnement `XDG_RUNTIME_DIR=<HOME de test>/run`, `GIO_USE_VFS=local`, `GVFS_DISABLE_FUSE=1`,
`GTK_USE_PORTAL=0`, `QT_NO_XDG_DESKTOP_PORTAL=1` : ni portail de documents ni gvfs (montages FUSE) ne sont activés.

**Nettoyage.** Le HOME de test est supprimé par `Start.Fin_Home` après **chaque test gb.test** lancé par `-T`
(boucle de `Run_Tests`) et après **chaque rejeu de scénario** (`Run_Scenario`), que le test réussisse ou non. Seul le
répertoire créé juste avant par `Start.Home_Test` est supprimé : il est créé vide, donc tout ce qu'il contient vient
du test. Le rejeu note le chemin du HOME de son fils dans `output/tests/<…>/home.txt`. Pour déboguer,
`LAURUX_TEST_GARDER=1` conserve le HOME de test et affiche son chemin. Un test qui écrit ailleurs que dans son HOME
ou dans `Temp$()` (supprimé par Gambas à la fin du processus) nettoie dans son `Public Sub _Teardown()`, appelé par
gb.test après chaque test, réussi ou non.

**Interruption (Ctrl+C).** `-T` intercepte SIGINT et SIGTERM : la série s'arrête après le test en cours (chaque
commande lancée par `Shell` est dans son propre groupe de processus et ne reçoit pas le Ctrl+C du terminal ; le test
en cours se termine donc normalement, dans son délai), le HOME de test est nettoyé et `-T` sort avec le code 130
(`# Interrompu (Ctrl+C) après n test(s) sur N`). Sous `xvfb-run`, le Ctrl+C arrête aussi l'écran virtuel : Laurux
perd alors sa connexion X et s'arrête brutalement ; préférer un écran lancé à part (`Xvfb :77 &` puis
`DISPLAY=:77 ./Laurux -T …`) pour une interruption propre.

**Serveur de test absent.** `TestKit.ServeurTest()` vérifie que le serveur MariaDB de test répond sur
`$LAURUX_TEST_DB_HOST:$LAURUX_TEST_DB_PORT`. Sinon :
- `-T` s'arrête aussitôt (code 2) si la sélection contient un scénario, avec le message « Serveur MariaDB de test
  injoignable sur <hôte>:<port> … : le démarrer avec « python3 .src/Tests/Framework/runner.py db up » » ; pour les
  seuls gb.test, il avertit et continue (certains n'utilisent pas la base) ;
- `TestKit.OuvreBase` (dans le `_Setup` d'un test) et `Run_Scenario` échouent avec ce même message ;
- le runner s'arrête avec ce message pour `replay`, `compare`, `report`, `record`, `dump`, `db reset`, et avertit
  pour `unit`. Avec `LAURUX_DOCKER=1`, le service `db` est démarré par compose (dépendance du service `runner`).

**Surveillance des tests lancés par `-T`.** Chaque test gb.test et chaque rejeu passent par un script
(`Start.Lance_Surveille`) : session propre (`setsid`), console écrite dans un fichier et affichée au fil de l'eau,
délai (20 s pour un test gb.test, `"timeout"` pour un scénario), arrêt 2 s après « Bail out! » (gb.test : erreur dans
`_Setup`… suivie d'une boîte d'erreur modale) ou après une erreur fatale de Laurux (code 125), groupe de processus
tué en fin de test et sur Ctrl+C.

**Progression (runner).** `unit` et `report` affichent sur la sortie d'erreur une barre de progression : tests
passés / total, pourcentage, temps écoulé, temps restant estimé (durées connues du dernier `report` dans
`results.json`, sinon durée moyenne observée). Sur un terminal, elle est redessinée en place ; sinon une ligne
`progression …` est écrite tous les 10 % environ.

##### Garde-fous de suppression

Le framework supprime des répertoires ; ces contrôles empêchent qu'une erreur ou une variable mal positionnée
n'atteigne autre chose qu'un répertoire de test. **Ne pas les affaiblir** (`AGENTS.md`, règle 17 bis) et ne jamais
les éprouver sur le HOME réel.

| Où | Contrôle |
|---|---|
| `Start.Home_Test` (création) | `mktemp -d /tmp/laurux-test/home-XXXXXXXX` : nom unique, jamais un chemin venu d'une variable (`LAURUX_TEST_OUT`, `LAURUX_TEST_HOME`…) ; aucun `rm` préalable ; refus si le chemin obtenu n'a pas ce préfixe ; marqueur `.laurux-test-home` (fichier) |
| `Start.Fin_Home` (suppression) — tous requis | 1. chemin `/tmp/laurux-test/home-<nom>` (un seul niveau, sans `..`) ; 2. répertoire réel, pas un lien symbolique (`Stat`), chemin résolu (`realpath -e`) identique ; 3. ni `/`, ni le HOME réel (lu dans la base des comptes sans `libhome` : `env -u LD_PRELOAD getent passwd`), ni un parent de celui-ci ; 4. marqueur présent et de type fichier |
| `Start.Fin_Home` (exécution) | points de montage FUSE sous le HOME de test lus dans `/proc/mounts` puis démontés un à un (`fusermount3 -u -z`, chemins échappés) ; `rm -rf --one-file-system` : jamais de traversée vers un autre système de fichiers |
| `runner.py`, `dossier_temp` | ne supprime que le répertoire qu'il vient de créer (`mkdtemp`) : nom au préfixe attendu, directement dans le répertoire temporaire du système, pas un lien, chemin résolu identique, ni `/` ni le HOME réel ni un de ses parents |
| `runner.py`, `test_env` (conteneur) | ne vide `/home/laurux` que si c'est le HOME du compte du conteneur (passwd généré par le runner) |

En cas de refus, rien n'est supprimé et un message `garde-fou` indique la raison (`# HOME de test non supprimé
(garde-fou : …)` pour `-T`, `runner: … non supprimé (garde-fou)` pour le runner). Un test qui écrit
ailleurs que dans son HOME ou dans `Temp$()` (supprimé par Gambas à la fin du processus) nettoie dans son
`Public Sub _Teardown()`, appelé par gb.test après chaque test, réussi ou non.

Rejeu GUI entièrement à la main, sur votre écran :

```bash
python3 $R db reset              # ajouter --dataset <nom> si le meta.json du scénario en déclare un
W=/tmp/laurux-manuel; mkdir -p $W
cp .src/Tests/Framework/Laurux-test.conf $W/Laurux.conf     # vise déjà 127.0.0.1:13306
cp .hidden/Tests/Communs/assets/demarrage_quitter/scenario.log $W/replay.log
PATH=$PWD/.src/Tests/Framework/bin:$PATH LAURUX_TEST_DB_PORT=13306 SDL_AUDIODRIVER=dummy \
  faketime -f "@2026-01-15 10:00:00" \
  ~/.cache/laurux-tests/*/rework/Laurux -c $W/Laurux.conf -l --logfile $W/replay.log -r --replay-exit -s 01
echo $?                          # 0 = rejeu complet, 3 = fenêtre ou contrôle introuvable
python3 $R dump --out $W/dump.sql   # à comparer avec expected/dump.sql du scénario
```

- `ref/Laurux` à la place de `rework/Laurux` rejoue le clone de référence.
- Sans `--replay-exit`, la fenêtre reste ouverte à la fin du rejeu pour inspection.
- Le journal rejoué est écrit dans `$W/replay.log.out`.
- Un `~/Laurux.lock` resté d'un Laurux arrêté brutalement provoque la boîte « Laurux semble encore ouvert ».
  Supprimez-le après avoir vérifié qu'aucun Laurux ne tourne.

Équivalent par le runner, sans conteneur (pas de `LAURUX_DOCKER`) : `python3 $R replay Communs/demarrage_quitter
--display :0`. Le HOME passé à Laurux reste temporaire, mais `User.Home` reste votre HOME réel.

#### Exécution en conteneur (HOME isolé)

Gambas lit `User.Home` dans `/etc/passwd`, pas dans `$HOME` : lancé directement sur le poste, Laurux écrirait
son verrou `~/Laurux.lock`, `~/tmp/…` et `~/.config/gambas3/` dans le vrai répertoire de l'utilisateur, et deux
tests (ou deux bacs à sable) se bloqueraient mutuellement (« Laurux semble encore ouvert »). Avec
`LAURUX_DOCKER=1`, le runner exécute donc toutes ses commandes, sauf `db up|down|status`, `harness` et `retime`,
dans un **conteneur jetable** (service
`runner` de `.hidden/Docker/docker-compose.test.yml`, lancé par `docker compose run --rm`) :

| Élément | Dans le conteneur |
|---|---|
| Système | image `ubuntu:24.04` nue ; `/usr` et `/etc` de l'hôte montés en lecture seule : mêmes Gambas, Xvfb, faketime, xdotool, client MariaDB que le poste, aucun paquet installé |
| Utilisateur | `laurux`, UID/GID de l'hôte, via un `/etc/passwd` généré par le runner : `User.Home` = `/home/laurux` |
| HOME, `/tmp` | `tmpfs` (avec `exec`, pour les faux binaires des tests) propres au conteneur ; le HOME est vidé avant chaque test |
| Dépôts | les deux clones et le cache des archives montés **en entier, au même chemin** : assets, CSV, jeux de données, `Laurux.conf` de test accessibles tels quels |
| Base | service `db` du même projet compose (`laurux-test-<port>`) : une base par bac à sable |
| Bus D-Bus | aucun bus système (`/run` de l'hôte non monté) ; rien ne peut atteindre la session de l'utilisateur |

Plusieurs conteneurs (bacs à sable sur des ports différents) tournent donc en parallèle sans rien partager.
Un délai dépassé, ou un « Bail out! » de gb.test (suivi d'une boîte d'erreur modale), arrête tout le groupe de
processus ; le conteneur est supprimé même si le runner est interrompu. Le conteneur n'est utilisé qu'avec
`LAURUX_DOCKER=1` (positionné par les bacs à sable dans `env.sh`) ; sans cette variable, le runner s'exécute
directement sur l'hôte (HOME et écran de l'utilisateur).

**Ouverture de documents (`Desktop.Open`).** En Gambas 3.19, `gb.desktop` passe par défaut par le portail de
bureau (`org.freedesktop.portal.Desktop`, D-Bus) : sur le poste, un test ouvrirait réellement le document dans la
session de l'utilisateur, sans appeler `xdg-open` ; dans le conteneur, l'appel échoue (« Cannot connect to the
system bus »). Sans portail, `Desktop.Open` lance directement l'application associée au type MIME (pas
`xdg-open`). `TestKit.OuvertureFactice([trace])` rend donc l'ouverture inoffensive dans tout environnement :
`Desktop.UsePortal = False`, `GB_DESKTOP_PORTAL_ENABLED=0`, types usuels (PDF, images, texte, CSV, HTML,
OpenDocument, liens http/mailto…) associés au faux programme `.src/Tests/Framework/bin/laurux-ouvrir` dans des
répertoires XDG temporaires (`XDG_DATA_HOME`, `XDG_CONFIG_HOME`). Ce programme n'ouvre rien : il trace l'appel
(`laurux-ouvrir [fichier]`) dans `$LAURUX_OUVRIR_TRACE`. Un test gb.test qui ouvre un document l'appelle
(`VisualiseurTest.T02DesktopOpen`) ; `-T <lot>/<nom>` l'applique au Laurux fils du rejeu (trace dans
`ouvrir.trace` du répertoire de sortie). Le runner prépare en plus la même association dans le HOME de test.

**Outils externes factices (politique du PATH).** Entre le processus `-T` et le Laurux testé, le PATH commence par
`.src/Tests/Framework/bin` : un outil externe lancé par Laurux (`Shell`/`Exec`) y est remplacé par un faux programme
**lorsque son comportement n'a pas d'effet sur celui de Laurux**. Le faux programme ne lance rien et trace l'appel
(`nom [arg1] [arg2]`) dans `$LAURUX_FACTICE_TRACE` (`outils.trace` du répertoire de sortie du rejeu ;
`~/tmp/outils.trace` en gb.test) : le test valide **l'usage** de l'outil par Laurux (commande, arguments), pas
l'outil lui-même.

| Outil | Faux programme | Utilisé par | Comportement |
|---|---|---|---|
| `thunderbird`, `icedove`, `evolution`, `kmail`, `xdg-email`, `xdg-open`, `pico2wave`, `aplay`, `evince` | lien vers `laurux-factice` | EnvMail, Fmenu, LGed, FClientcarte, Prefs, Syntheses | trace, code 0 |
| `gammu` | `gammu` | Gsm (SMS) | trace, affiche la réponse d'un envoi réussi (« …OK… », lue par Gsm) ; `LAURUX_GAMMU_ECHEC=1` : réponse d'échec |
| `wput` | `wput` | Btqart (catalogue FTP) | trace dans `ftp.trace`, copie du fichier sous `ftp/wput/` |
| `FtpClient` (gb.net.curl) | serveur `laurux-ftp` | SauvesAuto, FacturefmA | voir ci-dessous |

Ne sont **pas** remplacés les outils dont Laurux exploite la sortie ou l'effet (`mysql`, `mysqldump` : enveloppes
vers la base de test ; `curl`, `wget`, `ps`, `lpstat`, `lpc`, `ssh`, `gksu`, `hostname`…) : un faux programme y
changerait le comportement testé. Pour en ajouter un : lien symbolique `bin/<outil> -> laurux-factice` si la sortie
n'est pas lue, sinon un faux programme dédié qui reproduit la réponse attendue (modèle : `gammu`).

**FTP.** `FtpClient` (libcurl, dans le processus Gambas) ne passe par aucun programme externe : le PATH ne peut pas
le remplacer. `TestKit.FtpFactice(Mode, Dossier)` lance donc `bin/laurux-ftp`, petit serveur FTP en Python
(bibliothèque standard) sur `127.0.0.1` (port libre), qui accepte les envois (`USER`/`PASS`, `CWD`, `MKD`,
`EPSV`/`PASV`, `STOR`), range les fichiers reçus sous `Dossier` et trace les commandes (mot de passe compris :
données de test) ; il renvoie l'URL `ftp://127.0.0.1:<port>`. Modes : `ok`, `refus` (identifiants refusés, 530),
`absent` (aucun serveur, URL vers le port 1). `TestKit.FinFtp()` l'arrête (sinon arrêt automatique après 120 s).
Rejeu : `"ftp": "ok"` dans `meta.json`, URL injectée par `{ftp}` dans `"conf"`, trace comparée par
`"fichiers": ["@ftp.trace"]` (le port est masqué à la comparaison). gb.test : `FtpFactice` dans `_Setup`, URL posée
dans `Start.LocalSettings`, `FinFtp` dans `_Teardown`.

Autres fichiers de test : `.src/Tests/TriTest.class` (banc d'essai manuel de `TriGen`, à enrichir : TRITEST-002),
`.src/Utils/CTestTVA.class` (validation TVA), `.src/Caisse/TestCaisses.module` (`TestCai()`, contrôle des
verrous de caisse, pas un test).

## Tests : utilisation du mode logging/replay

Laurux peut enregistrer les événements GUI (clics, saisies, sélections, fermetures) dans un fichier de log,
puis les rejouer. Cela permet de produire des scénarios synthétiques, de rejouer des use-cases réalisés par
l'utilisateur, et de servir de base à des tests de non-régression.

**Important** : le rejeu ne vérifie rien par lui-même. Il reproduit uniquement les actions d'interface.
La vérification de la base de données ou des objets (valeurs attendues) doit être faite à part, à partir
des lignes `Exec_SQL` / `Log` du fichier de log ou par un harnais dédié.

### Enregistrement (capture)

L'enregistrement est **désactivé par défaut**. Il s'active avec `-l` ou depuis le formulaire de logs (`DB_Log`,
bouton `Enable`, qui appelle `DB_Connection.Set_Log`).

```bash
./Laurux -l --logfile /chemin/scenario.log
```

- `--logfile <chemin>` : fichier de log (sinon `~/tmp/Debug/<App>.log`). Le chemin relatif est résolu depuis le répertoire courant.
- `-d "console,file"` : niveaux de log (voir `Start.module`).
- Les contrôles sont observés à l'ouverture de chaque formulaire via `Utils.Observers(Me)`, qui crée un
  `ReplayObserver` par contrôle (`Menu`, `Button`, `CheckBox`, `TextBox`, `ListBox`, `ComboBox`, `GridView`,
  `TreeView`, `TabStrip`, `Label`, etc.), voir `Recursive_Observers` dans `Utils/Utils.module`.
- Chaque événement est écrit par `DB_Connection.GUI_Event` sous la forme :

```
<date> <heure>;<niveau>;GUI;<user>;<host>;<machine>;<pid>;<backtrace>;<Action>=<Valeur>@<Hôte><Ctrl>#<Fenêtre>#<ctrl1>#<ctrl2>...
```

Les actions enregistrées sont : `Click`, `Keypress` (uniquement si le contrôle a le focus), `GotFocus`
(zones de saisie), `MouseDown`/`MouseUp` (labels et toolbuttons), `Close`. La molette est tracée comme « unsupported ».

- Filtres : la chaîne stockée dans `Temp$(Application.Name & "_filter")` contient des lignes `Nom:regex`.
  Un filtre `GUI:...` restreint ce qui est écrit. Sans filtre, tout est accepté. Le filtre se règle dans l'écran
  de logs (`Filtres`).
- Au démarrage, `Start.module` purge les `~/tmp/Debug/*.log`. Un fichier de log utilisé pour un scénario doit donc être
  conservé en dehors de ce répertoire (ou passé avec `--logfile`).

### Rejeu (playback)

```bash
./Laurux -r --logfile /chemin/scenario.log
./Laurux -r --replay-exit --logfile /chemin/scenario.log   # quitte à la fin (code 0) ; 3 si un événement échoue
```

- Seules les lignes contenant `;GUI;` sont retenues ; les autres (`Exec_SQL`, `Log`) sont ignorées.
- Le rejeu démarre après un délai initial de 2 s. Chaque événement est rejoué par un `Timer` à usage unique
  (`ReplayTimer_Timer` dans `.src/Start.module`), ce qui évite de bloquer sur les `ShowModal`.
- Le délai avant l'événement suivant est l'écart entre les horodatages du log, plafonné à 1 s si l'écart dépasse 20 s.
- Avant chaque événement, `Replay_Event` (`.src/Utils/ReplayObserver.class`) vérifie que la fenêtre active
  correspond à la fenêtre enregistrée. Si ce n'est pas le cas, le rejeu s'arrête (`Quit 3`). Avec
  `--replay-exit`, une fenêtre ou un contrôle introuvable arrête aussi le rejeu avec le code 3. Les événements `Close`
  ne sont pas soumis à cette condition.
- Le contrôle est retrouvé par son nom en parcourant la hiérarchie enregistrée (`Children`, puis `Menus`).
- Le fichier de sortie est le fichier d'entrée suffixé par `.out` : l'entrée n'est jamais écrasée.

### Limites à connaître

- Le rejeu dépend des **noms** des contrôles et de la fenêtre active : renommer un contrôle casse le scénario.
- Les frappes (`Keypress`) passent par `Utils.De.SendKeys` et dépendent de l'environnement de bureau.
- Les clics sur les labels utilisent `xdotool` (X11) ou `ydotool` (Wayland, selon `Utils.de.wayland`).
- Sous `--devel`, les observateurs ne sont pas créés : rien n'est enregistré ni rejoué.
- Les écrans qui n'appelaient pas `Utils.Observers(Me)` appellent `Utils.ReplayObservers(Me)` (harnais de la
  phase 2) : observateurs de rejeu seuls, sans les couleurs du thème. Non rejoués : les touches `ImageButton`
  de la caisse et les clics de grilles sans handler `<Grille>_Click` (REPLAYOBSERVER-A06, non retenue).
- `Fmenu` lance `mysql -h <hôte>` sans port au démarrage (sql_mode global) ; le runner de test place des
  enveloppes `mysql`/`mysqldump` en tête du `PATH` pour viser la base de test (dans le conteneur : hôte `db`,
  port 3306).
- Boîtes `Message.*` (fenêtre `FMessage` de gb.form) : le focus est sur le 1er bouton (défaut). Bouton 1 :
  Entrée (`Keypress=16777220`) ; bouton n : (n-1) × Tab (`Keypress=16777217`) puis Espace (`Keypress= `). Le
  bouton visé est noté dans la description du `meta.json`. Si l'ordre ou le nombre des boutons d'un appel
  `Message.*` change, les scénarios qui y répondent sont à revoir (choix assumé : pas d'événement de réponse
  par rang dans le harnais).
- Cadencement : le rejeu respecte les écarts d'horodatage du `scenario.log`. `runner.py retime LOT/NOM|all
  [-n]` les recalcule selon ce que chaque événement peut déclencher (le premier événement garde son horodatage,
  temps de démarrage de Laurux) :

  | Événement | Écart après |
  |---|---|
  | touche (caractère, BackSpace, Suppr, Entrée, Tab) suivie d'une autre touche dans le même champ | 50 ms |
  | `Focus`, Tab suivie d'un événement sur un autre contrôle | 100 ms |
  | dernière touche d'édition d'un champ avant un événement sur un autre contrôle (contrôles et `Change` du champ) | 1 s |
  | `Click` (bouton de traitement, menu, case…), Entrée, Espace, `Close` | 1 s |
  | tout événement suivi d'un changement de fenêtre (ouverture d'écran ou de boîte modale) | 1 s |

  Un scénario se rejoue alors en quelques secondes, dans le délai de 20 s par test.

  Les valeurs (`frappe` 50, `focus` 100, `traitement` 1000, `fenetre` 1000 ms par défaut) sont **propres à chaque
  scénario** : `retime` les écrit dans le `"cadence"` de son `meta.json` au premier passage, puis les y relit.
  Changer les valeurs par défaut du runner ne modifie donc aucun scénario existant. Pour corriger un seul test :

  ```bash
  python3 $R retime Utils/<nom> --set traitement=1500     # écrit la cadence dans meta.json et recadence
  python3 $R replay Utils/<nom> --expected                # attendus dans ref
  python3 $R compare Utils/<nom>                          # → IDENTIQUE
  ```
- `faketime` fixe l'heure de départ du rejeu, mais l'horloge avance ensuite : un horodatage issu de `Now` dépend de
  la durée du rejeu (et de la vitesse de ref et de rework). Les horodatages ne sont **pas masqués** (un masquage
  cacherait une régression, ex. 9:59:59.99 contre 10:00:00.00, ou un changement de jour à minuit) : `compare`
  vérifie d'abord le contenu et l'**ordre** des lignes (`sql.log`, `dump.sql`, fichiers comparés), horodatages
  mis de côté, puis compare chaque horodatage obtenu à celui de la même position dans l'attendu avec un **écart
  toléré** : `"tolerance_horodatage"` de `meta.json`, en secondes (défaut 5). Il signale aussi l'inversion de deux
  horodatages successifs que l'attendu sépare d'au moins 1 s. Formes reconnues : `AAAA-MM-JJ hh:mm:ss[.f]` et heure
  seule `hh:mm:ss.f` (comparée modulo 24 h). Une date métier fixe garde un écart nul ; un jour de décalage est
  toujours signalé.
- Un document ouvert par `Desktop.Open` pendant un rejeu n'est pas affiché : il est tracé par `laurux-ouvrir`
  (voir « Exécution en conteneur »).
- Pour un `Button`, le rejeu affecte `Value = True` (`Replay_Click`) ; cela ne déclenche pas forcément
  `_Click` comme un clic utilisateur. À vérifier sur un cas réel avant de s'appuyer dessus.
- Les événements `MouseWheel` ne sont pas rejoués.
