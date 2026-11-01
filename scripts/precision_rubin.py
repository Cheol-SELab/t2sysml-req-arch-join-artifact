"""Decomposition of output allocations and precision for the Rubin runs (post-hoc, descriptive; ACCESS-048). No LLM.

The scorer counts as "spurious" every output (component, cited_id) pair that is not a GT claim. The Rubin GT covers
only DMS-REQ allocations (the trace export), while LDM-148 15.2 also lists interface-requirement identifiers
(OCS-DM-COM-ICD-xxxx etc.) and suffixed identifier variants under the components. Each output pair is classified
against a lenient parse of 15.2 in the model input (any identifier "PREFIX-dddd[a-z]", page furniture removed):
  gt              pair is a GT claim (supported or not_established)
  listed_out      pair is listed under that component in 15.2 but outside GT scope (interface ids, suffixed variants)
  wrong_component identifier is listed in 15.2, but not under the output component
  unlisted        identifier is not listed in 15.2 at all
Precision:
  doc_precision   (gt + listed_out) / output pairs        -- pair is stated by the document
  scope_precision gt / (gt + in-scope errors), in-scope = DMSR identifiers only (the GT vocabulary)
For wrong_component pairs, adjacency records whether the true component is the previous or next component in 15.2
order (the chunk-breadcrumb failure mode: a list continued across a chunk boundary is attributed to a neighbour).
Usage: python precision_rubin.py <remapped.txt> <gt.json> <out.json> <run_dir> [<run_dir> ...]
"""
import glob, json, os, re, sys
from collections import Counter, defaultdict
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import score as S

doc_p, gt_p, out_p, dirs = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4:]
t = open(doc_p, encoding="utf-8").read()
FURN = re.compile(r"^(?:LARGE SYNOPTIC SURVEY TELESCOPE|Data Management System Design|Data Management System \(DMS\) Requirements|"
                  r"LDM-148|LSE-61|Latest Revision \d{4}-\d{2}-\d{2}|The contents of this document are subject to con.guration control.*|\d{1,3})$")
IDP = re.compile(r"\b([A-Z][A-Z0-9]*(?:-[A-Z0-9]+)*-\d{3,4}[a-z]?)\b")
sec = t[t.rfind("Component to Requirement Traceability"):]
listed, order, comp = defaultdict(set), [], None
for line in sec.replace("\x0c", "").split("\n")[2:]:
    l = line.strip()
    if not l or FURN.match(l): continue
    if l.startswith("16 References") or l == "References": break
    if l.startswith("•"):
        if comp: listed[comp].update(S.idkey(x) for x in IDP.findall(l))
    else:
        comp = S.ckey(l)
        if comp not in order: order.append(comp)
pairs = {(c, i) for c, s in listed.items() for i in s}
where = defaultdict(set)
for c, i in pairs: where[i].add(c)
pos = {c: k for k, c in enumerate(order)}

gt = json.load(open(gt_p, encoding="utf-8"))
gk = {(S.ckey(g["component"]), S.idkey(g["cited_id"])) for g in gt["claims"]}
res = dict(gt=gt["version"], listed_pairs=len(pairs), listed_components=len(listed),
           listed_dmsr_pairs=sum(i.startswith("DMSR") for _, i in pairs), gt_pairs_listed=len(gk & pairs), gt_pairs=len(gk), runs=[])
for d in dirs:
    for p in sorted(glob.glob(os.path.join(d, "*.json"))):
        r = json.load(open(p, encoding="utf-8"))
        if "allocations" not in r: continue
        if "ldm-only" in str(r.get("doc", "")): r["arm"] = "B0-mem"  # memory arm: same arm code, definitions document withheld
        out = {}
        for a in r["allocations"]: out.setdefault((S.ckey(a.get("component")), S.idkey(a.get("cited_id"))), a)
        cat, adj, scope_err = Counter(), Counter(), 0
        for c, i in out:
            if (c, i) in gk: cat["gt"] += 1; continue
            if (c, i) in pairs: cat["listed_out"] += 1; continue
            k = "wrong_component" if i in where else "unlisted"
            cat[k] += 1
            if i.startswith("DMSR"): scope_err += 1
            if k == "wrong_component":
                near = c in pos and any(abs(pos[c] - pos[x]) == 1 for x in where[i])
                adj["neighbour" if near else ("non_listed_component" if c not in pos else "distant")] += 1
        n = len(out)
        res["runs"].append(dict(arm=r["arm"], model=r["model"], rep=r["rep"], output_pairs=n, **{k: cat[k] for k in ("gt", "listed_out", "wrong_component", "unlisted")},
                                wrong_component_adjacency=dict(adj),
                                doc_precision=round((cat["gt"] + cat["listed_out"]) / max(1, n), 4),
                                scope_precision=round(cat["gt"] / max(1, cat["gt"] + scope_err), 4)))
agg = defaultdict(list)
for x in res["runs"]: agg[(x["arm"], x["model"])].append(x)
res["summary"] = {f"{a}|{m}": {k: round(sum(x[k] for x in v) / len(v), 4) for k in ("output_pairs", "gt", "listed_out", "wrong_component", "unlisted", "doc_precision", "scope_precision")} | {"runs": len(v)}
                  for (a, m), v in sorted(agg.items())}
json.dump(res, open(out_p, "w", encoding="utf-8"), indent=1)
print(json.dumps({k: v for k, v in res.items() if k != "runs"}, indent=1))
