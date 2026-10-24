#!/usr/bin/env python3
"""Graphe des dépendances inter-fichiers des sources Gambas de Laurux.

Résolution (heuristique, Gambas est insensible à la casse) :
  - Classe.Membre               (modules, classes statiques, Create Static)
  - var.Membre / var[i].Membre  (var déclarée « As Classe » / « As New Classe » / « As Classe[] » dans le fichier)
  - Module.var.Membre           (var publique typée d'un autre fichier, ex. Utils.db.Exec → DB_Connection.Exec)
  - New Classe, As Classe, Inherits Classe, Classe(…) (_call)
  - contrôles d'un .form dont la classe est une classe du projet (UserControl)
Non résolu : objets non typés (Object/Variant), Last, appels dynamiques (signalés à part).

Usage :
  deps.py [--root DIR] [--json OUT.json]                 graphe complet (réanalyse des sources)
  deps.py -q LPrix [-q .src/Utils/LTaxe.class] [-f used_by,tables]
                                                         extrait de reference/data/deps.json
"""

import argparse
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from gambas_parse import FUNC_RE, form_controls, form_groups, form_names, iter_sources, parse, strings_of, strip_line  # noqa: E402

# Fonctions natives de Gambas : un appel nu « Nom(…) » les vise en priorité sur une méthode homonyme.
GAMBAS_SUBRS = {
    "abs", "acos", "asc", "asin", "atan", "atan2", "base64", "bin", "bool", "cbool", "cbyte", "cdate", "ceil",
    "cfloat", "chr", "cint", "clong", "comp", "conv", "copy", "cos", "cshort", "csingle", "cstr", "date",
    "dateadd", "datediff", "day", "dconv", "deg", "dir", "eof", "error", "eval", "even", "exec", "exist",
    "exp", "exp10", "exp2", "fix", "floor", "format", "frac", "hex", "hour", "html", "iif", "choose", "instr",
    "int", "isascii", "isblank", "isdigit", "isdir", "isletter", "islower", "isnull", "isnumber", "isspace",
    "isupper", "kill", "lcase", "left", "len", "like", "link", "lof", "log", "log10", "lower", "ltrim", "max",
    "mid", "min", "minute", "mkdir", "month", "move", "now", "oct", "odd", "quote", "rad", "rdir", "realpath",
    "replace", "right", "rinstr", "rmdir", "rnd", "round", "rtrim", "second", "seek", "sgn", "shell", "sin",
    "space", "split", "sqr", "stat", "str", "string", "subst", "tan", "temp", "time", "timer", "trim",
    "typeof", "ucase", "unquote", "upper", "url", "val", "week", "weekday", "year", "sleep", "wait", "file"}

# Événements standard des contrôles Gambas (gb.qt/gb.gui) ; complétés par les « Event » du projet.
GAMBAS_EVENTS = {
    "activate", "arrange", "beforearrange", "cancel", "change", "click", "close", "collapse", "columnclick",
    "compare", "cursor", "data", "dblclick", "deactivate", "draw", "drag", "dragleave", "dragmove", "drop",
    "enter", "error", "expand", "finished", "font", "gotfocus", "hide", "insert", "keypress", "keyrelease",
    "leave", "link", "lostfocus", "menu", "mousedown", "mousedrag", "mousemove", "mouseup", "mousewheel",
    "move", "open", "read", "remove", "rename", "resize", "rowclick", "scroll", "select", "show", "timer",
    "watch", "write", "save", "kill", "ready", "accept", "connection", "found", "progress", "signal", "state",
    "textchanged", "deselect", "sort", "status", "title", "icon", "newwindow", "url", "html",
    "add", "connect", "closed", "abort", "activated", "validate"}

SPECIAL = {"_new", "_free", "_init", "_exit", "_call", "_get", "_put", "_next", "_compare",
           "_attach", "_property", "_unknown", "_inline", "_ready"}
DYN_RE = re.compile(r"\b(Object\.(?:Call|New|GetProperty|SetProperty|Attach)|Class\.Load)\b", re.I)
TABLE_LIT_RE = re.compile(r"\b((?:Fiches|Docs|Mails)_\w+|Corsage)\b")
GROUP_RE = re.compile(r'\bAs\s+"(\$?\w+)"|Object\.Attach\([^,]+,\s*\w+\s*,\s*"(\$?\w+)"', re.I)
EVENT_SIG_RE = re.compile(r"^\s*(?:Public\s+)?Event\s+(\w+)\s*(\(.*)?$", re.I)
# Référence interne à un membre : nom nu, « Me.nom » ou « <Classe>.nom » (pas « obj.nom », autre objet)
def self_ref(cls: str) -> str:
    return r"(?:^|(?<=[^\w.$]))(?:(?:Me|" + re.escape(cls) + r")\.)?"
SQL_CALL_RE = re.compile(r"\.(?:Exec|Subst)\s*\(", re.I)
RAISE_RE = re.compile(r"\bRaise\s+(\w+)\s*(\()?", re.I)
TYPE_DECL_RE = re.compile(r"((?:\$?\w+\s*,\s*)*\$?\w+)\s+As\s+(?:New\s+)?(\w+)(\[\])?", re.I)
IDENT_CHAIN_RE = re.compile(r"(?<![\w.])(\$?\w+)(?:\[[^\]]*\])?((?:\.\$?\w+)+)")


def split_args(text: str) -> list:
    """Découpe une liste d'arguments au niveau 0 de parenthèses/crochets."""
    out, depth, cur = [], 0, ""
    for ch in text:
        if ch in "([":
            depth += 1
        elif ch in ")]":
            depth -= 1
        if ch == "," and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    out.append(cur)
    return [a for a in out] if text.strip() else []


def split_args_raw(line: str, start: int):
    """Arguments (texte brut, chaînes comprises) de l'appel dont la parenthèse ouvrante est line[start]."""
    out, cur, depth, in_str, i = [], "", 0, False, start
    while i < len(line):
        ch = line[i]
        if in_str:
            cur += ch
            if ch == '"':
                in_str = False
        elif ch == '"':
            in_str, cur = True, cur + ch
        elif ch == "'":
            return None
        elif ch in "([":
            depth += 1
            if depth > 1:
                cur += ch
        elif ch in ")]":
            depth -= 1
            if depth == 0:
                out.append(cur)
                return [x for x in out] if "".join(out).strip() else []
            cur += ch
        elif ch == "," and depth == 1:
            out.append(cur)
            cur = ""
        else:
            cur += ch
        i += 1
    return None


def paren_content(line: str, start: int):
    """Contenu entre la parenthèse ouvrante line[start] et sa fermante (None si non fermée)."""
    depth = 0
    for i in range(start, len(line)):
        if line[i] == "(":
            depth += 1
        elif line[i] == ")":
            depth -= 1
            if depth == 0:
                return line[start + 1:i]
    return None


def arity(signature: str):
    """(minimum, maximum) d'arguments d'après la signature ; maximum None si « ... »."""
    i = signature.find("(")
    if i < 0:
        return 0, 0
    params = split_args(paren_content(signature, i) or "")
    mini, opt, maxi = 0, False, 0
    for prm in params:
        if "..." in prm:
            return mini, None
        if re.search(r"\bOptional\b", prm, re.I):
            opt = True
        maxi += 1
        if not opt:
            mini += 1
    return mini, maxi


def ui_file(path: Path) -> Path:
    """Fichier d'interface d'une classe : .form, sinon .report (même syntaxe)."""
    f = path.with_suffix(".form")
    if not f.exists() and path.with_suffix(".report").exists():
        return path.with_suffix(".report")
    return f


def load_cbase(root: Path) -> dict:
    """Mapping TabXxx → table physique, lu dans Cbase.module."""
    mapping = {}
    p = root / ".src" / "Utils" / "Cbase.module"
    if not p.exists():
        return mapping
    txt = p.read_text(encoding="utf-8", errors="replace")
    for m in re.finditer(r'Case\s+"(Tab\w+)"\s*\n\s*(?:Return|\w+\s*=)\s*[^"\n]*"(\w+)"', txt):
        mapping[m[1]] = m[2]
    return mapping


def build(root: Path) -> dict:
    parsed = [parse(p, root) for p in iter_sources(root)]
    # Clé = nom en minuscules ; en cas d'homonymes à la casse près (Numtostring / numtostring),
    # la clé garde la casse exacte et la résolution se fait d'abord sur le nom exact.
    low = defaultdict(list)
    for s in parsed:
        low[s.name.lower()].append(s)
    srcs, exact = {}, {}
    for s in parsed:
        key = s.name.lower() if len(low[s.name.lower()]) == 1 else s.name
        srcs[key] = s
        exact[s.name] = key
    names = {k: s.name for k, s in srcs.items()}
    key_of = {s.name: k for k, s in srcs.items()}

    def R(name):
        """Résout un identifiant en clé de fichier source (ou None)."""
        if name in exact:
            return exact[name]
        n = name.lower()
        return n if n in srcs else None

    # Membres et types publics de chaque fichier
    members = {}
    member_types = {}
    for k, s in srcs.items():
        mem = {}
        for f in s.funcs:
            mem[f.name.lower()] = (f.name, f.scope, "func", f.start)
        for d in s.decls:
            mem.setdefault(d.name.lower(), (d.name, d.scope, d.kind, d.line))
            if d.kind in ("var", "property") and d.type:
                t = re.match(r"(?:New\s+)?(\w+)", d.type, re.I)
                if t and R(t[1]):
                    member_types[(k, d.name.lower())] = R(t[1])
        members[k] = mem

    def owner(t, mem):
        """Fichier qui définit <mem> pour la classe <t>, en remontant les Inherits du projet."""
        seen = set()
        while t and t not in seen:
            if mem in members[t]:
                return t
            seen.add(t)
            t = R(srcs[t].inherits) if srcs[t].inherits else None
        return None

    sigs = {k: {f.name.lower(): arity(f.signature) for f in s.funcs} for k, s in srcs.items()}
    ev_sigs = {}
    for k, s in srcs.items():
        for c in s.code:
            m = EVENT_SIG_RE.match(c)
            if m:
                ev_sigs.setdefault(k, {})[m[1].lower()] = arity(m[2] or "()")
    events = GAMBAS_EVENTS | {d.name.lower() for s in parsed for d in s.decls if d.kind == "event"}
    cbase = load_cbase(root)
    out = {}
    for k, s in srcs.items():
        uses = defaultdict(lambda: defaultdict(list))  # cible -> membre -> [lignes]
        local_types = {}
        dyn, tables, groups = [], set(), set()
        # noms locaux masquant une classe : contrôles du .form, variables d'un type externe
        shadow = {n.lower() for n in form_names(ui_file(s.path))} - {"form"}
        for cname, ctype in form_controls(ui_file(s.path)).items():
            if R(ctype):
                local_types[cname.lower()] = R(ctype)
        # Types déclarés : au niveau du fichier (membres) ou propres à une fonction (Dim, paramètres).
        # Une variable locale ne vaut que dans sa fonction et masque le membre homonyme.
        func_at = {}
        for fi, f in enumerate(s.funcs):
            for n in range(f.start, f.end + 1):
                func_at[n] = fi
        f_types = defaultdict(dict)
        f_shadow = defaultdict(set)
        for i, (raw, c) in enumerate(zip(s.lines, s.code), start=1):
            fi = func_at.get(i)
            for m in TYPE_DECL_RE.finditer(c):
                for v in re.split(r"\s*,\s*", m[1].lower()):
                    v = v.split()[-1]
                    if fi is None:
                        if R(m[2]):
                            local_types[v] = R(m[2])
                        else:
                            shadow.add(v)
                    elif R(m[2]):
                        f_types[fi][v] = R(m[2])
                    else:
                        f_shadow[fi].add(v)
        file_types, file_shadow = local_types, shadow
        scopes = {}
        for fi in set(f_types) | set(f_shadow):
            lt = {v: t for v, t in file_types.items() if v not in f_shadow[fi]}
            lt.update(f_types[fi])
            scopes[fi] = (lt, file_shadow | f_shadow[fi])
        with_stack = []
        arity_err = []
        sql_params = []
        self_used = set()
        by_class = []  # Classe.membre écrit avec le nom de la classe (module, statique ou auto-instance)
        for i, (raw, c) in enumerate(zip(s.lines, s.code), start=1):
            local_types, shadow = scopes.get(func_at.get(i), (file_types, file_shadow))
            # Blocs With <expr> … End With : « .Membre » se rapporte à <expr>
            mw = re.match(r"^\s*With\s+(\$?\w+)\s*$", c, re.I)
            if mw:
                w = mw[1]
                wt = local_types.get(w.lower()) or (R(w) if w.lower() not in shadow else None)
                with_stack.append(wt)
                continue
            if re.match(r"^\s*With\b", c, re.I):
                with_stack.append(None)
                continue
            if re.match(r"^\s*End\s+With\b", c, re.I):
                if with_stack:
                    with_stack.pop()
                continue
            if with_stack and with_stack[-1] and with_stack[-1] != k:
                wt = with_stack[-1]
                for mm in re.finditer(r"(?<![\w)\]$.])\.([A-Za-z_]\w*)", c):
                    mem = mm[1].lower()
                    if mem in members[wt]:
                        uses[wt][members[wt][mem][0]].append(i)
            for m in GROUP_RE.finditer(raw):
                groups.add((m[1] or m[2]).lower())
            if DYN_RE.search(c):
                dyn.append(i)
            for lit in strings_of(raw):
                for t in TABLE_LIT_RE.findall(lit):
                    tables.add(t)
                if lit in cbase and "Cbase.Table" in raw:
                    tables.add(cbase[lit])
            for m in re.finditer(r"\b(?:New|Inherits)\s+(\w+)|\bAs\s+(?:New\s+)?(\w+)", c, re.I):
                t = R(m[1] or m[2])
                if t and t != k:
                    uses[t]["<type>"].append(i)
            for m in IDENT_CHAIN_RE.finditer(c):
                head, chain = m[1].lower(), m[2].split(".")[1:]
                if head in shadow and head not in local_types:
                    continue
                if R(m[1]) and R(m[1]) != k:
                    target, mem = R(m[1]), chain[0].lower()
                    by_class.append((target, mem, i))
                elif head in local_types:
                    target, mem = local_types[head], chain[0].lower()
                else:
                    continue
                # Module.var.Membre : on suit un niveau de type
                if len(chain) > 1 and (target, mem) in member_types:
                    if target != k:
                        uses[target][members[target][mem][0]].append(i)
                    target, mem = member_types[(target, mem)], chain[1].lower()
                if target == k:
                    self_used.add(mem)  # obj.Membre sur une autre instance de la même classe
                    continue
                if mem in members.get(target, {}):
                    uses[target][members[target][mem][0]].append(i)
                elif owner(target, mem) and owner(target, mem) != k:
                    o = owner(target, mem)
                    uses[o][members[o][mem][0]].append(i)
                elif srcs[target].inherits or ui_file(srcs[target].path).exists():
                    uses[target]["<hérité:" + mem + ">"].append(i)
                else:
                    uses[target]["<inconnu:" + mem + ">"].append(i)
            # Arité des appels Cible.Méthode(…) et Méthode(…) locale
            if not FUNC_RE.match(c) and not re.match(r"^\s*(Public\s+)?(Event|Raise)\b", c, re.I):
                for m in re.finditer(r"(?<![\w.$])(\$?\w+)(?:\[[^\]]*\])?\.(\w+)\s*\(|(?<![\w.$])(\w+)\s*\(", c):
                    if m[3]:
                        if m[3].lower() in GAMBAS_SUBRS or re.search(r"\bNew\s*$", c[:m.start()], re.I):
                            continue
                        target, mem = k, m[3].lower()
                    else:
                        h = m[1].lower()
                        if h in shadow and h not in local_types:
                            continue
                        target = local_types.get(h) or R(m[1])
                        mem = m[2].lower()
                    if not target or mem not in sigs.get(target, {}) or mem in SPECIAL:
                        continue
                    inner = paren_content(c, m.end() - 1)
                    if inner is None:
                        continue
                    given = len(split_args(inner))
                    mini, maxi = sigs[target][mem]
                    if given < mini or (maxi is not None and given > maxi):
                        arity_err.append({"line": i, "cible": names[target], "membre": members[target][mem][0],
                                          "donnés": given, "min": mini, "max": maxi})
            # Exec/Subst(sql, args…) : arguments passés sans marqueur &N, ou marqueur sans argument.
            # Contrôlé seulement si le SQL ne contient, hors littéraux, que des noms de table.
            for m in SQL_CALL_RE.finditer(raw):
                parts = split_args_raw(raw, m.end() - 1)
                if not parts or '"' not in parts[0]:
                    continue
                sql_code = strip_line(parts[0])
                idents = re.findall(r"[A-Za-z_$][\w.$]*(?:\([^)]*\))?", sql_code.replace('""', ""))
                if any(not (re.match(r"(?i)cbase\.table\(", x) or re.fullmatch(r"(?i)\$?tab\w*", x))
                       for x in idents):
                    continue  # SQL en partie variable (req, cond…) : non contrôlé
                nargs = len(parts) - 1
                marks = [int(a or b) for lit in strings_of(parts[0])
                         for a, b in re.findall(r"&(\d+)|&\{(\d+)\}", lit)]
                if (nargs and not marks) or (marks and max(marks) > nargs):
                    sql_params.append({"line": i, "args": nargs, "marqueurs": sorted(set(marks))})
            # Raise Événement(…) : nombre d'arguments contre la déclaration Event
            for m in RAISE_RE.finditer(c):
                ev, t0 = m[1].lower(), k
                while t0 and ev not in ev_sigs.get(t0, {}):
                    t0 = R(srcs[t0].inherits) if srcs[t0].inherits else None
                if not t0:
                    continue
                inner = paren_content(c, m.end() - 1) if m[2] else ""
                if inner is None:
                    continue
                given = len(split_args(inner))
                mini, maxi = ev_sigs[t0][ev]
                if given < mini or (maxi is not None and given > maxi):
                    arity_err.append({"line": i, "cible": names[t0], "membre": "Raise " + m[1],
                                      "donnés": given, "min": mini, "max": maxi})
            # Classe[…] : _get / _put
            for m in re.finditer(r"(?<![\w.$])(\w+)\[", c):
                t = R(m[1])
                if t and t != k and m[1].lower() not in shadow and ("_get" in members[t] or srcs[t].inherits):
                    uses[t]["_get" if "_get" in members[t] else "<hérité:_get>"].append(i)
            for m in re.finditer(r"(?<![\w.])(\w+)\s*\(", c):
                t = R(m[1])
                if re.search(r"\bNew\s*$", c[:m.start()], re.I):
                    continue
                if t and t != k and "_call" in members[t]:
                    uses[t]["_call"].append(i)
        # Sous-classe d'une classe du projet : membres du parent utilisés sans préfixe ou via Me.
        parent = R(s.inherits) if s.inherits else None
        if parent and parent != k:
            own = {f.name.lower() for f in s.funcs} | {d.name.lower() for d in s.decls}
            for i, c in enumerate(s.code, start=1):
                for w in re.findall(r"(?<![\w.])(?:Me\.|Super\.)?(\$?\w+)", c):
                    wl = w.lower()
                    o = owner(parent, wl)
                    if o and o != k and wl not in own:
                        uses[o][members[o][wl][0]].append(i)
                for w in re.findall(r"\bSuper\.(\$?\w+)", c, re.I):
                    o = owner(parent, w.lower())
                    if o and o != k:
                        uses[o][members[o][w.lower()][0]].append(i)
        # contrôles du .form dont la classe appartient au projet
        form = ui_file(s.path)
        if form.exists():
            stack = []
            for l in form.read_text(encoding="utf-8", errors="replace").split("\n"):
                m = re.match(r"^\s*\{\s*!?\w+\s+#?(\w+)", l)
                if m:
                    t = R(m[1]) or ""
                    stack.append(t)
                    if t and t != k:
                        uses[t]["<form>"].append(0)
                    continue
                if re.match(r"^\s*\}", l):
                    if stack:
                        stack.pop()
                    continue
                m = re.match(r"^\s*(\w+)\s*=", l)
                if m and stack and stack[-1] in srcs and stack[-1] != k:
                    t, mem = stack[-1], m[1].lower()
                    if mem in members[t]:
                        uses[t][members[t][mem][0]].append(0)
        fgroups = form_groups(form) if form.exists() else {}
        grouped = {c.lower(): g for c, g in fgroups.items()}
        # ReplayObserver.Replay_Click appelle Object.Call(fenêtre, <Contrôle> & "_Click") pour ces classes
        replay_dyn = {c.lower() + "_click" for c, t in form_controls(form).items()
                      if t.lower() in ("gridview", "columnview", "listbox")}
        fnames = {f.name.lower() for f in s.funcs}
        replay_missing = sorted(c for c, t in form_controls(form).items()
                                if t.lower() in ("gridview", "columnview", "listbox")
                                and c.lower() + "_click" not in fnames)
        ctrl = ({n.lower() for n in form_names(form)} | groups if form.exists() else set(groups)) | {"application"}
        handlers = []
        for f in s.funcs:
            if "_" in f.name.strip("_"):
                prefix, suffix = f.name.rsplit("_", 1)
                prefix = prefix.lower()
                is_accessor = suffix.lower() in ("read", "write") and any(
                    d.kind == "property" and d.name.lower() == prefix for d in s.decls)
                # contrôle rattaché à un groupe : ses événements vont au groupe, pas à <Contrôle>_<Événement>
                in_group = prefix in grouped and grouped[prefix].lower() != prefix
                if prefix in ctrl and not is_accessor and not in_group and suffix.lower() in events:
                    handlers.append(f.name)
        # Handlers nominaux d'un contrôle rattaché à un groupe du .form : Gambas n'envoie
        # alors les événements qu'au groupe, le handler nominal n'est jamais déclenché.
        groups |= {g.lower() for g in fgroups.values()}

        def called_elsewhere(f):
            pat = re.compile(self_ref(s.name) + re.escape(f.name) + r"\b", re.I)
            return any(pat.search(c) for n, c in enumerate(s.code, start=1) if n != f.start) \
                or any(f.name.lower() == x.lower() for raw in s.lines for x in strings_of(raw))
        inactive = [f.name for f in s.funcs if "_" in f.name.strip("_")
                    and f.name.rsplit("_", 1)[1].lower() in events
                    and f.name.rsplit("_", 1)[0].lower() in grouped
                    and f.name.rsplit("_", 1)[0].lower() != grouped[f.name.rsplit("_", 1)[0].lower()].lower()
                    and not called_elsewhere(f)]
        out[k] = {
            "file": s.rel,
            "handlers_inactifs": inactive,
            "arity_errors": arity_err,
            "sql_params": sql_params,
            "_self_used": sorted(self_used),
            "_by_class": by_class,
            "replay_dynamic": [f.name for f in s.funcs if f.name.lower() in replay_dyn],
            "replay_missing": replay_missing,
            "name": s.name,
            "module": s.is_module,
            "form": form.exists(),
            "ui": form.name if form.exists() else "",
            "inherits": s.inherits,
            "create_static": s.create_static,
            "uses": {names[t]: {mm: sorted(set(v)) for mm, v in d.items()} for t, d in sorted(uses.items())},
            "tables": sorted(tables),
            "dynamic_calls": dyn,
            "handlers": handlers,
            "event_groups": sorted(groups),
        }

    # Graphe inverse : qui utilise quoi
    for k in out:
        out[k]["used_by"] = {}
    for k, d in out.items():
        for tname, mems in d["uses"].items():
            out[key_of[tname]]["used_by"][d["file"]] = mems

    # Noms cités en chaîne littérale dans un appel dynamique (Object.Call/SetProperty/GetProperty…)
    literals = set()
    for s in srcs.values():
        for raw, c in zip(s.lines, s.code):
            if DYN_RE.search(c):
                literals.update(x.lower() for x in strings_of(raw) if re.fullmatch(r"\w+", x))

    # Classe jamais référencée : aucun appelant et nom absent des chaînes du projet (Class.Load, Object.New…)
    all_lits = set()
    for s in srcs.values():
        for raw in s.lines:
            all_lits.update(x.lower() for x in strings_of(raw) if re.fullmatch(r"\w+", x))
    startup = ""
    pj = root / ".project"
    if pj.exists():
        mm = re.search(r"^Startup=(\w+)", pj.read_text(encoding="utf-8", errors="replace"), re.M)
        startup = mm[1].lower() if mm else ""
    # Une simple déclaration « As X » (sans New, Inherits ni accès à un membre) ne fait pas vivre la classe.
    newed_or_parent = set()
    for s2 in srcs.values():
        if s2.inherits and R(s2.inherits):
            newed_or_parent.add(R(s2.inherits))
        for c in s2.code:
            for mm in re.finditer(r"\bNew\s+(\w+)", c, re.I):
                if R(mm[1]):
                    newed_or_parent.add(R(mm[1]))
    for k, s in srcs.items():
        only_decl = all(set(m) <= {"<type>"} for m in out[k]["used_by"].values())
        used = out[k]["used_by"] and not (only_decl and k not in newed_or_parent and not s.is_module)
        out[k]["jamais_reference"] = (not used and s.name.lower() not in all_lits
                                      and s.name.lower() != startup)

    # Accès par auto-instance : Classe.membre d'instance d'une classe à formulaire, alors que cette
    # classe est aussi instanciée par « New Classe » ailleurs (la fenêtre affichée n'est pas l'auto-instance).
    newed = set()
    for k2, s2 in srcs.items():
        for c in s2.code:
            for mm in re.finditer(r"\bNew\s+(\w+)", c, re.I):
                if R(mm[1]):
                    newed.add(R(mm[1]))
    for k in srcs:
        out[k]["auto_instance"] = []
    for k, s in srcs.items():
        for target, mem, line in out[k].pop("_by_class"):
            st = srcs[target]
            if st.is_module or st.create_static or target not in newed or not ui_file(st.path).exists():
                continue
            info = members[target].get(mem)
            if not info or info[2] not in ("func", "var", "property"):
                continue
            static = any((f.static if f.name.lower() == mem else False) for f in st.funcs) or \
                any((d.static if d.name.lower() == mem else False) for d in st.decls)
            if static:
                continue
            out[target]["auto_instance"].append({"fichier": s.rel, "line": line, "membre": info[0]})
    # Homonymes à la casse près : un seul .gambas/<NOM> compilé
    for k, s in srcs.items():
        out[k]["collision_casse"] = sorted(o.rel for o in low[s.name.lower()] if o is not s)

    # Portée : membres Public sans usage externe détecté
    for k, s in srcs.items():
        ext = set()
        for mems in out[k]["used_by"].values():
            ext.update(m.lower() for m in mems)
        reducible = []
        for f in s.funcs:
            ln = f.name.lower()
            if (f.scope == "Public" and ln not in ext and ln not in SPECIAL
                    and f.name not in out[k]["handlers"] and ln not in literals
                    and f.name not in out[k]["replay_dynamic"]):
                reducible.append(f.name)
        for d in s.decls:
            if d.kind == "var" and d.scope == "Public" and d.name.lower() not in ext \
                    and d.name.lower() not in literals:
                reducible.append(d.name)
        out[k]["scope_reducible"] = reducible
        unused = []
        for f in s.funcs:
            ln = f.name.lower()
            if (ln in ext or ln in SPECIAL or f.name in out[k]["handlers"] or ln in literals
                    or ln in out[k]["_self_used"]
                    or f.name in out[k]["replay_dynamic"] or re.search(r"_(read|write)$", ln)):
                continue
            pat = re.compile(self_ref(s.name) + re.escape(f.name) + r"\b", re.I)
            if not any(pat.search(c) for n, c in enumerate(s.code, start=1) if not (f.start <= n <= f.end)):
                unused.append(f.name)
        out[k]["unused"] = unused
        # Mort par transitivité : appelée seulement depuis des fonctions mortes (unused, handlers inactifs)
        dead = set(unused) | set(out[k]["handlers_inactifs"])
        fn_at = {}
        for f in s.funcs:
            for n in range(f.start, f.end + 1):
                fn_at[n] = f.name
        changed = True
        trans = []
        while changed:
            changed = False
            for f in s.funcs:
                ln = f.name.lower()
                if (f.name in dead or ln in ext or ln in SPECIAL or f.name in out[k]["handlers"]
                        or ln in out[k]["_self_used"]
                        or ln in literals or f.name in out[k]["replay_dynamic"]
                        or re.search(r"_(read|write)$", ln)):
                    continue
                pat = re.compile(self_ref(s.name) + re.escape(f.name) + r"\b", re.I)
                callers = {fn_at.get(n, "<décl>") for n, c in enumerate(s.code, start=1)
                           if not (f.start <= n <= f.end) and pat.search(c)}
                if callers and callers <= dead:
                    dead.add(f.name)
                    trans.append(f.name)
                    changed = True
        out[k]["unused_transitive"] = trans
        out[k].pop("_self_used")
    return {"cbase": cbase, "files": {d["file"]: d for d in out.values()}}


def select(data: dict, queries: list, fields: list) -> dict:
    """Extrait les fichiers correspondant aux requêtes (chemin relatif, préfixe de répertoire
    ou nom de classe/module, insensible à la casse) et, si demandé, seulement certains champs."""
    out = {}
    for rel, d in data["files"].items():
        for q in queries:
            ql = q.lower().rstrip("/")
            if (rel.lower() == ql or rel.lower().startswith(ql + "/") or d["name"].lower() == ql
                    or Path(rel).name.lower() == ql):
                out[rel] = {k: v for k, v in d.items() if not fields or k in fields or k == "file"}
                break
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", default=str(Path(__file__).resolve().parents[2]))
    ap.add_argument("--json", default=None, help="écrit le graphe complet dans ce fichier")
    ap.add_argument("-q", "--query", action="append", default=[],
                    help="filtre : chemin (.src/Utils/LPrix.class), répertoire (.src/Utils) ou nom (LPrix) ; répétable")
    ap.add_argument("-f", "--fields", default="",
                    help="champs à garder, séparés par des virgules (uses,used_by,tables,handlers,"
                         "dynamic_calls,scope_reducible,event_groups,inherits,form…)")
    ap.add_argument("--from", dest="src", default=None,
                    help="lit un deps.json existant au lieu de réanalyser les sources "
                         "(défaut avec --query : reference/data/deps.json s'il existe)")
    a = ap.parse_args()
    root = Path(a.root).resolve()
    src = a.src or (str(root / "reference" / "data" / "deps.json") if a.query else None)
    if src and Path(src).exists():
        data = json.loads(Path(src).read_text(encoding="utf-8"))
    else:
        data = build(root)
    if a.query:
        fields = [f.strip() for f in a.fields.split(",") if f.strip()]
        res = select(data, a.query, fields)
        if not res:
            sys.exit(f"Aucun fichier ne correspond à : {', '.join(a.query)}")
        txt = json.dumps(res, indent=1, ensure_ascii=False) + "\n"
    else:
        txt = json.dumps(data, indent=1, ensure_ascii=False) + "\n"
    if a.json:
        Path(a.json).parent.mkdir(parents=True, exist_ok=True)
        Path(a.json).write_text(txt, encoding="utf-8")
    else:
        sys.stdout.write(txt)


if __name__ == "__main__":
    main()
