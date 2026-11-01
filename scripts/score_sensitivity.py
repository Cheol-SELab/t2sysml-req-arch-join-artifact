"""Sensitivity variant of the grounded-text metric (POST-HOC, ACCESS-022). score.py stays frozen.

GT body texts keep PDF artefacts: footnote markers glued to words ("appearance54", "button 63") and source
parentheticals ("(UC1.14 §4.1.1)", "(IEC 60601-1-8 2.3.1)"). Arms that drop them lose token F1 although the
requirement sentence is reproduced. Here both sides are compared on WORD tokens only (no pure-digit tokens),
after removing parentheticals that cite use cases, exception cases or standards. Quantities are already
scored separately by qty_preservation in score.py.
Usage: python score_sensitivity.py <gt.json> <run.json> [...]
"""
import json, re, sys, os
from collections import Counter
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import score as S

PAREN = re.compile(r"\((?:[^()]*?(?:UC\d|EC\d|IEC|ISO|FDA|many EC|all UC)[^()]*?)\)")


def words(s):
    s = PAREN.sub(" ", S.norm(s))
    s = re.sub(r"([A-Za-z])\d{1,3}\b", r"\1", s)  # footnote marker glued to a word
    return [t for t in re.findall(r"[a-z]+", s.lower())]


def f1w(a, b):
    ca, cb = Counter(words(a)), Counter(words(b))
    ov = sum((ca & cb).values())
    if not ov: return 0.0
    p, r = ov / sum(ca.values()), ov / sum(cb.values())
    return 2 * p * r / (p + r)


def run(gt, r):
    out = {}
    for a in r["allocations"]: out.setdefault((S.ckey(a.get("component")), S.idkey(a.get("cited_id"))), a)
    sup = [g for g in gt["claims"] if g["status"] == "supported"]
    full = grounded = 0
    for g in sup:
        a = out.get((S.ckey(g["component"]), S.idkey(g["cited_id"])))
        if not a: continue
        ok_text = f1w(a.get("requirement_text"), g["body_text"]) >= 0.8
        grounded += ok_text
        if ok_text and a.get("requirement_id") and S.idkey(a["requirement_id"]) == S.idkey(g["body_id"]): full += 1
    return dict(arm=r["arm"], model=r["model"], rep=r["rep"], grounded_words=round(grounded / len(sup), 4), full_words=round(full / len(sup), 4))


if __name__ == "__main__":
    gt = json.load(open(sys.argv[1], encoding="utf-8"))
    for p in sys.argv[2:]: print(json.dumps(run(gt, json.load(open(p, encoding="utf-8")))))
