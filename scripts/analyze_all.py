"""Combined analysis over several run directories (v1 pre-specified + v2 post-hoc). analyze.py stays frozen.

Adds: the word-level sensitivity metric, arbitrary paired comparisons (component bootstrap, 10,000 resamples,
seed 20261031), per-arm cost, and a resolution-basis breakdown.
Usage: python analyze_all.py <gt.json> <out.json> <dir> [<dir> ...] --pairs A:B,C:D
"""
import glob, json, os, random, sys
from collections import Counter, defaultdict
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import score as S
import score_sensitivity as SS

args = sys.argv[1:]
pairs = []
if "--pairs" in args:
    i = args.index("--pairs"); pairs = [tuple(p.split(":")) for p in args[i + 1].split(",")]; args = args[:i]
gt = json.load(open(args[0], encoding="utf-8")); out_path = args[1]; dirs = args[2:]
sup = [g for g in gt["claims"] if g["status"] == "supported"]
keys = [(S.ckey(g["component"]), S.idkey(g["cited_id"])) for g in sup]
comps = sorted({k[0] for k in keys})
cidx = {c: [i for i, k in enumerate(keys) if k[0] == c] for c in comps}

runs = []
for d in dirs:
    for p in sorted(glob.glob(os.path.join(d, "*.json"))):
        r = json.load(open(p, encoding="utf-8"))
        if "allocations" in r: runs.append(r)


def vector(r, words=False):
    out = {}
    for a in r["allocations"]: out.setdefault((S.ckey(a.get("component")), S.idkey(a.get("cited_id"))), a)
    v = []
    for g, k in zip(sup, keys):
        a = out.get(k)
        ok = False
        if a and a.get("requirement_id") and S.idkey(a["requirement_id"]) == S.idkey(g["body_id"]):
            ok = (SS.f1w if words else S.f1)(a.get("requirement_text"), g["body_text"]) >= 0.8
        v.append(int(ok))
    return v


agg, vecs, vecw, basis = defaultdict(list), defaultdict(list), defaultdict(list), defaultdict(Counter)
for r in runs:
    k = (r["arm"], r["model"])
    agg[k].append(S.score(gt, r)); vecs[k].append(vector(r)); vecw[k].append(vector(r, True))
    for a in r["allocations"]: basis[k][a.get("basis", "-")] += 1

summary = {}
for k, ms in sorted(agg.items()):
    def m(f): return round(sum(x[f] for x in ms) / len(ms), 4)
    u = [x["usage"] for x in ms]
    fw = [sum(v) / len(sup) for v in vecw[k]]
    summary[f"{k[0]}|{k[1]}"] = dict(arm=k[0], model=k[1], reps=len(ms), full=m("full_recall"),
        full_range=[min(x["full_recall"] for x in ms), max(x["full_recall"] for x in ms)], full_words=round(sum(fw) / len(fw), 4),
        identity=m("identity_recall"), grounded=m("grounded_recall"), qty=m("qty_preservation"), wrong_merges=m("wrong_merges"),
        unresolved=m("unresolved_supported"), ne_linked=m("ne_linked"), spurious=m("spurious"), link_precision=m("link_precision"),
        input_tokens=round(sum(x["input_tokens"] for x in u) / len(u)), output_tokens=round(sum(x["output_tokens"] for x in u) / len(u)),
        calls=round(sum(x["calls"] for x in u) / len(u), 1), call_errors=sum(x["errors"] for x in u),
        provider_seconds=round(sum(x["provider_wall_seconds"] for x in u) / len(u), 1),
        basis={b: round(n / len(ms), 1) for b, n in basis[k].items()})


def boot(va, vb, rnd):
    def comp_tot(per): return {c: (sum(per[i] for i in cidx[c]), len(cidx[c])) for c in comps}
    pa = [sum(v[i] for v in va) / len(va) for i in range(len(sup))]
    pb = [sum(v[i] for v in vb) / len(vb) for i in range(len(sup))]
    A, B = comp_tot(pa), comp_tot(pb)
    def d(cs): return sum(A[c][0] for c in cs) / sum(A[c][1] for c in cs) - sum(B[c][0] for c in cs) / sum(B[c][1] for c in cs)
    bs = sorted(d([rnd.choice(comps) for _ in comps]) for _ in range(10000))
    return dict(diff=round(d(comps), 4), ci95=[round(bs[249], 4), round(bs[9749], 4)],
                claims_a_better=sum(x > y for x, y in zip(pa, pb)), claims_b_better=sum(y > x for x, y in zip(pa, pb)))


rnd = random.Random(20261031)
paired = {}
for a, b in pairs:
    for model in sorted({k[1] for k in agg}):
        if (a, model) in vecs and (b, model) in vecs:
            paired[f"{a}-{b}|{model}|full"] = boot(vecs[(a, model)], vecs[(b, model)], rnd)
            paired[f"{a}-{b}|{model}|full_words"] = boot(vecw[(a, model)], vecw[(b, model)], rnd)

json.dump(dict(gt=gt["version"], n_supported=len(sup), components=len(comps), summary=summary, paired=paired),
          open(out_path, "w", encoding="utf-8"), indent=1, ensure_ascii=False)
for k, v in summary.items():
    print(f"{k:26s} full {v['full']:.3f} {v['full_range']} words {v['full_words']:.3f} ident {v['identity']:.3f} qty {v['qty']:.3f} "
          f"wrong {v['wrong_merges']} unres {v['unresolved']} neL {v['ne_linked']} spur {v['spurious']} in {v['input_tokens']} out {v['output_tokens']} calls {v['calls']} err {v['call_errors']}")
for k, v in paired.items(): print(k, v)
