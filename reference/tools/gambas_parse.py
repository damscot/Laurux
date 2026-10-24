"""Parseur léger de sources Gambas 3 (.class / .module) pour l'outillage du rework.

Le parseur ne fait pas d'analyse syntaxique complète : il découpe le fichier en
déclarations et en fonctions à partir des motifs utilisés dans le dépôt Laurux.
Toutes les fonctions sont pures (pas d'écriture disque).
"""

import re
from dataclasses import dataclass, field
from pathlib import Path

# Mots-clés de décision comptés dans la complexité cyclomatique
# (1 + nombre d'occurrences par fonction). « Else If » compte un « If »,
# « And If » / « Or If » comptent un « And » / « Or ».
DECISION_RE = re.compile(r"\b(If|Case|For|While|Until|And|Or|Catch|Try|IIf)\b", re.I)
# Fins de blocs à ne pas compter comme décisions
NON_DECISION_RE = re.compile(r"\b(End\s+If|End\s+Select|Select\s+Case|Case\s+Else|Error\s+Then)\b", re.I)

FUNC_RE = re.compile(
    r"^\s*(?P<mods>(?:(?:Static|Fast|Unsafe|Public|Private)\s+)*)"
    r"(?P<kind>Sub|Function|Procedure)\s+(?P<name>\$?\w+)\s*(?P<args>\(.*)?$",
    re.I,
)
END_RE = re.compile(r"^\s*End(\s+(Sub|Function|Procedure))?\s*$", re.I)
# Membres déclarés avec ou sans mot-clé (« Tab As String » = Private implicite)
VAR_RE = re.compile(
    r"^\s*(?P<mods>(?:(?:Static|Public|Private)\s+)*)(?P<name>\$?\w+)\s*(?:\[[^\]]*\])?\s+As\s+(?P<type>.+?)\s*$",
    re.I,
)
CONST_RE = re.compile(r"^\s*(?P<mods>(?:(?:Static|Public|Private)\s+)*)Const\s+(?P<name>\w+)", re.I)
ENUM_RE = re.compile(r"^\s*(?P<mods>(?:(?:Public|Private)\s+)*)Enum\s+(?P<body>.+)$", re.I)
PROP_RE = re.compile(
    r"^\s*(?P<mods>(?:(?:Static|Public|Private)\s+)*)Property\s+(?:Read\s+|Write\s+)?\{?(?P<name>\w+)\}?\s+As\s+(?P<type>\S+)",
    re.I,
)
EVENT_RE = re.compile(r"^\s*(?:Public\s+)?Event\s+(?P<name>\w+)", re.I)
INHERITS_RE = re.compile(r"^\s*Inherits\s+(?P<name>\w+)", re.I)


def strip_line(line: str) -> str:
    """Retire les chaînes littérales et le commentaire de fin de ligne."""
    out = []
    in_str = False
    i = 0
    while i < len(line):
        c = line[i]
        if in_str:
            if c == "\\" and i + 1 < len(line):
                i += 2
                continue
            if c == '"':
                in_str = False
                out.append('""')
        else:
            if c == '"':
                in_str = True
            elif c == "'":
                break
            else:
                out.append(c)
        i += 1
    return "".join(out).rstrip()


def strings_of(line: str) -> list[str]:
    """Renvoie les chaînes littérales d'une ligne (hors commentaire)."""
    res, cur, in_str, i = [], [], False, 0
    while i < len(line):
        c = line[i]
        if in_str:
            if c == "\\" and i + 1 < len(line):
                cur.append(line[i:i + 2])
                i += 2
                continue
            if c == '"':
                in_str = False
                res.append("".join(cur))
                cur = []
            else:
                cur.append(c)
        else:
            if c == '"':
                in_str = True
            elif c == "'":
                break
        i += 1
    return res


def is_comment_or_blank(line: str) -> bool:
    s = line.strip()
    return not s or s.startswith("'")


def scope_of(mods: str) -> tuple[str, bool]:
    m = mods.lower().split()
    scope = "Public" if "public" in m else "Private"
    return scope, "static" in m


@dataclass
class Func:
    name: str
    kind: str
    scope: str
    static: bool
    signature: str
    start: int  # 1-based
    end: int
    loc: int = 0
    cc: int = 1


@dataclass
class Decl:
    name: str
    kind: str  # var | const | enum | property | event
    scope: str
    static: bool
    type: str
    line: int


@dataclass
class Source:
    path: Path
    rel: str
    is_module: bool
    lines: list[str]
    code: list[str]  # lignes nettoyées (sans chaînes ni commentaires)
    funcs: list[Func] = field(default_factory=list)
    decls: list[Decl] = field(default_factory=list)
    inherits: str = ""
    create_static: bool = False

    @property
    def name(self) -> str:
        return self.path.stem


def parse(path: Path, root: Path) -> Source:
    text = path.read_text(encoding="utf-8", errors="replace")
    lines = text.split("\n")
    if lines and lines[-1] == "":
        lines.pop()
    code = [strip_line(l) for l in lines]
    src = Source(path, str(path.relative_to(root)), path.suffix == ".module", lines, code)

    cur = None
    for i, c in enumerate(code, start=1):
        if cur is None:
            m = FUNC_RE.match(c)
            if m:
                scope, static = scope_of(m["mods"])
                if src.is_module:
                    static = True
                cur = Func(m["name"], m["kind"].capitalize(), scope, static, c.strip(), i, i)
                continue
            if INHERITS_RE.match(c):
                src.inherits = INHERITS_RE.match(c)["name"]
            elif re.match(r"^\s*Create\s+Static\b", c, re.I):
                src.create_static = True
            elif (m := CONST_RE.match(c)):
                src.decls.append(Decl(m["name"], "const", *scope_of(m["mods"]), "", i))
            elif (m := ENUM_RE.match(c)):
                scope, _ = scope_of(m["mods"])
                for n in m["body"].split(","):
                    n = n.split("=")[0].strip()
                    if n:
                        src.decls.append(Decl(n, "enum", scope, True, "", i))
            elif (m := PROP_RE.match(c)):
                mods = m["mods"] or "Public"
                src.decls.append(Decl(m["name"], "property", *scope_of(mods), m["type"], i))
            elif (m := EVENT_RE.match(c)):
                src.decls.append(Decl(m["name"], "event", "Public", False, "", i))
            elif (m := VAR_RE.match(c)):
                scope, static = scope_of(m["mods"])
                typ = re.sub(r"\s*=.*$", "", m["type"])
                src.decls.append(Decl(m["name"], "var", scope, static or src.is_module, typ, i))
        else:
            if END_RE.match(c):
                cur.end = i
                body = code[cur.start:i - 1]
                cur.loc = sum(1 for k in range(cur.start - 1, i) if not is_comment_or_blank(lines[k]))
                cur.cc = 1 + sum(decisions(b) for b in body)
                src.funcs.append(cur)
                cur = None
    return src


def decisions(code_line: str) -> int:
    s = NON_DECISION_RE.sub(" ", code_line)
    s = re.sub(r"\bElse\s+If\b", "If", s, flags=re.I)
    s = re.sub(r"\bEnd\s+(For|While)\b", " ", s, flags=re.I)
    return len(DECISION_RE.findall(s))


def iter_sources(root: Path):
    """Itère sur les .class / .module de <root>/.src, triés."""
    for p in sorted((root / ".src").rglob("*")):
        if p.suffix in (".class", ".module") and p.is_file():
            yield p


def form_controls(form_path: Path) -> dict:
    """Contrôles d'un .form : nom → classe."""
    res = {}
    if form_path.exists():
        for l in form_path.read_text(encoding="utf-8", errors="replace").split("\n"):
            m = re.match(r"^\s*\{\s*!?(\w+)\s+#?(\w+)", l)
            if m:
                res[m[1]] = m[2]
    return res


def form_groups(form_path: Path) -> dict:
    """Contrôles d'un .form rattachés à un groupe d'événements : nom → groupe."""
    res = {}
    if form_path.exists():
        for l in form_path.read_text(encoding="utf-8", errors="replace").split("\n"):
            m = re.match(r"^\s*\{\s*!?(\w+)\s+#?\w+\s+(\w+)", l)
            if m:
                res[m[1]] = m[2]
    return res


def form_names(form_path: Path) -> set[str]:
    """Noms des contrôles et groupes déclarés dans un .form."""
    names = {"Form"}
    if not form_path.exists():
        return names
    for l in form_path.read_text(encoding="utf-8", errors="replace").split("\n"):
        m = re.match(r"^\s*\{\s*!?(\w+)\s+#?\w+(?:\s+(\w+))?", l)
        if m:
            names.add(m[1])
            if m[2]:
                names.add(m[2])
        m = re.match(r'^\s*Group\s*=\s*"(\w+)"', l)
        if m:
            names.add(m[1])
    return names
