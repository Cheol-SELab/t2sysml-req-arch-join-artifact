"""LaTeX table for the context-scaling experiment from experiments/outputs/ctx-analysis.json (no manual transcription).
Usage: python make_table_ctx.py <ctx-analysis.json> <out.tex>
"""
import json, sys

A = json.load(open(sys.argv[1], encoding="utf-8"))
S, T = A["summary"], A["tests"]
MOD = [("gpt-6.1-sol", "Sol"), ("claude-opus-5-5", "Opus")]
TOK = {"L0": "36K", "L1": "127K", "L2": "241K"}
EOL = "\\\\"
rows = []
for m, ml in MOD:
    for lv in ("L0", "L1", "L2"):
        b, r = S[f"{lv}|B0|{m}"], S[f"{lv}|M2R|{m}"]
        rows.append(f"{ml} & {lv} ({TOK[lv]}) & {b['full']:.3f} & {r['full']:.3f} & {r['identity']:.3f} & {r['wrong']:.1f} & "
                    f"{r['ne_linked']:.1f} & {r['calls']:.0f} & {r['input_tokens']/1000:.0f}K / {b['input_tokens']/1000:.0f}K " + EOL)
tests = []
for m, ml in MOD:
    for h in ("H1", "H2"):
        t = T[f"{h}|L2|{m}"]
        tests.append(f"{ml} {h} {t['estimate']:+.3f} [{t['ci95'][0]:+.3f}, {t['ci95'][1]:+.3f}]")
cap = ("Pre-specified context-scaling experiment: the test document embedded in unrelated natural engineering text "
       "(L1, L2; three runs per arm and model; L0 is the original document). Full recall for B0 and M2R; identity, wrong "
       "merges, not-established links and calls for M2R; total input tokens M2R / B0. At L2, " + "; ".join(tests) +
       " (H1: B0(L0)$-$B0(L2); H2: difference of drops B0 minus M2R; 95\\% component bootstrap).")
open(sys.argv[2], "w", encoding="utf-8").write(
    "\\begin{table*}[t]\\centering\\caption{" + cap + "}\\label{tab:ctx}\n"
    "\\begin{tabular}{llrrrrrrr}\\hline\nModel & Level & B0 full & M2R full & Identity & Wrong & NE & Calls & Input M2R / B0 "
    + EOL + "\\hline\n" + "\n".join(rows) + "\n\\hline\\end{tabular}\\end{table*}\n")
print("written", sys.argv[2])
