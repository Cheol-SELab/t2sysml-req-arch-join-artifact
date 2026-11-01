"""Build the Open PCA evaluation set (GT v1) from the document and alignment-v0 output.

GT unit = one allocation entry of ch.10 (component heading, cited id, cited title) with
  - body_id / body_title / body_text : requirement definition resolved by protocol v1 R4
  - numbers : numeric tokens of body_text (claim type B: constraint preservation)
  - status  : supported | not_established (protocol v1)
No LLM involved. Usage: python build_gt_openpca.py <requirements.txt> <openpca_claims.csv> <out.json>
"""
import csv, hashlib, io, json, re, sys

txt_path, claims_path, out_path = sys.argv[1:4]
txt = io.open(txt_path, encoding="utf-8").read()
LIG = {"ﬁ": "fi", "ﬂ": "fl", "ﬀ": "ff", "ﬃ": "ffi", "ﬄ": "ffl"}
def norm(s):
    for k, v in LIG.items(): s = s.replace(k, v)
    return re.sub(r"\s+", " ", s).strip()

arch = txt.find("10 Functional Architecture")
body_start = txt.find("\n3 System Overview", 15000)  # skip table of contents
body = txt[body_start:arch]

# section headings in body (3.x .. 8.x, optional third level)
heads = [(m.start(), m.group(1)) for m in re.finditer(r"\n([3-8]\.\d+(?:\.\d+)?) [A-Z][^\n]{0,60}\n", body)]
def section_at(pos):
    s = None
    for p, h in heads:
        if p <= pos: s = h
        else: break
    return s

# strip footnote lines and page footers for item text, but keep positions via a cleaned copy per section
FOOT = re.compile(r"^\d{1,3}requirement R\d+\.\d+\.\d+\(\d+\): .*$|^\d{1,3}[A-Z][^\n]*$|^-\d{1,3}-March 30, 2018.*$", re.M)

items = {}
for idx, (p, h) in enumerate(heads):
    end = heads[idx + 1][0] if idx + 1 < len(heads) else len(body)
    seg = FOOT.sub("", body[p:end])
    parts = re.split(r"\n\((\d{1,2})\) ", seg)
    for k in range(1, len(parts) - 1, 2):
        n, t = parts[k], parts[k + 1]
        lvl = h.split(".")
        rid = f"R{lvl[0]}.{lvl[1]}.{lvl[2] if len(lvl) > 2 else 0}({n})"
        items[rid] = norm(re.sub(r"(\w)-\n(\w)", r"\1\2", t))[:1500]

QTY = re.compile(r"(\d+(?:\.\d+)?)\s*(?:to\s*\d+(?:\.\d+)?\s*)?(?:ml/hr|ml/h|ml\b|mg\b|minutes?\b|min\b|hours?\b|hr\b|seconds?\b|sec\b|s\b|psi\b|Hz\b|%|m\b|dBA?\b|V\b|volts\b|°|kPa\b|mmHg\b|days?\b|years?\b)|=\s*(\d+(?:\.\d+)?)")
claims = list(csv.DictReader(io.open(claims_path, encoding="utf-8")))
gt = []
for c in claims:
    if not c["claim_type"].startswith("A allocation (+C"): continue
    m = re.match(r"Requirement '(.+)' \(", c["model_claim"])
    title = norm(m.group(1)) if m else ""
    heading = c["component"]
    bid = c["body_id"]
    text = items.get(bid, "") if bid else ""
    # quantities only: a number followed by a unit, or preceded by "=" (footnote markers and clause refs excluded)
    nums = sorted({n for m in QTY.finditer(text) for n in re.findall(r"\d+(?:\.\d+)?", m.group(0))}) if text else []
    gt.append(dict(gt_id=f"OPCA-{len(gt)+1:03d}", component=re.sub(r"^\d+(\.\d+)*\s+", "", heading).replace("F ailure", "Failure").replace("F ault", "Fault"),
                   component_heading=heading, cited_id=c["subject"], cited_title=title, body_id=bid, body_text=text,
                   numbers=nums, status=c["status"], reason=c["reason"], distance_tokens=c["distance_tokens"],
                   aadl_evidence=c["aadl_evidence"]))

missing_text = [g["body_id"] for g in gt if g["status"] == "supported" and not g["body_text"]]
out = dict(version="openpca-gt-v1", source_sha256="1bf625f5b6139ec34da57fd460aaeb5c51d103568d3588ed3f3be91d35aa5b07",
           text_sha256=hashlib.sha256(txt.encode("utf-8")).hexdigest(), n=len(gt),
           n_supported=sum(g["status"] == "supported" for g in gt), n_body_items=len(items), missing_body_text=missing_text,
           components=sorted({g["component"] for g in gt}), claims=gt)
io.open(out_path, "w", encoding="utf-8").write(json.dumps(out, ensure_ascii=False, indent=1))
print(json.dumps({k: v for k, v in out.items() if k != "claims"}, ensure_ascii=False, indent=1))
print("with numbers:", sum(1 for g in gt if g["numbers"]))
for g in gt[:3]: print(json.dumps(g, ensure_ascii=False)[:400])
