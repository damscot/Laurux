#!/usr/bin/env python3
"""Runner des tests de non-régression de Laurux (phase 2 du rework, voir .hidden/reference/PLAN.md §4).

Deux clones :
  rework : ce dépôt (Laurux_reworked), code retravaillé ;
  ref    : clone de référence (défaut /home/damscot/Laurux, variable LAURUX_REF), code d'origine
           + harnais de test (harness.patch) + copie de .src/Tests.

Base de test : MariaDB 10.11 Docker (.hidden/Docker/docker-compose.test.yml), 127.0.0.1:13306.

Commandes :
  db up|down|status                 démarrer / arrêter la base de test
  db reset [--dataset NOM]          recréer Laurux01 depuis Laurux01.sql (+ datasets/NOM.sql)
  dump [--out FICHIER]              dump normalisé de Laurux01 (sortie standard par défaut)
  harness make                      régénère harness.patch (fichiers de harness_files.txt, rework vs 6b6b9dfc)
  harness apply                     applique harness.patch au clone ref (si absent) et y synchronise .src/Tests
  build [--clone rework|ref|all]    compile (gbc3 -ag) et produit l'archive ~/.cache/laurux-tests/<clone>/Laurux
  unit [TESTS] [--clone rework|ref] [--record] [-v]
                                    gb.test, un processus par test (gbx3 -T Module.Méthode) ; TESTS = all,
                                    Module, Module.Méthode ou liste ; --record : enregistre les valeurs
                                    attendues dans ref puis les recopie dans rework
  record LOT/NOM [--dataset D] [--date "AAAA-MM-JJ hh:mm:ss"] [--pos] [--display :0]
                                    enregistre un scénario GUI joué à la main dans le clone ref
  replay LOT/NOM [--clone rework|ref] [--out DIR] [--expected]
                                    rejoue un scénario (Xvfb, faketime) et produit dump + SQL exécutés
  compare LOT/NOM [--live]          rejoue sur rework et compare aux attendus enregistrés (ou à ref avec --live)
  report [--lot LOT] [--no-run]     exécute chaque test (gb.test un par un, scénarios) et génère
                                    output/tests/list.md et le bloc « tests » de .hidden/reference/TODO.md

Un scénario vit dans .src/Tests/<LOT>/assets/<NOM>/ :
  scenario.log   lignes « ;GUI; » du journal Laurux (-l), rejouées par -r --replay-exit
  meta.json      {"dataset": "...", "date": "...", "args": [...], "societe": "01", "timeout": 300}
  expected/      dump.sql et sql.log produits par le rejeu dans ref (référence de comparaison)
"""

import argparse
import difflib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

FRAMEWORK = Path(__file__).resolve().parent
TESTS = FRAMEWORK.parent
REWORK = TESTS.parents[1]
REF = Path(os.environ.get("LAURUX_REF", "/home/damscot/Laurux")).resolve()
DOCKER_DIR = REWORK / ".hidden" / "Docker"
DB_PORT = os.environ.get("LAURUX_TEST_DB_PORT", "13306")
# Un projet compose par port : plusieurs bases de test peuvent tourner en parallèle (un agent par base).
COMPOSE = ["docker", "compose", "-p", f"laurux-test-{DB_PORT}", "-f", str(DOCKER_DIR / "docker-compose.test.yml")]
BASE_COMMIT = "6b6b9dfc"
# Archives exécutables nommées « Laurux » : Application.Name (noms de configuration et de journaux) doit
# être identique dans les deux clones, ce que « gbx3 <répertoire> » ne garantit pas (nom du répertoire).
# Cache propre à chaque copie de travail (bacs à sable parallèles).
CACHE = (Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "laurux-tests"
         / __import__("hashlib").md5(str(REWORK).encode()).hexdigest()[:8])

DB = {
    "host": os.environ.get("LAURUX_TEST_DB_HOST", "127.0.0.1"),
    "port": DB_PORT,
    "user": "laurux",
    "password": "laurux",
    "name": "Laurux01",
}
LOCALE = {"LANG": "fr_FR.UTF-8", "LC_ALL": "fr_FR.UTF-8", "LANGUAGE": "fr_FR"}


def die(msg, code=2):
    print(f"runner: {msg}", file=sys.stderr)
    sys.exit(code)


def run(cmd, **kw):
    kw.setdefault("check", True)
    return subprocess.run(cmd, **kw)


def clone_path(name):
    return {"rework": REWORK, "ref": REF}[name]


# ------------------------------------------------------------------------------------------------ base

def mariadb(args, **kw):
    return run(["mariadb", "-h", DB["host"], "-P", DB["port"], "-u", DB["user"], f"-p{DB['password']}"] + args, **kw)


def cmd_db(a):
    if a.action == "up":
        run(COMPOSE + ["up", "-d", "--build", "--wait"])
    elif a.action == "down":
        run(COMPOSE + ["down"])
    elif a.action == "status":
        run(COMPOSE + ["ps"])
        mariadb(["-e", "select version(), @@sql_mode"])
    elif a.action == "reset":
        db_reset(a.dataset)
        print(f"Laurux01 restaurée{' + ' + a.dataset if a.dataset else ''}")


def db_reset(dataset=None):
    mariadb(["-e", f"DROP DATABASE IF EXISTS {DB['name']}; CREATE DATABASE {DB['name']} "
                   "CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"])
    with open(REWORK / "Laurux01.sql", "rb") as f:
        mariadb([DB["name"]], stdin=f)
    if dataset:
        ds = FRAMEWORK / "datasets" / f"{dataset}.sql"
        if not ds.exists():
            die(f"jeu de données introuvable : {ds}")
        with open(ds, "rb") as f:
            mariadb([DB["name"]], stdin=f)


def load_mask():
    """Colonnes volatiles à masquer dans le dump : {"Table": ["colonne", …]} (dump_mask.json)."""
    p = FRAMEWORK / "dump_mask.json"
    return {k: v for k, v in json.loads(p.read_text(encoding="utf-8")).items() if not k.startswith("_")} \
        if p.exists() else {}


def dump_normalized():
    """Schéma + données, une ligne par enregistrement, tables et lignes triées, colonnes volatiles masquées."""
    schema = run(["mariadb-dump", "-h", DB["host"], "-P", DB["port"], "-u", DB["user"], f"-p{DB['password']}",
                  "--no-data", "--skip-comments", "--skip-dump-date", "--compact", DB["name"]],
                 capture_output=True, text=True).stdout
    schema = re.sub(r" AUTO_INCREMENT=\d+", "", schema)
    out = ["-- schéma", schema.strip(), "-- données"]
    mask = load_mask()
    tables = mariadb(["-N", "-B", "-e", f"SHOW TABLES FROM {DB['name']}"], capture_output=True,
                     text=True).stdout.split()
    for t in sorted(tables):
        res = mariadb(["-B", "--raw", DB["name"], "-e", f"SELECT * FROM `{t}`"], capture_output=True, text=True).stdout
        lines = res.splitlines()
        if not lines:
            continue
        cols = lines[0].split("\t")
        masked = [i for i, c in enumerate(cols) if c in mask.get(t, [])]
        rows = []
        for l in lines[1:]:
            vals = l.split("\t")
            for i in masked:
                if i < len(vals):
                    vals[i] = "<masqué>"
            rows.append("\t".join(vals))
        out.append("## " + t + " (" + "\t".join(cols) + ")")
        out.extend(sorted(rows))
    return "\n".join(out) + "\n"


def cmd_dump(a):
    txt = dump_normalized()
    if a.out:
        Path(a.out).write_text(txt, encoding="utf-8")
    else:
        sys.stdout.write(txt)


# --------------------------------------------------------------------------------------------- harnais

def harness_files():
    return [l.strip() for l in (FRAMEWORK / "harness_files.txt").read_text(encoding="utf-8").splitlines()
            if l.strip() and not l.startswith("#")]


def cmd_harness(a):
    patch = FRAMEWORK / "harness.patch"
    if a.action == "make":
        txt = run(["git", "-C", str(REWORK), "diff", BASE_COMMIT, "--"] + harness_files(),
                  capture_output=True, text=True).stdout
        patch.write_text(txt, encoding="utf-8")
        print(f"{patch} : {len(txt.splitlines())} lignes")
        return
    # apply : patch (une seule fois) puis synchronisation de .src/Tests
    if not (REF / ".git").exists():
        die(f"clone de référence introuvable : {REF}")
    already = run(["git", "-C", str(REF), "apply", "--reverse", "--check", str(patch)],
                  capture_output=True, check=False).returncode == 0
    if already:
        print("harnais déjà appliqué au clone ref")
    else:
        run(["git", "-C", str(REF), "apply", str(patch)])
        print("harnais appliqué au clone ref")
    dst = REF / ".src" / "Tests"
    for sub in TESTS.iterdir():
        if sub.name in ("TriTest.class", "TriTest.form"):
            continue  # fichiers d'origine, déjà présents dans ref
        target = dst / sub.name
        if sub.is_dir():
            shutil.copytree(sub, target, dirs_exist_ok=True)
        else:
            shutil.copy2(sub, target)
    print(f".src/Tests synchronisé vers {dst}")


def build(clone):
    """Compile le clone (gbc3 -ag) et produit son archive exécutable CACHE/<clone>/Laurux."""
    root = clone_path(clone)
    arch = CACHE / clone / "Laurux"
    arch.parent.mkdir(parents=True, exist_ok=True)
    print(f"gbc3 -ag {root} ; gba3 -o {arch}")
    run(["gbc3", "-ag", str(root)], stdout=subprocess.DEVNULL)
    run(["gba3", "-o", str(arch), str(root)], stdout=subprocess.DEVNULL)
    return arch


def archive(clone):
    arch = CACHE / clone / "Laurux"
    if not arch.exists():
        die(f"archive absente pour {clone} : lancer « runner.py build »")
    return arch


def cmd_build(a):
    for c in (["rework", "ref"] if a.clone == "all" else [a.clone]):
        build(c)


# ----------------------------------------------------------------------------------- environnement

def test_env(home, extra=None):
    """Environnement minimal et reproductible : HOME isolé, locale française, configuration de test."""
    # bin/ en tête du PATH : mysql/mysqldump lancés par Laurux (sans port) visent la base de test.
    env = {"HOME": str(home), "PATH": f"{FRAMEWORK / 'bin'}:/usr/local/bin:/usr/bin:/bin",
           "USER": os.environ.get("USER", "laurux"), "LAURUX_TEST_DB_PORT": DB["port"],
           "XDG_RUNTIME_DIR": str(home / "run"), "LAURUX_TEST_CONF": str(home / ".config/gambas3/Laurux.conf")}
    env.update(LOCALE)
    # Pas de carte son sous Xvfb : Music.Load (Start.Main) échouerait sur « Unable to initialize mixer ».
    env["SDL_AUDIODRIVER"] = "dummy"
    for k in ("DISPLAY", "XAUTHORITY"):
        if k in os.environ:
            env[k] = os.environ[k]
    env.update(extra or {})
    (home / "run").mkdir(mode=0o700, parents=True, exist_ok=True)
    (home / "tmp").mkdir(parents=True, exist_ok=True)
    conf = home / ".config" / "gambas3" / "Laurux.conf"
    conf.parent.mkdir(parents=True, exist_ok=True)
    txt = (FRAMEWORK / "Laurux-test.conf").read_text(encoding="utf-8")
    conf.write_text(re.sub(r'^Port="\d+"', f'Port="{DB["port"]}"', txt, flags=re.M), encoding="utf-8")
    return env


def wrap(cmd, display=None, date=None):
    """Préfixe xvfb-run (sauf --display) et faketime (si une date est fournie)."""
    if date:
        if not shutil.which("faketime"):
            die("faketime absent : sudo apt install faketime (ou relancer sans date)")
        cmd = ["faketime", "-f", f"@{date}"] + cmd
    if not display:
        if not shutil.which("xvfb-run"):
            die("xvfb-run absent : sudo apt install xvfb (ou utiliser --display :0)")
        cmd = ["xvfb-run", "-a", "-s", "-screen 0 1280x1024x24"] + cmd
    return cmd


def select_methods(spec):
    """Méthodes gb.test visées : all, Module, Module.Méthode ou liste séparée par des virgules."""
    meths = gbtest_methods()
    if not spec or spec == "all":
        return meths
    out = []
    for s in spec.split(","):
        mod, _, meth = s.partition(".")
        out += [x for x in meths if x[1] == mod and (not meth or x[2] == meth)]
    return out


def cmd_unit(a):
    clone = "ref" if a.record else a.clone
    meths = select_methods(a.tests)
    if not meths:
        die(f"aucun test ne correspond à « {a.tests} »")
    if a.record:  # repartir de zéro pour les modules visés (pas de valeurs périmées)
        for mod in {m[1] for m in meths}:
            lot = next(m[0] for m in meths if m[1] == mod)
            f = REF / ".src" / "Tests" / lot / "assets" / mod / "expected.txt"
            if f.exists() and a.tests in (None, "all", mod):
                f.unlink()
    failed = 0
    for lot, mod, meth in meths:
        txt, dur = run_gbtest(mod, meth, a.timeout, clone, a.record, a.display, a.date)
        status, got, exp = parse_tap(txt)
        print(f"{status:5} {dur:6.2f}s {mod}.{meth}" + (f"   obtenu={short(got)} attendu={short(exp)}"
                                                         if status == "fail" else ""))
        if status == "fail":
            failed += 1
            if a.verbose:
                print(txt)
    if a.record:
        n = 0
        for f in (REF / ".src" / "Tests").glob("*/assets/*/expected.txt"):
            dst = REWORK / f.relative_to(REF)
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(f, dst)
            n += 1
        print(f"{n} fichier(s) de valeurs attendues recopié(s) de ref vers rework")
    print(f"{len(meths) - failed}/{len(meths)} test(s) sans échec")
    sys.exit(1 if failed else 0)


# ------------------------------------------------------------------------------------------- replay

def scenario_dir(spec):
    lot, nom = spec.split("/", 1)
    return TESTS / lot / "assets" / nom


def laurux_cmd(clone, conf, logfile, extra):
    return [str(archive(clone)), "-c", str(conf), "-l", "--logfile", str(logfile)] + extra


def sql_lines(logfile):
    """Requêtes Exec_SQL d'un journal, sans horodatage ni pid ni backtrace (ordre conservé)."""
    out = []
    p = Path(str(logfile) + ".out") if Path(str(logfile) + ".out").exists() else Path(logfile)
    if not p.exists():
        return out
    for l in p.read_text(encoding="utf-8", errors="replace").splitlines():
        parts = l.split(";", 8)
        if len(parts) == 9 and parts[2] == "Exec_SQL":
            out.append(parts[8])
    return out


def do_replay(spec, clone, outdir, display=None, journal=True):
    sdir = scenario_dir(spec)
    meta = json.loads((sdir / "meta.json").read_text(encoding="utf-8"))
    root = clone_path(clone)
    db_reset(meta.get("dataset"))
    outdir.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="laurux-replay-", ignore_cleanup_errors=True) as tmp:
        home = Path(tmp)
        env = test_env(home)
        log = home / "tmp" / "replay.log"
        shutil.copy2(sdir / "scenario.log", log)
        extra = ["-r", "--replay-exit", "-s", meta.get("societe", "01")] + meta.get("args", [])
        cmd = wrap(laurux_cmd(clone, env["LAURUX_TEST_CONF"], log, extra), display, meta.get("date"))
        print("$ " + " ".join(cmd))
        try:
            p = subprocess.run(cmd, cwd=root, env=env, timeout=meta.get("timeout", 300),
                               capture_output=True, text=True)
            rc, console = p.returncode, p.stdout + p.stderr
        except subprocess.TimeoutExpired as e:
            rc, console = 124, (e.stdout or b"").decode(errors="replace") + "\n[délai dépassé]"
        (outdir / "console.txt").write_text(console, encoding="utf-8")
        (outdir / "sql.log").write_text("\n".join(sql_lines(log)) + "\n", encoding="utf-8")
        if journal and Path(str(log) + ".out").exists():  # journal brut (noms de machine, pid) : jamais dans les attendus
            shutil.copy2(Path(str(log) + ".out"), outdir / "journal.out")
    (outdir / "dump.sql").write_text(dump_normalized(), encoding="utf-8")
    (outdir / "exit_code").write_text(f"{rc}\n", encoding="utf-8")
    return rc


def cmd_replay(a):
    if a.expected:
        a.clone, out = "ref", scenario_dir(a.scenario) / "expected"
        shutil.rmtree(out, ignore_errors=True)
    else:
        out = Path(a.out) if a.out else Path(tempfile.mkdtemp(prefix=f"laurux-{a.clone}-"))
    rc = do_replay(a.scenario, a.clone, out, a.display, journal=not a.expected)
    print(f"code de sortie {rc} ; résultats dans {out}")
    sys.exit(0 if rc == 0 else 1)


def diff_files(a_path, b_path, label):
    a_txt = Path(a_path).read_text(encoding="utf-8").splitlines()
    b_txt = Path(b_path).read_text(encoding="utf-8").splitlines()
    d = list(difflib.unified_diff(a_txt, b_txt, f"attendu/{label}", f"obtenu/{label}", lineterm="", n=2))
    return d


def cmd_compare(a):
    sdir = scenario_dir(a.scenario)
    work = Path(tempfile.mkdtemp(prefix="laurux-compare-"))
    if a.live:
        expected = work / "ref"
        if do_replay(a.scenario, "ref", expected, a.display) != 0:
            die(f"le rejeu échoue dans ref (voir {expected}/console.txt)", 1)
    else:
        expected = sdir / "expected"
        if not (expected / "dump.sql").exists():
            die(f"pas d'attendus pour {a.scenario} : lancer « record » ou « compare --live »")
    got = work / "rework"
    rc = do_replay(a.scenario, "rework", got, a.display)
    ok = rc == 0
    for f in ("dump.sql", "sql.log"):
        d = diff_files(expected / f, got / f, f)
        if d:
            ok = False
            print("\n".join(d[:200]) + ("\n[…]" if len(d) > 200 else ""))
    print(f"{a.scenario} : {'IDENTIQUE' if ok else 'DIFFÉRENT'} (rejeu rework : code {rc} ; détails {work})")
    sys.exit(0 if ok else 1)


def cmd_record(a):
    sdir = scenario_dir(a.scenario)
    sdir.mkdir(parents=True, exist_ok=True)
    meta = {"dataset": a.dataset, "date": a.date, "args": ["-p"] if a.pos else [], "societe": a.societe,
            "timeout": a.timeout}
    db_reset(a.dataset)
    with tempfile.TemporaryDirectory(prefix="laurux-record-", ignore_cleanup_errors=True) as tmp:
        home = Path(tmp)
        env = test_env(home)
        env["DISPLAY"] = a.display
        log = home / "tmp" / "record.log"
        cmd = laurux_cmd("ref", env["LAURUX_TEST_CONF"], log, ["-s", a.societe] + meta["args"])
        if a.date:
            cmd = ["faketime", "-f", f"@{a.date}"] + cmd
        print("Jouer le scénario dans la fenêtre Laurux (clone ref), puis quitter l'application.")
        print("$ " + " ".join(cmd))
        subprocess.run(cmd, cwd=REF, env=env)
        gui = [l for l in log.read_text(encoding="utf-8", errors="replace").splitlines() if ";GUI;" in l] \
            if log.exists() else []
    if not gui:
        die("aucun événement GUI journalisé : scénario non enregistré")
    (sdir / "scenario.log").write_text("\n".join(gui) + "\n", encoding="utf-8")
    (sdir / "meta.json").write_text(json.dumps(meta, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"{len(gui)} événements enregistrés dans {sdir} ; production des attendus par rejeu dans ref…")
    rc = do_replay(a.scenario, "ref", sdir / "expected", None if not a.display_replay else a.display, journal=False)
    if rc != 0:
        die(f"le rejeu du scénario échoue dans ref (code {rc}) : voir {sdir}/expected/console.txt", 1)
    print("attendus produits dans " + str(sdir / "expected"))



# ------------------------------------------------------------------------------------- rapport

RESULTS = TESTS / "results.json"
LISTE = TESTS / "list.md"
TODO = REWORK / "reference" / "TODO.md"
TEST_ID_RE = re.compile(r"^T(\d+)_", re.I)


def doc_index():
    """{Classe: chemin du dossier .hidden/reference/<rel>/} pour toutes les sources documentées."""
    idx = {}
    for d in (REWORK / "reference" / ".src").rglob("test.md"):
        idx[d.parent.name.rsplit(".", 1)[0]] = d.parent
    return idx


def doc_tests(docdir):
    """Tests prévus dans test.md : {ID: {"type", "objet"}}, et drapeau « module complexe »."""
    txt = (docdir / "test.md").read_text(encoding="utf-8")
    tests = {}
    for l in txt.splitlines():
        m = re.match(r"^\| ([A-Z0-9_]+-T\d+) \| ([^|]*) \| ([^|]*) \|", l)
        if m:
            tests[m[1]] = {"type": m[2].strip(), "objet": m[3].strip()}
    complexe = bool(re.search(r"(à faire valider|valider par l'utilisateur|module complexe)", txt[:3000], re.I))
    return tests, complexe


def classe_of_module(module):
    return module[:-4] if module.endswith("Test") else module


def gbtest_methods():
    """[(lot, module, méthode)] des modules .test du clone rework."""
    out = []
    for f in sorted(TESTS.glob("*/*.test")):
        for m in re.finditer(r"^\s*Public\s+Sub\s+(\w+)\s*\(", f.read_text(encoding="utf-8"), re.M | re.I):
            if not m[1].startswith("_"):
                out.append((f.parent.name, f.stem, m[1]))
    return out


def parse_tap(txt):
    """Statut d'un test gb.test lancé seul : pass, fail, xfail (assertion TODO en échec), xpass ;
    avec la première comparaison en échec (obtenu, attendu)."""
    status = "pass" if re.search(r"^ok \d+ - ", txt, re.M) else "fail"
    todo_fail = re.search(r"^\s+not ok \d+ .*# TODO", txt, re.M)
    todo_pass = re.search(r"^\s+ok \d+ .*# TODO", txt, re.M)
    if todo_fail:
        status = "xfail"
    elif todo_pass and status == "pass":
        status = "xpass"
    got = exp = ""
    m = re.search(r"-+ Expected -+\n#?\s*(.*?)\n.*?-+ Got -+\n#?\s*(.*?)\n", txt, re.S)
    if m:
        exp, got = m[1].strip(" #"), m[2].strip(" #")
    elif status == "fail":
        m = (re.search(r"crashed with error '([^']*)'", txt) or re.search(r"Bail out! (.*)", txt)
             or re.search(r"^\s+not ok \d+ - (?:[\w.]+: )?(.*)$", txt, re.M))
        got = m[1] if m else "échec (voir console)"
    return status, got, exp


def short(s, n=60):
    s = str(s).replace("|", "\\|").replace("\n", " ")
    return s if len(s) <= n else s[:n - 1] + "…"


def run_gbtest(module, method, timeout, clone="rework", record=False, display=None, date=None):
    """Un test gb.test = un processus (gbx3 -T Module.Méthode) : les valeurs ne dépendent pas de l'ordre des
    tests, ni de l'état statique laissé par un test précédent (ex. auto-instance de LPrix, LPRIX-A01)."""
    with tempfile.TemporaryDirectory(prefix="laurux-gbtest-", ignore_cleanup_errors=True) as tmp:
        env = test_env(Path(tmp), {"LAURUX_TEST_RECORD": "1"} if record else None)
        if display:
            env["DISPLAY"] = display
        cmd = wrap(["gbx3", "-T", f"{module}.{method}"], display, date)
        t0 = __import__("time").time()
        try:
            p = subprocess.run(cmd, cwd=clone_path(clone), env=env, timeout=timeout, capture_output=True, text=True)
            txt = p.stdout + p.stderr
        except subprocess.TimeoutExpired:
            txt = "Bail out! délai dépassé"
        return txt, round(__import__("time").time() - t0, 2)


def cmd_report(a):
    import time
    results = json.loads(RESULTS.read_text(encoding="utf-8")) if RESULTS.exists() else {}
    docs = doc_index()
    if not a.no_run:
        if not a.scenarios_only:
            for lot, module, method in gbtest_methods():
                if a.lot and lot != a.lot:
                    continue
                txt, dur = run_gbtest(module, method, a.timeout)
                status, got, exp = parse_tap(txt)
                classe = classe_of_module(module)
                m = TEST_ID_RE.match(method)
                tid = f"{classe.upper()}-T{int(m[1]):02d}" if m else ""
                results[f"{module}.{method}"] = {"lot": lot, "classe": classe, "id": tid, "type": "gbtest",
                                                 "test": method, "statut": status, "obtenu": got,
                                                 "attendu": exp, "duree": dur}
                print(f"{status:5} {dur:6.2f}s {module}.{method}")
        for meta_p in sorted(TESTS.glob("*/assets/*/meta.json")):
            sdir = meta_p.parent
            lot = sdir.parents[1].name
            if a.lot and lot != a.lot:
                continue
            meta = json.loads(meta_p.read_text(encoding="utf-8"))
            spec = f"{lot}/{sdir.name}"
            if not (sdir / "expected" / "dump.sql").exists():
                continue
            t0 = time.time()
            got_dir = Path(tempfile.mkdtemp(prefix="laurux-report-replay-"))
            rc = do_replay(spec, "rework", got_dir)
            dur = round(time.time() - t0, 2)
            diffs = {f: len([l for l in diff_files(sdir / "expected" / f, got_dir / f, f)
                             if l[:1] in "+-" and not l.startswith(("+++", "---"))])
                     for f in ("dump.sql", "sql.log")}
            ok = rc == 0 and not any(diffs.values())
            status = "pass" if ok else ("xfail" if meta.get("xfail") else "fail")
            classe = meta.get("classe") or (meta.get("id", "").rsplit("-T", 1)[0].title() if meta.get("id") else "")
            results[spec] = {"lot": lot, "classe": meta.get("classe", classe), "id": meta.get("id", ""),
                             "type": "replay", "test": sdir.name, "statut": status,
                             "obtenu": "identique" if ok else
                             f"code {rc}, dump ±{diffs['dump.sql']} l., SQL ±{diffs['sql.log']} l.",
                             "attendu": meta.get("xfail_attendu", "dump et SQL identiques à ref"),
                             "duree": dur, "raison": meta.get("xfail", "")}
            print(f"{status:5} {dur:6.2f}s {spec}")
        RESULTS.write_text(json.dumps(results, indent=1, ensure_ascii=False, sort_keys=True) + "\n",
                           encoding="utf-8")
    write_list(results, docs)
    write_todo(results, docs)


def test_num(r):
    m = re.search(r"-T(\d+)$", r.get("id") or "")
    return int(m[1]) if m else 10 ** 6


def write_list(results, docs):
    rows = sorted(results.values(), key=lambda r: (r["classe"].lower(), test_num(r), r["test"]))
    n = {s: sum(1 for r in rows if r["statut"] == s) for s in ("pass", "fail", "xfail", "xpass")}
    out = ["# Tests implémentés\n",
           "> Généré par `python3 .src/Tests/Framework/runner.py report` (ne pas éditer à la main). "
           "Statuts : pass ; fail (régression ou test cassé) ; xfail (échec attendu : comportement de test.md "
           "non obtenu, à vérifier par l'utilisateur, voir .hidden/reference/TODO.md) ; xpass (échec attendu qui réussit).\n",
           f"**{len(rows)} tests** : {n['pass']} pass, {n['fail']} fail, {n['xfail']} xfail, {n['xpass']} xpass.\n",
           "| Classe | Test | Type | Statut | Obtenu | Attendu | Durée (s) | Description |",
           "|---|---|---|---|---|---|---|---|"]
    for r in rows:
        desc = ""
        d = docs.get(r["classe"])
        if d and r["id"]:
            desc = doc_tests(d)[0].get(r["id"], {}).get("objet", "")
        tid = r["id"] or r["test"]
        out.append(f"| {r['classe']} | {tid} | {r['type']} | {r['statut']} | {short(r['obtenu'])} | "
                   f"{short(r['attendu'])} | {r['duree']} | {short(desc or r['test'], 80)} |")
    LISTE.write_text("\n".join(out) + "\n", encoding="utf-8")
    print(f"{LISTE} : {len(rows)} tests")


def write_todo(results, docs):
    sys.path.insert(0, str(REWORK / "reference" / "tools"))
    from gambas_parse import parse  # noqa: E402
    from kpi import kpi_of  # noqa: E402
    done_ids = {r["id"] for r in results.values() if r["id"]}
    verif = sorted((r for r in results.values() if r["statut"] in ("xfail", "fail", "xpass")),
                   key=lambda r: (r["classe"].lower(), test_num(r)))
    todo = []
    for classe, d in docs.items():
        tests, complexe = doc_tests(d)
        missing = [t for t in tests if t not in done_ids]
        if not missing:
            continue
        rel = d.relative_to(REWORK / "reference")
        src = REWORK / rel
        try:
            k = kpi_of(parse(src, REWORK))
        except Exception:
            k = {"cc_total": 0, "cc_max": 0, "loc": 0}
        score = k["cc_total"] * (2 if complexe else 1) + 5 * len(missing)
        todo.append((score, classe, rel, len(tests), len(missing), k, complexe))
    todo.sort(key=lambda x: -x[0])
    out = ["<!-- AUTO:tests -->",
           "## Phase 2 — tests\n",
           "> Bloc généré par `python3 .src/Tests/Framework/runner.py report` ; liste détaillée des tests implémentés : "
           "[output/tests/list.md](../output/tests/list.md).\n",
           f"### Tests à vérifier à la main ({len(verif)})\n",
           "Tests synthétisés dont le comportement obtenu diffère de celui décrit par test.md (xfail), ou en "
           "échec : à vérifier ou corriger par l'utilisateur.\n",
           "| Test | Statut | Obtenu | Attendu (test.md) | Raison | Description |", "|---|---|---|---|---|---|"]
    for r in verif:
        d = docs.get(r["classe"])
        link = f"[{r['id'] or r['test']}]({d.relative_to(REWORK / 'reference')}/test.md)" if d else (r["id"] or r["test"])
        out.append(f"| {link} | {r['statut']} | {short(r['obtenu'])} | {short(r['attendu'])} | "
                   f"{short(r.get('raison', ''), 50)} | {short(r['test'], 40)} |")
    out += ["", f"### Classes dont des tests restent à implémenter ({len(todo)}), par priorité\n",
            "Priorité = complexité cyclomatique totale (×2 pour un module complexe à scénarios validés par "
            "l'utilisateur) + 5 par test restant.\n",
            "| # | Classe | Tests prévus | Restant | CC totale | CC max | LOC | Complexe | test.md |",
            "|---|---|---|---|---|---|---|---|---|"]
    for i, (score, classe, rel, nt, nm, k, complexe) in enumerate(todo, 1):
        out.append(f"| {i} | {classe} | {nt} | {nm} | {k['cc_total']} | {k['cc_max']} | {k['loc']} | "
                   f"{'oui' if complexe else ''} | [{rel}]({rel}/test.md) |")
    out.append("<!-- /AUTO:tests -->")
    block = "\n".join(out)
    if TODO.exists():
        txt = TODO.read_text(encoding="utf-8")
        if "<!-- AUTO:tests -->" in txt:
            txt = re.sub(r"<!-- AUTO:tests -->.*?<!-- /AUTO:tests -->", lambda _: block, txt, flags=re.S)
        else:
            txt = txt.rstrip() + "\n\n" + block + "\n"
    else:
        txt = ("# TODO du rework\n\n> Phase 2 : tests (bloc généré ci-dessous). Phase 3 : ordre des rework_id "
               "(à venir).\n\n" + block + "\n")
    TODO.write_text(txt, encoding="utf-8")
    print(f"{TODO} : {len(verif)} test(s) à vérifier, {len(todo)} classe(s) à compléter")

# --------------------------------------------------------------------------------------------- main

def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sp = ap.add_subparsers(dest="cmd", required=True)
    p = sp.add_parser("db")
    p.add_argument("action", choices=["up", "down", "status", "reset"])
    p.add_argument("--port", help="port de la base (défaut 13306 ou LAURUX_TEST_DB_PORT)")
    p.add_argument("--dataset")
    p.set_defaults(func=cmd_db)
    p = sp.add_parser("dump")
    p.add_argument("--out")
    p.set_defaults(func=cmd_dump)
    p = sp.add_parser("harness")
    p.add_argument("action", choices=["make", "apply"])
    p.set_defaults(func=cmd_harness)
    p = sp.add_parser("build")
    p.add_argument("--clone", choices=["rework", "ref", "all"], default="all")
    p.set_defaults(func=cmd_build)
    p = sp.add_parser("unit")
    p.add_argument("tests", nargs="?", default="all")
    p.add_argument("--clone", choices=["rework", "ref"], default="rework")
    p.add_argument("--record", action="store_true")
    p.add_argument("--date")
    p.add_argument("--display")
    p.add_argument("--timeout", type=int, default=120)
    p.add_argument("-v", "--verbose", action="store_true", help="affiche la sortie TAP des tests en échec")
    p.set_defaults(func=cmd_unit)
    for name, func in (("replay", cmd_replay), ("compare", cmd_compare)):
        p = sp.add_parser(name)
        p.add_argument("scenario", help="LOT/NOM (ex. Gestion/facture_simple)")
        p.add_argument("--display")
        if name == "replay":
            p.add_argument("--clone", choices=["rework", "ref"], default="rework")
            p.add_argument("--out")
            p.add_argument("--expected", action="store_true",
                           help="écrit les attendus du scénario (rejeu dans ref, sans journal brut)")
        else:
            p.add_argument("--live", action="store_true")
        p.set_defaults(func=func)
    p = sp.add_parser("report", help="exécute les tests et génère output/tests/list.md et .hidden/reference/TODO.md")
    p.add_argument("--lot")
    p.add_argument("--no-run", action="store_true", help="régénère seulement les fichiers depuis results.json")
    p.add_argument("--scenarios-only", action="store_true")
    p.add_argument("--timeout", type=int, default=300)
    p.set_defaults(func=cmd_report)
    p = sp.add_parser("record")
    p.add_argument("scenario")
    p.add_argument("--dataset")
    p.add_argument("--date", help='date fixe du scénario, ex. "2026-01-15 10:00:00"')
    p.add_argument("--pos", action="store_true", help="mode caisse (-p)")
    p.add_argument("--societe", default="01")
    p.add_argument("--display", default=os.environ.get("DISPLAY", ":0"))
    p.add_argument("--display-replay", action="store_true", help="rejeu de contrôle sur le même écran")
    p.add_argument("--timeout", type=int, default=300)
    p.set_defaults(func=cmd_record)
    a = ap.parse_args()
    a.func(a)


if __name__ == "__main__":
    main()
