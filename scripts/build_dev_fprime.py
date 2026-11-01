"""Development set from F Prime subtopology SDDs (memorized project -> dev/pilot only, ACCESS-011).

Document = concatenation of the subtopology SDDs (requirements table, design prose, traceability matrix).
GT claim = one traceability row: component = first named satisfier, cited_id = requirement id,
body_id = same id (defined in the requirements table), body_text = requirement description.
Usage: python build_dev_fprime.py <fprime_repo> <out_doc.txt> <out_gt.json>
"""
import glob, io, json, os, re, sys

repo, out_doc, out_gt = sys.argv[1:4]
parts, claims = [], []
QTY = re.compile(r"(\d+(?:\.\d+)?)\s*(?:ms\b|s\b|seconds?\b|bytes?\b|%|Hz\b)|=\s*(\d+(?:\.\d+)?)")
for sdd in sorted(glob.glob(os.path.join(repo, "Svc", "Subtopologies", "*", "docs", "sdd.md"))):
    s = io.open(sdd, encoding="utf-8").read()
    parts.append(s)
    defs = {m.group(1): re.sub(r"\*\*", "", m.group(2)).strip() for m in re.finditer(r"^\|\s*(SVC-[A-Z]+-\d{3})\s*\|\s*(.+?)\s*\|\s*\w+\s*\|\s*$", s, re.M)}
    tr = s[s.find("Traceability"):] if "Traceability" in s else ""
    for m in re.finditer(r"^\|\s*(SVC-[A-Z]+-\d{3})\s*\|\s*(.+?)\s*\|\s*$", tr, re.M):
        names = re.findall(r"`(\$?[\w.]+)`", m.group(2)) or [m.group(2).split()[0]]
        rid = m.group(1)
        txt = defs.get(rid, "")
        claims.append(dict(gt_id=f"FPD-{len(claims)+1:03d}", component=names[0].lstrip("$"), cited_id=rid, cited_title="",
                           body_id=rid if txt else "", body_text=txt, numbers=[], status="supported" if txt else "not_established",
                           reason="" if txt else "id not in requirements table"))
doc = "\n\n".join(parts)
io.open(out_doc, "w", encoding="utf-8").write(doc)
gt = dict(version="fprime-dev-v1", n=len(claims), n_supported=sum(c["status"] == "supported" for c in claims), claims=claims)
io.open(out_gt, "w", encoding="utf-8").write(json.dumps(gt, indent=1, ensure_ascii=False))
print(len(doc), "chars;", gt["n"], "claims;", gt["n_supported"], "supported")
