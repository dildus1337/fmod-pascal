#!/usr/bin/env python3
"""Translate FMOD C headers (4.44.64 and 2.00.22) into FreePascal units."""
from __future__ import annotations

import os
import re
import subprocess
import textwrap
from collections import OrderedDict

from pycparser import c_ast, parse_file

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.environ.get("FMOD_SRC", "/tmp/fmod_src")
FAKE = os.path.join(HERE, "fake_fmod.h")
OUT = os.environ.get("FMOD_OUT", os.path.abspath(os.path.join(HERE, "..")))

RESERVED = {
    "and", "array", "as", "asm", "begin", "case", "class", "const",
    "constructor", "destructor", "div", "do", "downto", "else", "end",
    "except", "exports", "file", "finalization", "finally", "for", "function",
    "goto", "if", "implementation", "in", "inherited", "initialization",
    "inline", "interface", "is", "label", "library", "mod", "nil", "not",
    "object", "of", "on", "operator", "or", "out", "packed", "procedure",
    "program", "property", "raise", "record", "repeat", "self", "set", "shl",
    "shr", "string", "then", "threadvar", "to", "try", "type", "unit", "until",
    "uses", "var", "while", "with", "xor", "dispose", "exit", "false", "new",
    "true",
}

PRIM = {
    "void": "Pointer",
    "char": "AnsiChar",
    "int": "Integer",
    "signed": "Integer",
    "signed int": "Integer",
    "unsigned": "Cardinal",
    "unsigned int": "Cardinal",
    "float": "Single",
    "double": "Double",
    "short": "SmallInt",
    "signed short": "SmallInt",
    "unsigned short": "Word",
    "unsigned char": "Byte",
    "signed char": "ShortInt",
    "long": "Integer",
    "unsigned long": "Cardinal",
    "long long": "Int64",
    "signed long long": "Int64",
    "unsigned long long": "QWord",
}

PRIM_PTR = {
    "void": "Pointer",
    "char": "PAnsiChar",
    "int": "PInteger",
    "signed": "PInteger",
    "signed int": "PInteger",
    "unsigned": "PCardinal",
    "unsigned int": "PCardinal",
    "float": "PSingle",
    "double": "PDouble",
    "short": "PSmallInt",
    "signed short": "PSmallInt",
    "unsigned short": "PWord",
    "unsigned char": "PByte",
    "signed char": "PShortInt",
    "long long": "PInt64",
    "signed long long": "PInt64",
    "unsigned long long": "PQWord",
}

# second-level pointers that already exist in the System unit
SYS_PTR = {
    "Pointer", "PAnsiChar", "PPAnsiChar", "PInteger", "PCardinal", "PSingle",
    "PDouble", "PByte", "PInt64", "PQWord", "PUInt64", "PSmallInt", "PWord",
    "PShortInt", "PPointer",
}


def ident(name: str | None, used: set[str] | None = None) -> str | None:
    if not name:
        return name
    out = name + "_" if name.lower() in RESERVED else name
    if used is not None:
        base = out
        n = 2
        while out.lower() in used:
            out = f"{base}{n}"
            n += 1
        used.add(out.lower())
    return out


def basename(coord) -> str:
    if not coord or not coord.file:
        return ""
    return os.path.basename(coord.file)


class Conv:
    def __init__(self):
        self.warnings: list[str] = []
        self.type_names: list[str] = []
        self.defined: set[str] = set()
        self.opaque: set[str] = set()
        self.structs: dict[str, list[tuple[str, str]]] = {}  # name -> [(field, type)]
        self.funcs: list[dict] = []
        self.extra_ptrs: set[str] = set()

    def warn(self, msg: str):
        self.warnings.append(msg)

    def render_expr(self, node) -> str:
        if node is None:
            return "0"
        if isinstance(node, c_ast.Constant):
            return self.render_constant(node.value)
        if isinstance(node, c_ast.ID):
            return ident(node.name)
        if isinstance(node, c_ast.UnaryOp):
            op = {"-": "-", "+": "+", "~": "not ", "!": "not "}.get(node.op, node.op)
            return f"({op}{self.render_expr(node.expr)})"
        if isinstance(node, c_ast.BinaryOp):
            ops = {
                "+": "+", "-": "-", "*": "*", "/": "/",
                "|": " or ", "&": " and ", "^": " xor ",
                "<<": " shl ", ">>": " shr ",
            }
            op = ops.get(node.op, f" {node.op} ")
            return f"({self.render_expr(node.left)}{op}{self.render_expr(node.right)})"
        if isinstance(node, c_ast.Cast):
            return self.render_expr(node.expr)
        self.warn(f"expr {type(node).__name__}")
        return "0"

    def render_constant(self, value: str) -> str:
        v = value.strip()
        if re.fullmatch(r"[+-]?0x[0-9A-Fa-f]+[uUlL]*", v):
            sign = ""
            if v[0] in "+-":
                sign, v = v[0], v[1:]
            hexpart = v[2:].rstrip("uUlL")
            return f"{sign}${hexpart.upper()}"
        if re.fullmatch(r"[+-]?\d+[uUlL]+", v):
            return re.sub(r"[uUlL]+$", "", v)
        if re.fullmatch(r"[+-]?\d*\.\d+[fF]", v) or re.fullmatch(r"[+-]?\d+\.[fF]", v):
            return v[:-1]
        if v.endswith(("f", "F")) and re.fullmatch(r"[+-]?\d+(\.\d+)?[fF]", v):
            return v[:-1]
        return v

    def id_key(self, names) -> str:
        return " ".join(names)

    def render_ident_type(self, names) -> str:
        key = self.id_key(names)
        if key in PRIM and key != "void":
            return PRIM[key]
        if key == "void":
            return "Pointer"
        if len(names) == 1:
            return ident(names[0])
        self.warn(f"unknown type {key}")
        return "Integer"

    def pointer_to_names(self, names) -> str:
        key = self.id_key(names)
        if key in PRIM_PTR:
            return PRIM_PTR[key]
        if len(names) == 1:
            return "P" + ident(names[0])
        self.warn(f"unknown ptr {key}")
        return "Pointer"

    def pointer_to_rendered(self, inner: str) -> str:
        if inner == "Pointer":
            return "PPointer"
        if inner in SYS_PTR or inner.startswith("P"):
            # PFoo -> PPFoo, but Pointer already handled
            if inner.startswith("PP"):
                name = "P" + inner
            else:
                name = "P" + inner
            if name not in SYS_PTR:
                self.extra_ptrs.add(name)
            return name
        return "P" + inner

    def render_type(self, typ) -> str:
        if isinstance(typ, c_ast.PtrDecl):
            inner = typ.type
            # pointer to function: the FuncDecl itself is the procedural type
            if isinstance(inner, c_ast.FuncDecl):
                return self.render_func_type(inner)
            if isinstance(inner, c_ast.PtrDecl):
                return self.pointer_to_rendered(self.render_type(inner))
            if isinstance(inner, c_ast.TypeDecl):
                base = inner.type
                if isinstance(base, c_ast.IdentifierType):
                    return self.pointer_to_names(base.names)
                if isinstance(base, c_ast.Struct):
                    return "P" + ident(base.name or inner.declname or "Anon")
                if isinstance(base, c_ast.Enum):
                    return "P" + ident(base.name or inner.declname or "Anon")
                if isinstance(base, c_ast.Union):
                    return "P" + ident(base.name or inner.declname or "Anon")
            if isinstance(inner, c_ast.ArrayDecl):
                # pointer to array -> pointer to element (rare); keep pointer to array type
                return "Pointer"
            self.warn(f"ptr of {type(inner).__name__}")
            return "Pointer"
        if isinstance(typ, c_ast.ArrayDecl):
            elem = self.render_type(typ.type)
            if typ.dim is None:
                self.warn("flexible array")
                return f"array[0..0] of {elem}"
            dim = self.render_expr(typ.dim)
            try:
                n = int(dim, 0) if dim.startswith("$") else int(dim)
                hi = n - 1
                if hi < 0:
                    hi = 0
                return f"array[0..{hi}] of {elem}"
            except ValueError:
                return f"array[0..({dim})-1] of {elem}"
        if isinstance(typ, c_ast.TypeDecl):
            return self.render_type(typ.type)
        if isinstance(typ, c_ast.IdentifierType):
            return self.render_ident_type(typ.names)
        if isinstance(typ, c_ast.FuncDecl):
            return self.render_func_type(typ)
        if isinstance(typ, c_ast.Struct):
            # anonymous struct used as a type — caller should have named it
            return ident(typ.name) if typ.name else "record end"
        if isinstance(typ, c_ast.Enum):
            return ident(typ.name) if typ.name else "Integer"
        if isinstance(typ, c_ast.Union):
            return ident(typ.name) if typ.name else "record end"
        self.warn(f"type node {type(typ).__name__}")
        return "Integer"

    def render_params(self, args) -> tuple[str, bool]:
        if args is None:
            return "", False
        parts = []
        used: set[str] = set()
        varargs = False
        for i, p in enumerate(args.params):
            if isinstance(p, c_ast.EllipsisParam):
                varargs = True
                continue
            if isinstance(p, c_ast.Typename):
                # void
                if self._is_void_type(p.type):
                    continue
                pname = ident(f"arg{i+1}", used)
                parts.append(f"{pname}: {self.render_type(p.type)}")
                continue
            if isinstance(p, c_ast.Decl):
                if p.name is None and self._is_void_type(p.type):
                    continue
                pname = ident(p.name or f"arg{i+1}", used)
                parts.append(f"{pname}: {self.render_type(p.type)}")
                continue
            self.warn(f"param {type(p).__name__}")
        return "; ".join(parts), varargs

    def _is_void_type(self, typ) -> bool:
        t = typ
        while isinstance(t, c_ast.TypeDecl):
            t = t.type
        return isinstance(t, c_ast.IdentifierType) and t.names == ["void"]

    def render_func_type(self, func: c_ast.FuncDecl) -> str:
        params, varargs = self.render_params(func.args)
        ret = self.render_type(func.type)
        void_ret = self._is_void_type(func.type)
        cc = "cdecl" if varargs else "FMOD_CC"
        var = "; varargs" if varargs else ""
        if void_ret:
            return f"procedure({params}); {cc}{var}"
        return f"function({params}): {ret}; {cc}{var}"

    def render_enum_body(self, enum: c_ast.Enum) -> str:
        lines = []
        if not enum.values:
            return ""
        for e in enum.values.enumerators:
            if e.value is not None:
                lines.append(f"    {ident(e.name)} = {self.render_expr(e.value)}")
            else:
                lines.append(f"    {ident(e.name)}")
        return "(\n" + ",\n".join(lines) + "\n  )"

    def remember(self, name: str):
        if name and name not in self.defined:
            self.defined.add(name)
            self.type_names.append(name)

    def struct_fields(self, struct: c_ast.Struct) -> tuple[list[tuple[str, str]], c_ast.Union | None]:
        fields = []
        union = None
        used: set[str] = set()
        decls = struct.decls or []
        for d in decls:
            if not isinstance(d, c_ast.Decl):
                self.warn(f"struct member {type(d).__name__}")
                continue
            if d.name is None and isinstance(d.type, c_ast.Union):
                union = d.type
                continue
            fname = ident(d.name or "anon", used)
            ftyp = self.render_type(d.type)
            fields.append((fname, ftyp))
        return fields, union

    def render_union_variant(self, union: c_ast.Union, indent: str) -> list[str]:
        lines = [f"{indent}case Integer of"]
        used: set[str] = set()
        idx = 0
        for d in union.decls or []:
            if not isinstance(d, c_ast.Decl):
                continue
            fname = ident(d.name or f"u{idx}", used)
            ftyp = self.render_type(d.type)
            lines.append(f"{indent}  {idx}: ({fname}: {ftyp});")
            idx += 1
        return lines

    def emit_record(self, name: str, fields, union) -> list[str]:
        self.structs[name] = fields
        lines = [f"  {name} = record"]
        for fname, ftyp in fields:
            lines.append(f"    {fname}: {ftyp};")
        if union is not None:
            lines.extend(self.render_union_variant(union, "    "))
        lines.append("  end;")
        lines.append(f"  P{name} = ^{name};")
        lines.append(f"  PP{name} = ^P{name};")
        return lines


def preprocess(header: str, inc_dirs: list[str], out_c: str):
    cmd = [
        "gcc", "-E", "-std=c99", "-nostdinc",
        "-include", FAKE,
    ]
    for d in inc_dirs:
        cmd.extend(["-I", d])
    cmd.extend([header, "-o", out_c])
    subprocess.check_call(cmd, stderr=subprocess.DEVNULL)


def parse(path: str):
    return parse_file(path, use_cpp=False)


def collect(conv: Conv, ast, allow: set[str]):
    """Return ordered items: ('enum'| 'alias' | 'proc' | 'record' | 'func', payload)."""
    items = []
    seen_records = set()
    for node in ast.ext:
        fn = basename(getattr(node, "coord", None))
        if fn not in allow:
            continue
        if isinstance(node, c_ast.Typedef):
            t = node.type
            # unwrap TypeDecl
            if isinstance(t, c_ast.TypeDecl):
                inner = t.type
                name = ident(node.name)
                if isinstance(inner, c_ast.Enum):
                    conv.remember(name)
                    items.append(("enum", name, inner))
                    continue
                if isinstance(inner, c_ast.IdentifierType):
                    conv.remember(name)
                    items.append(("alias", name, conv.render_ident_type(inner.names)))
                    continue
                if isinstance(inner, c_ast.Struct):
                    if inner.decls is None:
                        conv.opaque.add(name)
                        conv.remember(name)
                        items.append(("opaque", name))
                        continue
                    conv.remember(name)
                    fields, union = conv.struct_fields(inner)
                    conv.opaque.discard(name)
                    items.append(("record", name, fields, union))
                    seen_records.add(name)
                    continue
                if isinstance(inner, c_ast.Union):
                    conv.remember(name)
                    fields, _ = conv.struct_fields(c_ast.Struct(name, inner.decls))
                    # union typedef as variant-only record
                    items.append(("record", name, [], inner))
                    continue
            if isinstance(t, c_ast.PtrDecl) and isinstance(t.type, c_ast.FuncDecl):
                name = ident(node.name)
                conv.remember(name)
                items.append(("proctype", name, t.type))
                continue
            conv.warn(f"typedef {node.name} shape {type(t).__name__}")
            continue
        if isinstance(node, c_ast.Decl):
            if isinstance(node.type, c_ast.FuncDecl):
                items.append(("func", node))
                continue
            if isinstance(node.type, c_ast.Struct) and node.type.decls is not None:
                name = ident(node.type.name or node.name)
                if not name:
                    conv.warn("anonymous struct decl")
                    continue
                conv.remember(name)
                conv.opaque.discard(name)
                fields, union = conv.struct_fields(node.type)
                items.append(("record", name, fields, union))
                continue
            conv.warn(f"decl {node.name} {type(node.type).__name__} @ {fn}")
            continue
        if isinstance(node, c_ast.FuncDef):
            continue
        conv.warn(f"skip {type(node).__name__}")
    return items


def emit_types(conv: Conv, items) -> list[str]:
    if not conv.type_names and not conv.extra_ptrs:
        return []
    lines = ["type"]
    # forward pointers for every named type so callbacks can mention them early
    for name in conv.type_names:
        lines.append(f"  P{name} = ^{name};")
        lines.append(f"  PP{name} = ^P{name};")
    for extra in sorted(conv.extra_ptrs):
        # extra is like PPInteger meaning ^PInteger — declared if not a known type pointer
        if extra.startswith("PP") and not any(extra == f"PP{n}" for n in conv.type_names):
            target = extra[1:]  # PInteger
            if target in SYS_PTR or target.startswith("P"):
                lines.append(f"  {extra} = ^{target};")
    # drop opaque items that were later completed
    completed = {it[1] for it in items if it[0] == "record"}
    emitted_body = set()
    for it in items:
        kind = it[0]
        if kind == "opaque":
            name = it[1]
            if name in completed:
                continue
            lines.append(f"  {name} = record end;")
            emitted_body.add(name)
        elif kind == "alias":
            _, name, rhs = it
            lines.append(f"  {name} = {rhs};")
            emitted_body.add(name)
        elif kind == "enum":
            _, name, enum = it
            body = conv.render_enum_body(enum)
            lines.append(f"  {name} = {body};")
            emitted_body.add(name)
        elif kind == "proctype":
            _, name, func = it
            lines.append(f"  {name} = {conv.render_func_type(func)};")
            emitted_body.add(name)
        elif kind == "record":
            _, name, fields, union = it
            if name in emitted_body:
                continue
            # forward P/PP already emitted; don't re-emit them inside emit_record
            lines.append(f"  {name} = record")
            for fname, ftyp in fields:
                lines.append(f"    {fname}: {ftyp};")
            if union is not None and not isinstance(union, list):
                lines.extend(conv.render_union_variant(union, "    "))
            lines.append("  end;")
            conv.structs[name] = fields
            emitted_body.add(name)
    return lines


def emit_funcs(conv: Conv, items) -> list[str]:
    lines = []
    for it in items:
        if it[0] != "func":
            continue
        node = it[1]
        name = ident(node.name)
        func = node.type
        params, varargs = conv.render_params(func.args)
        void_ret = conv._is_void_type(func.type)
        cc = "cdecl" if varargs else "FMOD_CC"
        var = "; varargs" if varargs else ""
        cname = node.name
        if void_ret:
            sig = f"procedure {name}({params}); {cc}{var}"
            ret = None
        else:
            ret = conv.render_type(func.type)
            sig = f"function {name}({params}): {ret}; {cc}{var}"
        lines.append(f"{sig};")
        lines.append(f"  external FMOD_LIB name '{cname}';")
        # store raw param pieces for classes
        param_list = []
        if func.args:
            used: set[str] = set()
            for i, p in enumerate(func.args.params):
                if isinstance(p, c_ast.EllipsisParam):
                    continue
                if isinstance(p, c_ast.Decl):
                    if p.name is None and conv._is_void_type(p.type):
                        continue
                    pname = ident(p.name or f"arg{i+1}", used)
                    ptyp = conv.render_type(p.type)
                    param_list.append((pname, ptyp))
        conv.funcs.append({
            "name": name,
            "cname": cname,
            "params": param_list,
            "ret": ret,
            "varargs": varargs,
        })
    return lines


SKIP_DEFINES = {
    "F_API", "F_CALL", "F_CALLBACK", "F_CDECL", "F_STDCALL", "F_DECLSPEC",
    "F_DLLEXPORT", "F_EXPORT", "FB_API", "FB_CALL", "FB_EXPORT", "DLL_EXPORTS",
}


def strip_comments(text: str) -> str:
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    text = re.sub(r"//.*?$", "", text, flags=re.M)
    return text


def translate_macro_expr(expr: str) -> str:
    expr = expr.strip()
    expr = re.sub(r"\b0x([0-9A-Fa-f]+)[uUlL]*", lambda m: "$" + m.group(1).upper(), expr)
    expr = re.sub(r"(\d+)[uUlL]+\b", r"\1", expr)
    expr = re.sub(r"(\d*\.\d+|\d+\.)[fF]\b", r"\1", expr)
    expr = expr.replace("|", " or ").replace("&", " and ")
    expr = expr.replace("<<", " shl ").replace(">>", " shr ")
    expr = expr.replace("~", "not ")
    expr = re.sub(r"[ \t]+", " ", expr)
    return expr.strip()


def extract_defines(paths: list[str]) -> tuple[list[tuple[str, str]], list[tuple[str, str]]]:
    scalars = []
    presets = []
    for path in paths:
        text = strip_comments(open(path, errors="replace").read())
        text = text.replace("\\\n", " ")
        for m in re.finditer(r"^[ \t]*#define[ \t]+(\w+)(?:\((.*?)\))?[ \t]*(.*?)$", text, re.M):
            name, args, rest = m.group(1), m.group(2), m.group(3).strip()
            if name.startswith("_") or name in SKIP_DEFINES:
                continue
            if args is not None:
                continue  # function-like, handled separately
            if not rest:
                continue
            if rest.startswith("{"):
                presets.append((name, rest))
            else:
                scalars.append((name, translate_macro_expr(rest)))
    return scalars, presets


def split_brace_list(body: str) -> list[str]:
    assert body.startswith("{") and body.endswith("}")
    inner = body[1:-1].strip()
    parts = [translate_macro_expr(p.strip()) for p in inner.split(",")]
    return parts


def emit_presets(presets, structs) -> list[str]:
    if not presets:
        return []
    fields = structs.get("FMOD_REVERB_PROPERTIES")
    if not fields:
        return [f"  {{ preset {n} skipped: FMOD_REVERB_PROPERTIES missing }}" for n, _ in presets]
    lines = ["", "const"]
    for name, body in presets:
        vals = split_brace_list(body)
        if len(vals) != len(fields):
            lines.append(f"  {{ {name}: {len(vals)} values, struct has {len(fields)} fields }}")
            continue
        lines.append(f"  {name}: FMOD_REVERB_PROPERTIES = (")
        assigns = []
        for (fname, ftyp), val in zip(fields, vals):
            if ftyp == "Single" and re.fullmatch(r"[+-]?\d+", val):
                val = val + ".0"
            assigns.append(f"    {fname}: {val}")
        lines.append(";\n".join(assigns))
        lines.append("  );")
    return lines


def error_string_func(header: str, fn_name: str) -> tuple[str, str]:
    text = open(header, errors="replace").read()
    cases = re.findall(
        r'case\s+(\w+)\s*:\s*return\s+"((?:\\.|[^"\\])*)"\s*;',
        text,
    )
    default = "Unknown error."
    m = re.search(r'default\s*:\s*return\s+"((?:\\.|[^"\\])*)"', text)
    if m:
        default = m.group(1)
    iface = f"function {fn_name}(errcode: FMOD_RESULT): AnsiString;"
    # fsbank uses FSBANK_RESULT
    if "FSBANK" in fn_name or "fsbank" in os.path.basename(header):
        iface = f"function {fn_name}(errcode: FSBANK_RESULT): AnsiString;"
    body = [iface, "begin", "  case errcode of"]
    for enum, msg in cases:
        msg = msg.replace("'", "''")
        body.append(f"    {enum}: Result := '{msg}';")
    default = default.replace("'", "''")
    body.append("  else")
    body.append(f"    Result := '{default}';")
    body.append("  end;")
    body.append("end;")
    return iface + "\n", "\n".join(body) + "\n"


UNIT_HEADER = """\
(*
  FreePascal binding for {title}
  API version {version} ({hexver})

  Unofficial translation of the C API. FMOD is a trademark of Firelight
  Technologies Pty Ltd. This unit does not include the FMOD library;
  obtain a licensed SDK from https://www.fmod.com/ and ship the matching
  shared library next to your executable.

  Calling convention matches the C headers: stdcall on Windows, cdecl elsewhere.
  Records use PACKRECORDS C so the layout matches the C ABI.

  Define FMOD_LOGGING to link the logging build (fmodL / fmodexL).
*)
{{$IFDEF FPC}}
  {{$MODE OBJFPC}}{{$H+}}{{$PACKRECORDS C}}{{$PACKENUM 4}}{{$MACRO ON}}
  {{$MODESWITCH RESULT+}}
{{$ENDIF}}
unit {unit};
"""


def lib_const(kind: str) -> str:
    # kind: core4, event, eventnet, core2, studio, fsbank
    table = {
        "core4": (
            "fmodex64.dll", "fmodex.dll", "fmodexL64.dll", "fmodexL.dll",
            "libfmodex64.so", "libfmodex.so", "libfmodexL64.so", "libfmodexL.so",
            "libfmodex.dylib", "libfmodexL.dylib",
        ),
        "event": (
            "fmod_event64.dll", "fmod_event.dll", "fmod_eventL64.dll", "fmod_eventL.dll",
            "libfmodevent64.so", "libfmodevent.so", "libfmodeventL64.so", "libfmodeventL.so",
            "libfmodevent.dylib", "libfmodeventL.dylib",
        ),
        "eventnet": (
            "fmod_event_net64.dll", "fmod_event_net.dll", "fmod_event_netL64.dll", "fmod_event_netL.dll",
            "libfmodeventnet64.so", "libfmodeventnet.so", "libfmodeventnetL64.so", "libfmodeventnetL.so",
            "libfmodeventnet.dylib", "libfmodeventnetL.dylib",
        ),
        "core2": (
            "fmod.dll", "fmod.dll", "fmodL.dll", "fmodL.dll",
            "libfmod.so", "libfmod.so", "libfmodL.so", "libfmodL.so",
            "libfmod.dylib", "libfmodL.dylib",
        ),
        "studio": (
            "fmodstudio.dll", "fmodstudio.dll", "fmodstudioL.dll", "fmodstudioL.dll",
            "libfmodstudio.so", "libfmodstudio.so", "libfmodstudioL.so", "libfmodstudioL.so",
            "libfmodstudio.dylib", "libfmodstudioL.dylib",
        ),
        "fsbank": (
            "fsbank.dll", "fsbank.dll", "fsbank.dll", "fsbank.dll",
            "libfsbank.so", "libfsbank.so", "libfsbank.so", "libfsbank.so",
            "libfsbank.dylib", "libfsbank.dylib",
        ),
    }
    w64, w32, wl64, wl32, l64, l32, ll64, ll32, d, dl = table[kind]
    return f"""\
const
{{$IF defined(MSWINDOWS)}}
  {{$IF defined(FMOD_LOGGING)}}
    {{$IF defined(WIN64)}}
  FMOD_LIB = '{wl64}';
    {{$ELSE}}
  FMOD_LIB = '{wl32}';
    {{$ENDIF}}
  {{$ELSE}}
    {{$IF defined(WIN64)}}
  FMOD_LIB = '{w64}';
    {{$ELSE}}
  FMOD_LIB = '{w32}';
    {{$ENDIF}}
  {{$ENDIF}}
{{$ELSEIF defined(DARWIN)}}
  {{$IF defined(FMOD_LOGGING)}}
  FMOD_LIB = '{dl}';
  {{$ELSE}}
  FMOD_LIB = '{d}';
  {{$ENDIF}}
{{$ELSE}}
  {{$IF defined(FMOD_LOGGING)}}
    {{$IF defined(CPU64)}}
  FMOD_LIB = '{ll64}';
    {{$ELSE}}
  FMOD_LIB = '{ll32}';
    {{$ENDIF}}
  {{$ELSE}}
    {{$IF defined(CPU64)}}
  FMOD_LIB = '{l64}';
    {{$ELSE}}
  FMOD_LIB = '{l32}';
    {{$ENDIF}}
  {{$ENDIF}}
{{$ENDIF}}

{{$IF defined(MSWINDOWS)}}
  {{$DEFINE FMOD_CC := stdcall}}
{{$ELSE}}
  {{$DEFINE FMOD_CC := cdecl}}
{{$ENDIF}}
"""


def build_unit(spec) -> tuple[str, Conv]:
    out_c = f"/tmp/pp_{spec['unit']}.c"
    preprocess(spec["header"], spec["inc"], out_c)
    ast = parse(out_c)
    conv = Conv()
    items = collect(conv, ast, spec["allow"])
    # second pass: extra_ptrs discovered during collect's render, but render
    # happens inside collect before extra_ptrs is complete. Re-render by
    # running collect once (extra_ptrs filled during collect). emit_types
    # reads extra_ptrs. However render during collect already ran, and
    # extra_ptrs is filled as a side effect BEFORE emit_types. Good.
    # Problem: emit_types calls render again for enums only; records already
    # rendered during collect. extra_ptrs is complete. Good.

    scalars, presets = extract_defines(spec["define_paths"])
    # unique defines preserving order
    seen = set()
    scal_lines = []
    for n, e in scalars:
        if n in seen:
            continue
        seen.add(n)
        scal_lines.append(f"  {n} = {e};")

    err_iface, err_impl = ("", "")
    if spec.get("errors"):
        err_iface, err_impl = error_string_func(spec["errors"], spec["error_fn"])

    body = []
    body.append(UNIT_HEADER.format(
        title=spec["title"], version=spec["version"], hexver=spec["hexver"], unit=spec["unit"]
    ))
    body.append("interface\n")
    if spec.get("uses"):
        body.append("uses\n  " + ", ".join(spec["uses"]) + ";\n")
    body.append(lib_const(spec["lib"]))
    if scal_lines:
        body.append("const\n" + "\n".join(scal_lines) + "\n")
    tlines = emit_types(conv, items)
    body.append("\n".join(tlines) + "\n")
    pre = emit_presets(presets, conv.structs)
    if pre:
        body.append("\n".join(pre) + "\n")
    flines = emit_funcs(conv, items)
    if flines:
        body.append("\n".join(flines) + "\n")
    if err_iface:
        body.append(err_iface)
    impl_extra = spec.get("impl", "")
    body.append("\nimplementation\n")
    if err_impl:
        body.append(err_impl)
    if impl_extra:
        body.append(impl_extra)
    body.append("end.\n")
    text = "\n".join(body)
    # the template doubled braces; UNIT_HEADER uses {{ for format. lib_const also used {{.
    # Wait: I used format() only on UNIT_HEADER. lib_const returns a string with {{ already
    # as literal braces because I wrote {{ in the f-string... LOOK.
    # lib_const is an f-string! {{ becomes {. Good.
    # UNIT_HEADER is formatted, {{ becomes {. Good.
    # But I then join and the file should contain single braces.
    return text, conv


HELPERS_64 = """
procedure FMOD_64BIT_ADD(var hi1, lo1: Cardinal; hi2, lo2: Cardinal);
begin
  hi1 := hi1 + hi2 + Cardinal(Ord((lo1 + lo2) < lo1));
  lo1 := lo1 + lo2;
end;

procedure FMOD_64BIT_SUB(var hi1, lo1: Cardinal; hi2, lo2: Cardinal);
begin
  hi1 := hi1 - (hi2 + Cardinal(Ord((lo1 - lo2) > lo1)));
  lo1 := lo1 - lo2;
end;
"""

HELPERS_64_IFACE = """
{ 64-bit hi/lo helpers from fmod.h (FMOD_64BIT_ADD / FMOD_64BIT_SUB). }
procedure FMOD_64BIT_ADD(var hi1, lo1: Cardinal; hi2, lo2: Cardinal);
procedure FMOD_64BIT_SUB(var hi1, lo1: Cardinal; hi2, lo2: Cardinal);
"""


def disambiguate(params, banned: set[str]):
    used = {b.lower() for b in banned}
    out = []
    for n, t in params:
        nn = n
        while nn.lower() in used:
            nn += "_"
        used.add(nn.lower())
        out.append((nn, t))
    return out


def fmt_params(params) -> str:
    if not params:
        return ""
    return "(" + "; ".join(f"{n}: {t}" for n, t in params) + ")"


def classes_unit(conv: Conv, unit: str, base_unit: str, handles: set[str]) -> str:
    """OOP wrapper mirroring the C++ classes: method = C function without the handle."""
    by_handle: dict[str, list] = OrderedDict()
    for fn in conv.funcs:
        if fn["varargs"] or not fn["params"]:
            continue
        _pname, ptyp = fn["params"][0]
        m = re.fullmatch(r"P(FMOD_[A-Za-z0-9_]+)", ptyp)
        if m and m.group(1) in handles:
            by_handle.setdefault(m.group(1), []).append(fn)

    uses = [base_unit] if base_unit == "fmod" else ["fmod", base_unit]
    lines = []
    lines.append(f"""\
(*
  Object Pascal wrappers around the flat C API, shaped like the C++ headers
  (fmod.hpp / fmod_studio.hpp / fmod_event.hpp). Methods are not C++ exports;
  each one calls the matching stdcall/cdecl C function.

  FHandle is not owned. Call Release (where it exists) before freeing the
  wrapper, or use the wrapper as a non-owning view of an existing handle.
*)
{{$IFDEF FPC}}
  {{$MODE OBJFPC}}{{$H+}}{{$MODESWITCH RESULT+}}
{{$ENDIF}}
unit {unit};

interface

uses
  {', '.join(uses)};

type
""")
    prepared: dict[str, list] = {}
    for handle, fns in by_handle.items():
        cname = "T" + handle
        methods = []
        for fn in fns:
            mname = method_name(fn["name"], handle)
            methods.append(mname)
        banned = set(methods) | {"FHandle", "Make", "Create", "Destroy", "Free"}
        prepared[handle] = []
        lines.append(f"  {cname} = class")
        lines.append("  public")
        lines.append(f"    FHandle: P{handle};")
        factory = None
        for fn in conv.funcs:
            if fn["params"] and fn["params"][0][1] == f"PP{handle}" and fn["name"].endswith("_Create"):
                factory = fn
                break
        if factory is not None:
            extra = disambiguate(factory["params"][1:], {"Inst", "Result", "h"})
            parts = [f"{n}: {t}" for n, t in extra] + [f"out Inst: {cname}"]
            lines.append(f"    class function Make({'; '.join(parts)}): FMOD_RESULT;")
        for fn in fns:
            rest = disambiguate(fn["params"][1:], banned)
            mname = method_name(fn["name"], handle)
            prepared[handle].append((fn, mname, rest))
            if fn["ret"] is None:
                lines.append(f"    procedure {mname}{fmt_params(rest)};")
            else:
                lines.append(f"    function {mname}{fmt_params(rest)}: {fn['ret']};")
        lines.append("  end;")
        lines.append("")
    lines.append("implementation")
    lines.append("")
    for handle, fns in by_handle.items():
        cname = "T" + handle
        factory = None
        for fn in conv.funcs:
            if fn["params"] and fn["params"][0][1] == f"PP{handle}" and fn["name"].endswith("_Create"):
                factory = fn
                break
        if factory is not None:
            extra = disambiguate(factory["params"][1:], {"Inst", "Result", "h"})
            parts = [f"{n}: {t}" for n, t in extra] + [f"out Inst: {cname}"]
            call = ", ".join(["@h"] + [n for n, _ in extra])
            lines.append(f"class function {cname}.Make({'; '.join(parts)}): FMOD_RESULT;")
            lines.append("var")
            lines.append(f"  h: P{handle};")
            lines.append("begin")
            lines.append(f"  Result := {factory['name']}({call});")
            lines.append("  if Result = FMOD_OK then")
            lines.append("  begin")
            lines.append(f"    Inst := {cname}.Create;")
            lines.append("    Inst.FHandle := h;")
            lines.append("  end")
            lines.append("  else")
            lines.append("    Inst := nil;")
            lines.append("end;")
            lines.append("")
        for fn, mname, rest in prepared[handle]:
            if fn["ret"] is None:
                lines.append(f"procedure {cname}.{mname}{fmt_params(rest)};")
                call_args = ", ".join(["FHandle"] + [n for n, _ in rest])
                lines.append("begin")
                lines.append(f"  {fn['name']}({call_args});")
                lines.append("end;")
            else:
                lines.append(f"function {cname}.{mname}{fmt_params(rest)}: {fn['ret']};")
                call_args = ", ".join(["FHandle"] + [n for n, _ in rest])
                lines.append("begin")
                lines.append(f"  Result := {fn['name']}({call_args});")
                lines.append("end;")
            lines.append("")
    lines.append("end.")
    return "\n".join(lines) + "\n"


def _removed_old_classes():
    return None


def method_name(fn_name: str, handle: str) -> str:
    # FMOD_System_SetOutput -> SetOutput ; FMOD_Studio_System_Create handled elsewhere
    prefix = handle + "_"  # FMOD_SYSTEM is the type, function prefix is FMOD_System not FMOD_SYSTEM
    # function names use the C prefix which matches the typedef but not always the same case.
    # FMOD_System_SetOutput vs handle FMOD_SYSTEM. Strip the longest function prefix.
    # We stored cname. fn_name is sanitized ident equal to C name (no reserved clash expected).
    # Remove leading FMOD_ / FSBANK_ token group until the method.
    parts = fn_name.split("_")
    # Method is the last component only if CamelCase is one token. FMOD_System_SetOutput -> SetOutput
    # FMOD_Studio_EventInstance_GetDescription -> GetDescription
    # Heuristic: drop leading tokens while the remainder joined doesn't start with an uppercase method...
    # The C method token is everything after the handle prefix.
    # Map handle FMOD_SYSTEM -> prefix candidates FMOD_System_
    # Build prefix from function by matching case-insensitive handle with underscores removed.
    h = handle.replace("_", "").lower()
    acc = ""
    for i, p in enumerate(parts):
        acc += p
        if acc.lower() == h or acc.lower().replace("_", "") == h:
            rest = parts[i+1:]
            return ident("_".join(rest)) if rest else ident(fn_name)
        acc += "_"
    return ident(parts[-1])


def write(path: str, text: str):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", newline="\n") as f:
        f.write(text)
    print(f"wrote {path} ({len(text.splitlines())} lines)")


def main():
    os.makedirs(OUT, exist_ok=True)
    v4 = os.path.join(ROOT, "fmodapi44464win-installer")
    v2 = os.path.join(ROOT, "fmodstudioapi20022win-installer")
    specs = [
        dict(
            unit="fmod",
            title="FMOD Ex",
            version="4.44.64",
            hexver="0x00044464",
            header=f"{v4}/api/inc/fmod.h",
            inc=[f"{v4}/api/inc"],
            allow={"fmod.h", "fmod_codec.h", "fmod_dsp.h", "fmod_output.h", "fmod_memoryinfo.h"},
            define_paths=[
                f"{v4}/api/inc/fmod.h",
                f"{v4}/api/inc/fmod_dsp.h",
                f"{v4}/api/inc/fmod_codec.h",
                f"{v4}/api/inc/fmod_output.h",
                f"{v4}/api/inc/fmod_memoryinfo.h",
            ],
            lib="core4",
            errors=f"{v4}/api/inc/fmod_errors.h",
            error_fn="FMOD_ErrorString",
            out=f"{OUT}/fmod-4.44.64/fmod.pas",
            classes=f"{OUT}/fmod-4.44.64/fmod_classes.pas",
            uses=[],
        ),
        dict(
            unit="fmdevent",
            title="FMOD Ex Event / Designer API",
            version="4.44.64",
            hexver="0x00044464",
            header=f"{v4}/fmoddesignerapi/api/inc/fmod_event.h",
            inc=[f"{v4}/fmoddesignerapi/api/inc", f"{v4}/api/inc"],
            allow={"fmod_event.h"},
            define_paths=[f"{v4}/fmoddesignerapi/api/inc/fmod_event.h"],
            lib="event",
            errors=None,
            out=f"{OUT}/fmod-4.44.64/fmdevent.pas",
            classes=f"{OUT}/fmod-4.44.64/fmdevent_classes.pas",
            uses=["fmod"],
        ),
        dict(
            unit="fmdeventnet",
            title="FMOD Ex Event Network API",
            version="4.44.64",
            hexver="0x00044464",
            header=f"{v4}/fmoddesignerapi/api/inc/fmod_event_net.h",
            inc=[f"{v4}/fmoddesignerapi/api/inc", f"{v4}/api/inc"],
            allow={"fmod_event_net.h"},
            define_paths=[f"{v4}/fmoddesignerapi/api/inc/fmod_event_net.h"],
            lib="eventnet",
            errors=None,
            out=f"{OUT}/fmod-4.44.64/fmdeventnet.pas",
            classes=None,
            uses=["fmod", "fmdevent"],
        ),
        dict(
            unit="fmod",
            title="FMOD Core",
            version="2.00.22",
            hexver="0x00020022",
            header=f"{v2}/api/core/inc/fmod.h",
            inc=[f"{v2}/api/core/inc"],
            allow={"fmod.h", "fmod_common.h", "fmod_codec.h", "fmod_dsp.h", "fmod_dsp_effects.h", "fmod_output.h"},
            define_paths=[
                f"{v2}/api/core/inc/fmod_common.h",
                f"{v2}/api/core/inc/fmod_dsp.h",
                f"{v2}/api/core/inc/fmod_dsp_effects.h",
                f"{v2}/api/core/inc/fmod_output.h",
                f"{v2}/api/core/inc/fmod.h",
            ],
            lib="core2",
            errors=f"{v2}/api/core/inc/fmod_errors.h",
            error_fn="FMOD_ErrorString",
            out=f"{OUT}/fmod-2.00.22/fmod.pas",
            classes=f"{OUT}/fmod-2.00.22/fmod_classes.pas",
            uses=[],
        ),
        dict(
            unit="fmodstudio",
            title="FMOD Studio",
            version="2.00.22",
            hexver="0x00020022",
            header=f"{v2}/api/studio/inc/fmod_studio.h",
            inc=[f"{v2}/api/studio/inc", f"{v2}/api/core/inc"],
            allow={"fmod_studio.h", "fmod_studio_common.h"},
            define_paths=[
                f"{v2}/api/studio/inc/fmod_studio_common.h",
                f"{v2}/api/studio/inc/fmod_studio.h",
            ],
            lib="studio",
            errors=None,
            out=f"{OUT}/fmod-2.00.22/fmodstudio.pas",
            classes=f"{OUT}/fmod-2.00.22/fmodstudio_classes.pas",
            uses=["fmod"],
        ),
        dict(
            unit="fsbank",
            title="FMOD FSBank",
            version="2.00.22",
            hexver="0x00020022",
            header=f"{v2}/api/fsbank/inc/fsbank.h",
            inc=[f"{v2}/api/fsbank/inc"],
            allow={"fsbank.h"},
            define_paths=[f"{v2}/api/fsbank/inc/fsbank.h"],
            lib="fsbank",
            errors=f"{v2}/api/fsbank/inc/fsbank_errors.h",
            error_fn="FSBank_ErrorString",
            out=f"{OUT}/fmod-2.00.22/fsbank.pas",
            classes=None,
            uses=[],
        ),
    ]

    # fmod 4 also needs output header even if not included by fmod.h — it is NOT included.
    # I added fmod_output.h to allow list but it is only parsed if the preprocessed TU includes it.
    # fmod.h 4.44 does NOT include fmod_output.h. Parse it by appending? I'll add it to a second
    # translation unit merged manually: preprocess output and merge items.
    report = []
    for spec in specs:
        print("===", spec["out"])
        text, conv = build_unit(spec)
        if spec["unit"] == "fmod" and spec["version"].startswith("4."):
            # pull fmod_output.h which is not included by fmod.h
            spec2 = dict(spec)
            spec2["header"] = f"{v4}/api/inc/fmod_output.h"
            spec2["allow"] = {"fmod_output.h"}
            # build_unit would re-emit the whole unit. Instead preprocess separately and splice
            # functions/types by calling internals.
            out_c = "/tmp/pp_fmod_output.c"
            preprocess(spec2["header"], spec["inc"], out_c)
            ast = parse(out_c)
            conv2 = Conv()
            items2 = collect(conv2, ast, {"fmod_output.h"})
            # Only types/functions that are new. Splice before implementation.
            extra_types = emit_types(conv2, items2)
            # emit_types includes forward pointers for conv2 only; the output structs
            # reference fmod types which live in the main unit. Forward pointers inside
            # a second type block CANNOT see... they can, previous type block is in scope.
            # But P-names for fmod types shouldn't be redeclared. emit_types emits P for
            # every type in conv2, which is only output types. Good.
            extra_funcs = emit_funcs(conv2, items2)
            # Remove duplicate forward P for types already in main? only output types.
            needle = "\nimplementation\n"
            extra = "\n{ fmod_output.h }\n" + "\n".join(extra_types) + "\n" + "\n".join(extra_funcs) + "\n"
            # also 64-bit helpers
            text = text.replace(needle, HELPERS_64_IFACE + extra + needle + HELPERS_64 + "\n")
            conv.funcs.extend(conv2.funcs)
            conv.structs.update(conv2.structs)
            conv.warnings.extend(conv2.warnings)
            handles = set(conv.opaque) | {n for n, fs in conv.structs.items() if not fs}
            # opaque set may have been discarded. Handles are record end types.
            # We'll pass structs with no fields unioned with names that are empty records.
            # Recompute: types that are opaque pointers used as first params.
        if spec["unit"] == "fmod" and spec["version"].startswith("4."):
            pass
        # inject 64bit iface for v4 already done
        if spec.get("classes"):
            handles = set()
            for fn in conv.funcs:
                if not fn["params"]:
                    continue
                ptyp = fn["params"][0][1]
                m = re.fullmatch(r"P(FMOD_[A-Za-z0-9_]+)", ptyp)
                if m:
                    handles.add(m.group(1))
            ctext = classes_unit(conv, spec["classes"].split("/")[-1].replace(".pas", ""), spec["unit"], handles)
            write(spec["classes"], ctext)
        write(spec["out"], text)
        report.append((spec["out"], len(conv.funcs), len(conv.warnings), conv.warnings[:15]))
    print("\\n==== REPORT ====")
    for path, nfunc, nw, ws in report:
        print(f"{path}: funcs={nfunc} warnings={nw}")
        for w in ws:
            print("   ", w)


if __name__ == "__main__":
    main()
