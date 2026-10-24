#!/usr/bin/env python3
"""Génère ou rafraîchit les documents de référence d'un ou plusieurs fichiers sources.

Pour chaque source <rel> (ex. .src/Utils/LPrix.class), crée reference/<rel>/ avec :
  summary.md, architecture.md, dependencies.md, test.md, rework.md

Les blocs délimités par <!-- AUTO:nom --> … <!-- /AUTO:nom --> sont (re)générés
à partir des sources ; le reste du document (rédigé) n'est jamais écrasé.
Les fichiers absents sont créés à partir d'un gabarit.

Usage :
  gendoc.py [--root DIR] [--history LABEL] [--commit SHA] PREFIXE...
    PREFIXE   préfixe de chemin relatif (ex. .src/Utils, .src/Start.module)
    --history ajoute (ou remplace) une ligne LABEL dans l'historique KPI de rework.md
Les pointeurs vers les sources sont ensuite recalculés (voir links.py).
"""

import argparse
import re
import subprocess
import sys
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from deps import SPECIAL, build  # noqa: E402
from gambas_parse import iter_sources, parse  # noqa: E402
from kpi import kpi_of  # noqa: E402
import links  # noqa: E402

AUTO_RE = r"<!-- AUTO:{0} -->.*?<!-- /AUTO:{0} -->"
KPI_COLS = [("loc", "Lignes de code (hors commentaires)"), ("comments", "Lignes de commentaire"),
            ("funcs", "Fonctions"), ("pub_funcs", "Fonctions Public"),
            ("cc_total", "Complexité cyclomatique totale"), ("cc_max", "Complexité max (fonction)"),
            ("globals", "Variables globales"), ("pub_vars", "Variables Public")]
HIST_HEAD = ("| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |\n"
             "|---|---|---|---|---|---|---|---|---|---|")


def block(name: str, body: str) -> str:
    return f"<!-- AUTO:{name} -->\n{body.rstrip()}\n<!-- /AUTO:{name} -->"


def put_blocks(path: Path, template: str, blocks: dict):
    """Crée le fichier depuis le gabarit, ou remplace uniquement les blocs AUTO existants."""
    txt = path.read_text(encoding="utf-8") if path.exists() else template
    for name, body in blocks.items():
        new = block(name, body)
        pat = re.compile(AUTO_RE.format(re.escape(name)), re.S)
        if pat.search(txt):
            txt = pat.sub(lambda _: new, txt)
        else:
            txt = txt.replace("{{" + name + "}}", new)
    path.write_text(txt, encoding="utf-8")


def md_lines(rel_src: str, lines) -> str:
    lines = [l for l in lines if l]
    if not lines:
        return ""
    shown = ", ".join(f"[{l}]({'../' * (rel_src.count('/') + 2)}{rel_src}#L{l})" for l in lines[:8])
    return shown + (f" … (+{len(lines) - 8})" if len(lines) > 8 else "")


def kpi_block(k: dict) -> str:
    rows = ["| KPI | Valeur |", "|---|---|"]
    for key, lab in KPI_COLS:
        v = k[key]
        if key == "cc_max" and k["cc_max_func"]:
            v = f"{v} (`{k['cc_max_func']}`)"
        rows.append(f"| {lab} | {v} |")
    rows.append("| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |")
    rows.append("| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |")
    return "\n".join(rows)


def hist_row(label, sha, k):
    return (f"| {label} | `{sha}` | {date.today().isoformat()} | {k['loc']} | {k['cc_total']} | {k['cc_max']} "
            f"| {k['globals']} | {k['pub_funcs']} | n/a | n/a |")


def update_history(path: Path, label: str, sha: str, k: dict):
    txt = path.read_text(encoding="utf-8")
    pat = re.compile(AUTO_RE.format("historique"), re.S)
    m = pat.search(txt)
    rows = []
    if m:
        rows = [l for l in m.group(0).split("\n")[3:-1] if l.startswith("|") and not l.startswith(f"| {label} |")]
    rows.append(hist_row(label, sha, k))
    txt = pat.sub(lambda _: block("historique", HIST_HEAD + "\n" + "\n".join(rows)), txt)
    path.write_text(txt, encoding="utf-8")


def decl_block(src) -> str:
    if not src.decls:
        return "_Aucune déclaration de niveau classe/module._"
    rows = ["| Nom | Nature | Portée | Static | Type | Ligne |", "|---|---|---|---|---|---|"]
    for d in src.decls:
        rows.append(f"| `{d.name}` | {d.kind} | {d.scope} | {'oui' if d.static else ''} | {d.type} | {d.line} |")
    return "\n".join(rows)


def func_block(src, dep) -> str:
    if not src.funcs:
        return "_Aucune fonction._"
    ext = {}
    for caller, mems in dep["used_by"].items():
        for m in mems:
            ext.setdefault(m.lower(), set()).add(caller)
    rows = ["| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |", "|---|---|---|---|---|---|---|"]
    for f in src.funcs:
        rem = []
        if f.name in dep["handlers"]:
            rem.append("handler GUI")
        if f.name.lower() in SPECIAL:
            rem.append("méthode spéciale")
        if f.name in dep["scope_reducible"]:
            rem.append("portée réductible ?")
        rows.append(f"| `{f.name}` | {f.start}-{f.end} | {f.scope}{' Static' if f.static and not src.is_module else ''} "
                    f"| {f.cc} | {f.loc} | {len(ext.get(f.name.lower(), ()))} | {', '.join(rem)} |")
    return "\n".join(rows)


def deps_block(src, dep, rel_src) -> str:
    out = []
    out.append(f"- Fichier : `{rel_src}` — {'module' if src.is_module else 'classe'}"
               f"{', Create Static' if dep['create_static'] else ''}"
               f"{', hérite de `' + dep['inherits'] + '`' if dep['inherits'] else ''}"
               f"{', formulaire associé `' + dep.get('ui', Path(rel_src).with_suffix('.form').name) + '`' if dep['form'] else ''}")
    out.append(f"- Handlers GUI détectés : {len(dep['handlers'])}")
    if dep.get("handlers_inactifs"):
        out.append("- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : "
                   + ", ".join(f"`{h}`" for h in dep["handlers_inactifs"]))
    if dep.get("arity_errors"):
        out.append("- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : " + ", ".join(
            f"l. {e['line']} `{e['cible']}.{e['membre']}` ({e['donnés']} donnés, attendus "
            f"{e['min']}{'' if e['max'] == e['min'] else '-' + (str(e['max']) if e['max'] is not None else '…')})"
            for e in dep["arity_errors"]))
    if dep.get("unused"):
        out.append("- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : "
                   + ", ".join(f"`{u}`" for u in dep["unused"]))
    if dep.get("replay_dynamic"):
        out.append("- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : "
                   + ", ".join(f"`{h}`" for h in dep["replay_dynamic"]))
    if dep.get("jamais_reference"):
        out.append("- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable"
                   " ; la suppression d'un couple .class + .form est une anomalie à valider")
    if dep.get("sql_params"):
        out.append("- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : " + ", ".join(
            f"l. {e['line']} ({e['args']} argument(s), marqueurs {e['marqueurs'] or 'aucun'})" for e in dep["sql_params"]))
    if dep.get("auto_instance"):
        out.append("- ⚠️ Accès par l'auto-instance du formulaire alors que la classe est aussi ouverte par `New` "
                   "(la fenêtre affichée n'est pas celle modifiée) : " + ", ".join(
                       f"`{Path(e['fichier']).stem}:{e['line']}` → `{e['membre']}`" for e in dep["auto_instance"]))
    if dep.get("collision_casse"):
        out.append("- ⚠️ Homonyme à la casse près (un seul `.gambas/` compilé pour les deux) : "
                   + ", ".join(f"`{c}`" for c in dep["collision_casse"]))
    if dep.get("unused_transitive"):
        out.append("- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : "
                   + ", ".join(f"`{u}`" for u in dep["unused_transitive"]))
    if dep.get("replay_missing"):
        out.append("- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` "
                   "(`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : "
                   + ", ".join(f"`{g}`" for g in dep["replay_missing"]))
    if dep["dynamic_calls"]:
        out.append(f"- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : {md_lines(rel_src, dep['dynamic_calls'])}")
    out.append("\n### Utilisé par\n")
    if dep["used_by"]:
        out.append("| Fichier appelant | Membres utilisés |\n|---|---|")
        for caller, mems in sorted(dep["used_by"].items()):
            ms = ", ".join(f"`{m}`" for m in sorted(mems) if not m.startswith(("<inconnu", "<hérité"))) or "`<hérité>`"
            out.append(f"| `{caller}` | {ms} |")
    else:
        out.append("_Aucun usage externe détecté statiquement._")
    out.append("\n### Utilise\n")
    if dep["uses"]:
        out.append("| Fichier utilisé | Membres |\n|---|---|")
        for t, mems in sorted(dep["uses"].items()):
            ms = ", ".join(f"`{m}`" for m in sorted(mems) if not m.startswith(("<inconnu", "<hérité"))) or "`<hérité>`"
            out.append(f"| `{t}` | {ms} |")
    else:
        out.append("_Aucune dépendance vers d'autres fichiers du projet._")
    out.append("\n### Tables SQL référencées\n")
    out.append(", ".join(f"`{t}`" for t in dep["tables"]) if dep["tables"] else "_Aucune._")
    if dep["scope_reducible"]:
        out.append("\n### Membres Public sans usage externe détecté (portée réductible ?)\n")
        out.append(", ".join(f"`{m}`" for m in dep["scope_reducible"]))
    return "\n".join(out)


def templates(name: str, rel_src: str) -> dict:
    return {
        "summary.md": f"""# {name} — Synthèse

> Source : `{rel_src}` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

## Points clés

## Dépendances principales

## Risques

## KPI

{{{{kpi}}}}

## Tests

## Rework
""",
        "architecture.md": f"""# {name} — Architecture

> Source : `{rel_src}`

## Vue d'ensemble

## Déclarations

{{{{declarations}}}}

## Fonctions

{{{{fonctions}}}}

## Description des fonctions

<!-- Pour chaque fonction (ou groupe de fonctions) : comportement, effets de bord, SQL émis,
     tables touchées, état global utilisé, étiquettes [portée: nécessaire|réductible]
     [nature: calcul|GUI|mixte]. -->

## État global utilisé

## Propositions d'amélioration

### Réécriture / refactorisation

### Commonalisation avec d'autres fichiers

### Réduction de portée

### Séparation traitement / GUI

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._
""",
        "dependencies.md": f"""# {name} — Dépendances

> Source : `{rel_src}` · Généré par `reference/tools/deps.py` (heuristique statique).

{{{{dependances}}}}

## Notes d'analyse
""",
        "test.md": f"""# {name} — Tests

> Source : `{rel_src}` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|

## Détail des tests
""",
        "rework.md": f"""# {name} — Rework

> Source : `{rel_src}` · Message de commit (phase 4) : `reference/{rel_src}/rework.md <REWORK_ID>`

## KPI

{{{{kpi}}}}

## Historique des KPI

{{{{historique}}}}

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->
""",
    }


def git_sha(root):
    return subprocess.run(["git", "-C", str(root), "rev-parse", "--short", "HEAD"],
                          capture_output=True, text=True).stdout.strip()


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", default=str(Path(__file__).resolve().parents[2]))
    ap.add_argument("--history", default="")
    ap.add_argument("--commit", default="")
    ap.add_argument("prefixes", nargs="+")
    a = ap.parse_args()
    root = Path(a.root).resolve()
    deps = build(root)["files"]
    sha = a.commit or git_sha(root)
    n = 0
    done = []
    for p in iter_sources(root):
        rel = str(p.relative_to(root))
        if not any(rel == x or rel.startswith(x.rstrip("/") + "/") for x in a.prefixes):
            continue
        src = parse(p, root)
        dep = deps[rel]
        k = kpi_of(src)
        d = root / "reference" / rel
        d.mkdir(parents=True, exist_ok=True)
        tpl = templates(src.name, rel)
        put_blocks(d / "summary.md", tpl["summary.md"], {"kpi": kpi_block(k)})
        put_blocks(d / "architecture.md", tpl["architecture.md"],
                   {"declarations": decl_block(src), "fonctions": func_block(src, dep)})
        put_blocks(d / "dependencies.md", tpl["dependencies.md"], {"dependances": deps_block(src, dep, rel)})
        put_blocks(d / "test.md", tpl["test.md"], {})
        rw = {"kpi": kpi_block(k)}
        rpath = d / "rework.md"
        if not rpath.exists() or "{{historique}}" in rpath.read_text(encoding="utf-8"):
            rw["historique"] = HIST_HEAD
        put_blocks(d / "rework.md", tpl["rework.md"], rw)
        if a.history:
            update_history(d / "rework.md", a.history, sha, k)
        n += 1
        done.append(str(d.relative_to(root)))
    print(f"{n} fichier(s) traité(s)")
    # Pointeurs [Fichier.class:Fonction|ligne](…) recalculés
    if done:
        links.run(root, done, check=False)


if __name__ == "__main__":
    main()
