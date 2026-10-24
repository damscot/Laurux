#!/usr/bin/env python3
"""Pointeurs Markdown des documents de référence vers les lignes des sources.

Deux formes de liens sont reconnues dans les .md de reference/ :

  [LPrix.class:_call](../../../../.src/Utils/LPrix.class#L76-L83)   lien de FONCTION
      → recalculé automatiquement (chemin relatif + plage de lignes de la fonction).
  [LPrix.class:80](../../../../.src/Utils/LPrix.class#L80)          lien de LIGNE
      → chemin recalculé ; la ligne est seulement vérifiée (elle doit exister dans le fichier).
        Elle doit être mise à jour à la main lors d'un rework.

Le texte du lien suffit : la cible peut être écrite vide `()` ou approximative, l'outil la corrige.

Usage :
  links.py [--root DIR] [--check] PREFIXE...
    PREFIXE   préfixe de source (.src/Utils) ou de dossier de référence (reference/.src/Utils)
    --check   n'écrit rien ; code de sortie 1 si un lien est cassé ou à corriger
"""

import argparse
import os
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gambas_parse import iter_sources, parse  # noqa: E402

LINK_RE = re.compile(r"\[(?P<file>[\w.-]+\.(?:class|module)):(?P<anchor>[A-Za-z_]\w*|\d+(?:-\d+)?)\]\((?P<target>[^)]*)\)")


def index(root: Path) -> dict:
    """nom de fichier source (casse exacte, + minuscules si non ambigu) → (chemin, {fonction: (début, fin)}, nb lignes)."""
    idx, low = {}, {}
    for p in iter_sources(root):
        s = parse(p, root)
        idx[p.name] = (p, {f.name.lower(): (f.start, f.end) for f in s.funcs}, len(s.lines))
        low.setdefault(p.name.lower(), []).append(p.name)
    # Repli insensible à la casse, seulement si le nom n'est pas ambigu (Numtostring / numtostring)
    for k, v in low.items():
        if len(v) == 1 and k not in idx:
            idx[k] = idx[v[0]]
    return idx


def fix_text(txt: str, md_dir: Path, idx: dict, problems: list, md: Path) -> str:
    def repl(m):
        key = m["file"] if m["file"] in idx else m["file"].lower()
        if key not in idx:
            problems.append(f"{md}: fichier inconnu « {m['file']} »")
            return m.group(0)
        path, funcs, nlines = idx[key]
        rel = os.path.relpath(path, md_dir)
        a = m["anchor"]
        if a[0].isdigit():
            parts = [int(x) for x in a.split("-")]
            if any(x < 1 or x > nlines for x in parts):
                problems.append(f"{md}: ligne hors fichier « {m.group(0)[:80]} » ({nlines} lignes)")
            frag = "#L" + "-L".join(str(x) for x in parts)
        else:
            if a.lower() not in funcs:
                problems.append(f"{md}: fonction inconnue « {m['file']}:{a} »")
                return m.group(0)
            st, en = funcs[a.lower()]
            frag = f"#L{st}-L{en}"
        return f"[{m['file']}:{a}]({rel}{frag})"
    return LINK_RE.sub(repl, txt)


def run(root: Path, prefixes: list, check: bool) -> int:
    idx = index(root)
    ref = root / "reference"
    mds = []
    for pre in prefixes:
        pre = pre.rstrip("/")
        base = root / pre if pre.startswith("reference") else ref / pre
        if base.is_file():
            mds.append(base)
        elif base.exists():
            mds += sorted(base.rglob("*.md"))
        else:
            mds += sorted(ref.glob(pre.lstrip("/") + "*/**/*.md"))
    problems, changed = [], 0
    for md in mds:
        txt = md.read_text(encoding="utf-8")
        new = fix_text(txt, md.parent, idx, problems, md.relative_to(root))
        if new != txt:
            changed += 1
            if not check:
                md.write_text(new, encoding="utf-8")
    for p in problems:
        print("⚠️ ", p)
    verb = "à corriger" if check else "mis à jour"
    print(f"{len(mds)} document(s) analysé(s), {changed} {verb}, {len(problems)} problème(s)")
    return 1 if (problems or (check and changed)) else 0


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", default=str(Path(__file__).resolve().parents[2]))
    ap.add_argument("--check", action="store_true")
    ap.add_argument("prefixes", nargs="+")
    a = ap.parse_args()
    sys.exit(run(Path(a.root).resolve(), a.prefixes, a.check))


if __name__ == "__main__":
    main()
