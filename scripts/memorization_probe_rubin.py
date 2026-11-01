"""Memorization admission probe for Rubin LDM-148 v8.1 + LSE-61 v6.2 (ACCESS-042), forced answer, both models.
Admission rule (protocol v1): the project fails if any model reproduces >= 50% of an official list
(allocation ID lists: recall of IDs; specification texts: share of the official content words, >= 4 letters).
Official answers: trace CSV v8.1 (model export) and LSE-61 v6.2 specification paragraphs.
Usage: python memorization_probe_rubin.py <trace.csv> <LSE-61.txt> <out.json>
"""
import csv, json, os, re, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import llm

FORCE = ("You must answer from memory with your best guess even if unsure. Do not refuse, do not say you don't know, "
         "do not add caveats. Output only the requested JSON.")
COMPONENTS = ["Archiving", "Data Butler", "Alert Distribution"]
REQS = ["DMS-REQ-0068", "DMS-REQ-0274", "DMS-REQ-0004"]
MODELS = ["gpt-6.1-sol", "claude-opus-5-5"]


def official(trace, lse):
    rows = list(csv.reader(open(trace, encoding="utf-8-sig")))
    comps = [re.sub(r"^\d+\s+", "", c.split(" [")[0]) for c in rows[0]]
    alloc = {c: set() for c in COMPONENTS}
    for r in rows[1:]:
        m = re.match(r"(DMS-REQ-\d{4})", r[0])
        if not m: continue
        for c, v in zip(comps, r):
            if v.strip() and c in alloc: alloc[c].add(m.group(1))
    t = open(lse, encoding="utf-8").read()
    spec = {}
    for rid in REQS:
        i = t.find("ID: " + rid)
        j = re.compile("Speci(?:fi|ﬁ)cation:").search(t, i).end()  # PDF text uses the fi ligature
        k = t.find("Discussion:", j); k2 = t.find("\nID: ", j)
        end = min(x for x in (k, k2, j + 3000) if x > j)
        spec[rid] = re.sub(r"\s+", " ", t[j:end]).strip()
    return alloc, spec


def words(s): return set(re.findall(r"[a-z]{4,}", (s or "").lower()))


def main():
    trace, lse, out = sys.argv[1:4]
    llm.load_env()
    alloc, spec = official(trace, lse)
    res = {"official_sizes": {c: len(v) for c, v in alloc.items()}, "probes": {}}
    for m in MODELS:
        for c in COMPONENTS:
            p = (FORCE + f" In the Vera C. Rubin Observatory document LDM-148 'Data Management System Design' (v8.1, 2020), "
                 f"appendix 'Component to Requirement Traceability' lists the DMS-REQ requirement IDs allocated to the "
                 f"component '{c}'. Reproduce that list. JSON {{\"ids\": [\"DMS-REQ-....\", ...]}}.")
            js, rec = llm.call(m, p, tag="memprobe-rubin-alloc", rep=0, max_tokens=4000)
            got = set(re.findall(r"DMS-REQ-\d{4}", json.dumps(js)))
            rec_ = len(got & alloc[c]) / max(1, len(alloc[c]))
            res["probes"][f"{m}|alloc|{c}"] = dict(official=len(alloc[c]), answered=len(got), hit=len(got & alloc[c]), recall=round(rec_, 3))
        for rid in REQS:
            p = (FORCE + f" Quote the 'Specification' text of requirement {rid} in the Vera C. Rubin Observatory document "
                 f"LSE-61 'Data Management System (DMS) Requirements'. JSON {{\"id\": \"{rid}\", \"title\": \"...\", \"specification\": \"...\"}}.")
            js, rec = llm.call(m, p, tag="memprobe-rubin-spec", rep=0, max_tokens=4000)
            ow, gw = words(spec[rid]), words(json.dumps(js))
            res["probes"][f"{m}|spec|{rid}"] = dict(official_words=len(ow), share=round(len(ow & gw) / max(1, len(ow)), 3))
    fail = [k for k, v in res["probes"].items() if v.get("recall", v.get("share", 0)) >= 0.5]
    res["fails_admission"] = fail
    res["admitted"] = not fail
    json.dump(res, open(out, "w", encoding="utf-8"), indent=1)
    print(json.dumps(res, indent=1))


if __name__ == "__main__":
    main()
