"""Aggregate scored runs: per arm x model means over reps, run spread, cost, and paired comparisons.

Unit of resampling: architecture component (claims are clustered by component). For each arm pair
(M vs B0/B1/B2) and model, the paired difference of full-claim recall is bootstrapped over components
(10,000 resamples, percentile 95% CI), using per-component means over reps. Also reports per-claim
discordant counts (descriptive). Usage: python analyze.py <gt.json> <run_dir> <out.json>
"""
import glob, json, os, random, sys
from collections import defaultdict
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import score as S

gt = json.load(open(sys.argv[1], encoding="utf-8"))
runs = [json.load(open(p, encoding="utf-8")) for p in sorted(glob.glob(os.path.join(sys.argv[2], "*.json")))]
sup = [g for g in gt["claims"] if g["status"] == "supported"]
gkeys = [(S.ckey(g["component"]), S.idkey(g["cited_id"])) for g in sup]


def claim_vector(run):
    out = {}
    for a in run["allocations"]:
        out.setdefault((S.ckey(a.get("component")), S.idkey(a.get("cited_id"))), a)
    v = []
    for g, k in zip(sup, gkeys):
        a = out.get(k)
        ok = bool(a) and a.get("requirement_id") and S.idkey(a["requirement_id"]) == S.idkey(g["body_id"]) and S.f1(a.get("requirement_text"), g["body_text"]) >= 0.8
        v.append(1 if ok else 0)
    return v


table = defaultdict(list)
vec = defaultdict(list)
for r in runs:
    if "allocations" not in r: continue
    m = S.score(gt, r)
    table[(r["arm"], r["model"])].append(m)
    vec[(r["arm"], r["model"])].append(claim_vector(r))

summary = {}
for (arm, model), ms in sorted(table.items()):
    def mean(k): return round(sum(x[k] for x in ms) / len(ms), 4)
    def rng(k): return [min(x[k] for x in ms), max(x[k] for x in ms)]
    u = [x["usage"] for x in ms]
    summary[f"{arm}|{model}"] = dict(arm=arm, model=model, reps=len(ms),
        full_recall=mean("full_recall"), full_recall_range=rng("full_recall"), recall_found=mean("recall_found"),
        identity_recall=mean("identity_recall"), grounded_recall=mean("grounded_recall"), qty_preservation=mean("qty_preservation"),
        wrong_merges=mean("wrong_merges"), ne_linked=mean("ne_linked"), ne_abstained=mean("ne_abstained"), spurious=mean("spurious"),
        link_precision=mean("link_precision"),
        input_tokens=round(sum(x["input_tokens"] for x in u) / len(u)), output_tokens=round(sum(x["output_tokens"] for x in u) / len(u)),
        calls=round(sum(x["calls"] for x in u) / len(u), 1), call_errors=sum(x["errors"] for x in u), truncated=sum(x.get("truncated", 0) for x in u),
        provider_seconds=round(sum(x["provider_wall_seconds"] for x in u) / len(u), 1))

# paired bootstrap over components
comps = sorted({k[0] for k in gkeys})
idx = {c: [i for i, k in enumerate(gkeys) if k[0] == c] for c in comps}
def comp_means(vs):
    per = [sum(v[i] for v in vs) / len(vs) for i in range(len(sup))]
    return {c: (sum(per[i] for i in idx[c]), len(idx[c])) for c in comps}
rnd = random.Random(20261031)
paired = {}
models = sorted({k[1] for k in vec})
for model in models:
    for base in ("B0", "B1", "B2"):
        if (base, model) not in vec or ("M", model) not in vec: continue
        a, b = comp_means(vec[("M", model)]), comp_means(vec[(base, model)])
        def diff(cs): return sum(a[c][0] for c in cs) / sum(a[c][1] for c in cs) - sum(b[c][0] for c in cs) / sum(b[c][1] for c in cs)
        obs = diff(comps)
        boots = sorted(diff([rnd.choice(comps) for _ in comps]) for _ in range(10000))
        va = [sum(v[i] for v in vec[("M", model)]) / len(vec[("M", model)]) for i in range(len(sup))]
        vb = [sum(v[i] for v in vec[(base, model)]) / len(vec[(base, model)]) for i in range(len(sup))]
        paired[f"M-{base}|{model}"] = dict(diff_full_recall=round(obs, 4), ci95=[round(boots[249], 4), round(boots[9749], 4)],
            claims_M_better=sum(1 for x, y in zip(va, vb) if x > y), claims_base_better=sum(1 for x, y in zip(va, vb) if y > x),
            components=len(comps))

res = dict(gt=gt["version"], n_supported=len(sup), n_ne=gt["n"] - len(sup), summary=summary, paired=paired)
json.dump(res, open(sys.argv[3], "w", encoding="utf-8"), indent=1, ensure_ascii=False)
for k, v in summary.items():
    print(f"{k:28s} full {v['full_recall']:.3f} {v['full_recall_range']} found {v['recall_found']:.3f} ident {v['identity_recall']:.3f} "
          f"qty {v['qty_preservation']:.3f} wrong {v['wrong_merges']} neLinked {v['ne_linked']} spur {v['spurious']} prec {v['link_precision']:.3f} "
          f"in {v['input_tokens']} out {v['output_tokens']} calls {v['calls']} err {v['call_errors']} trunc {v['truncated']}")
for k, v in paired.items(): print(k, v)
