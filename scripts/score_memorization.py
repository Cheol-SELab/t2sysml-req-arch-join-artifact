"""Score memorization probe responses against official artifacts (deterministic string matching).
Usage: python score_memorization.py <probe_dir> <fprime_repo> <openpca_raw> <openetcs_modeling>
Metrics per probe/model: items_claimed, items_correct (exact name match), recall over official set, precision.
"""
import glob, io, json, os, re, sys

probe_dir, fprime, openpca, openetcs = sys.argv[1:5]
def read(p): return io.open(p, encoding="utf-8", errors="replace").read()

# official sets
cd = read(os.path.join(fprime, "Svc/CmdDispatcher/CmdDispatcher.fpp"))
cd_ports = set(re.findall(r"^\s*(?:(?:async|sync|guarded)\s+)?(?:input|output)\s+port\s+(\w+)", cd, re.M))
hl = read(os.path.join(fprime, "Svc/Health/Health.fpp"))
hl_ports = set(re.findall(r"^\s*(?:(?:async|sync|guarded)\s+)?(?:input|output)\s+port\s+(\w+)", hl, re.M))
cc = read(os.path.join(fprime, "Svc/Subtopologies/CdhCore/CdhCore.fpp"))
cc_inst = set(n.lstrip("$") for n in re.findall(r"^\s*instance\s+(\$?\w+)", cc, re.M))
cc_sdd = read(os.path.join(fprime, "Svc/Subtopologies/CdhCore/docs/sdd.md"))
cc_reqs = set(re.findall(r"SVC-CDHCORE-\d{3}", cc_sdd))
cp = read(glob.glob(os.path.join(openpca, "aadl/**/PCA_Control_Panel.aadl"), recursive=True)[0])
cp_comps = set(re.findall(r"^\s*(?:device|thread|process|system|abstract)\s+(?:implementation\s+)?(\w+)", cp, re.M | re.I))
cp_reqs = set(re.findall(r"R\d+\.\d+\.\d+\(\d+\)", cp))
txt = read(os.path.join(openpca, "requirements.txt"))
sec = txt[txt.rfind("10.5.1 Control Panel"):]
sec = sec[:sec.find("10.5.2")]
alloc_cp = set(re.findall(r"R\d+\.\d+\.\d+\(\d+\)", sec))
reqif = read(os.path.join(openetcs, "model/subset26/chapter3/chapter3.reqif"))
clauses = {}
for m in re.finditer(r'ATTRIBUTE-VALUE-STRING THE-VALUE="([^"]*)">\s*<DEFINITION>\s*<ATTRIBUTE-DEFINITION-STRING-REF>_stype_requirement_PlainText', reqif):
    pass
# map requirementID -> PlainText by walking spec objects
for obj in re.finditer(r"<SPEC-OBJECT .*?</SPEC-OBJECT>", reqif, re.S):
    o = obj.group(0)
    rid = re.search(r'THE-VALUE="([^"]*)">\s*<DEFINITION>\s*<ATTRIBUTE-DEFINITION-STRING-REF>_stype_requirement_requirementID', o)
    pt = re.search(r'THE-VALUE="([^"]*)">\s*<DEFINITION>\s*<ATTRIBUTE-DEFINITION-STRING-REF>_stype_requirement_PlainText', o)
    if rid and pt and rid.group(1).startswith("3.13.2.2."): clauses[rid.group(1)] = pt.group(1)

def words(s): return set(w for w in re.findall(r"[a-z]{4,}", s.lower()))

def score(probe, resp):
    r = resp or ""
    if probe == "fprime_cmddispatcher_ports": off, got = cd_ports, set(re.findall(r'"name"\s*:\s*"(\w+)"', r))
    elif probe == "fprime_health_ports": off, got = hl_ports, set(re.findall(r'"name"\s*:\s*"(\w+)"', r))
    elif probe == "fprime_cdhcore_instances":
        got_i = set(n.lstrip("$") for n in re.findall(r'"name"\s*:\s*"(\$?\w+)"', r)); got_r = set(re.findall(r"SVC-CDHCORE-\d{3}", r))
        return dict(instances=dict(official=len(cc_inst), claimed=len(got_i), correct=len(got_i & cc_inst), correct_items=sorted(got_i & cc_inst)),
                    requirement_ids=dict(official=len(cc_reqs), claimed=len(got_r), correct=len(got_r & cc_reqs)))
    elif probe == "openpca_control_panel":
        got_c = set(re.findall(r'"name"\s*:\s*"(\w+)"', r)); got_r = set(re.findall(r"R\d+\.\d+\.\d+\(\d+\)", r))
        return dict(components=dict(official=len(cp_comps), claimed=len(got_c), correct=len(got_c & cp_comps), correct_items=sorted(got_c & cp_comps)),
                    requirement_ids=dict(official=len(cp_reqs), claimed=len(got_r), correct=len(got_r & cp_reqs), correct_items=sorted(got_r & cp_reqs)))
    elif probe == "openpca_allocation_control_panel": off, got = alloc_cp, set(re.findall(r"R\d+\.\d+\.\d+\(\d+\)", r))
    elif probe == "subset026_3_13_2":
        out = {}
        for cid, text in sorted(clauses.items()):
            m = re.search(re.escape(cid) + r'"?\s*,?\s*"text"\s*:\s*"([^"]*)"', r)
            if m:
                ow, gw = words(text), words(m.group(1)); out[cid] = dict(official_words=len(ow), overlap=len(ow & gw), jaccard=round(len(ow & gw) / max(1, len(ow | gw)), 2))
            else: out[cid] = "not answered"
        return out
    else: return {}
    return dict(official=len(off), claimed=len(got), correct=len(got & off), correct_items=sorted(got & off), wrong_items=sorted(got - off)[:10])

results = {}
for f in sorted(glob.glob(os.path.join(probe_dir, "*.json"))):
    if os.path.basename(f).startswith(("run.", "scores")): continue
    d = json.load(io.open(f, encoding="utf-8"))
    if "probe" not in d: continue
    results[f"{d['probe']} | {d['model']}"] = score(d["probe"], d.get("response")) if "response" in d else {"error": d.get("error")}
io.open(os.path.join(probe_dir, "scores.json"), "w", encoding="utf-8").write(json.dumps(results, indent=2, ensure_ascii=False))
print(json.dumps(results, indent=2, ensure_ascii=False))
