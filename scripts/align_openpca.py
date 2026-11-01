"""Deterministic document<->model alignment for Open PCA Pump (SRC-OPENPCA-001/002).

Three evidence layers:
  body   : requirement definitions in ch.3-8, footnotes "requirement R6.5.0(n): title"
  alloc  : ch.10 "Allocated Requirements" lists under architecture headings (R5.5.0(n) title)
  aadl   : comments "--R5.5.0(n) title" in .aadl packages
Identity rule (plan s5, review v0 s3): alloc/aadl id resolves to a body id only if
  (a) id equal after +1 chapter shift (or verbatim) AND (b) title string equal (case-insensitive).
Either condition alone -> not_established. No LLM is involved.

Usage: python align_openpca.py <requirements.txt> <aadl_dir> <out_dir>
"""
import csv, glob, io, json, os, re, sys

txt_path, aadl_dir, out = sys.argv[1], sys.argv[2], sys.argv[3]
os.makedirs(out, exist_ok=True)
txt = io.open(txt_path, encoding="utf-8").read()
ID = r"R\d+\.\d+\.\d+\(\d+\)"

pages = [(m.start(), int(m.group(1))) for m in re.finditer(r"-(\d{1,3})-March 30, 2018", txt)]
def page(pos):
    for s, n in pages:
        if s >= pos: return n
    return None

# body footnote definitions
body = {}
for m in re.finditer(r"requirement (" + ID + r"): ([^\n]+)", txt):
    body[m.group(1)] = dict(title=m.group(2).strip().lower(), pos=m.start(), page=page(m.start()))

# allocation lists in ch.10, split merged lines into id/title tokens
arch_start = txt.find("10 Functional Architecture")
sec10 = txt[arch_start:]
alloc = []  # (heading, id, title, pos)
heading = None
for m in re.finditer(r"\n(10\.\d+(?:\.\d+)?) ([A-Z][^\n]{0,50})|\n((?:" + ID + r" [^\n]+))", sec10):
    if m.group(1):
        heading = f"{m.group(1)} {m.group(2).strip()}"
    elif heading:
        line = m.group(3)
        toks = re.split(r"(?=" + ID + r")", line)
        for t in toks:
            mm = re.match(r"(" + ID + r") (.+)", t.strip())
            if mm: alloc.append((heading, mm.group(1), mm.group(2).strip().lower(), arch_start + m.start()))

# AADL citations
aadl = []
for f in sorted(glob.glob(os.path.join(aadl_dir, "**", "*.aadl"), recursive=True)):
    for i, line in enumerate(io.open(f, encoding="utf-8", errors="replace").read().splitlines()):
        for mm in re.finditer(r"--\s*(" + ID + r")\s*([^\n]*)", line):
            aadl.append((os.path.relpath(f, aadl_dir), i + 1, mm.group(1), mm.group(2).strip().lower()))

def shift(i):
    m = re.match(r"R(\d+)\.(\d+\.\d+\(\d+\))", i); return f"R{int(m.group(1))+1}.{m.group(2)}"

def resolve(i, title):
    cands = [c for c in (i, shift(i)) if c in body]
    if not cands: return None, "id not defined in body (verbatim or +1 shift)"
    for c in cands:
        if body[c]["title"] == title: return c, "verbatim id" if c == i else "+1 chapter shift"
    return None, f"id {cands[0]} found but title differs: body '{body[cands[0]]['title']}'"

claims = []
for heading, aid, title, pos in alloc:
    bid, how = resolve(aid, title)
    aadl_hits = [(f, ln) for f, ln, cid, _ in aadl if cid == aid]
    status = "supported" if bid else "not_established"
    claims.append(dict(project="openpca", claim_type="A allocation (+C identity)", component=heading, subject=aid,
        model_claim=f"Requirement '{title}' ({bid or aid}) is allocated to {heading}",
        body_id=bid or "", body_evidence=f"p.{body[bid]['page']} footnote {bid}" if bid else "",
        alloc_evidence=f"p.{page(pos)} s{heading.split()[0]} Allocated Requirements ({aid})",
        aadl_evidence="; ".join(f"{f}:{ln}" for f, ln in aadl_hits), identity_basis=how,
        distance_tokens=(pos - body[bid]["pos"]) // 4 if bid else "", status=status, reason="" if bid else how))

# AADL citations not in allocation lists
alloc_ids = {a[1] for a in alloc}
for f, ln, cid, ctitle in aadl:
    if cid not in alloc_ids:
        claims.append(dict(project="openpca", claim_type="A allocation (AADL only)", component=f, subject=cid,
            model_claim=f"AADL cites {cid} {ctitle}", body_id="", body_evidence="", alloc_evidence="",
            aadl_evidence=f"{f}:{ln}", identity_basis="", distance_tokens="", status="not_established", reason="cited in AADL but absent from ch.10 allocation lists"))

fields = ["project", "claim_type", "component", "subject", "model_claim", "body_id", "body_evidence", "alloc_evidence", "aadl_evidence", "identity_basis", "distance_tokens", "status", "reason"]
with io.open(os.path.join(out, "openpca_claims.csv"), "w", encoding="utf-8", newline="") as fh:
    w = csv.DictWriter(fh, fieldnames=fields); w.writeheader(); [w.writerow(c) for c in claims]
summ = dict(body_defs=len(body), alloc_entries=len(alloc), alloc_distinct=len(alloc_ids), aadl_citations=len(aadl),
            supported=sum(c["status"] == "supported" for c in claims), not_established=sum(c["status"] != "supported" for c in claims),
            by_basis={})
for c in claims: summ["by_basis"][c["identity_basis"] or c["reason"]] = summ["by_basis"].get(c["identity_basis"] or c["reason"], 0) + 1
d = [c["distance_tokens"] for c in claims if c["distance_tokens"] != ""]
summ["distance_tokens"] = dict(min=min(d), median=sorted(d)[len(d)//2], max=max(d)) if d else None
summ["aadl_with_alloc"] = sum(1 for c in claims if c["aadl_evidence"] and c["claim_type"].startswith("A allocation (+C"))
io.open(os.path.join(out, "openpca_summary.json"), "w", encoding="utf-8").write(json.dumps(summ, indent=2, ensure_ascii=False))
print(json.dumps(summ, indent=2, ensure_ascii=False))
