#!/usr/bin/env python3
"""Calcul des KPI de rework par fichier source Gambas.

KPI par fichier :
  loc        lignes de code (hors lignes vides et commentaires)
  comments   lignes de commentaire
  funcs      nombre de Sub/Function/Procedure
  pub_funcs  nombre de fonctions Public
  cc_total   somme des complexités cyclomatiques des fonctions
  cc_max     complexité maximale d'une fonction (et son nom)
  globals    variables globales : Public non-Const d'un .module, ou Static Public d'une .class
  pub_vars   variables Public (instance ou statiques)

Usage :
  kpi.py [--root DIR] [--label LABEL] [--json OUT.json] [fichier.class ...]
Sans fichier : tous les sources de <root>/.src.
"""

import argparse
import json
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gambas_parse import is_comment_or_blank, iter_sources, parse  # noqa: E402

KEYS = ["loc", "comments", "funcs", "pub_funcs", "cc_total", "cc_max", "globals", "pub_vars"]


def kpi_of(src) -> dict:
    loc = sum(1 for l in src.lines if not is_comment_or_blank(l))
    comments = sum(1 for l in src.lines if l.strip().startswith("'"))
    vars_ = [d for d in src.decls if d.kind == "var"]
    pub_vars = [d for d in vars_ if d.scope == "Public"]
    if src.is_module:
        glob = pub_vars
    else:
        glob = [d for d in pub_vars if d.static]
    top = max(src.funcs, key=lambda f: f.cc, default=None)
    return {
        "file": src.rel,
        "loc": loc,
        "comments": comments,
        "funcs": len(src.funcs),
        "pub_funcs": sum(1 for f in src.funcs if f.scope == "Public"),
        "cc_total": sum(f.cc for f in src.funcs),
        "cc_max": top.cc if top else 0,
        "cc_max_func": top.name if top else "",
        "globals": len(glob),
        "pub_vars": len(pub_vars),
    }


def git_sha(root: Path) -> str:
    try:
        return subprocess.run(["git", "-C", str(root), "rev-parse", "--short", "HEAD"],
                              capture_output=True, text=True, check=True).stdout.strip()
    except Exception:
        return "?"


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", default=str(Path(__file__).resolve().parents[2]))
    ap.add_argument("--label", default="")
    ap.add_argument("--json", help="fichier JSON de sortie")
    ap.add_argument("files", nargs="*")
    a = ap.parse_args()
    root = Path(a.root).resolve()
    paths = [Path(f).resolve() for f in a.files] if a.files else list(iter_sources(root))
    rows = [kpi_of(parse(p, root)) for p in paths]
    total = {k: sum(r[k] for r in rows) for k in KEYS if k != "cc_max"}
    total["cc_max"] = max((r["cc_max"] for r in rows), default=0)
    total["files"] = len(rows)
    data = {"label": a.label, "sha1": git_sha(root), "total": total, "files": rows}
    if a.json:
        Path(a.json).parent.mkdir(parents=True, exist_ok=True)
        Path(a.json).write_text(json.dumps(data, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    else:
        print("file;" + ";".join(KEYS) + ";cc_max_func")
        for r in rows:
            print(r["file"] + ";" + ";".join(str(r[k]) for k in KEYS) + ";" + r["cc_max_func"])
    print("TOTAL " + " ".join(f"{k}={v}" for k, v in total.items()), file=sys.stderr)


if __name__ == "__main__":
    main()
