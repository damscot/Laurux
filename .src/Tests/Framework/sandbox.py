#!/usr/bin/env python3
"""Bacs à sable pour écrire des tests en parallèle (un sous-agent par bac).

Chaque bac N contient une copie des deux clones (compilation et archives indépendantes) et utilise sa propre
base de test Docker sur le port 13306+N :
  <racine>/sbN/rework   copie de Laurux_reworked
  <racine>/sbN/ref      copie du clone de référence (code d'origine + harnais)
  <racine>/sbN/env.sh   variables à sourcer (LAURUX_REF, LAURUX_TEST_DB_PORT)

Commandes :
  sandbox.py create N        crée (ou recrée) le bac N et démarre sa base
  sandbox.py collect N       recopie dans le dépôt principal les fichiers créés ou modifiés dans le bac
                             (sous .src/Tests/ et .hidden/reference/) depuis sa création
  sandbox.py remove N        arrête la base et supprime le bac
Racine : $LAURUX_SANDBOX_ROOT, défaut ~/.cache/laurux-sandbox.
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

FRAMEWORK = Path(__file__).resolve().parent
REWORK = FRAMEWORK.parents[2]
REF = Path(os.environ.get("LAURUX_REF", "/home/damscot/Laurux")).resolve()
ROOT = Path(os.environ.get("LAURUX_SANDBOX_ROOT", Path.home() / ".cache" / "laurux-sandbox"))
COLLECT = (".src/Tests", ".hidden/Tests", ".hidden/reference", "output/tests/runs")  # runs : résultats des exécutions


def sb(n):
    return ROOT / f"sb{n}"


def port(n):
    return str(13306 + int(n))


def runner(n, *args):
    env = dict(os.environ, LAURUX_REF=str(sb(n) / "ref"), LAURUX_TEST_DB_PORT=port(n), LAURUX_DOCKER="1")
    return subprocess.run([sys.executable, str(sb(n) / "rework/.src/Tests/Framework/runner.py"), *args],
                          env=env, check=True)


def create(n):
    d = sb(n)
    if d.exists():
        remove(n, quiet=True)
    d.mkdir(parents=True)
    for src, name in ((REWORK, "rework"), (REF, "ref")):
        subprocess.run(["cp", "-a", str(src), str(d / name)], check=True)
    (d / "stamp").touch()
    (d / "env.sh").write_text(f"export LAURUX_REF={d / 'ref'}\nexport LAURUX_TEST_DB_PORT={port(n)}\n"
                              "export LAURUX_DOCKER=1\n"
                              f"alias runner='python3 {d / 'rework/.src/Tests/Framework/runner.py'}'\n",
                              encoding="utf-8")
    runner(n, "db", "up")
    runner(n, "harness", "apply")
    runner(n, "build")
    print(f"bac {n} prêt : {d} (base 127.0.0.1:{port(n)}) ; source {d / 'env.sh'}")


def collect(n):
    d = sb(n)
    stamp = (d / "stamp").stat().st_mtime
    copied = []
    for sub in COLLECT:
        for f in (d / "rework" / sub).rglob("*"):
            if f.is_file() and f.stat().st_mtime > stamp and "__pycache__" not in f.parts:
                rel = f.relative_to(d / "rework")
                dst = REWORK / rel
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(f, dst)
                copied.append(str(rel))
    for c in sorted(copied):
        print(c)
    print(f"{len(copied)} fichier(s) recopié(s) depuis le bac {n}")


def remove(n, quiet=False):
    d = sb(n)
    if (d / "rework").exists():
        try:
            runner(n, "db", "down")
        except subprocess.CalledProcessError:
            pass
    shutil.rmtree(d, ignore_errors=True)
    if not quiet:
        print(f"bac {n} supprimé")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("action", choices=["create", "collect", "remove"])
    ap.add_argument("n", type=int)
    a = ap.parse_args()
    {"create": create, "collect": collect, "remove": remove}[a.action](a.n)


if __name__ == "__main__":
    main()
