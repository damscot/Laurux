# Framework de tests de non-régression (phase 2 du rework)

Décisions : `.hidden/reference/PLAN.md` §4.0. Les tests et leurs données vivent dans `.src/Tests/<lot>/` ;
`.hidden/reference/` ne contient que la documentation.

## Arborescence

```
.src/Tests/
  Framework/
    runner.py            pilote : base Docker, harnais, gb.test, record/replay/compare
    TestKit.module       aide gb.test : valeurs attendues « golden » (TestKit.Check), état global de test
    Laurux-test.conf     configuration Laurux de test (base 127.0.0.1:13306, Maj=0, Tips=0, son=0)
    harness_files.txt    fichiers du harnais (diff vs 6b6b9dfc → harness.patch, appliqué au clone ref)
    harness.patch        généré par « runner.py harness make »
    dump_mask.json       colonnes volatiles masquées dans le dump normalisé
    datasets/<nom>.sql   jeux de données partagés, appliqués après Laurux01.sql
    bin/                 enveloppes mysql/mysqldump (port de la base de test), en tête du PATH de test
  <lot>/
    <Classe>Test.test    module gb.test
    assets/<nom>/        données d'un test : expected.txt (gb.test) ou scénario GUI :
                         scenario.log, meta.json, expected/{dump.sql, sql.log, console.txt, exit_code}
```

## Prérequis

- Docker ; paquets hôte : `mariadb-client`, `xvfb`, `faketime`, `xdotool` (rejeu des frappes et des clics
  sur labels, `Utils.De.SendKeys`).
- Clone de référence : `/home/damscot/Laurux` (ou `LAURUX_REF=…`), au commit `6b6b9dfc` + harnais.

## Utilisation

```bash
R=.src/Tests/Framework/runner.py
python3 $R db up                        # base MariaDB 10.11 de test (.hidden/Docker/docker-compose.test.yml)
python3 $R harness apply                # applique le harnais au clone ref et y copie .src/Tests
python3 $R build                        # gbc3 + archives ~/.cache/laurux-tests/{rework,ref}/Laurux

python3 $R unit --record                # gb.test dans ref, enregistre les valeurs attendues, les recopie ici
python3 $R unit                         # gb.test dans rework (code 0 = succès)

python3 $R record Gestion/facture_simple --dataset facturation_base --date "2026-01-15 10:00:00"
                                        # scénario joué à la main dans ref (écran réel), puis attendus par rejeu
python3 $R replay Communs/demarrage_quitter --expected   # (ré)écrit les attendus depuis ref
python3 $R compare Communs/demarrage_quitter              # rejeu rework comparé aux attendus (dump + SQL)
python3 $R compare Communs/demarrage_quitter --live       # comparé à un rejeu ref fait à l'instant
python3 $R report                       # exécute tout et régénère output/tests/list.md et .hidden/reference/TODO.md

python3 .src/Tests/Framework/sandbox.py create 1   # bac à sable n°1 (copies des clones, base 13307)
python3 .src/Tests/Framework/sandbox.py collect 1  # recopie ici les tests et docs produits dans le bac
```

Règles : un test = un processus ; méthodes gb.test `T<nn>_<objet>` (ID `<CLASSE>-T<nn>` du test.md) ;
scénarios avec `meta.json` (`id`, `classe`, `dataset`, `date`) ; échec attendu par `TestKit.CheckXFail`
(gb.test) ou `"xfail"` dans `meta.json` (replay).

## Déterminisme

- Base restaurée avant chaque rejeu (`Laurux01.sql` + `datasets/<dataset>.sql`, 0,2 s).
- `faketime -f "@<date>"` : la date part de la valeur du scénario et avance normalement.
- `HOME` temporaire, `LANG=fr_FR.UTF-8`, `SDL_AUDIODRIVER=dummy` (pas de carte son sous Xvfb).
- Archive exécutable nommée `Laurux` pour les deux clones (`Application.Name` identique).
- `sql_mode` du serveur : `NO_ENGINE_SUBSTITUTION`, valeur que `Fmenu` impose lui-même au démarrage.
- Dump : schéma (sans `AUTO_INCREMENT=`) puis données, tables et lignes triées ; colonnes de
  `dump_mask.json` masquées. Le SQL comparé est la suite des requêtes `Exec_SQL` du journal (sans horodatage,
  pid ni pile d'appels).
