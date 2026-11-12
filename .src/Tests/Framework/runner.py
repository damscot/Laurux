#!/usr/bin/env python3
"""Runner des tests de non-régression de Laurux (phase 2 du rework, voir .hidden/reference/PLAN.md §4).

Deux clones :
  rework : ce dépôt (Laurux_reworked), code retravaillé ;
  ref    : clone de référence (défaut /home/damscot/Laurux, variable LAURUX_REF), code d'origine
           + harnais de test (harness.patch) + copie de .src/Tests.

Base de test : MariaDB 10.11 Docker (.hidden/Docker/docker-compose.test.yml), 127.0.0.1:13306.

Commandes :
  db up|down|status                 démarrer / arrêter la base de test
  db reset [--dataset LOT/DIR/JEU]  recréer Laurux01 depuis Laurux01.sql (+ jeu des assets d'un test ou <classe>_shared)
  dump [--out FICHIER]              dump normalisé de Laurux01 (sortie standard par défaut)
  harness make                      régénère harness.patch (fichiers de harness_files.txt, rework vs 6b6b9dfc)
  harness apply                     applique harness.patch au clone ref (si absent) et y synchronise .src/Tests
  build [--clone rework|ref|all]    compile (gbc3 -ag) et produit l'archive ~/.cache/laurux-tests/<clone>/Laurux
  SÉLECTION (list, gbtest, replay, compare) : même syntaxe et même logique que « ./Laurux -T » (déléguée à
  « Laurux -T list:<sélection> ») : all, gbtest, replay, lot, classe, ID (CHANGEFOUR-T05), chemin,
  Module[.Méthode], lot/nom, jokers * ? [ ], séparés par des virgules ; défaut * ; un scénario sans
  attendus n'est retenu que s'il est désigné exactement (sauf list et replay --expected)
  list [SÉLECTION]                  liste les tests retenus (colonnes de ./Laurux -T list)
  gbtest [SÉLECTION] [--clone rework|ref] [--record] [--out DIR] [-v]   (alias : unit)
                                    gb.test retenus, un processus par test (gbx3 -T Module.Méthode) ;
                                    --record : enregistre les valeurs attendues dans ref puis les recopie
  record LOT/NOM [--dataset D] [--date "AAAA-MM-JJ hh:mm:ss"] [--pos] [--display :0]
                                    enregistre un scénario GUI joué à la main dans le clone ref
  replay [SÉLECTION] [--clone rework|ref] [--out DIR] [--expected]
                                    rejoue les scénarios retenus (Laurux -T, Xvfb) : dump + SQL exécutés
  compare [SÉLECTION] [--live] [--out DIR]   rejoue sur rework et compare aux attendus (ou à ref avec --live) ; bilan
  report [RUN…] [--out DIR]         rapport SANS exécution : fusionne les results.json des exécutions (défaut :
                                    output/tests/runs/*), écrit output/tests/{results.json,list.md} et le bloc
                                    « tests » de .hidden/reference/TODO.md

  Exécutions : chaque appel à gbtest, replay ou compare écrit son répertoire d'exécution (--out DIR, sinon
  $LAURUX_TEST_RUN, sinon output/tests/runs/<AAAAMMJJ-hhmmss>-<commande>-<pid>/) : results.json réécrit après
  chaque test (statut/obtenu/attendu pour gbtest ; obtenu seul — code de sortie, sorties — pour replay ; verdict
  pour compare). Plusieurs exécutions (lots différents, sous-agents, bacs à sable) se combinent dans un même report.

Un scénario vit dans .hidden/Tests/<LOT>/assets/<NOM>/ :
  scenario.log   lignes « ;GUI; » du journal Laurux (-l), rejouées par -r --replay-exit
  meta.json      {"dataset": "...", "date": "...", "args": [...], "societe": "01", "timeout": 20}
  expected/      dump.sql et sql.log produits par le rejeu dans ref (référence de comparaison)
"""

import argparse
import contextlib
import fcntl
import pwd
import time
import datetime
import difflib
import json
import os
import re
import shutil
import signal
import subprocess
import sys
import tempfile
from pathlib import Path

FRAMEWORK = Path(__file__).resolve().parent
TESTS = FRAMEWORK.parent  # modules gb.test : .src/Tests/<lot>/*.test (compilés avec le projet)
REWORK = TESTS.parents[1]
ASSETS = REWORK / ".hidden" / "Tests"  # données des tests : .hidden/Tests/<lot>/assets/ (hors archive Laurux)
REF = Path(os.environ.get("LAURUX_REF", "/home/damscot/Laurux")).resolve()
DOCKER_DIR = REWORK / ".hidden" / "Docker"
DB_PORT = os.environ.get("LAURUX_TEST_DB_PORT", "13306")
# Un projet compose par port : plusieurs bases de test peuvent tourner en parallèle (un agent par base).
COMPOSE = ["docker", "compose", "-p", f"laurux-test-{DB_PORT}", "-f", str(DOCKER_DIR / "docker-compose.test.yml")]
BASE_COMMIT = "6b6b9dfc"
# Archives exécutables nommées « Laurux » : Application.Name (noms de configuration et de journaux) doit
# être identique dans les deux clones, ce que « gbx3 <répertoire> » ne garantit pas (nom du répertoire).
# Cache propre à chaque copie de travail (bacs à sable parallèles).
CACHE = Path(os.environ.get("LAURUX_TEST_CACHE") or
             (Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "laurux-tests"
              / __import__("hashlib").md5(str(REWORK).encode()).hexdigest()[:8]))
OUT = CACHE / "out"  # résultats de rejeu temporaires : visibles depuis l'hôte (répertoire monté)
# LAURUX_DOCKER=1 : exécution dans le conteneur « runner » (docker-compose.test.yml), HOME, verrou Laurux.lock,
# ~/tmp et base propres à chaque appel (bacs à sable, valeurs attendues). Sans cette variable : exécution directe
# sur l'hôte (User.Home et écran de l'utilisateur).
IN_DOCKER = os.environ.get("LAURUX_IN_DOCKER") == "1"
USE_DOCKER = os.environ.get("LAURUX_DOCKER") == "1"

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


# Erreur non interceptée d'une application Gambas : « Classe.Méthode.ligne: message » (ou « [composant].… ») sur la
# console, puis boîte d'erreur fatale modale que le rejeu ne sait pas fermer.
# Non ancrée en début de ligne : la sortie standard de Laurux est tamponnée, l'erreur (non tamponnée) peut arriver
# collée au milieu d'une ligne (« …Keypress = rImportStk.Button2_Click.56: Out of bounds »).
# Repère « .Méthode.ligne: » (la classe peut être collée à un fragment de ligne précédent).
FATAL_RE = re.compile(rb"\.[A-Za-z_][\w:]*\.\d+: ")
CODE_FATAL = 125


# Délai par défaut d'un test (gb.test ou rejeu) : 20 s. Un délai plus long n'est accepté que s'il a été accordé
# par l'utilisateur : « "timeout": N, "timeout_accord": "<qui, date, raison>" » dans meta.json (sinon ramené à 20 s).
TIMEOUT_DEFAUT = 20


def replay_timeout(meta, spec=""):
    t = int(meta.get("timeout", TIMEOUT_DEFAUT))
    if t > TIMEOUT_DEFAUT and not meta.get("timeout_accord"):
        print(f"runner: {spec} : timeout {t} s sans « timeout_accord » dans meta.json, ramené à {TIMEOUT_DEFAUT} s",
              file=sys.stderr)
        return TIMEOUT_DEFAUT
    return t


@contextlib.contextmanager
def dossier_temp(prefix):
    """Répertoire temporaire (HOME de test) supprimé à la sortie, même si un portail de documents
    (xdg-document-portal, lancé par le bus de session) y a monté run/doc en FUSE : démontage paresseux d'abord."""
    d = tempfile.mkdtemp(prefix=prefix)  # créé ici : seul ce répertoire est supprimé
    try:
        yield d
    finally:
        # garde-fous : répertoire créé ici (nom au préfixe attendu, directement dans le répertoire temporaire du
        # système), pas un lien symbolique, chemin résolu identique, ni « / » ni le HOME réel ni un de ses parents
        reel = os.path.realpath(pwd.getpwuid(os.getuid()).pw_dir)
        resolu = os.path.realpath(d)
        if (os.path.islink(d) or resolu != d or resolu == "/" or resolu == reel or reel.startswith(resolu + "/")
                or os.path.dirname(resolu) != os.path.realpath(tempfile.gettempdir())
                or not os.path.basename(resolu).startswith(prefix)):
            print(f"runner: {d} non supprimé (garde-fou)", file=sys.stderr)
            return
        for outil in ("fusermount3", "fusermount"):
            if shutil.which(outil):
                subprocess.run([outil, "-u", "-z", os.path.join(d, "run", "doc")], stdout=subprocess.DEVNULL,
                               stderr=subprocess.DEVNULL)
                break
        shutil.rmtree(d, ignore_errors=True)


def run_group(cmd, timeout, fatal=False, **kw):
    """Lance cmd dans son propre groupe de processus ; au délai dépassé, tue tout le groupe (xvfb-run, Xvfb, gbr3)
    pour ne laisser aucun Laurux orphelin. Renvoie (code, sortie) ; code 124 si délai dépassé."""
    # « Bail out! » de gb.test : l'erreur ouvre ensuite une boîte modale (application graphique) qui bloquerait
    # jusqu'au délai ; on arrête alors le groupe 2 s après.
    import selectors
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, start_new_session=True, **kw)
    sel = selectors.DefaultSelector()
    sel.register(p.stdout, selectors.EVENT_READ)
    buf, deadline, bailed = b"", time.time() + timeout, None
    while True:
        limit = min(deadline, bailed) if bailed else deadline
        if not sel.select(timeout=max(0, limit - time.time())):
            if p.poll() is not None:
                break
            break  # délai dépassé (global ou après Bail out!)
        chunk = os.read(p.stdout.fileno(), 65536)
        if not chunk:
            break
        buf += chunk
        if bailed is None and (b"Bail out!" in buf or (fatal and FATAL_RE.search(buf))):
            bailed = time.time() + 2
    timed_out = p.poll() is None
    if timed_out:
        for sig in (signal.SIGTERM, signal.SIGKILL):
            try:
                os.killpg(p.pid, sig)
            except ProcessLookupError:
                break
            try:
                p.wait(timeout=5)
                break
            except subprocess.TimeoutExpired:
                pass
    else:
        p.wait()
        try:
            os.killpg(p.pid, signal.SIGKILL)  # descendants restés en arrière-plan (Xvfb, dbus)
        except ProcessLookupError:
            pass
    out = buf.decode(errors="replace")
    if timed_out and not bailed:
        return 124, out + "\n[délai dépassé]"
    if timed_out and fatal:
        return CODE_FATAL, out + "\n[erreur fatale : boîte d'erreur Gambas, rejeu arrêté]"
    return (p.returncode if not timed_out else 1), out


def clone_path(name):
    return {"rework": REWORK, "ref": REF}[name]


# ------------------------------------------------------------------------------------------------ base

def mariadb(args, **kw):
    return run(["mariadb", "-h", DB["host"], "-P", DB["port"], "-u", DB["user"], f"-p{DB['password']}"] + args, **kw)


def serveur_test():
    """"" si le serveur MariaDB de test répond (hôte et port de DB), sinon le message à afficher."""
    import socket
    try:
        socket.create_connection((DB["host"], int(DB["port"])), timeout=3).close()
        return ""
    except OSError:
        return (f"serveur MariaDB de test injoignable sur {DB['host']}:{DB['port']} (LAURUX_TEST_DB_HOST:"
                f"LAURUX_TEST_DB_PORT) : le démarrer avec « python3 .src/Tests/Framework/runner.py db up »")


def cmd_db(a):
    if a.action == "up":
        run(COMPOSE + ["up", "-d", "--build", "--wait"])
        marque_serveur()
    elif a.action == "down":
        run(COMPOSE + ["down"])
    elif a.action == "status":
        run(COMPOSE + ["ps"])
        mariadb(["-e", "select version(), @@sql_mode"])
    elif a.action == "reset":
        db_reset(a.dataset)
        print(f"Laurux01 restaurée{' + ' + a.dataset if a.dataset else ''}")


# Marqueur du serveur de test : compte verrouillé (sans connexion possible), invisible pour Laurux, posé par
# « db up ». Seul un serveur marqué est nettoyé de ses bases autres que Laurux01 (nettoie_bases,
# TestKit.NettoieBases) : un serveur réel désigné par erreur (LAURUX_TEST_DB_PORT=3306) n'est jamais nettoyé.
MARQUEUR = "laurux_serveur_test"
BASES_SYSTEME = ("information_schema", "mysql", "performance_schema", "sys")


def marque_serveur():
    mariadb(["-e", f"CREATE USER IF NOT EXISTS '{MARQUEUR}'@'localhost' ACCOUNT LOCK;"])
    print(f"serveur {DB['host']}:{DB['port']} marqué comme serveur de test ({MARQUEUR})")


def nettoie_bases(garde):
    """Supprime toutes les bases sauf `garde` et les bases système, sur un serveur marqué seulement."""
    rep = mariadb(["-N", "-B", "-e", f"SELECT COUNT(*) FROM mysql.user WHERE User = '{MARQUEUR}'"],
                  capture_output=True, text=True, check=False).stdout.strip()
    if rep != "1":
        print(f"serveur {DB['host']}:{DB['port']} non marqué comme serveur de test (runner.py db up) : bases autres "
              f"que {garde} conservées", file=sys.stderr)
        return
    for base in mariadb(["-N", "-B", "-e", "SHOW DATABASES"], capture_output=True, text=True).stdout.split():
        if base not in BASES_SYSTEME and base != garde:
            mariadb(["-e", f"DROP DATABASE `{base}`"])


def jeu_de_donnees(dataset):
    """Jeu de données d'un test (voir TestKit.JeuDeDonnees) : « <Lot>/<classe>_shared/<jeu>[.sql] » ou
    « <Lot>/<test>/<jeu> » (relatif à .hidden/Tests/<Lot>/assets/), ou chemin d'un fichier."""
    p = Path(dataset)
    if p.is_file():
        return p
    nom = dataset if dataset.endswith(".sql") else dataset + ".sql"
    parts = nom.split("/")
    if len(parts) < 3:
        die(f"jeu de données « {dataset} » : attendu <Lot>/<classe>_shared/<jeu>, <Lot>/<test>/<jeu> ou un chemin")
    return ASSETS / parts[0] / "assets" / "/".join(parts[1:])


def db_reset(dataset=None):
    nettoie_bases(DB["name"])
    mariadb(["-e", f"DROP DATABASE IF EXISTS {DB['name']}; CREATE DATABASE {DB['name']} "
                   "CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"])
    with open(REWORK / "Laurux01.sql", "rb") as f:
        mariadb([DB["name"]], stdin=f)
    if dataset:
        ds = jeu_de_donnees(dataset)
        if not ds.exists():
            die(f"jeu de données introuvable : {ds}")
        with open(ds, "rb") as f:
            mariadb([DB["name"]], stdin=f)


def load_mask():
    """Colonnes volatiles à masquer dans le dump : {"Table": ["colonne", …]} (dump_mask.json)."""
    p = FRAMEWORK / "dump_mask.json"
    return {k: v for k, v in json.loads(p.read_text(encoding="utf-8")).items() if not k.startswith("_")} \
        if p.exists() else {}


def dump_normalized(base=None):
    """Schéma + données de `base` (défaut : base de test), une ligne par enregistrement, tables et lignes triées,
    colonnes volatiles masquées."""
    base = base or DB["name"]
    if base not in mariadb(["-N", "-B", "-e", "SHOW DATABASES"], capture_output=True, text=True).stdout.split():
        return f"-- base {base} absente\n"
    schema = run(["mariadb-dump", "-h", DB["host"], "-P", DB["port"], "-u", DB["user"], f"-p{DB['password']}",
                  "--no-data", "--skip-comments", "--skip-dump-date", "--compact", base],
                 capture_output=True, text=True, check=False).stdout
    schema = re.sub(r" AUTO_INCREMENT=\d+", "", schema)
    out = ["-- schéma", schema.strip(), "-- données"]
    mask = load_mask()
    tables = mariadb(["-N", "-B", "-e", f"SHOW TABLES FROM `{base}`"], capture_output=True, text=True,
                     check=False).stdout.split()
    for t in sorted(tables):
        res = mariadb(["-B", "--raw", base, "-e", f"SELECT * FROM `{t}`"], capture_output=True, text=True).stdout
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
    if ASSETS.is_dir():  # données des tests (.hidden/Tests)
        shutil.copytree(ASSETS, REF / ".hidden" / "Tests", dirs_exist_ok=True)
        print(f".hidden/Tests synchronisé vers {REF / '.hidden' / 'Tests'}")


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
    """Environnement minimal et reproductible : HOME isolé, locale française, configuration de test.
    Dans le conteneur runner, le HOME est /home/laurux (= User.Home de Gambas, tmpfs du conteneur), vidé à chaque
    test : verrou, ~/tmp, ~/.config ne survivent pas d'un test à l'autre."""
    if IN_DOCKER:
        home = Path("/home/laurux")
        # garde-fou : uniquement le HOME tmpfs du conteneur runner (utilisateur « laurux » du passwd généré)
        if pwd.getpwuid(os.getuid()).pw_dir != str(home):
            die("HOME du conteneur inattendu : remise à zéro refusée")
        for x in home.iterdir():
            if x.is_dir() and not x.is_symlink():
                shutil.rmtree(x, ignore_errors=True)
            else:
                x.unlink(missing_ok=True)
    # bin/ en tête du PATH : mysql/mysqldump lancés par Laurux (sans port) visent la base de test.
    env = {"HOME": str(home), "PATH": f"{FRAMEWORK / 'bin'}:/usr/local/bin:/usr/bin:/bin",
           "USER": os.environ.get("USER", "laurux"), "LAURUX_TEST_DB_PORT": DB["port"], "LAURUX_TEST_DB_HOST": DB["host"],
           "XDG_RUNTIME_DIR": str(home / "run"), "LAURUX_TEST_CONF": str(home / ".config/gambas3/Laurux.conf")}
    env.update(LOCALE)
    env["TZ"] = "Europe/Paris"  # dates locales identiques sur toute machine
    env["GTK_USE_PORTAL"] = "0"  # pas de portail de documents monté dans XDG_RUNTIME_DIR
    # Desktop.Open (gb.desktop 3.19) passe par défaut par le portail D-Bus de la session (bus système requis) et
    # ouvrirait le document dans la vraie session. Sans portail, il lance l'application associée au type MIME :
    # desktop_open_env() associe tous les types usuels au faux programme bin/laurux-ouvrir (trace, rien d'ouvert).
    env["GB_DESKTOP_PORTAL_ENABLED"] = "0"
    env.update({"GIO_USE_VFS": "local", "GVFS_DISABLE_FUSE": "1", "QT_NO_XDG_DESKTOP_PORTAL": "1"})
    if not IN_DOCKER:  # hors conteneur : User.Home de Gambas redirigé vers le HOME de test (libhome, LD_PRELOAD)
        lib = libhome()
        if lib:
            env["LAURUX_TEST_HOME"] = str(home)
            env["LAURUX_TEST_USER"] = env["USER"] = "laurux"  # User.Name comme dans le conteneur
            env["LD_PRELOAD"] = lib
    # Pas de carte son sous Xvfb : Music.Load (Start.Main) échouerait sur « Unable to initialize mixer ».
    env["SDL_AUDIODRIVER"] = "dummy"
    for k in ("DISPLAY", "XAUTHORITY"):
        if k in os.environ:
            env[k] = os.environ[k]
    env.update(extra or {})
    (home / "run").mkdir(mode=0o700, parents=True, exist_ok=True)
    desktop_open_env(home)
    (home / "tmp").mkdir(parents=True, exist_ok=True)
    conf = home / ".config" / "gambas3" / "Laurux.conf"
    conf.parent.mkdir(parents=True, exist_ok=True)
    txt = (FRAMEWORK / "Laurux-test.conf").read_text(encoding="utf-8")
    txt = re.sub(r'^Port="\d+"', f'Port="{DB["port"]}"', txt, flags=re.M)
    txt = re.sub(r'^Host="[^"]*"', f'Host="{DB["host"]}"', txt, flags=re.M)
    conf.write_text(txt, encoding="utf-8")
    return env


OUVRIR_MIME = ["application/pdf", "application/postscript", "text/plain", "text/csv", "text/html", "text/xml",
               "application/xml", "image/png", "image/jpeg", "image/gif", "image/svg+xml", "image/tiff",
               "application/vnd.oasis.opendocument.text", "application/vnd.oasis.opendocument.spreadsheet",
               "application/msword", "application/vnd.ms-excel", "application/zip", "application/octet-stream",
               "x-scheme-handler/http", "x-scheme-handler/https", "x-scheme-handler/mailto"]


def desktop_open_env(home):
    """Associe les types MIME usuels au faux programme laurux-ouvrir dans le HOME de test (voir test_env)."""
    apps = home / ".local" / "share" / "applications"
    apps.mkdir(parents=True, exist_ok=True)
    (apps / "laurux-ouvrir.desktop").write_text(
        "[Desktop Entry]\nType=Application\nName=Ouverture (tests Laurux)\nExec=laurux-ouvrir %f\n"
        f"MimeType={';'.join(OUVRIR_MIME)};\nNoDisplay=true\n", encoding="utf-8")
    cfg = home / ".config"
    cfg.mkdir(parents=True, exist_ok=True)
    (cfg / "mimeapps.list").write_text("[Default Applications]\n" + "".join(
        f"{m}=laurux-ouvrir.desktop\n" for m in OUVRIR_MIME), encoding="utf-8")


def libhome():
    """Bibliothèque libhome (Framework/libhome/libhome.c) compilée dans /tmp/laurux-test/ : chargée par LD_PRELOAD,
    elle fait lire à Gambas User.Home = $LAURUX_TEST_HOME (Gambas lit la base des comptes, pas $HOME)."""
    src = FRAMEWORK / "libhome" / "libhome.c"
    lib = Path(f"/tmp/laurux-test/libhome-{os.getuid()}.so")
    if not lib.exists() or lib.stat().st_mtime < src.stat().st_mtime:
        lib.parent.mkdir(parents=True, exist_ok=True)
        if subprocess.run(["gcc", "-shared", "-fPIC", "-O2", "-o", str(lib), str(src), "-ldl"]).returncode != 0:
            print("runner: libhome non compilée (gcc ?) : User.Home reste le HOME réel", file=sys.stderr)
            return ""
    return str(lib)


def wrap(cmd, display=None, date=None):
    """Préfixe xvfb-run (sauf --display) et faketime (si une date est fournie)."""
    if date:
        if not shutil.which("faketime"):
            die("faketime absent : sudo apt install faketime (ou relancer sans date)")
        cmd = ["faketime", "-f", f"@{date}"] + cmd
    if not IN_DOCKER and shutil.which("dbus-run-session"):
        # bus de session privé, arrêté avec le processus (sinon dbus-launch --autolaunch laisse un démon orphelin)
        cmd = ["dbus-run-session", "--"] + cmd
    if not display:
        if not shutil.which("xvfb-run"):
            die("xvfb-run absent : sudo apt install xvfb (ou utiliser --display :0)")
        cmd = ["xvfb-run", "-a", "-s", "-screen 0 1280x1024x24"] + cmd
    return cmd


def selection(spec, non_valides=False):
    """Tests retenus par la sélection spec, avec la même syntaxe et la même logique que « ./Laurux -T » (tout est
    délégué à « Laurux -T list:<spec> ») : liste de dict {type, lot, classe, test, chemin, description, cle}, cle =
    « Module.Méthode » (gbtest) ou « lot/nom » (replay). Comme pour -T, un scénario sans attendus (expected/) n'est
    retenu que s'il est désigné exactement (test, chemin ou lot/nom), sauf non_valides=True."""
    spec = spec or "*"
    with dossier_temp("laurux-liste-") as tmp:
        env = test_env(Path(tmp))
        env["LAURUX_TEST_ROOT"] = str(REWORK)
        rc, txt = run_group(wrap([str(archive("rework")), "-T", "list:" + spec]), TIMEOUT_DEFAUT * 3, cwd=REWORK,
                            env=env)
    exacts = {x.strip().lower() for x in spec.split(",") if not any(c in x for c in "*?[")}
    out = []
    for l in txt.splitlines():
        c = l.split("\t")
        if len(c) < 6 or c[0] not in ("gbtest", "replay"):
            continue
        t = dict(zip(("type", "lot", "classe", "test", "chemin", "description"), c[:6]))
        if t["type"] == "gbtest":
            fic, _, meth = t["chemin"].partition(":")
            t["module"], t["methode"] = Path(fic).stem, meth
            t["cle"] = f"{t['module']}.{meth}"
        else:
            t["cle"] = f"{t['lot']}/{Path(t['chemin']).name}"
            valide = (scenario_dir(t["cle"]) / "expected" / "dump.sql").exists()
            if not (valide or non_valides or {t["test"].lower(), t["chemin"].lower(), t["cle"].lower()} & exacts):
                continue
        out.append(t)
    return out


def select_methods(spec):
    """Méthodes gb.test retenues par la sélection (syntaxe de « ./Laurux -T ») : [(lot, module, méthode)]."""
    return [(t["lot"], t["module"], t["methode"]) for t in selection(spec) if t["type"] == "gbtest"]


class Progression:
    """Barre de progression (sortie d'erreur) : tests passés / total, pourcentage, temps écoulé et estimation du
    temps restant. L'estimation additionne les durées connues des tests restants (results.json, dernier report),
    sinon la durée moyenne observée. Sur un terminal, la barre est redessinée en place ; sinon une ligne est écrite
    tous les 10 % environ."""

    def __init__(self, cles, durees=None):
        self.cles, self.durees = list(cles), durees or {}
        self.total, self.fait, self.t0, self.mesure = len(self.cles), 0, time.time(), 0.0
        self.tty = sys.stderr.isatty() or os.environ.get("LAURUX_TTY") == "1"
        self.palier = max(1, self.total // 10)
        self.dessine()

    @staticmethod
    def hms(sec):
        sec = int(sec)
        return f"{sec // 3600}:{sec % 3600 // 60:02d}:{sec % 60:02d}" if sec >= 3600 else f"{sec // 60}:{sec % 60:02d}"

    def reste(self):
        restants = self.cles[self.fait:]
        moyenne = self.mesure / self.fait if self.fait else None
        connus = [self.durees[c] for c in restants if self.durees.get(c) is not None]
        if moyenne is None and not connus:
            return None
        defaut = moyenne if moyenne is not None else sum(connus) / len(connus)
        return sum(self.durees.get(c, defaut) or defaut for c in restants)

    def texte(self):
        n = 30
        pct = self.fait / self.total if self.total else 1
        plein = int(n * pct)
        r = self.reste()
        return (f"[{'█' * plein}{'░' * (n - plein)}] {self.fait}/{self.total} {int(pct * 100):3d} % │ écoulé "
                f"{self.hms(time.time() - self.t0)} │ reste {'~' + self.hms(r) if r is not None else '?'}")

    def dessine(self):
        if self.tty:
            sys.stderr.write("\r\033[K" + self.texte())
            sys.stderr.flush()

    def ligne(self, txt, duree=None):
        """Affiche une ligne de résultat au-dessus de la barre, puis compte le test."""
        if self.tty:
            sys.stderr.write("\r\033[K")
            sys.stderr.flush()
        print(txt, flush=True)
        self.fait += 1
        if duree is not None:
            self.mesure += duree
        if self.tty:
            self.dessine()
        elif self.fait % self.palier == 0 or self.fait == self.total:
            print("progression " + self.texte(), file=sys.stderr, flush=True)

    def fin(self):
        if self.tty:
            sys.stderr.write("\r\033[K")
            sys.stderr.flush()


RUNS = REWORK / "output" / "tests" / "runs"  # une exécution (gbtest, replay, compare) = un répertoire
VERDICTS = ("pass", "fail", "xfail", "xpass")


class Journal:
    """Résultats d'une exécution : <run>/results.json, réécrit après chaque test (une exécution interrompue garde
    ses résultats). Répertoire : --out DIR, sinon $LAURUX_TEST_RUN, sinon un nouveau
    output/tests/runs/<AAAAMMJJ-hhmmss>-<commande>-<pid>/ (des sous-agents parallèles n'écrivent jamais au même
    endroit)."""

    def __init__(self, commande, dossier=None):
        d = dossier or os.environ.get("LAURUX_TEST_RUN")
        self.dir = Path(d).resolve() if d else RUNS / f"{time.strftime('%Y%m%d-%H%M%S')}-{commande}-{os.getpid()}"
        self.dir.mkdir(parents=True, exist_ok=True)
        self.fic = self.dir / "results.json"
        self.res = json.loads(self.fic.read_text(encoding="utf-8")) if self.fic.exists() else {}
        self.commande = commande

    def ajoute(self, cle, **r):
        r.setdefault("date", time.strftime("%Y-%m-%d %H:%M:%S"))
        r.setdefault("commande", self.commande)
        self.res[cle] = r
        tmp = self.fic.with_suffix(".tmp")
        tmp.write_text(json.dumps(self.res, indent=1, ensure_ascii=False, sort_keys=True) + "\n", encoding="utf-8")
        tmp.replace(self.fic)

    def fin(self):
        print(f"résultats enregistrés dans {self.fic}")


def fusion(sources):
    """Fusionne les results.json (fichiers ou répertoires d'exécution) : pour chaque test, le verdict le plus récent
    (pass/fail/xfail/xpass) ; à défaut, la dernière exécution sans verdict (replay seul)."""
    res = {}
    for src in sources:
        f = Path(src)
        f = f / "results.json" if f.is_dir() else f
        try:
            donnees = json.loads(f.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            print(f"runner: {f} illisible, ignoré", file=sys.stderr)
            continue
        for cle, r in donnees.items():
            r = dict(r, source=str(f.parent))
            avant = res.get(cle)
            if avant is None:
                res[cle] = r
                continue
            va, vr = avant.get("statut") in VERDICTS, r.get("statut") in VERDICTS
            if (vr and not va) or (vr == va and r.get("date", "") >= avant.get("date", "")):
                res[cle] = r
    return res


def runs_existants():
    return sorted(RUNS.glob("*/results.json"), key=lambda f: f.stat().st_mtime)


def durees_connues():
    """{clé de test : durée (s)} des dernières exécutions, pour estimer le temps restant."""
    return {k: v.get("duree") for k, v in fusion(([RESULTS] if RESULTS.exists() else []) + runs_existants()).items()}


def info_gbtest(lot, module, methode):
    classe = classe_of_module(module)
    m = TEST_ID_RE.match(methode)
    return {"lot": lot, "classe": classe, "id": f"{classe.upper()}-T{int(m[1]):02d}" if m else "", "type": "gbtest",
            "test": methode}


def info_scenario(spec):
    meta = json.loads((scenario_dir(spec) / "meta.json").read_text(encoding="utf-8"))
    return meta, {"lot": spec.split("/")[0], "classe": meta.get("classe", ""), "id": meta.get("id", ""),
                  "type": "replay", "test": spec.split("/", 1)[1]}


def cmd_unit(a):
    clone = "ref" if a.record else a.clone
    meths = select_methods(a.tests)
    if not meths:
        die(f"aucun test ne correspond à « {a.tests} »")
    if a.record:  # repartir de zéro pour les modules visés (pas de valeurs périmées)
        for mod in {m[1] for m in meths}:
            lot = next(m[0] for m in meths if m[1] == mod)
            f = REF / ".hidden" / "Tests" / lot / "assets" / mod / "expected.txt"
            tout = {m for _, m2, m in gbtest_methods() if m2 == mod}
            if f.exists() and tout <= {t for _, m2, t in meths if m2 == mod}:  # module entier visé
                f.unlink()
    failed = 0
    journal = None if a.record else Journal("gbtest", a.out)  # --record produit des attendus : pas un résultat
    prog = Progression([f"{m}.{t}" for _, m, t in meths], durees_connues())
    for lot, mod, meth in meths:
        txt, dur = run_gbtest(mod, meth, a.timeout, clone, a.record, a.display, a.date)
        status, got, exp = parse_tap(txt)
        if journal:
            journal.ajoute(f"{mod}.{meth}", **info_gbtest(lot, mod, meth), statut=status, obtenu=got, attendu=exp,
                           duree=dur, clone=clone)
        prog.ligne(f"{status:5} {dur:6.2f}s {mod}.{meth}" + (f"   obtenu={short(got)} attendu={short(exp)}"
                                                              if status == "fail" else ""), dur)
        if status == "fail":
            failed += 1
            if a.verbose:
                print(txt)
    prog.fin()
    if journal:
        journal.fin()
    if a.record:
        n = 0
        for f in (REF / ".hidden" / "Tests").glob("*/assets/*/expected.txt"):
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
    return ASSETS / lot / "assets" / nom


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


@contextlib.contextmanager
def app_lock(max_wait=900):
    """Sérialise les lancements de l'application complète (rejeu, enregistrement) entre tous les bacs à sable.
    Laurux pose son verrou dans User.Home (le vrai home de l'utilisateur, pas le HOME de test) : deux instances
    simultanées, même issues de bacs différents, déclencheraient le Message.Warning « Laurux soit encore ouvert »
    et figeraient le rejeu. On prend donc un verrou commun, puis on attend que ~/<Application>.lock ne désigne
    plus aucun processus vivant (ex. un Laurux ouvert à la main par l'utilisateur)."""
    real_home = Path(pwd.getpwuid(os.getuid()).pw_dir)
    lockdir = real_home / ".cache" / "laurux-tests"
    lockdir.mkdir(parents=True, exist_ok=True)
    with open(lockdir / "app.lock", "w") as fh:
        fcntl.flock(fh, fcntl.LOCK_EX)
        t0 = time.time()
        warned = False
        while True:
            alive = []
            for lf in real_home.glob("Laurux*.lock"):
                try:
                    pids = lf.read_text().split()
                except OSError:
                    continue
                alive += [x for x in pids if x.isdigit() and Path("/proc", x).exists()]
            if not alive:
                break
            if time.time() - t0 > max_wait:
                die(f"verrou Laurux toujours tenu par le(s) pid(s) {' '.join(alive)} : fermer Laurux puis relancer")
            if not warned:
                print(f"attente de la fermeture de Laurux (pid {' '.join(alive)})…", file=sys.stderr)
                warned = True
            time.sleep(2)
        yield


def do_replay(spec, clone, outdir, display=None, journal=True, affiche=True):
    """Rejoue un scénario par « Laurux -T <lot>/<nom> » (Start.Run_Scenario : restauration de la base, jeu de
    données, configuration, fichiers d'entrée, processus Laurux fils sous faketime, sorties brutes) ; le runner
    n'ajoute que Xvfb, le délai et la détection d'erreur fatale, puis produit les sorties comparées : dump
    normalisé de la base, requêtes Exec_SQL, console, code de sortie."""
    meta = json.loads((scenario_dir(spec) / "meta.json").read_text(encoding="utf-8"))
    root = clone_path(clone)
    outdir.mkdir(parents=True, exist_ok=True)
    with dossier_temp("laurux-replay-") as tmp:
        env = test_env(Path(tmp))
        brut = Path(env["HOME"]) / "tmp" / "rejeu"
        env.update({"LAURUX_TEST_ROOT": str(root), "LAURUX_TEST_OUT": str(brut)})
        cmd = wrap([str(archive(clone)), "-T", spec], display)
        if affiche:
            print("$ " + " ".join(cmd))
        with app_lock():
            # délai du rejeu (dans Laurux, commande timeout) + restauration et dump de la base
            # l'erreur fatale (125) et le délai du rejeu (124) sont gérés par -T (Run_Scenario, fils en session
            # propre tué en fin de rejeu) ; ce délai-ci ne couvre qu'un blocage de -T lui-même
            rc, console = run_group(cmd, replay_timeout(meta, spec) + 30, cwd=root, env=env)
        if rc != 124 and (brut / "exit_code").exists():
            rc = int((brut / "exit_code").read_text().strip() or rc)
        (outdir / "console.txt").write_text(console, encoding="utf-8")
        log = brut / "replay.log"
        (outdir / "sql.log").write_text("\n".join(sql_lines(log)) + "\n", encoding="utf-8")
        if journal and Path(str(log) + ".out").exists():  # journal brut (noms de machine, pid) : jamais dans les attendus
            shutil.copy2(Path(str(log) + ".out"), outdir / "journal.out")
        # « fichiers » de meta.json : copiés par Run_Scenario (avant suppression du HOME de test)
        shutil.rmtree(outdir / "fichiers", ignore_errors=True)
        if (brut / "fichiers").is_dir():
            shutil.copytree(brut / "fichiers", outdir / "fichiers")
    # base de test puis « bases » supplémentaires de meta.json, à la suite dans dump.sql
    dump = dump_normalized() + "".join(f"-- base {b}\n" + dump_normalized(b) for b in meta.get("bases", []))
    (outdir / "dump.sql").write_text(dump, encoding="utf-8")
    (outdir / "exit_code").write_text(f"{rc}\n", encoding="utf-8")
    return rc

def scenarios(a):
    """Scénarios retenus par la sélection de la commande (syntaxe de « ./Laurux -T »)."""
    sel = [t["cle"] for t in selection(a.tests, non_valides=getattr(a, "expected", False)) if t["type"] == "replay"]
    if not sel:
        die(f"aucun scénario ne correspond à « {a.tests} »")
    return sel


def cmd_replay(a):
    specs = scenarios(a)
    if a.expected:
        a.clone = "ref"
    journal = None if a.expected else Journal("replay", a.out)  # --expected produit des attendus : pas un résultat
    prog = Progression(specs, durees_connues()) if len(specs) > 1 else None
    echecs = 0
    for spec in specs:
        if a.expected:
            out = scenario_dir(spec) / "expected"
            shutil.rmtree(out, ignore_errors=True)
        else:  # sorties du scénario dans le répertoire d'exécution (--out), à côté de results.json
            out = journal.dir / spec.replace("/", "_")
        t0 = time.time()
        rc = do_replay(spec, a.clone, out, a.display, journal=not a.expected, affiche=prog is None)
        code = expected_code(spec)
        echecs += rc != code
        if journal:  # replay seul : obtenu uniquement (pas de comparaison, voir compare)
            journal.ajoute(spec, **info_scenario(spec)[1], statut="exécuté", obtenu=f"code {rc}", attendu="",
                           duree=round(time.time() - t0, 2), clone=a.clone, sorties=str(out))
        ligne = f"{spec} : code de sortie {rc} (attendu {code}) ; résultats dans {out}"
        prog.ligne(ligne, time.time() - t0) if prog else print(ligne)
    if prog:
        prog.fin()
        print(f"{len(specs) - echecs}/{len(specs)} rejeu(x) au code attendu")
    if journal:
        journal.fin()
    sys.exit(1 if echecs else 0)

# Horodatages : faketime fixe le départ du rejeu, mais l'horloge avance (durée variable du rejeu, ref et rework
# n'ont pas la même vitesse). Ils ne sont pas masqués (un masquage cacherait une régression, ex. 9:59:59.99 contre
# 10:00:00.00, ou un changement de jour à minuit) : chaque horodatage obtenu est comparé à celui de la même position
# dans l'attendu, avec un écart toléré (« tolerance_horodatage » de meta.json, en secondes, défaut 5), et l'ordre des
# événements est vérifié (même ordre des lignes, et pas d'inversion entre deux horodatages successifs que l'attendu
# sépare d'au moins une seconde). Formes reconnues : « AAAA-MM-JJ hh:mm:ss[.f] » et heure seule « hh:mm:ss.f »
# (Now formaté, ex. « dteinv = '2026-01-15 10:00:02.970' »).
TOLERANCE_HORODATAGE = 5.0
HORODATAGE_RE = re.compile(r"\b(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2}):(\d{2})(?:[.,](\d{1,6}))?\b")
HEURE_RE = re.compile(r"(?<![\d:.-])(\d{2}):(\d{2}):(\d{2})[.,](\d{1,6})\b")


# Verrou DocActif (Fiches_Docactif) : process_id (pid) et host_id (nom d'hôte, aléatoire en conteneur) changent à
# chaque exécution ; masqués dans sql.log (le dump les masque via dump_mask.json). machine_id et user_name restent
# comparés.
DOCACTIF_INSERT_RE = re.compile(r"(INSERT INTO Fiches_Docactif\s*\([^)]*\)\s*VALUES\s*\('(?:[^']|'')*',\s*"
                                r"'(?:[^']|'')*',\s*'(?:[^']|'')*',\s*)\d+(,\s*'(?:[^']|'')*',\s*)'(?:[^']|'')*'",
                                re.I)
DOCACTIF_PID_RE = re.compile(r"(UPDATE\s+Fiches_Docactif\s+SET\s+process_id\s*=\s*)\d+", re.I)


# HOME de test dans les fichiers comparés (Laurux.conf…, chemins issus de {home}/{out}) : HOME du fils hors conteneur
# (mktemp, nom aléatoire), HOME du runner hors conteneur (/tmp/laurux-replay-…, qui contient les sorties de -T) et
# HOME fixe du conteneur (/home/laurux) : même texte « <home> » dans les deux modes d'exécution
HOME_TEST_RE = re.compile(r"/tmp/laurux-test/home-[A-Za-z0-9]+|/tmp/laurux-replay-[A-Za-z0-9_]+|/home/laurux(?=/|\b)")
# faux serveur FTP (TestKit.FtpFactice) : port libre, différent à chaque rejeu
FTP_PORT_RE = re.compile(r"ftp://127\.0\.0\.1:\d+")


def normalise(txt):
    txt = HOME_TEST_RE.sub("<home>", txt)
    txt = FTP_PORT_RE.sub("ftp://127.0.0.1:<port>", txt)
    txt = DOCACTIF_INSERT_RE.sub(r"\1<pid>\2'<hôte>'", txt)
    txt = DOCACTIF_PID_RE.sub(r"\1<pid>", txt)
    return txt


def lit_compare(path):
    p = Path(path)
    return p.read_text(encoding="utf-8", errors="replace") if p.is_file() else "<sortie absente>\n"


def horodatages(ligne):
    """Ligne -> (texte où chaque horodatage est remplacé par <horodatage>/<heure>, valeurs en secondes). Une heure seule
    est rapportée au jour (comparée modulo 24 h)."""
    valeurs = []

    def complet(m):
        a, mo, j, h, mi, s, f = m.groups()
        try:
            v = datetime.datetime(int(a), int(mo), int(j), int(h), int(mi), int(s)).timestamp()
        except ValueError:  # date invalide (ex. 0000-00-00 00:00:00) : comparée telle quelle
            return m.group(0)
        valeurs.append(("j", v + (float("0." + f) if f else 0.0)))
        return "<horodatage>"

    def heure(m):
        h, mi, s, f = m.groups()
        valeurs.append(("h", int(h) * 3600 + int(mi) * 60 + int(s) + float("0." + f)))
        return "<heure>"

    ligne = HORODATAGE_RE.sub(complet, ligne)
    ligne = HEURE_RE.sub(heure, ligne)
    return ligne, valeurs


def ecart_horodatage(x, y):
    d = abs(x[1] - y[1])
    return min(d, 86400 - d) if x[0] == "h" else d


def diff_files(a_path, b_path, label, tolerance=TOLERANCE_HORODATAGE):
    """Diff des sorties normalisées (lignes de différence au format unified diff). Les horodatages sont comparés
    avec un écart toléré (`tolerance`, s) et leur ordre vérifié (voir HORODATAGE_RE)."""
    a = [horodatages(l) for l in normalise(lit_compare(a_path)).splitlines()]
    b = [horodatages(l) for l in normalise(lit_compare(b_path)).splitlines()]
    d = list(difflib.unified_diff([x[0] for x in a], [x[0] for x in b], f"attendu/{label}", f"obtenu/{label}",
                                  lineterm="", n=2))
    if d:  # contenu ou ordre des lignes différent
        return d
    ecarts = []
    seq_a, seq_b = [], []
    for n, ((ta, va), (tb, vb)) in enumerate(zip(a, b), 1):
        trop = [ecart_horodatage(x, y) for x, y in zip(va, vb) if ecart_horodatage(x, y) > tolerance]
        if trop:
            ecarts.append(f"@@ {label} ligne {n} : horodatage décalé de {max(trop):.2f} s (tolérance {tolerance} s)")
        seq_a += [(n, x) for x in va if x[0] == "j"]
        seq_b += [(n, x) for x in vb if x[0] == "j"]
        if trop:
            ecarts += ["-" + ligne for ligne in [lit_ligne(a_path, n)]] + ["+" + lit_ligne(b_path, n)]
    # ordre : deux horodatages successifs que l'attendu sépare d'au moins 1 s ne doivent pas être inversés
    for (n1, x1), (n2, x2), (_, y1), (_, y2) in zip(seq_a, seq_a[1:], seq_b, seq_b[1:]):
        da, db = x2[1] - x1[1], y2[1] - y1[1]
        if abs(da) >= 1 and da * db < 0:
            ecarts += [f"@@ {label} lignes {n1}-{n2} : ordre des horodatages inversé",
                       "-" + lit_ligne(a_path, n2), "+" + lit_ligne(b_path, n2)]
    return ecarts


def lit_ligne(path, n):
    lignes = normalise(lit_compare(path)).splitlines()
    return lignes[n - 1] if 0 < n <= len(lignes) else ""


def expected_code(spec):
    """Code de sortie attendu du rejeu : « code_sortie » de meta.json (défaut 0). 125 fige une erreur fatale
    (erreur non interceptée, boîte d'erreur Gambas), 3 un événement non rejouable."""
    return int(json.loads((scenario_dir(spec) / "meta.json").read_text(encoding="utf-8")).get("code_sortie", 0))


def compare_un(spec, a, affiche=True, journal=None):
    """Compare un scénario ; renvoie (identique, résumé) et l'enregistre dans le journal d'exécution (sorties dans
    <répertoire d'exécution>/<lot>_<nom>/)."""
    t0 = time.time()
    sdir = scenario_dir(spec)
    if journal:
        work = journal.dir / spec.replace("/", "_")
        shutil.rmtree(work, ignore_errors=True)
        work.mkdir(parents=True)
    else:
        work = Path(tempfile.mkdtemp(prefix="laurux-compare-", dir=outdir()))
    if a.live:
        expected = work / "ref"
        if do_replay(spec, "ref", expected, a.display, affiche=affiche) != expected_code(spec):
            return False, f"{spec} : le rejeu échoue dans ref (voir {expected}/console.txt)"
    else:
        expected = sdir / "expected"
        if not (expected / "dump.sql").exists():
            return False, f"{spec} : pas d'attendus (lancer « replay {spec} --expected » ou « compare --live »)"
    got = work / "rework"
    rc = do_replay(spec, "rework", got, a.display, affiche=affiche)
    code = expected_code(spec)
    ok = rc == code
    ecarts = {}
    meta = json.loads((sdir / "meta.json").read_text(encoding="utf-8"))
    fichiers = ["fichiers/" + f.lstrip("@") for f in meta.get("fichiers", [])]
    for f in ["dump.sql", "sql.log"] + fichiers:
        d = diff_files(expected / f, got / f, f, float(meta.get("tolerance_horodatage", TOLERANCE_HORODATAGE)))
        ecarts[f] = len([l for l in d if l[:1] in "+-" and not l.startswith(("+++", "---"))])
        if d:
            ok = False
            if affiche:
                print("\n".join(d[:200]) + ("\n[…]" if len(d) > 200 else ""))
    if journal:
        meta, info = info_scenario(spec)
        # xfail : le rejeu fige un comportement qui diffère du test.md ; identique à ref = échec attendu (à vérifier
        # à la main), différent de ref = régression (fail)
        journal.ajoute(spec, **info, statut=("xfail" if meta.get("xfail") else "pass") if ok else "fail",
                       obtenu="identique" if ok else
                       f"code {rc}, dump ±{ecarts['dump.sql']} l., SQL ±{ecarts['sql.log']} l."
                       + (f", fichiers ±{sum(ecarts[f] for f in fichiers)} l." if fichiers else ""),
                       attendu=meta.get("xfail_attendu", "dump et SQL identiques à ref"),
                       duree=round(time.time() - t0, 2), raison=meta.get("xfail", ""),
                       reference="live" if a.live else "expected", sorties=str(work))
    return ok, (f"{spec} : {'IDENTIQUE' if ok else 'DIFFÉRENT'} (rejeu rework : code {rc}, attendu {code} ; "
                f"détails {work})")


def cmd_compare(a):
    specs = scenarios(a)
    journal = Journal("compare", a.out)
    if len(specs) == 1:
        ok, txt = compare_un(specs[0], a, journal=journal)
        print(txt)
        journal.fin()
        sys.exit(0 if ok else 1)
    prog = Progression(specs, durees_connues())
    differents = []
    for spec in specs:
        t0 = time.time()
        ok, txt = compare_un(spec, a, affiche=False, journal=journal)
        if not ok:
            differents.append(spec)
        prog.ligne(txt, time.time() - t0)
    prog.fin()
    print(f"{len(specs) - len(differents)}/{len(specs)} scénario(s) IDENTIQUE(s)"
          + (" ; différents : " + ", ".join(differents) if differents else ""))
    journal.fin()
    sys.exit(1 if differents else 0)


def cmd_list(a):
    """Tests retenus par la sélection (mêmes colonnes que « ./Laurux -T list »)."""
    print("# type\tlot\tclasse\ttest\tchemin\tdescription")
    for t in selection(a.tests, non_valides=True):
        print("\t".join(t[k] for k in ("type", "lot", "classe", "test", "chemin", "description")))

# ------------------------------------------------------------------------------------- cadencement

# Écart laissé APRÈS chaque événement, selon ce qu'il peut déclencher (le rejeu respecte les écarts du journal) :
#   touche d'édition (caractère, BackSpace, Suppr) suivie d'une autre dans le même champ ... CADENCE_FRAPPE
#   Focus, Tab (déplacement, sans traitement) ............................................. CADENCE_FOCUS
#   Click (bouton de traitement, menu, case…), Entrée, Espace (validation), Close,
#   dernière frappe d'une saisie suivie d'un événement sur un autre contrôle (Change, contrôles) CADENCE_TRAITEMENT
#   tout événement suivi d'un changement de fenêtre (ouverture d'écran ou de boîte modale) . CADENCE_FENETRE
# Valeurs par défaut (ms). Chaque scénario porte les siennes dans meta.json (« cadence ») : retime les y écrit au
# premier passage et les relit ensuite ; changer ces valeurs par défaut ne modifie donc pas les scénarios existants.
CADENCE_DEFAUT = {"frappe": 50, "focus": 100, "traitement": 1000, "fenetre": 1000}
TOUCHES_VALIDATION = {"16777220", "16777221", " "}             # Entrée, Entrée du pavé, Espace


def _evenement(ligne):
    champs = ligne.split(";", 8)
    action, _, cible = champs[8].partition("@")
    nom, _, valeur = action.partition("=")
    parties = cible.split("#")
    return champs, nom, valeur, (parties[1] if len(parties) > 1 else ""), parties[0]


def ecart_apres(ev, suivant, c):
    _, nom, valeur, fen, ctrl = ev
    if suivant is not None and suivant[3] != fen:
        return c["fenetre"]  # changement de fenêtre : ouverture/fermeture d'écran ou de boîte
    if nom == "Keypress":
        if valeur in TOUCHES_VALIDATION:
            return c["traitement"]
        if valeur == "16777217":
            return c["focus"]  # Tab : déplacement du focus
        if suivant is not None and suivant[1] == "Keypress" and suivant[4] == ctrl:
            return c["frappe"]  # touche suivante (caractère, BackSpace, Suppr, Entrée, Tab) du même champ
        return c["traitement"]  # fin de saisie : contrôles et Change du champ avant l'événement suivant
    if nom == "Focus":
        return c["focus"]
    return c["traitement"]  # Click, Close, autres


def retime_lines(lignes, cadence=None):
    """Recalcule les horodatages : le premier événement garde le sien (démarrage de Laurux), les suivants sont
    espacés selon ecart_apres(). Renvoie (lignes, durée avant, durée après) en secondes."""
    from datetime import datetime, timedelta
    fmt = "%m/%d/%Y %H:%M:%S.%f"
    c = dict(CADENCE_DEFAUT, **(cadence or {}))
    evs = [_evenement(l) for l in lignes]
    t0 = datetime.strptime(evs[0][0][0], fmt)
    avant = (datetime.strptime(evs[-1][0][0], fmt) - t0).total_seconds()
    t, out = t0, []
    for i, ev in enumerate(evs):
        champs = list(ev[0])
        champs[0] = t.strftime(fmt)[:-3]
        out.append(";".join(champs))
        t += timedelta(milliseconds=ecart_apres(ev, evs[i + 1] if i + 1 < len(evs) else None, c))
    return out, avant, (datetime.strptime(out[-1].split(";")[0], fmt) - t0).total_seconds()


def cmd_retime(a):
    """Applique le cadencement du scénario (« cadence » de son meta.json, complétée par CADENCE_DEFAUT et écrite
    dans meta.json si absente) à son scenario.log ; --set frappe=…,traitement=… modifie d'abord la cadence du
    scénario visé. LOT/NOM ou all."""
    dirs = [scenario_dir(a.scenario)] if a.scenario != "all" else sorted(
        d for d in ASSETS.glob("*/assets/*") if (d / "scenario.log").exists())
    for d in dirs:
        f, fm = d / "scenario.log", d / "meta.json"
        lignes = [l for l in f.read_text(encoding="utf-8").splitlines() if l.strip()]
        if not lignes:
            continue
        meta = json.loads(fm.read_text(encoding="utf-8")) if fm.exists() else {}
        cadence = dict(CADENCE_DEFAUT, **meta.get("cadence", {}))
        for kv in (a.set.split(",") if a.set else []):
            k, _, v = kv.partition("=")
            if k.strip() not in CADENCE_DEFAUT:
                die(f"paramètre de cadence inconnu : {k} (attendus : {', '.join(CADENCE_DEFAUT)})")
            cadence[k.strip()] = int(v)
        out, avant, apres = retime_lines(lignes, cadence)
        print(f"{d.parent.parent.name}/{d.name} : {avant:6.1f} s -> {apres:6.1f} s ({len(lignes)} événements) "
              f"cadence {cadence}")
        if a.dry_run:
            continue
        if out != lignes:
            f.write_text("\n".join(out) + "\n", encoding="utf-8")
        if meta.get("cadence") != cadence and fm.exists():
            meta["cadence"] = cadence
            fm.write_text(json.dumps(meta, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")


def cmd_record(a):
    sdir = scenario_dir(a.scenario)
    sdir.mkdir(parents=True, exist_ok=True)
    meta = {"dataset": a.dataset, "date": a.date, "args": ["-p"] if a.pos else [], "societe": a.societe,
            "timeout": a.timeout}
    db_reset(a.dataset)
    with dossier_temp("laurux-record-") as tmp:
        home = Path(tmp)
        env = test_env(home)
        home = Path(env["HOME"])  # /home/laurux dans le conteneur
        env["DISPLAY"] = a.display
        log = home / "tmp" / "record.log"
        cmd = laurux_cmd("ref", env["LAURUX_TEST_CONF"], log, ["-s", a.societe] + meta["args"])
        if a.date:
            cmd = ["faketime", "-f", f"@{a.date}"] + cmd
        print("Jouer le scénario dans la fenêtre Laurux (clone ref), puis quitter l'application.")
        print("$ " + " ".join(cmd))
        with app_lock():
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

RESULTS = REWORK / "output" / "tests" / "results.json"  # fichiers générés (non versionnés)
LISTE = REWORK / "output" / "tests" / "list.md"
TODO = REWORK / ".hidden" / "reference" / "TODO.md"
TEST_ID_RE = re.compile(r"^T(\d+)(?=[A-Z_])")


def doc_index():
    """{Classe: chemin du dossier .hidden/reference/<rel>/} pour toutes les sources documentées."""
    idx = {}
    for d in (REWORK / ".hidden" / "reference" / ".src").rglob("test.md"):
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
    with dossier_temp("laurux-gbtest-") as tmp:
        env = test_env(Path(tmp), {"LAURUX_TEST_RECORD": "1"} if record else None)
        if display:
            env["DISPLAY"] = display
        cmd = wrap(["gbx3", "-T", f"{module}.{method}"], display, date)
        t0 = __import__("time").time()
        rc, txt = run_group(cmd, timeout, cwd=clone_path(clone), env=env)
        if rc == 124:
            txt += "\nBail out! délai dépassé"
        if os.environ.get("LAURUX_TRACE_HOME") == "1":  # fichiers laissés dans le HOME par le test
            home = Path(env["HOME"])
            prep = {"run", "tmp", ".config/gambas3/Laurux.conf", ".config/mimeapps.list",
                    ".local/share/applications/laurux-ouvrir.desktop"}
            laisses = sorted(str(f.relative_to(home)) for f in home.rglob("*")
                             if (f.is_file() or f.is_symlink()) and str(f.relative_to(home)) not in prep
                             and not str(f.relative_to(home)).startswith(("run/", ".cache/", ".local/share/applications")))
            if laisses:
                print(f"HOME {module}.{method} : {' '.join(laisses[:8])}")
        return txt, round(__import__("time").time() - t0, 2)


def cmd_report(a):
    """Rapport, sans exécuter de test : fusionne les results.json des exécutions indiquées (répertoires ou fichiers ;
    défaut : toutes celles de output/tests/runs/), écrit output/tests/results.json (fusion), output/tests/list.md
    et le bloc « tests » de .hidden/reference/TODO.md."""
    sources = [Path(x) for x in a.runs] if a.runs else runs_existants()
    if not sources:
        die("aucune exécution à rapporter : lancer d'abord « gbtest », « replay » ou « compare » "
            "(résultats dans output/tests/runs/), ou indiquer des répertoires d'exécution")
    results = fusion(sources)
    # tests renommés ou supprimés : retirés
    existants = {f"{m}.{t}" for _, m, t in gbtest_methods()} | \
        {f"{p.parents[2].name}/{p.parent.name}" for p in ASSETS.glob("*/assets/*/meta.json")}
    retires = sorted(k for k in results if k not in existants)
    results = {k: v for k, v in results.items() if k in existants}
    # --out DIR : rapport dans DIR (results.json, list.md), TODO.md inchangé ; sinon output/tests/ et TODO.md
    fic_res, fic_liste = (Path(a.out) / "results.json", Path(a.out) / "list.md") if a.out else (RESULTS, LISTE)
    fic_res.parent.mkdir(parents=True, exist_ok=True)
    fic_res.write_text(json.dumps(results, indent=1, ensure_ascii=False, sort_keys=True) + "\n", encoding="utf-8")
    print(f"{len(sources)} exécution(s) fusionnée(s), {len(results)} test(s)"
          + (f", {len(retires)} retiré(s) (n'existent plus)" if retires else "") + f" : {fic_res}")
    docs = doc_index()
    write_list(results, docs, fic_liste)
    if not a.out:
        write_todo(results, docs)

def test_num(r):
    m = re.search(r"-T(\d+)$", r.get("id") or "")
    return int(m[1]) if m else 10 ** 6


def descriptions_tests():
    """{« Module.Méthode » | « lot/nom » : description}, telles que les affiche « Laurux -T list » (gb.test : _Desc
    du module, TestKit.Desc ; scénario : « objet » de meta.json)."""
    out = {}
    with dossier_temp("laurux-liste-") as tmp:
        env = test_env(Path(tmp))
        env["LAURUX_TEST_ROOT"] = str(REWORK)
        rc, txt = run_group(wrap([str(archive("rework")), "-T", "list"]), TIMEOUT_DEFAUT * 3, cwd=REWORK, env=env)
    for l in txt.splitlines():
        c = l.split("\t")
        if len(c) < 6 or c[0] not in ("gbtest", "replay"):
            continue
        if c[0] == "gbtest":
            fic, _, meth = c[4].partition(":")
            out[Path(fic).stem + "." + meth] = c[5]
        else:  # chemin .hidden/Tests/<lot>/assets/<nom> -> clé <lot>/<nom>
            out[f"{c[1]}/{Path(c[4]).name}"] = c[5]
    return out


def write_list(results, docs, fichier=None):
    rows = sorted(results.values(), key=lambda r: (r["classe"].lower(), test_num(r), r["test"]))
    n = {s: sum(1 for r in rows if r["statut"] == s) for s in ("pass", "fail", "xfail", "xpass", "exécuté")}
    out = ["# Tests implémentés\n",
           "> Généré par `python3 .src/Tests/Framework/runner.py report` (ne pas éditer à la main). "
           "Statuts : pass ; fail (régression ou test cassé) ; xfail (échec attendu : comportement de test.md "
           "non obtenu, à vérifier par l'utilisateur, voir .hidden/reference/TODO.md) ; xpass (échec attendu qui réussit) ; "
           "exécuté (scénario rejoué sans comparaison : `runner.py compare` donne le verdict). Dernier passage : date "
           "et commande de l'exécution retenue (`output/tests/runs/`).\n",
           f"**{len(rows)} tests** : {n['pass']} pass, {n['fail']} fail, {n['xfail']} xfail, {n['xpass']} xpass, "
           f"{n['exécuté']} exécuté(s) sans verdict.\n",
           "| Classe | Test | Type | Statut | Obtenu | Attendu | Durée (s) | Dernier passage | Description |",
           "|---|---|---|---|---|---|---|---|---|"]
    descs = descriptions_tests()
    for cle, r in sorted(results.items(), key=lambda kv: (kv[1]["classe"].lower(), test_num(kv[1]), kv[1]["test"])):
        desc = descs.get(cle, "")
        tid = r["id"] or r["test"]
        out.append(f"| {r['classe']} | {tid} | {r['type']} | {r['statut']} | {short(r['obtenu'])} | "
                   f"{short(r['attendu'])} | {r['duree']} | {r.get('date', '')} {r.get('commande', '')} | "
                   f"{short(desc or r['test'], 80)} |")
    fichier = fichier or LISTE
    fichier.write_text("\n".join(out) + "\n", encoding="utf-8")
    print(f"{fichier} : {len(rows)} tests")


def write_todo(results, docs):
    sys.path.insert(0, str(REWORK / ".hidden" / "reference" / "tools"))
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
        rel = d.relative_to(REWORK / ".hidden" / "reference")
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
           "[output/tests/list.md](../../output/tests/list.md).\n",
           f"### Tests à vérifier à la main ({len(verif)})\n",
           "Tests synthétisés dont le comportement obtenu diffère de celui décrit par test.md (xfail), ou en "
           "échec : à vérifier ou corriger par l'utilisateur.\n",
           "| Test | Statut | Obtenu | Attendu (test.md) | Raison | Description |", "|---|---|---|---|---|---|"]
    for r in verif:
        d = docs.get(r["classe"])
        link = f"[{r['id'] or r['test']}]({d.relative_to(REWORK / '.hidden' / 'reference')}/test.md)" if d else (r["id"] or r["test"])
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

def outdir():
    OUT.mkdir(parents=True, exist_ok=True)
    return OUT


# Commandes exécutées sur l'hôte (Docker, git) ; toutes les autres sont relancées dans le conteneur « runner ».
HOST_ONLY = {("db", "up"), ("db", "down"), ("db", "status"), ("harness", None), ("retime", None)}


def in_container(a, argv):
    """Relance « runner.py argv » dans un conteneur runner jetable du projet compose de ce port. Dépôts, cache et
    répertoires de sortie montés au même chemin ; HOME, /tmp et réseau (base « db ») propres au conteneur."""
    CACHE.mkdir(parents=True, exist_ok=True)
    mounts = {REWORK, REF, CACHE}
    run = os.environ.get("LAURUX_TEST_RUN")
    if run:
        Path(run).resolve().mkdir(parents=True, exist_ok=True)
        mounts.add(Path(run).resolve())
    v = getattr(a, "out", None)
    if v:  # répertoire d'exécution (gbtest, replay, compare) ; fichier pour dump --out
        d = Path(v).resolve()
        d = d.parent if a.cmd == "dump" else d
        d.mkdir(parents=True, exist_ok=True)
        mounts.add(d)
    name = f"laurux-runner-{DB_PORT}-{os.getpid()}"
    cmd = COMPOSE + ["--profile", "runner", "run", "--rm", "--quiet-pull", "--name", name]
    if not sys.stdin.isatty():
        cmd.append("-T")
    for m in sorted(mounts):
        cmd += ["-v", f"{m}:{m}"]
    cmd += ["-e", f"LAURUX_REF={REF}", "-e", f"LAURUX_TEST_CACHE={CACHE}", "-w", str(REWORK)]
    for var in ("LAURUX_TRACE_HOME", "LAURUX_TEST_RUN"):
        if os.environ.get(var):
            cmd += ["-e", f"{var}={os.environ[var]}"]
    if sys.stderr.isatty():  # barre de progression redessinée en place dans le conteneur aussi
        cmd += ["-e", "LAURUX_TTY=1"]
    display = getattr(a, "display", None)
    if display:  # écran réel de l'hôte (record, --display) : socket X11 et cookie montés
        cmd += ["-e", f"DISPLAY={display}", "-v", "/tmp/.X11-unix:/tmp/.X11-unix"]
        xauth = os.environ.get("XAUTHORITY", str(Path.home() / ".Xauthority"))
        if Path(xauth).exists():
            cmd += ["-v", f"{xauth}:/home/laurux/.Xauthority:ro", "-e", "XAUTHORITY=/home/laurux/.Xauthority"]
    cmd += ["runner", "python3", str(FRAMEWORK / "runner.py")] + argv
    # /etc/passwd et /etc/group du conteneur : seul utilisateur « laurux » (UID/GID de l'hôte), HOME /home/laurux.
    uid, gid = os.getuid(), os.getgid()
    (CACHE / "passwd").write_text(f"root:x:0:0:root:/root:/bin/bash\nlaurux:x:{uid}:{gid}:Laurux tests:/home/laurux:"
                                  "/bin/bash\n", encoding="utf-8")
    (CACHE / "group").write_text(f"root:x:0:\nlaurux:x:{gid}:\n", encoding="utf-8")
    env = dict(os.environ, LAURUX_UID=str(uid), LAURUX_GID=str(gid), LAURUX_PASSWD=str(CACHE / "passwd"),
               LAURUX_GROUP=str(CACHE / "group"))
    signal.signal(signal.SIGTERM, lambda *_: sys.exit(143))  # « timeout » : passer quand même par finally
    try:
        rc = subprocess.run(cmd, env=env).returncode
    finally:  # client interrompu (Ctrl-C, timeout) : le conteneur ne doit pas survivre
        subprocess.run(["docker", "rm", "-f", name], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    sys.exit(rc)


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
    p = sp.add_parser("list", help="liste les tests retenus par la sélection (colonnes de ./Laurux -T list)")
    p.add_argument("tests", nargs="?", default="*", help="sélection, même syntaxe que « ./Laurux -T » : all, gbtest, replay, lot, classe, ID (CHANGEFOUR-T05), chemin, Module[.Méthode], lot/nom, avec jokers * ? [ ], séparés par des virgules (défaut : *)")
    p.set_defaults(func=cmd_list)
    p = sp.add_parser("gbtest", aliases=["unit"], help="lance les tests gb.test retenus (un processus par test)")
    p.add_argument("tests", nargs="?", default="*", help="sélection, même syntaxe que « ./Laurux -T » : all, gbtest, replay, lot, classe, ID (CHANGEFOUR-T05), chemin, Module[.Méthode], lot/nom, avec jokers * ? [ ], séparés par des virgules (défaut : *)")
    p.add_argument("--clone", choices=["rework", "ref"], default="rework")
    p.add_argument("--record", action="store_true")
    p.add_argument("--date")
    p.add_argument("--display")
    p.add_argument("--timeout", type=int, default=TIMEOUT_DEFAUT)
    p.add_argument("-v", "--verbose", action="store_true", help="affiche la sortie TAP des tests en échec")
    p.add_argument("--out", help="répertoire d'exécution (results.json) ; défaut : $LAURUX_TEST_RUN, sinon un nouveau "
                   "répertoire de output/tests/runs/")
    p.set_defaults(func=cmd_unit)
    for name, func in (("replay", cmd_replay), ("compare", cmd_compare)):
        p = sp.add_parser(name)
        p.add_argument("tests", nargs="?", default="*", help="sélection, même syntaxe que « ./Laurux -T » : all, gbtest, replay, lot, classe, ID (CHANGEFOUR-T05), chemin, Module[.Méthode], lot/nom, avec jokers * ? [ ], séparés par des virgules (défaut : *) ; seuls les scénarios sont retenus")
        p.add_argument("--display")
        if name == "replay":
            p.add_argument("--clone", choices=["rework", "ref"], default="rework")
            p.add_argument("--expected", action="store_true",
                           help="écrit les attendus du scénario (rejeu dans ref, sans journal brut)")
        else:
            p.add_argument("--live", action="store_true")
        p.add_argument("--out", help="répertoire d'exécution : results.json et sorties de chaque scénario "
                       "(<lot>_<nom>/) ; défaut : $LAURUX_TEST_RUN, sinon un nouveau répertoire de output/tests/runs/")
        p.set_defaults(func=func)
    p = sp.add_parser("report", help="rapport (sans exécution) : fusionne les exécutions, écrit list.md et TODO.md")
    p.add_argument("runs", nargs="*", help="répertoires d'exécution ou results.json à fusionner "
                   "(défaut : tous ceux de output/tests/runs/)")
    p.add_argument("--out", help="répertoire du rapport (results.json fusionné, list.md), .hidden/reference/TODO.md "
                   "inchangé ; défaut : output/tests/ et mise à jour de TODO.md")
    p.set_defaults(func=cmd_report)
    p = sp.add_parser("retime", help="recalcule les horodatages des scenario.log (cadencement standard)")
    p.add_argument("scenario", help="LOT/NOM ou all")
    p.add_argument("-n", "--dry-run", action="store_true", help="affiche les durées sans modifier les fichiers")
    p.add_argument("--set", help="cadence du scénario, ex. traitement=1500,frappe=80 (ms), écrite dans meta.json")
    p.set_defaults(func=cmd_retime)
    p = sp.add_parser("record")
    p.add_argument("scenario")
    p.add_argument("--dataset")
    p.add_argument("--date", help='date fixe du scénario, ex. "2026-01-15 10:00:00"')
    p.add_argument("--pos", action="store_true", help="mode caisse (-p)")
    p.add_argument("--societe", default="01")
    p.add_argument("--display", default=os.environ.get("DISPLAY", ":0"))
    p.add_argument("--display-replay", action="store_true", help="rejeu de contrôle sur le même écran")
    p.add_argument("--timeout", type=int, default=TIMEOUT_DEFAUT)
    p.set_defaults(func=cmd_record)
    a = ap.parse_args()
    key = (a.cmd, getattr(a, "action", None) if a.cmd == "db" else None)
    if USE_DOCKER and not IN_DOCKER and key not in HOST_ONLY:
        in_container(a, sys.argv[1:])  # le service runner dépend du service db (démarré par compose)
    if a.cmd in ("unit", "gbtest", "replay", "compare", "record", "dump") or key == ("db", "reset"):
        msg = serveur_test()
        if msg and a.cmd in ("unit", "gbtest"):  # gb.test : seuls les tests qui ouvrent la base en dépendent
            print(f"runner: avertissement : {msg} ; les tests qui ouvrent la base échoueront", file=sys.stderr)
        elif msg:
            die(msg)
    a.func(a)


if __name__ == "__main__":
    main()
