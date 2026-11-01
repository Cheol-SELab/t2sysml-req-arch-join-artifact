"""Method v3 step (ACCESS-038): verbatim source anchoring of requirement text, deterministic, no model call.

For every resolved allocation of a run, the extracted requirement sentence is replaced by the span of the INPUT
document that best matches it (token F1 over lower-case alphanumeric tokens, the same tokenization as the scorer's
f1), if that best F1 is >= THRESH. Window lengths n-3 .. n+3 tokens (n = extracted length), window starts restricted
to positions holding one of the first three extracted tokens. The span is copied verbatim (characters from the start
of its first token to the end of its last token), so the output text is evidence from the source, not model wording.
Identifiers, components and resolution are unchanged.
Usage: python anchor.py <doc> <in_run.json> <out_run.json> [arm_name=M3]
"""
import json, re, sys
from collections import Counter

THRESH = 0.7
TOK = re.compile(r"[a-z0-9]+(?:\.[0-9]+)?")


def toks(s): return TOK.findall((s or "").lower())


def f1c(a, b, na, nb):
    c = sum((a & b).values())
    if not c: return 0.0
    p, r = c / na, c / nb
    return 2 * p * r / (p + r)


def anchor(doc, text, idx, pos):
    t = toks(text); n = len(t)
    if n < 3: return None, 0.0
    tc = Counter(t); best = (0.0, None)
    starts = sorted({i for w in t[:3] for i in pos.get(w, ())})
    for s in starts:
        for L in range(max(3, n - 3), n + 4):
            e = s + L
            if e > len(idx): break
            wc = Counter(w for w, _, _ in idx[s:e])
            f = f1c(tc, wc, n, L)
            if f > best[0]: best = (f, (idx[s][1], idx[e - 1][2]))
    if best[0] >= THRESH:
        return doc[best[1][0]:best[1][1]], best[0]
    return None, best[0]


def main():
    doc_path, inp, outp = sys.argv[1:4]
    arm = sys.argv[4] if len(sys.argv) > 4 else "M3"
    doc = open(doc_path, encoding="utf-8").read()
    low = doc.lower()
    idx = [(m.group(0), m.start(), m.end()) for m in TOK.finditer(low)]
    pos = {}
    for i, (w, _, _) in enumerate(idx): pos.setdefault(w, []).append(i)
    r = json.load(open(inp, encoding="utf-8"))
    cache, n_rep, n_res = {}, 0, 0
    for a in r["allocations"]:
        txt = a.get("requirement_text")
        if not a.get("requirement_id") or not txt: continue
        n_res += 1
        if txt not in cache: cache[txt] = anchor(doc, txt, idx, pos)
        span, f = cache[txt]
        if span is not None:
            a["requirement_text_model"] = txt
            a["requirement_text"] = re.sub(r"\s+", " ", span).strip()
            a["anchor_f1"] = round(f, 3); n_rep += 1
    r["arm"] = arm
    r.setdefault("diagnostics", {})["anchor"] = dict(threshold=THRESH, resolved_with_text=n_res, replaced=n_rep, source_run=inp)
    json.dump(r, open(outp, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(arm, r["model"], r["rep"], "resolved", n_res, "replaced", n_rep)


if __name__ == "__main__":
    main()
