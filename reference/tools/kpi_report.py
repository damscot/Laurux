#!/usr/bin/env python3
"""Génère reference/KPI.md : tableau de bord synthétique des KPI de tout le projet.

Sources :
  - reference/data/kpi_initial.json      KPI de départ (commit 6b6b9dfc), figés ;
  - les sources .src actuelles           KPI courants, recalculés (kpi.kpi_of) ;
  - reference/<rel>/rework.md            cases cochées / à faire (reworks et anomalies) ;
  - reference/<rel>/test.md              statut des tests (à faire, implémenté, vert, bloqué) ;
  - reference/data/coverage.json         (optionnel, phase 2) couverture et durée des tests par fichier :
                                         {"<rel>": {"coverage": 87.5, "duration": 1.23}, ...}

À relancer après chaque rework_id (phase 4), avec la mise à jour de rework.md :
  python3 reference/tools/kpi_report.py            # écrit reference/KPI.md
  python3 reference/tools/kpi_report.py --stdout   # affiche sans écrire
"""

import argparse
import json
import re
import subprocess
import sys
from collections import OrderedDict
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gambas_parse import iter_sources, parse  # noqa: E402
from kpi import kpi_of  # noqa: E402

# Lots dans l'ordre de PLAN.md : (libellé, prédicat sur le chemin relatif)
GESTION_1 = ("Facturation", "Tables", "Reglements", "Entrées", "Depots")
LOTS = [
    ("Utils", lambda r: r.startswith(".src/Utils/")),
    ("Communs", lambda r: r.startswith(".src/Communs/")),
    ("Start / Serveur", lambda r: r in (".src/Start.module", ".src/Serveur.module")),
    ("Compta", lambda r: r.startswith(".src/Compta/")),
    ("Gestion (sous-lot 1)", lambda r: r.startswith(".src/Gestion/") and (
        r.count("/") == 2 or r.split("/")[2] in GESTION_1)),
    ("Gestion (sous-lot 2)", lambda r: r.startswith(".src/Gestion/")),
    ("Caisse", lambda r: r.startswith(".src/Caisse/")),
    ("Statistiques", lambda r: r.startswith(".src/Statistiques/")),
    ("Affichages", lambda r: r.startswith(".src/Affichages/")),
    ("Archivages", lambda r: r.startswith(".src/Archivages/")),
    ("Reports", lambda r: r.startswith(".src/Reports/")),
    ("Tests", lambda r: r.startswith(".src/Tests/")),
    ("Autres", lambda r: True),
]
CASE_RE = re.compile(r"^- \[( |x|X)\] [A-Z0-9_]+-(A?)\d+\b", re.M)
TEST_ROW_RE = re.compile(r"^\| [A-Z0-9_]+-T\d+ \|.*\| ([^|]+?) \|\s*$", re.M)
SUM_KEYS = ["loc", "comments", "funcs", "pub_funcs", "cc_total", "globals", "pub_vars"]


def lot_of(rel):
    for name, pred in LOTS:
        if pred(rel):
            return name
    return "Autres"


def doc_counts(root, rel):
    """Avancement lu dans les documents : reworks, anomalies, tests par statut."""
    d = root / "reference" / rel
    c = {"rw_done": 0, "rw_tot": 0, "an_done": 0, "an_tot": 0, "t_tot": 0, "t_vert": 0, "t_impl": 0, "t_bloque": 0}
    if (d / "rework.md").exists():
        for done, ano in CASE_RE.findall((d / "rework.md").read_text(encoding="utf-8")):
            k = "an" if ano else "rw"
            c[k + "_tot"] += 1
            c[k + "_done"] += done.lower() == "x"
    if (d / "test.md").exists():
        for st in TEST_ROW_RE.findall((d / "test.md").read_text(encoding="utf-8")):
            st = st.strip().lower()
            c["t_tot"] += 1
            c["t_vert"] += st.startswith("vert")
            c["t_impl"] += st.startswith("implément")
            c["t_bloque"] += st.startswith("bloqu")
    return c


def fmt(n):
    return f"{n:,}".replace(",", " ")


def evol(a, b):
    """« a → b (Δ) » ; une seule valeur si inchangé."""
    if a == b:
        return fmt(b)
    d = b - a
    return f"{fmt(a)} → {fmt(b)} ({'+' if d > 0 else ''}{fmt(d)})"


def pct(a, b):
    return f"{100 * a / b:.0f} %" if b else "–"


def git_sha(root):
    try:
        return subprocess.run(["git", "-C", str(root), "rev-parse", "--short", "HEAD"],
                              capture_output=True, text=True, check=True).stdout.strip()
    except Exception:
        return "?"


def build(root):
    init = json.loads((root / "reference/data/kpi_initial.json").read_text(encoding="utf-8"))
    init_by = {r["file"]: r for r in init["files"]}
    cov_p = root / "reference/data/coverage.json"
    cov = json.loads(cov_p.read_text(encoding="utf-8")) if cov_p.exists() else {}
    rows = []
    for p in iter_sources(root):
        cur = kpi_of(parse(p, root))
        rel = cur["file"]
        ini = init_by.get(rel, {k: 0 for k in cur} | {"file": rel, "cc_max_func": ""})
        rows.append({"rel": rel, "lot": lot_of(rel), "ini": ini, "cur": cur,
                     "doc": doc_counts(root, rel), "cov": cov.get(rel, {})})
    # fichiers supprimés pendant le rework (présents au départ, absents aujourd'hui)
    gone = [r for r in init["files"] if r["file"] not in {x["rel"] for x in rows}]
    return init, rows, gone, bool(cov)


def agg(rows, side):
    t = {k: sum(r[side].get(k, 0) for r in rows) for k in SUM_KEYS}
    t["cc_max"] = max((r[side].get("cc_max", 0) for r in rows), default=0)
    return t


def agg_doc(rows):
    t = {}
    for r in rows:
        for k, v in r["doc"].items():
            t[k] = t.get(k, 0) + v
    return t


def cov_cell(rows):
    vals = [r["cov"]["coverage"] for r in rows if "coverage" in r["cov"]]
    return f"{sum(vals) / len(vals):.0f} %" if vals else "n/a"


def dur_cell(rows):
    vals = [r["cov"]["duration"] for r in rows if "duration" in r["cov"]]
    return f"{sum(vals):.1f} s" if vals else "n/a"


def render(root, init, rows, gone, has_cov):
    out = []
    w = out.append
    sha = git_sha(root)
    ti, tc = agg(rows + [{"ini": g, "cur": {}} for g in gone], "ini"), agg(rows, "cur")
    td = agg_doc(rows)
    w("# KPI du projet Laurux — tableau de bord du rework\n")
    w(f"> Généré par `reference/tools/kpi_report.py` le {date.today().isoformat()} au commit `{sha}`. "
      f"Référence initiale : `{init.get('sha1', '?')}` (`reference/data/kpi_initial.json`).")
    w("> **Ne pas éditer à la main** : relancer `python3 reference/tools/kpi_report.py` après chaque "
      "rework_id (phase 4), dans le même commit que le code et le `rework.md` coché.\n")
    w("Définitions des KPI : [tools/README.md](tools/README.md). LOC = lignes non vides hors commentaires ; "
      "CC = complexité cyclomatique ; globales = `Public` non-`Const` d'un `.module` ou `Static Public` d'une "
      "classe. Couverture (`gbx3 -t`) et durée des tests (`gbx3 -p`) : alimentées en phase 2 par "
      "`reference/data/coverage.json`" + ("." if has_cov else " (absent : n/a).") + "\n")

    w("## Avancement\n")
    w("| Élément | Fait | Total | % |\n|---|---|---|---|")
    w(f"| Fichiers source documentés | {sum(1 for r in rows if (root / 'reference' / r['rel'] / 'summary.md').exists())} "
      f"| {len(rows)} | {pct(sum(1 for r in rows if (root / 'reference' / r['rel'] / 'summary.md').exists()), len(rows))} |")
    w(f"| Étapes de rework (`<ID>-NNN`) | {td['rw_done']} | {td['rw_tot']} | {pct(td['rw_done'], td['rw_tot'])} |")
    w(f"| Anomalies traitées (`<ID>-Annn`, validation utilisateur) | {td['an_done']} | {td['an_tot']} | "
      f"{pct(td['an_done'], td['an_tot'])} |")
    w(f"| Tests au vert | {td['t_vert']} | {td['t_tot']} | {pct(td['t_vert'], td['t_tot'])} |")
    w(f"| Tests implémentés (pas encore verts) | {td['t_impl']} | {td['t_tot']} | {pct(td['t_impl'], td['t_tot'])} |")
    w(f"| Tests bloqués | {td['t_bloque']} | {td['t_tot']} | {pct(td['t_bloque'], td['t_tot'])} |")
    if gone:
        w(f"| Fichiers source supprimés depuis l'état initial | {len(gone)} | {len(init['files'])} | – |")
    w("")

    w("## KPI globaux\n")
    w("| KPI | Initial | Actuel | Évolution |\n|---|---|---|---|")
    labels = [("loc", "Lignes de code (hors commentaires)"), ("comments", "Lignes de commentaire"),
              ("funcs", "Fonctions"), ("pub_funcs", "Fonctions Public"), ("cc_total", "Complexité cyclomatique totale"),
              ("cc_max", "Complexité max (fonction)"), ("globals", "Variables globales"), ("pub_vars", "Variables Public")]
    for k, lab in labels:
        d = tc[k] - ti[k]
        w(f"| {lab} | {fmt(ti[k])} | {fmt(tc[k])} | {('+' if d > 0 else '') + fmt(d) if d else '='}"
          f"{f' ({100 * d / ti[k]:+.1f} %)' if d and ti[k] else ''} |")
    w(f"| Fichiers source | {fmt(len(init['files']))} | {fmt(len(rows))} | "
      f"{('+' if len(rows) > len(init['files']) else '') + fmt(len(rows) - len(init['files'])) if len(rows) != len(init['files']) else '='} |")
    w(f"| Couverture des tests (`gbx3 -t`, moyenne) | n/a | {cov_cell(rows)} | |")
    w(f"| Durée des tests (`gbx3 -p`, somme) | n/a | {dur_cell(rows)} | |\n")

    w("## Par lot\n")
    w("Valeurs « initial → actuel (Δ) » ; une seule valeur si inchangée.\n")
    w("| Lot | Fichiers | LOC | CC totale | CC max | Globales | Fonc. Public | Reworks | Anomalies | Tests verts | Couverture |")
    w("|---|---|---|---|---|---|---|---|---|---|---|")
    lots = OrderedDict((name, []) for name, _ in LOTS)
    for r in rows:
        lots[r["lot"]].append(r)
    for name, lr in lots.items():
        if not lr:
            continue
        a, b, dd = agg(lr, "ini"), agg(lr, "cur"), agg_doc(lr)
        w(f"| {name} | {len(lr)} | {evol(a['loc'], b['loc'])} | {evol(a['cc_total'], b['cc_total'])} | "
          f"{evol(a['cc_max'], b['cc_max'])} | {evol(a['globals'], b['globals'])} | "
          f"{evol(a['pub_funcs'], b['pub_funcs'])} | {dd['rw_done']}/{dd['rw_tot']} | {dd['an_done']}/{dd['an_tot']} | "
          f"{dd['t_vert']}/{dd['t_tot']} | {cov_cell(lr)} |")
    w(f"| **Total** | **{len(rows)}** | **{evol(ti['loc'], tc['loc'])}** | **{evol(ti['cc_total'], tc['cc_total'])}** | "
      f"**{evol(ti['cc_max'], tc['cc_max'])}** | **{evol(ti['globals'], tc['globals'])}** | "
      f"**{evol(ti['pub_funcs'], tc['pub_funcs'])}** | **{td['rw_done']}/{td['rw_tot']}** | "
      f"**{td['an_done']}/{td['an_tot']}** | **{td['t_vert']}/{td['t_tot']}** | **{cov_cell(rows)}** |\n")

    w("## Points chauds\n")
    w("Les 20 fonctions les plus complexes (CC max par fichier), à surveiller pendant le rework.\n")
    w("| Fichier | Fonction | CC initiale | CC actuelle | LOC du fichier | Reworks |\n|---|---|---|---|---|---|")
    for r in sorted(rows, key=lambda r: -r["cur"]["cc_max"])[:20]:
        link = f"[{r['rel'][5:]}]({r['rel']}/rework.md)"
        w(f"| {link} | `{r['cur']['cc_max_func']}` | {r['ini'].get('cc_max', 0)} | {r['cur']['cc_max']} | "
          f"{fmt(r['cur']['loc'])} | {r['doc']['rw_done']}/{r['doc']['rw_tot']} |")
    w("")

    w("## Détail par fichier\n")
    w("Un tableau par lot (déplier). Colonnes : LOC, CC totale, CC max, globales et fonctions `Public` "
      "(initial → actuel), avancement des reworks et anomalies, tests verts / total, couverture, durée.\n")
    for name, lr in lots.items():
        if not lr:
            continue
        w(f"<details><summary><b>{name}</b> — {len(lr)} fichiers</summary>\n")
        w("| Fichier | LOC | CC tot. | CC max | Glob. | Fonc. Public | Reworks | Anomalies | Tests | Couv. | Durée |")
        w("|---|---|---|---|---|---|---|---|---|---|---|")
        for r in sorted(lr, key=lambda x: x["rel"]):
            i, c, d, cv = r["ini"], r["cur"], r["doc"], r["cov"]
            w(f"| [{r['rel'][5:]}]({r['rel']}/rework.md) | {evol(i.get('loc', 0), c['loc'])} | "
              f"{evol(i.get('cc_total', 0), c['cc_total'])} | {evol(i.get('cc_max', 0), c['cc_max'])} | "
              f"{evol(i.get('globals', 0), c['globals'])} | {evol(i.get('pub_funcs', 0), c['pub_funcs'])} | "
              f"{d['rw_done']}/{d['rw_tot']} | {d['an_done']}/{d['an_tot']} | {d['t_vert']}/{d['t_tot']} | "
              f"{str(cv['coverage']) + ' %' if 'coverage' in cv else 'n/a'} | "
              f"{str(cv['duration']) + ' s' if 'duration' in cv else 'n/a'} |")
        w("\n</details>\n")
    if gone:
        w("## Fichiers supprimés\n")
        w("| Fichier | LOC initiale | CC initiale |\n|---|---|---|")
        for g in gone:
            w(f"| `{g['file']}` | {fmt(g['loc'])} | {fmt(g['cc_total'])} |")
        w("")
    return "\n".join(out)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", default=str(Path(__file__).resolve().parents[2]))
    ap.add_argument("--out", default=None, help="fichier de sortie (défaut : reference/KPI.md)")
    ap.add_argument("--stdout", action="store_true", help="affiche le résultat sans écrire de fichier")
    a = ap.parse_args()
    root = Path(a.root).resolve()
    txt = render(root, *build(root))
    if a.stdout:
        sys.stdout.write(txt)
        return
    out = Path(a.out) if a.out else root / "reference" / "KPI.md"
    out.write_text(txt, encoding="utf-8")
    print(f"{out} écrit")


if __name__ == "__main__":
    main()
