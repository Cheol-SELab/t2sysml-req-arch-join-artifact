"""Context-scaling analysis (ACCESS-034, protocol/context-scaling-plan-v1.txt).
For each model: B0 and M2R full recall per level, H1 = B0(L0) - B0(Lx), H2 = D = [B0(L0)-B0(Lx)] - [M2R(L0)-M2R(Lx)],
paired component bootstrap (28 components, 10,000 resamples, seed 20261031), percentile 95% intervals.
Runs missing an output file (provider failure) count as recall 0, as pre-specified.
Usage: python analyze_ctx.py <gt.json> <out.json> L0:B0=<dir>,M2R=<dir> L2:B0=<dir>,M2R=<dir> [L1:...]
"""
import glob, json, os, random, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import score as S

gt = json.load(open(sys.argv[1], encoding="utf-8")); out_path = sys.argv[2]
levels = {}
for spec in sys.argv[3:]:
    lv, rest = spec.split(":", 1)
    levels[lv] = dict(kv.split("=", 1) for kv in rest.split(","))
MODELS = ["gpt-6.1-sol", "claude-opus-5-5"]; REPS = 3
sup = [g for g in gt["claims"] if g["status"] == "supported"]
keys = [(S.ckey(g["component"]), S.idkey(g["cited_id"])) for g in sup]
comps = sorted({k[0] for k in keys})
cidx = {c: [i for i, k in enumerate(keys) if k[0] == c] for c in comps}


def vector(r):
    if r is None: return [0] * len(sup)
    out = {}
    for a in r["allocations"]: out.setdefault((S.ckey(a.get("component")), S.idkey(a.get("cited_id"))), a)
    v = []
    for g, k in zip(sup, keys):
        a = out.get(k)
        v.append(int(bool(a and a.get("requirement_id") and S.idkey(a["requirement_id"]) == S.idkey(g["body_id"])
                          and S.f1(a.get("requirement_text"), g["body_text"]) >= 0.8)))
    return v


def runs(d, arm, model):
    res = []
    for rep in range(REPS):
        p = os.path.join(d, f"{arm}.{model}.r{rep}.json")
        res.append(json.load(open(p, encoding="utf-8")) if os.path.exists(p) else None)
    return res


def permean(rs):
    vs = [vector(r) for r in rs]
    return [sum(v[i] for v in vs) / len(vs) for i in range(len(sup))]


def rate(per, cs):
    return sum(sum(per[i] for i in cidx[c]) for c in cs) / sum(len(cidx[c]) for c in cs)


summary, tests = {}, {}
rnd = random.Random(20261031)
for model in MODELS:
    per = {}
    for lv, arms in levels.items():
        for arm, d in arms.items():
            rs = runs(d, arm, model)
            per[(lv, arm)] = permean(rs)
            sc = [S.score(gt, r) for r in rs if r is not None]
            u = [r["usage"] for r in rs if r is not None]
            summary[f"{lv}|{arm}|{model}"] = dict(
                runs_ok=len(sc), full=round(rate(per[(lv, arm)], comps), 4),
                identity=round(sum(x["identity_recall"] for x in sc) / len(sc), 4) if sc else None,
                wrong=round(sum(x["wrong_merges"] for x in sc) / len(sc), 2) if sc else None,
                ne_linked=round(sum(x["ne_linked"] for x in sc) / len(sc), 2) if sc else None,
                spurious=round(sum(x["spurious"] for x in sc) / len(sc), 2) if sc else None,
                input_tokens=round(sum(x["input_tokens"] for x in u) / len(u)) if u else None,
                calls=round(sum(x["calls"] for x in u) / len(u), 1) if u else None,
                call_errors=sum(x["errors"] for x in u) if u else None)
    for lv in levels:
        if lv == "L0": continue
        def h1(cs): return rate(per[("L0", "B0")], cs) - rate(per[(lv, "B0")], cs)
        def h2(cs): return h1(cs) - (rate(per[("L0", "M2R")], cs) - rate(per[(lv, "M2R")], cs))
        for name, fn in (("H1", h1), ("H2", h2)):
            bs = sorted(fn([rnd.choice(comps) for _ in comps]) for _ in range(10000))
            ci = [round(bs[249], 4), round(bs[9749], 4)]
            tests[f"{name}|{lv}|{model}"] = dict(estimate=round(fn(comps), 4), ci95=ci, supported=ci[0] > 0)

json.dump(dict(gt=gt["version"], components=len(comps), summary=summary, tests=tests),
          open(out_path, "w", encoding="utf-8"), indent=1)
for k, v in summary.items(): print(k, v)
for k, v in tests.items(): print(k, v)
