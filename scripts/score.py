"""Deterministic scorer for allocation-integration outputs against a frozen GT (protocol v1).

Per GT claim g (component, cited_id, body_id, body_text, numbers, status):
  found      : output has an allocation with the same component (normalized) and cited_id
  identity   : supported g -> requirement_id == body_id ; not_established g -> requirement_id is null
  grounded   : requirement_text token-F1 >= 0.8 against body_text (supported g only)
  quantities : every GT quantity of body_text appears in requirement_text (g with numbers only)
  full       : found and identity and grounded
Output-side:
  spurious   : output allocations whose (component, cited_id) matches no GT claim
  wrong_merge: allocations linked to a requirement_id that differs from the GT body_id, or linked where GT is
               not_established
Usage: python score.py <gt.json> <run.json> [<run.json> ...]  -> prints one JSON line per run
"""
import json, re, sys
from collections import Counter

LIG = {"ﬁ": "fi", "ﬂ": "fl", "ﬀ": "ff", "ﬃ": "ffi", "ﬄ": "ffl"}
def norm(s):
    s = s or ""
    for k, v in LIG.items(): s = s.replace(k, v)
    return re.sub(r"\s+", " ", s).strip()
def ckey(s):
    # drop a leading section number, backticks, and anything after an em/en dash or "(" (e.g. "`cmdDisp` — `Svc.X`")
    s = re.sub(r"^\s*\d+(\.\d+)*\s+", "", norm(s).replace("`", ""))
    s = re.split(r"\s[—–-]\s|\(", s)[0]
    return re.sub(r"[^a-z0-9]", "", s.lower())
def idkey(s): return re.sub(r"\s+", "", norm(s or "")).upper()
def toks(s): return re.findall(r"[a-z0-9]+(?:\.[0-9]+)?", norm(s).lower())
def f1(a, b):
    ca, cb = Counter(toks(a)), Counter(toks(b))
    ov = sum((ca & cb).values())
    if not ov: return 0.0
    p, r = ov / sum(ca.values()), ov / sum(cb.values())
    return 2 * p * r / (p + r)


def score(gt, run):
    out = {}
    for a in run["allocations"]:
        out.setdefault((ckey(a.get("component")), idkey(a.get("cited_id"))), a)
    gk = {(ckey(g["component"]), idkey(g["cited_id"])): g for g in gt["claims"]}
    res = Counter()
    for k, g in gk.items():
        a = out.get(k)
        sup = g["status"] == "supported"
        res["gt_supported" if sup else "gt_ne"] += 1
        if g["numbers"] and sup: res["gt_with_qty"] += 1
        if not a: continue
        res["found"] += 1
        rid = idkey(a.get("requirement_id")) if a.get("requirement_id") else None
        if sup:
            res["found_sup"] += 1
            ident = rid == idkey(g["body_id"])
            grounded = f1(a.get("requirement_text"), g["body_text"]) >= 0.8
            if ident: res["identity"] += 1
            elif rid: res["wrong_merge"] += 1
            else: res["unresolved_sup"] += 1
            if grounded: res["grounded"] += 1
            if ident and grounded: res["full"] += 1
            if g["numbers"]:
                txt = norm(a.get("requirement_text"))
                if ident and all(re.search(r"(?<![\d.])" + re.escape(n) + r"(?![\d])", txt) for n in g["numbers"]): res["qty_preserved"] += 1
        else:
            res["found_ne"] += 1
            if rid: res["ne_linked"] += 1
            else: res["ne_abstained"] += 1
    res["spurious"] = sum(1 for k in out if k not in gk)
    res["output_allocations"] = len(out)
    S = res["gt_supported"]
    m = dict(arm=run["arm"], model=run["model"], rep=run["rep"],
             recall_found=round(res["found_sup"] / S, 4), identity_recall=round(res["identity"] / S, 4),
             grounded_recall=round(res["grounded"] / S, 4), full_recall=round(res["full"] / S, 4),
             qty_preservation=round(res["qty_preserved"] / max(1, res["gt_with_qty"]), 4),
             wrong_merges=res["wrong_merge"], unresolved_supported=res["unresolved_sup"],
             ne_linked=res["ne_linked"], ne_abstained=res["ne_abstained"], spurious=res["spurious"],
             link_precision=round(res["identity"] / max(1, res["identity"] + res["wrong_merge"] + res["ne_linked"]), 4),
             output_allocations=res["output_allocations"], usage=run.get("usage"), counts=dict(res))
    return m


if __name__ == "__main__":
    gt = json.load(open(sys.argv[1], encoding="utf-8"))
    for p in sys.argv[2:]:
        print(json.dumps(score(gt, json.load(open(p, encoding="utf-8"))), ensure_ascii=False))
