"""Generate LaTeX tables for the manuscript from analysis JSON files (no manual transcription).
Usage: python make_tables.py <analysis-all.json> <analysis-dev.json> <out_dir>
"""
import json, os, sys

A = json.load(open(sys.argv[1], encoding="utf-8"))
D = json.load(open(sys.argv[2], encoding="utf-8"))
out = sys.argv[3]
os.makedirs(out, exist_ok=True)
S = A["summary"]
MOD = [("gpt-6.1-sol", "Sol"), ("claude-opus-5-5", "Opus")]
ARMS = [("B0", "B0 whole document", "pre"), ("B1", "B1 chunk + exact-id merge", "pre"), ("B2", "B2 chunk + BM25 retrieval", "pre"),
        ("M", "M v1 fact store", "pre"), ("B1v2", "B1 on v2 extraction", "post"), ("B2v2", "B2 on v2 extraction", "post"),
        ("M2-noT", "M2 without correspondence", "post"), ("M2", "M2 split-evidence store", "post"), ("M2R", "M2R + text re-reading", "post")]


def f(x, d=3): return f"{x:.{d}f}"


DAG = "$^\dagger$"
def mark(kind): return DAG if kind == "post" else ""
EOL = "\\\\"


rows = []
for arm, label, kind in ARMS:
    for m, ml in MOD:
        v = S.get(f"{arm}|{m}")
        if not v: continue
        rows.append(f"{label}{mark(kind)} & {ml} & {f(v['full'])} & {f(v['full_words'])} & {f(v['identity'])} & {f(v['qty'])} & "
                    f"{v['wrong_merges']:.1f} & {v['ne_linked']:.1f} & {v['unresolved']:.1f} " + EOL)
open(os.path.join(out, "tab-main.tex"), "w", encoding="utf-8").write(
    "\\begin{table*}[t]\\centering\\caption{Open PCA test document: mean over three runs per arm and model (160 supported allocation claims, 8 not-established entries). "
    "Full: identity correct and requirement text token-F1 $\\ge$0.8 against the defining sentence (pre-specified); Words: the same on word tokens after removing footnote markers and source parentheticals (post hoc); "
    "Qty: unit-bearing quantities preserved (36 claims); Wrong: links to a different defining requirement; NE: not-established entries linked; Unres.: supported claims left unresolved. "
    "$^\\dagger$Post hoc (designed after the error analysis of the pre-specified run).}\\label{tab:main}\n"
    "\\begin{tabular}{llrrrrrrr}\\hline\nArm & Model & Full & Words & Identity & Qty & Wrong & NE & Unres. \\\\\\hline\n" + "\n".join(rows) + "\n\\hline\\end{tabular}\\end{table*}\n")

rows = []
for arm, label, kind in [a for a in ARMS if a[0] in ("B0", "B1", "B2", "M", "M2", "M2R")]:
    for m, ml in MOD:
        v = S.get(f"{arm}|{m}")
        if not v: continue
        rows.append(f"{label}{mark(kind)} & {ml} & {v['calls']:.0f} & {v['input_tokens']/1000:.1f} & {v['output_tokens']/1000:.1f} & {v['provider_seconds']:.0f} " + EOL)
open(os.path.join(out, "tab-cost.tex"), "w", encoding="utf-8").write(
    "\\begin{table}[t]\\centering\\caption{Mean cost per run on the test document (provider-reported tokens, thousands; provider seconds summed over calls). Chunk arms share one extraction pass per model and run; its cost is included in every arm that uses it.}\\label{tab:cost}\n"
    "\\begin{tabular}{llrrrr}\\hline\nArm & Model & Calls & In (K) & Out (K) & Sec. \\\\\\hline\n" + "\n".join(rows) + "\n\\hline\\end{tabular}\\end{table}\n")

P = A["paired"]
LAB = {"M-B0": "M v1 $-$ B0", "M2-B0": "M2$^\\dagger$ $-$ B0", "M2R-B0": "M2R$^\\dagger$ $-$ B0", "M2R-M": "M2R$^\\dagger$ $-$ M v1",
       "M2R-B2v2": "M2R$^\\dagger$ $-$ B2 (v2 extr.)", "M2R-M2": "M2R$^\\dagger$ $-$ M2$^\\dagger$", "M2R-M2-noT": "M2R$^\\dagger$ $-$ M2 w/o corr.$^\\dagger$",
       "M-B2": "M v1 $-$ B2", "M2R-B2": "M2R$^\\dagger$ $-$ B2"}
rows = []
for key, lab in LAB.items():
    for m, ml in MOD:
        a, b = P.get(f"{key}|{m}|full"), P.get(f"{key}|{m}|full_words")
        if not a: continue
        rows.append(f"{lab} & {ml} & {a['diff']:+.3f} [{a['ci95'][0]:+.3f}, {a['ci95'][1]:+.3f}] & {a['claims_a_better']}/{a['claims_b_better']} & "
                    f"{b['diff']:+.3f} [{b['ci95'][0]:+.3f}, {b['ci95'][1]:+.3f}] " + EOL)
open(os.path.join(out, "tab-paired.tex"), "w", encoding="utf-8").write(
    "\\begin{table*}[t]\\centering\\caption{Paired differences of full-claim recall with 95\\% percentile bootstrap intervals over the "
    f"{A['components']} architecture components (10,000 resamples). Claims: number of claims on which the first arm is better / worse (run-mean, descriptive). "
    "Only M v1 $-$ B0 is a pre-specified contrast.}\\label{tab:paired}\n"
    "\\begin{tabular}{llrrr}\\hline\nContrast & Model & Full: diff [95\\% CI] & Claims & Words: diff [95\\% CI] \\\\\\hline\n" + "\n".join(rows) + "\n\\hline\\end{tabular}\\end{table*}\n")

DS = D["summary"]
rows = []
for arm, label, kind in [a for a in ARMS if a[0] in ("B0", "B1", "B2", "M", "M2R")]:
    cells = []
    for m, ml in MOD:
        v = DS.get(f"{arm}|{m}")
        cells.append(f(v["full"]) if v else "--")
    rows.append(f"{label}{mark(kind)} & " + " & ".join(cells) + " " + EOL)
open(os.path.join(out, "tab-dev.tex"), "w", encoding="utf-8").write(
    "\\begin{table}[t]\\centering\\caption{Development document (F Prime subtopology SDDs, 45 traceability claims, one run). F Prime is memorized by both models and is not test material.}\\label{tab:dev}\n"
    "\\begin{tabular}{lrr}\\hline\nArm & Sol & Opus \\\\\\hline\n" + "\n".join(rows) + "\n\\hline\\end{tabular}\\end{table}\n")
print("tables written to", out)
