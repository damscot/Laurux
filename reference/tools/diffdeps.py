#!/usr/bin/env python3
"""Compare deux versions de deps.json et liste les documents de référence à revoir.

Pour chaque fichier source déjà documenté (reference/<rel>/ existe) :
  - appelants (« Utilisé par ») ajoutés ou retirés entre ANCIEN et NOUVEAU ;
  - membres sortis ou entrés dans « portée réductible » ;
  - handlers GUI ajoutés ou retirés ;
  - incohérences des documents rédigés avec le NOUVEAU graphe :
      * membre annoncé « réductible » (architecture.md, case [réduction de portée] de rework.md)
        alors qu'il a un appelant externe ou est un handler GUI ;
      * fichier annoncé « sans appelant » / « code mort » alors que le graphe lui trouve des appelants ;
      * handler nominal inactif (contrôle rattaché à un groupe du .form) non mentionné dans le texte ;
      * appel d'arité incompatible non mentionné ; fonction jamais référencée non citée ;
      * fonction morte par transitivité non citée.

Usage :
  diffdeps.py ANCIEN.json [NOUVEAU.json] [--root DIR] [--md RAPPORT.md] [-p PREFIXE]…
NOUVEAU vaut reference/data/deps.json par défaut.
"""

import argparse
import json
import re
import sys
from pathlib import Path

PORTEE_RE = re.compile(r"`([\w$]+)`[^\n`]{0,60}?\[portée\s*:\s*réductible", re.I)
CASE_RE = re.compile(r"^- \[ \] ([A-Z0-9_]+-\d{3}) — \[([^\]]*)\](.*?)(?=^- \[|^#|\Z)", re.M | re.S)
# Affirmations portant sur le FICHIER entier (et non sur une fonction)
MORT_RE = re.compile(r"((classe|module|fichier)( est)?( entièrement| entier| totalement)? (mort|morte)\b"
                     r"|(classe|module|fichier) (n'est )?(jamais |)(appelée?|utilisée?|référencée?) nulle part"
                     r"|aucun appelant (dans le projet|externe)?\s*[.;:)]|\bcode mort\b[^.\n]{0,20}(entier|complet))", re.I)


def load(p):
    return json.loads(Path(p).read_text(encoding="utf-8"))["files"]


def ext_members(entry):
    res = {}
    for caller, mems in entry["used_by"].items():
        for m in mems:
            if not m.startswith("<"):
                res.setdefault(m.lower(), set()).add(caller)
    return res


def analyse(rel, old, new, root):
    out = []
    o_callers, n_callers = set(old.get("used_by", {})), set(new["used_by"])
    if n_callers - o_callers:
        out.append(("appelants ajoutés", sorted(n_callers - o_callers)))
    if o_callers - n_callers:
        out.append(("appelants retirés", sorted(o_callers - n_callers)))
    o_red, n_red = set(old.get("scope_reducible", [])), set(new["scope_reducible"])
    if o_red - n_red:
        out.append(("plus réductibles", sorted(o_red - n_red)))
    if n_red - o_red:
        out.append(("nouvellement réductibles", sorted(n_red - o_red)))
    o_h, n_h = set(old.get("handlers", [])), set(new["handlers"])
    if n_h ^ o_h:
        out.append(("handlers modifiés", sorted(f"+{h}" for h in n_h - o_h) + sorted(f"-{h}" for h in o_h - n_h)))

    for key, lab in (("handlers_inactifs", "handlers inactifs"), ("tables", "tables"),
                     ("event_groups", "groupes d'événements"), ("dynamic_calls", "lignes d'appels dynamiques")):
        o, n = set(map(str, old.get(key, []))), set(map(str, new.get(key, [])))
        if o != n:
            out.append((f"{lab} modifiés", sorted(f"+{x}" for x in n - o) + sorted(f"-{x}" for x in o - n)))
    o_uses, n_uses = set(old.get("uses", {})), set(new["uses"])
    if o_uses != n_uses:
        out.append(("dépendances sortantes modifiées",
                    sorted(f"+{x}" for x in n_uses - o_uses) + sorted(f"-{x}" for x in o_uses - n_uses)))
    # Handlers inactifs : à mentionner dans les textes rédigés (anomalie ou code mort)
    d0 = root / "reference" / rel
    docs = "".join((d0 / f).read_text(encoding="utf-8") for f in ("architecture.md", "rework.md")
                   if (d0 / f).exists())
    docs = re.sub(r"<!-- AUTO:(\w+) -->.*?<!-- /AUTO:\1 -->", "", docs, flags=re.S)
    missing = [h for h in new.get("handlers_inactifs", []) if h not in docs]
    if missing:
        out.append(("⚠️ handlers inactifs non mentionnés dans le texte", missing))
    # Appels d'arité incompatible : la ligne ou le membre doit être cité dans le texte
    miss_ar = [f"l.{e['line']} {e['cible']}.{e['membre']}" for e in new.get("arity_errors", [])
               if not re.search(rf"(:{e['line']}\b|l\.\s*{e['line']}\b|{re.escape(e['membre'])})", docs, re.I)]
    if miss_ar:
        out.append(("⚠️ appels d'arité incompatible non mentionnés", miss_ar))
    # Fonctions jamais référencées : doivent être signalées (code mort) dans le texte
    miss_un = [u for u in new.get("unused", []) if not re.search(rf"\b{re.escape(u)}\b", docs)]
    if miss_un:
        out.append(("fonctions jamais référencées non citées (code mort probable)", miss_un))
    miss_tr = [u for u in new.get("unused_transitive", []) if not re.search(rf"\b{re.escape(u)}\b", docs)]
    if miss_tr:
        out.append(("fonctions mortes par transitivité non citées", miss_tr))
    # Requêtes aux marqueurs &N incohérents : la ligne doit être citée
    miss_sql = [f"l.{e['line']}" for e in new.get("sql_params", [])
                if not re.search(rf"(:{e['line']}\b|l\.\s*{e['line']}\b)", docs)]
    if miss_sql:
        out.append(("⚠️ requêtes aux marqueurs &N incohérents non citées", miss_sql))
    # Classe jamais référencée : le texte doit l'annoncer morte
    if new.get("jamais_reference"):
        txt = docs + ((d0 / "summary.md").read_text(encoding="utf-8") if (d0 / "summary.md").exists() else "")
        if not re.search(r"\bmort|jamais (ouvert|appel|instanci|référenc)|aucun appelant", txt, re.I):
            out.append(("⚠️ classe jamais référencée non annoncée morte", [rel]))
    # Accès par auto-instance : le membre concerné doit être cité dans le texte
    miss_ai = sorted({e["membre"] for e in new.get("auto_instance", [])
                      if not re.search(rf"(?<![\w$]){re.escape(e['membre'])}\b", docs)})
    if miss_ai:
        out.append(("accès par auto-instance non cités", miss_ai))
    # replay_missing : affiché automatiquement par gendoc (bloc AUTO), pas de contrôle du texte

    # Cohérence des documents rédigés avec le nouveau graphe
    d = root / "reference" / rel
    used = ext_members(new)
    handlers = {h.lower() for h in new["handlers"]}
    arch = (d / "architecture.md").read_text(encoding="utf-8") if (d / "architecture.md").exists() else ""
    rework = (d / "rework.md").read_text(encoding="utf-8") if (d / "rework.md").exists() else ""
    claimed = set(PORTEE_RE.findall(arch))
    for cid, cat, body in CASE_RE.findall(rework):
        if "portée" in cat.lower():
            # seuls les noms placés avant « → `Private` » sont annoncés réductibles
            for seg in re.split(r"[;.]\s", body.split("· sources")[0]):
                if "→" in seg and "Private" in seg.split("→", 1)[1]:
                    # les noms cités entre parenthèses (commentaire) ne sont pas annoncés réductibles
                    head = re.sub(r"\([^()]*\)", "", seg.split("→", 1)[0])
                    claimed |= set(re.findall(r"`([\w$]+)`", head))
    bad = []
    for name in sorted(claimed):
        ln = name.lower()
        if ln in used:
            bad.append(f"{name} (utilisé par {', '.join(Path(c).stem for c in sorted(used[ln])[:4])})")
        elif ln in handlers:
            bad.append(f"{name} (handler GUI)")
    if bad:
        out.append(("⚠️ annoncés réductibles mais utilisés", bad))
    summary = (d / "summary.md").read_text(encoding="utf-8") if (d / "summary.md").exists() else ""
    head = "\n".join(summary.split("\n")[:30])
    if MORT_RE.search(head) and n_callers:
        real = [c for c, m in new["used_by"].items() if any(not k.startswith("<inconnu") for k in m)]
        if real:
            out.append(("⚠️ annoncé mort/sans appelant mais appelants trouvés", sorted(real)))
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("old")
    ap.add_argument("new", nargs="?", default=None)
    ap.add_argument("--root", default=str(Path(__file__).resolve().parents[2]))
    ap.add_argument("--md", default=None, help="écrit le rapport Markdown dans ce fichier")
    ap.add_argument("-p", "--prefix", dest="prefixes", action="append", default=None,
                    help="préfixe de source à analyser (répétable, défaut .src)")
    a = ap.parse_args()
    a.prefixes = a.prefixes or [".src"]
    root = Path(a.root).resolve()
    old = load(a.old)
    new = load(a.new or root / "reference" / "data" / "deps.json")
    lines, n_warn, n_chg = [], 0, 0
    for rel in sorted(new):
        if not any(rel == p or rel.startswith(p.rstrip("/") + "/") for p in a.prefixes):
            continue
        if not (root / "reference" / rel).is_dir():
            continue
        res = analyse(rel, old.get(rel, {}), new[rel], root)
        if not res:
            continue
        warn = any(k.startswith("⚠️") for k, _ in res)
        n_warn += warn
        n_chg += 1
        lines.append(f"\n### {'⚠️ ' if warn else ''}`{rel}`\n")
        for k, v in res:
            lines.append(f"- **{k}** ({len(v)}) : " + ", ".join(f"`{x}`" for x in v[:15]) + (" …" if len(v) > 15 else ""))
    head = [f"# Revue des documents après régénération de deps.json\n",
            f"- Fichiers documentés touchés : {n_chg}",
            f"- Dont à revoir en priorité (⚠️ incohérence texte/graphe) : {n_warn}\n"]
    txt = "\n".join(head + lines) + "\n"
    if a.md:
        Path(a.md).parent.mkdir(parents=True, exist_ok=True)
        Path(a.md).write_text(txt, encoding="utf-8")
        print(f"{n_chg} fichier(s) touché(s), {n_warn} à revoir en priorité → {a.md}")
    else:
        sys.stdout.write(txt)


if __name__ == "__main__":
    main()
