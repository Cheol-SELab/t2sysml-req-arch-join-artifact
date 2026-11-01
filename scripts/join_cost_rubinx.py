"""X3 (Rubin-X plan v1, descriptive): join cost = arm on Rubin-X minus the same arm on Rubin (GT v1.1), paired by claim.
Claim i of rubin-x-gt-v1 and rubin-gt-v1.1 is the same allocation (same component, body, status; only cited_id differs),
so per-claim full indicators are averaged over runs on each material and compared with the paired component bootstrap
of analyze_all.py (10,000 resamples, seed 20261031). No LLM.
Usage: python join_cost_rubinx.py <gt_rubin.json> <dir_rubin> <gt_x.json> <dir_x> <out.json> [arms=M]
"""
import glob, json, os, random, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import score as S

gt_a_p, dir_a, gt_b_p, dir_b, out_p = sys.argv[1:6]
arms = (sys.argv[6] if len(sys.argv) > 6 else "M").split(",")
ga, gb = json.load(open(gt_a_p, encoding="utf-8")), json.load(open(gt_b_p, encoding="utf-8"))
assert len(ga["claims"]) == len(gb["claims"])
assert all((x["component"], x["body_id"], x["status"]) == (y["component"], y["body_id"], y["status"]) for x, y in zip(ga["claims"], gb["claims"]))
idx = [i for i, g in enumerate(ga["claims"]) if g["status"] == "supported"]
comps = sorted({S.ckey(ga["claims"][i]["component"]) for i in idx})
cidx = {c: [j for j, i in enumerate(idx) if S.ckey(ga["claims"][i]["component"]) == c] for c in comps}


def vector(gt, r):
    out = {}
    for a in r["allocations"]: out.setdefault((S.ckey(a.get("component")), S.idkey(a.get("cited_id"))), a)
    v = []
    for i in idx:
        g = gt["claims"][i]; a = out.get((S.ckey(g["component"]), S.idkey(g["cited_id"])))
        v.append(int(bool(a and a.get("requirement_id") and S.idkey(a["requirement_id"]) == S.idkey(g["body_id"])
                          and S.f1(a.get("requirement_text"), g["body_text"]) >= 0.8)))
    return v


def runs(d, arm, model):
    rs = [json.load(open(p, encoding="utf-8")) for p in sorted(glob.glob(os.path.join(d, f"{arm}.{model}.r*.json")))]
    return [r for r in rs if r.get("arm") == arm]


rnd = random.Random(20261031)
res = dict(gt_rubin=ga["version"], gt_x=gb["version"], n_supported=len(idx), components=len(comps), x3={})
for arm in arms:
    for model in ("claude-opus-5-5", "gpt-6.1-sol"):
        ra, rb = runs(dir_a, arm, model), runs(dir_b, arm, model)
        if not ra or not rb: continue
        va, vb = [vector(ga, r) for r in ra], [vector(gb, r) for r in rb]
        pa = [sum(v[j] for v in va) / len(va) for j in range(len(idx))]
        pb = [sum(v[j] for v in vb) / len(vb) for j in range(len(idx))]
        A = {c: (sum(pa[j] for j in cidx[c]), len(cidx[c])) for c in comps}
        B = {c: (sum(pb[j] for j in cidx[c]), len(cidx[c])) for c in comps}
        def d(cs): return sum(B[c][0] for c in cs) / sum(B[c][1] for c in cs) - sum(A[c][0] for c in cs) / sum(A[c][1] for c in cs)
        bs = sorted(d([rnd.choice(comps) for _ in comps]) for _ in range(10000))
        res["x3"][f"{arm}|{model}"] = dict(runs_rubin=len(ra), runs_x=len(rb), full_rubin=round(sum(pa) / len(idx), 4),
                                           full_x=round(sum(pb) / len(idx), 4), diff_x_minus_rubin=round(d(comps), 4),
                                           ci95=[round(bs[249], 4), round(bs[9749], 4)])
json.dump(res, open(out_p, "w", encoding="utf-8"), indent=1)
print(json.dumps(res, indent=1))
