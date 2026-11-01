"""Deterministic model<->document alignment for NASA F Prime (SRC-FPRIME-001/002).

Produces candidate GT claims by matching SDD tables to FPP declarations:
  D interface : SDD port-table row  -> FPP `port <name>` (direct or via `import <Interface>`)
  A allocation: subtopology SDD traceability row -> FPP `instance <name>`
  A allocation: component SDD requirement row -> FPP component definition (single-section case)
Rules (plan s5): a claim is `supported` only when the model element is resolved by
exact identifier and the document evidence location is recorded; otherwise
`not_established` with a reason. No LLM is involved.

Usage: python align_fprime.py <fprime_repo_root> <out_dir>
"""
import csv, glob, io, json, os, re, sys

repo, out = sys.argv[1], sys.argv[2]
os.makedirs(out, exist_ok=True)

def read(p): return io.open(p, encoding="utf-8", errors="replace").read()

# ---- FPP index: ports per component (with interface expansion), instances per subtopology
interfaces = {}
for f in glob.glob(os.path.join(repo, "**", "*.fpp"), recursive=True):
    for m in re.finditer(r"interface\s+(\w+)\s*\{(.*?)\n\s*\}", read(f), re.S):
        interfaces[m.group(1)] = (f, m.group(2))

PORT_RE = re.compile(r"^\s*(?:(async|sync|guarded)\s+)?(input|output)\s+port\s+(\w+)\s*:\s*(?:\[[^\]]*\]\s*)?([\w.]+)", re.M)
# special ports (command/event/telemetry/time/param/product) and internal ports have implied types
SPECIAL_RE = re.compile(r"^\s*(command recv|command reg|command resp|event|text event|time get|telemetry|param get|param set|product request|product recv|product send|product get|internal)\s+port\s+(\w+)", re.M)
SPECIAL_TYPE = {"command recv": "Fw.Cmd", "command reg": "Fw.CmdReg", "command resp": "Fw.CmdResponse", "event": "Fw.Log", "text event": "Fw.LogText",
                "time get": "Fw.Time", "telemetry": "Fw.Tlm", "param get": "Fw.PrmGet", "param set": "Fw.PrmSet", "internal": ""}
SPECIAL_DIR = {"command recv": "input", "internal": "internal"}

def fpp_ports(text, path):
    ports = {}
    module = re.search(r"^\s*module\s+(\w+)", text, re.M)
    for m in PORT_RE.finditer(text):
        kind, direction, name, ptype = m.groups()
        if "." not in ptype and module: ptype = f"{module.group(1)}.{ptype}"  # unqualified name inside `module X {}`
        ports[name] = dict(kind=kind or "", direction=direction, type=ptype, file=path, line=text[:m.start()].count("\n") + 1)
    for m in SPECIAL_RE.finditer(text):
        skind, name = m.groups()
        ports.setdefault(name, dict(kind="special:" + skind, direction=SPECIAL_DIR.get(skind, "output"), type=SPECIAL_TYPE.get(skind, ""), file=path, line=text[:m.start()].count("\n") + 1))
    for m in re.finditer(r"^\s*import\s+([\w.]+)", text, re.M):
        iname = m.group(1).split(".")[-1]
        if iname in interfaces:
            ifile, body = interfaces[iname]
            for name, d in fpp_ports(body, ifile).items():
                d["via_interface"] = iname; ports.setdefault(name, d)
    return ports

def norm_type(t): return t.replace("::", ".").strip("`[] ")

claims = []
def add(**kw): claims.append(kw)

# ---- component SDDs
for sdd in sorted(glob.glob(os.path.join(repo, "Svc", "*", "docs", "sdd.md"))):
    comp_dir = os.path.dirname(os.path.dirname(sdd)); comp = os.path.basename(comp_dir)
    fpps = glob.glob(os.path.join(comp_dir, "*.fpp"))
    if not fpps: continue
    ftext = "\n".join(read(f) for f in fpps)
    ports = {}
    for f in fpps: ports.update(fpp_ports(read(f), os.path.relpath(f, repo)))
    comp_def = re.search(r"(active|passive|queued)\s+component\s+(\w+)", ftext)
    s = read(sdd); lines = s.splitlines()
    # port table
    for i, line in enumerate(lines):
        if re.match(r"\s*Port Data Type\s*\|", line):
            j = i + 2
            while j < len(lines) and "|" in lines[j]:
                cells = [c.strip() for c in lines[j].split("|")]
                if len(cells) >= 3:
                    names = [n.strip("` ") for n in cells[1].split("/")]
                    dirs = [d.strip() for d in cells[2].split("/")] if len(cells) > 2 else [""]
                    for k, name in enumerate(names):
                        if not name or name.lower() == "n/a": continue
                        p = ports.get(name)
                        sdd_type = norm_type(re.sub(r"\]\(.*?\)", "", cells[0]).strip("[]` "))
                        sdd_dir = (dirs[k] if k < len(dirs) else dirs[0]).lower()
                        if p is None:
                            status, reason = "not_established", "port name not declared in FPP (incl. imported interfaces)"
                        else:
                            probs = []
                            if sdd_type and sdd_type != "n/a" and p["type"] and sdd_type != p["type"]: probs.append(f"type {sdd_type} vs {p['type']}")
                            if sdd_dir and p["direction"] not in ("internal",) and not p["kind"].startswith("special") and sdd_dir != p["direction"]: probs.append(f"direction {sdd_dir} vs {p['direction']}")
                            status, reason = ("supported", "") if not probs else ("not_established", "; ".join(probs))
                        add(project="fprime", claim_type="D interface", component=comp, subject=name,
                            model_claim=f"{comp} has {sdd_dir or '?'} port {name} : {sdd_type}",
                            doc_evidence=f"{os.path.relpath(sdd, repo)}:{j+1}", doc_section="port table",
                            model_evidence=f"{p['file']}:{p['line']}" + (f" via interface {p['via_interface']}" if p and p.get('via_interface') else "") if p else "",
                            identity_basis="port name", required_contexts="SDD table + FPP (2 files)", status=status, reason=reason)
                j += 1
    # requirement table rows
    for i, line in enumerate(lines):
        m = re.match(r"\s*([A-Z][A-Za-z]+-[0-9]{3})\s*\|\s*(.+?)\s*\|", line)
        if m:
            add(project="fprime", claim_type="A allocation", component=comp, subject=m.group(1),
                model_claim=f"Requirement {m.group(1)} is allocated to component {comp_def.group(2) if comp_def else comp}: {m.group(2)[:120]}",
                doc_evidence=f"{os.path.relpath(sdd, repo)}:{i+1}", doc_section="requirements table",
                model_evidence=os.path.relpath(fpps[0], repo) if comp_def else "", identity_basis="SDD placement (component folder)",
                required_contexts="single section (table alone suffices)", status="supported" if comp_def else "not_established",
                reason="" if comp_def else "no component definition in FPP")

# ---- subtopology SDDs: traceability matrix -> instances
for sdd in sorted(glob.glob(os.path.join(repo, "Svc", "Subtopologies", "*", "docs", "sdd.md"))):
    sub_dir = os.path.dirname(os.path.dirname(sdd)); sub = os.path.basename(sub_dir)
    fpp = os.path.join(sub_dir, f"{sub}.fpp")
    if not os.path.exists(fpp): continue
    ftext = read(fpp)
    inst = {m.group(1): ftext[:m.start()].count("\n") + 1 for m in re.finditer(r"^\s*instance\s+(\$?\w+)", ftext, re.M)}
    # topology ports (`port healthRun = $health.Run`) and config modules (`module CdhCoreConfig`) are also valid satisfiers
    for m in re.finditer(r"^\s*port\s+(\w+)\s*=\s*(\$?\w+)\.(\w+)", ftext, re.M):
        inst[f"{m.group(2)}.{m.group(3)}"] = ftext[:m.start()].count("\n") + 1
    cfg_modules = {}
    for cf in glob.glob(os.path.join(sub_dir, "*Config", "*.fpp")):
        for m in re.finditer(r"^\s*module\s+(\w+)", read(cf), re.M): cfg_modules[m.group(1)] = os.path.relpath(cf, repo)
    s = read(sdd); lines = s.splitlines()
    in_trace = False
    for i, line in enumerate(lines):
        if re.match(r"#+\s*.*Traceability", line): in_trace = True; continue
        if in_trace and line.startswith("#"): in_trace = False
        if not in_trace: continue
        m = re.match(r"\s*\|\s*(SVC-[A-Z]+-[0-9]{3})\s*\|\s*(.+?)\s*\|", line)
        if not m: continue
        names = re.findall(r"`(\$?[\w.]+)`", m.group(2)) or re.findall(r"(\$?[\w.]+)", m.group(2))[:1]
        hits = [n for n in names if n in inst]
        cfg_hits = [n for n in names if n in cfg_modules]
        if hits: status, reason = "supported", ""
        elif cfg_hits: status, reason = "supported", "config module (not an instance)"
        else: status, reason = "not_established", ("configurable/deployment-provided instance not declared in this fpp" if names else "no instance named")
        add(project="fprime", claim_type="A allocation", component=sub, subject=m.group(1),
            model_claim=f"Requirement {m.group(1)} satisfied by {', '.join(names) or m.group(2)[:60]} in {sub}",
            doc_evidence=f"{os.path.relpath(sdd, repo)}:{i+1}", doc_section="traceability matrix (withheld from input)",
            model_evidence="; ".join([f"{os.path.relpath(fpp, repo)}:{inst[n]}" for n in hits] + [cfg_modules[n] for n in cfg_hits]), identity_basis="instance name" if hits else ("config module name" if cfg_hits else ""),
            required_contexts="SDD req table + prose + FPP (2-3 files)", status=status, reason=reason)

# ---- write
fields = ["project", "claim_type", "component", "subject", "model_claim", "doc_evidence", "doc_section", "model_evidence", "identity_basis", "required_contexts", "status", "reason"]
with io.open(os.path.join(out, "fprime_claims.csv"), "w", encoding="utf-8", newline="") as f:
    w = csv.DictWriter(f, fieldnames=fields); w.writeheader(); [w.writerow(c) for c in claims]
summary = {}
for c in claims:
    k = (c["claim_type"], c["status"]); summary[k] = summary.get(k, 0) + 1
summ = {f"{k[0]} / {k[1]}": v for k, v in sorted(summary.items())}
summ["total"] = len(claims)
io.open(os.path.join(out, "fprime_summary.json"), "w", encoding="utf-8").write(json.dumps(summ, indent=2))
print(json.dumps(summ, indent=2))
for c in claims:
    if c["status"] != "supported": print("  NE:", c["component"], c["subject"], "|", c["reason"])
