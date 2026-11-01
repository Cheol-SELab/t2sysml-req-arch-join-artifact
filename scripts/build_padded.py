"""Build context-scaling test documents (ACCESS-034): the Open PCA test document embedded in the middle of natural,
unrelated engineering text. Distractors contain no Open PCA identifiers (R<d>.<d>.<d>(<n>)) and no Open PCA components.
  L1 ~128K tokens: first 46K tokens of FAA REMH + Open PCA + first 46K tokens of TMT OAD
  L2 ~241K tokens: full FAA REMH + Open PCA + full TMT OAD
Usage: python build_padded.py <out_dir>
"""
import hashlib, json, os, re, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pipeline as P

SRC = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "data", "sources")
remh = open(os.path.join(SRC, "alisa", "raw", "remh.txt"), encoding="utf-8", errors="replace").read()
oad = open(os.path.join(SRC, "tmt", "raw", "oad.txt"), encoding="utf-8", errors="replace").read()
pca = open(os.path.join(SRC, "openpca", "raw", "requirements.txt"), encoding="utf-8").read()
ID = re.compile(r"R\d+\.\d+\.\d+\(\d+\)")
assert not ID.search(remh) and not ID.search(oad)


def head_tokens(text, n):
    out, tot = [], 0
    for ln in text.splitlines(keepends=True):
        t = P.ntok(ln)
        if tot + t > n: break
        out.append(ln); tot += t
    return "".join(out)


def doc(parts):
    return "\n\n".join(f"===== DOCUMENT: {title} =====\n{body.strip()}\n" for title, body in parts)


out = sys.argv[1]; os.makedirs(out, exist_ok=True)
T_REMH = "FAA Requirements Engineering Management Handbook DOT/FAA/AR-08/32"
T_OAD = "TMT Observatory Architecture Document CCR34"
T_PCA = "Open PCA Pump System Requirements 1.0.0"
docs = {"L1": doc([(T_REMH, head_tokens(remh, 46000)), (T_PCA, pca), (T_OAD, head_tokens(oad, 46000))]),
        "L2": doc([(T_REMH, remh), (T_PCA, pca), (T_OAD, oad)])}
meta = {}
for k, d in docs.items():
    p = os.path.join(out, f"openpca-{k}.txt")
    open(p, "w", encoding="utf-8").write(d)
    start = d.index(pca.strip()[:200])
    meta[k] = dict(path=p, tokens=P.ntok(d), pca_start_token=P.ntok(d[:start]), sha256=hashlib.sha256(d.encode("utf-8")).hexdigest())
json.dump(meta, open(os.path.join(out, "padded-meta.json"), "w"), indent=1)
print(json.dumps(meta, indent=1))
