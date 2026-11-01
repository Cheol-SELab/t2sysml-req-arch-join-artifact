"""Build the Rubin evaluation set (protocol v1.1, ACCESS-044) and the identifier-remapped input document. No LLM.

Sources (version-pinned): LSE-61 v6.2 text (requirement definitions: "ID: DMS-REQ-xxxx" + Specification),
LDM-148 v8.1 text (design; appendix 15.2 "Component to Requirement Traceability" lists, per leaf component,
"• DMS-REQ-xxxx Title"), trace CSV v8.1 (MagicDraw export: requirement rows x component columns, "<-" = traced).
Alignment (bidirectional): an allocation (component, DMS-REQ id) is a candidate if it is in the CSV; it is
  supported         if it is also listed under that component in 15.2, the id is defined in LSE-61 v6.2 and the
                    15.2 title equals the LSE-61 heading title (closed normalization: case, whitespace, ligatures,
                    straight/curly quotes, '&' vs 'and');
  not_established   otherwise (reason recorded).
CSV-only and 15.2-only pairs are counted in the alignment report.
Identifier remapping (memorization control): every DMS-REQ-dddd in both texts and in the GT is replaced by
DMSR-dddd with a random permutation of 1000..9999 (seed 20261031); titles, texts and components are unchanged.
Usage: python build_gt_rubin.py <LSE-61.txt> <LDM-148.txt> <trace.csv> <out_dir> [v1.1|v1.2 [split]]
v1.2 (ACCESS-057, reviewer inspection): a composite requirement ("ID: ..." without its own Specification) no longer
takes the Specification of its first child; such ids are not_established with reason "composite requirement without
a Specification in LSE-61 v6.2". Otherwise identical to v1.1 (model input unchanged).
split (ACCESS-050, controlled cross-identifier variant "Rubin-X"): the design document LDM-148 gets an independent
second permutation (seed 20261101) while LSE-61 keeps the first; the same requirement then carries unrelated
identifiers in the two documents and can be joined only through its title/wording. GT: cited_id = LDM-148 side,
body_id = LSE-61 side. Outputs rubin-x-remapped.txt, rubin-x-gt-v1.json, rubin-x-id-remap.json.
"""
import csv, hashlib, json, os, random, re, sys

lse_p, ldm_p, csv_p, out = sys.argv[1:5]
V11 = len(sys.argv) > 5 and sys.argv[5] in ("v1.1", "v1.2")  # default reproduces rubin-gt-v1 exactly
V12 = V11 and sys.argv[5] == "v1.2"
SPLIT = V11 and len(sys.argv) > 6 and sys.argv[6] == "split"
os.makedirs(out, exist_ok=True)
LIG = {"ﬁ": "fi", "ﬂ": "fl", "ﬀ": "ff", "ﬃ": "ffi", "ﬄ": "ffl"}
def norm(s):
    for k, v in LIG.items(): s = s.replace(k, v)
    return re.sub(r"\s+", " ", s).strip()
def tkey(s):
    s = norm(s).lower().replace("&", "and")
    s = re.sub(r"[‘’“”\"']", "", s)
    return re.sub(r"\s+", " ", s).strip()

lse = open(lse_p, encoding="utf-8").read()
ldm = open(ldm_p, encoding="utf-8").read()
RID = re.compile(r"DMS-REQ-\d{4}")
FURN = re.compile(r"^(?:LARGE SYNOPTIC SURVEY TELESCOPE|Data Management System Design|Data Management System \(DMS\) Requirements|"
                  r"LDM-148|LSE-61|Latest Revision \d{4}-\d{2}-\d{2}|The contents of this document are subject to con.guration control.*|\d{1,3})$")
def clean(t):
    """Page furniture removed for GT parsing only (the model input keeps the natural text)."""
    return "\n".join(l for l in t.replace("\x0c", "").split("\n") if not FURN.match(l.strip()))
lse_c, ldm_c = clean(lse), clean(ldm)

# --- LSE-61 definitions: nearest heading line before "ID: DMS-REQ-xxxx", specification paragraph
HEAD = re.compile(r"^(\d+(?:\.\d+)+) (\S.*)$", re.M)
defs, composite = {}, set()
for m in re.finditer(r"ID: (DMS-REQ-\d{4})", lse_c):
    rid = m.group(1)
    hs = list(HEAD.finditer(lse_c, max(0, m.start() - 600), m.start()))
    sm = re.compile("Speci(?:fi|ﬁ)cation:").search(lse_c, m.end())
    if V12 and sm and re.search(r"ID: DMS-REQ-\d{4}", lse_c[m.end():sm.start()]):  # Specification belongs to a child
        composite.add(rid); continue
    if not hs or not sm or sm.start() - m.end() > 200: continue
    j = sm.end()
    ends = [x for x in (lse_c.find("Discussion:", j), lse_c.find("\nID: ", j), lse_c.find("Derived from Requirements:", j)) if x > j]
    ends += [h.start() for h in HEAD.finditer(lse_c, j, j + 4000)][:1]
    if V11:  # v1.1 correction (ACCESS-047): the parameter table ("Description ... Value ... Unit ... Name") is not part of the specification sentence
        pt = re.compile(r"\n\s*Description ").search(lse_c, j)
        if pt: ends.append(pt.start())
    text = norm(lse_c[j:min(ends + [j + 4000])])
    defs.setdefault(rid, dict(title=norm(hs[-1].group(2)), section=hs[-1].group(1), text=text))

# --- LDM-148 15.2 lists
start = ldm_c.rfind("Component to Requirement Traceability")
sec = ldm_c[start:]
listed, comp = {}, None
for line in sec.split("\n")[2:]:
    line = line.strip()
    if not line: continue
    if line.startswith("•"):
        if comp is None: continue
        for it in re.split(r"\s*•\s*", line):
            mm = re.match(r"(DMS-REQ-\d{4}) (.+)", it.strip())
            if mm: listed.setdefault(comp, {})[mm.group(1)] = norm(mm.group(2))
    elif re.match(r"^\d+$", line) or line.startswith("16 References") or line.startswith("References"):
        if line.startswith("16") or line.startswith("References"): break
    else:
        comp = norm(line)

# --- CSV
rows = list(csv.reader(open(csv_p, encoding="utf-8-sig")))
comps = [re.sub(r"^\d+\s+", "", c.split(" [")[0]).replace("&", "and") for c in rows[0]]
csv_pairs, csv_title = set(), {}
for r in rows[1:]:
    m = re.match(r"(DMS-REQ-\d{4})(?:\s+\d+)?\s+(.*?)\s*\[", r[0])
    if not m: continue
    csv_title[m.group(1)] = norm(m.group(2))
    for c, v in zip(comps[1:], r[1:]):
        if v.strip(): csv_pairs.add((c, m.group(1)))

listed_pairs = {(c, i) for c, d in listed.items() for i in d}
report = dict(csv_pairs=len(csv_pairs), listed_pairs=len(listed_pairs), both=len(csv_pairs & listed_pairs),
              csv_only=sorted(map(list, csv_pairs - listed_pairs))[:50], listed_only=sorted(map(list, listed_pairs - csv_pairs))[:50],
              components_csv=len({c for c, _ in csv_pairs}), components_listed=len(listed), defs=len(defs))

# --- remapping
all_ids = sorted(set(RID.findall(lse)) | set(RID.findall(ldm)) | {i for _, i in csv_pairs})
rnd = random.Random(20261031)
new = rnd.sample(range(1000, 10000), len(all_ids))
remap = {o: f"DMSR-{n}" for o, n in zip(all_ids, new)}
def rm(s): return RID.sub(lambda m: remap[m.group(0)], s)
remap_b = remap
if SPLIT:
    rnd_b = random.Random(20261101)
    remap_b = {o: f"DMSR-{n}" for o, n in zip(all_ids, rnd_b.sample(range(1000, 10000), len(all_ids)))}
def rm_b(s): return RID.sub(lambda m: remap_b[m.group(0)], s)

QTY = re.compile(r"(\d+(?:\.\d+)?)\s*(?:%|percent\b|arcsec(?:onds?)?\b|mas\b|milli-?arcsec\w*|deg(?:rees?)?\b|sec(?:onds?)?\b|s\b|"
                 r"min(?:utes?)?\b|hours?\b|hr\b|days?\b|years?\b|months?\b|weeks?\b|mag\b|[KMGTP]B\b|[KMGTP]bps\b|[KMGTP]b/s\b|"
                 r"Hz\b|nm\b|mm\b|cm\b|m\b|km\b|pixels?\b|visits?\b|users?\b)")
claims = []
for k, (c, rid) in enumerate(sorted(csv_pairs)):
    d = defs.get(rid); lt = listed.get(c, {}).get(rid)
    if (c, rid) not in listed_pairs and V11 and re.search(re.escape(rid) + r"[a-z]\b", sec):
        status, reason = "not_established", "listed in LDM-148 15.2 only under a suffixed identifier variant (e.g. 0336b)"
    elif (c, rid) not in listed_pairs: status, reason = "not_established", "not listed under the component in LDM-148 15.2"
    elif not d and rid in composite: status, reason = "not_established", "composite requirement without a Specification in LSE-61 v6.2"
    elif not d: status, reason = "not_established", "identifier not defined in LSE-61 v6.2"
    elif tkey(lt) != tkey(d["title"]): status, reason = "not_established", f"title differs: '{lt}' vs '{d['title']}'"
    else: status, reason = "supported", ""
    text = rm(d["text"]) if d else ""
    nums = sorted({n for m in QTY.finditer(text) for n in re.findall(r"\d+(?:\.\d+)?", m.group(0))})
    claims.append(dict(gt_id=f"RUBIN-{k+1:04d}", component=c, cited_id=remap_b[rid], cited_title=lt or csv_title.get(rid, ""),
                       body_id=remap[rid] if d else "", body_title=d["title"] if d else "", body_text=text, numbers=nums,
                       status=status, reason=reason, original_id=rid))

doc = ("===== DOCUMENT: LSE-61 Data Management System (DMS) Requirements, v6.2 (2019-12-04) =====\n" + rm(lse).strip() +
       "\n\n===== DOCUMENT: LDM-148 Data Management System Design, v8.1 (2020-08-20) =====\n" + rm_b(ldm).strip() + "\n")
assert not RID.search(doc)
open(os.path.join(out, "rubin-x-remapped.txt" if SPLIT else "rubin-remapped.txt"), "w", encoding="utf-8").write(doc)
sup = [c for c in claims if c["status"] == "supported"]
VER = ("rubin-x-gt-v1.2" if V12 else "rubin-x-gt-v1") if SPLIT else "rubin-gt-v1.2" if V12 else "rubin-gt-v1.1" if V11 else "rubin-gt-v1"
gt = dict(version=VER, protocol="annotation-v1.1 (ACCESS-044)",
          source_sha256={p: hashlib.sha256(open(p, "rb").read()).hexdigest() for p in (lse_p, ldm_p, csv_p)},
          input_sha256=hashlib.sha256(doc.encode("utf-8")).hexdigest(), n=len(claims), n_supported=len(sup),
          components=len({c["component"] for c in sup}), alignment=report, claims=claims)
json.dump(gt, open(os.path.join(out, VER + ".json"), "w", encoding="utf-8"), indent=1, ensure_ascii=False)
json.dump(dict(lse61=remap, ldm148=remap_b) if SPLIT else remap, open(os.path.join(out, "rubin-x-id-remap.json" if SPLIT else "rubin-id-remap.json"), "w", encoding="utf-8"), indent=1)
print(json.dumps({k: v for k, v in gt.items() if k not in ("claims",)}, indent=1)[:3000])
from collections import Counter
print(Counter(c["reason"].split(":")[0] for c in claims if c["status"] != "supported"))
