"""Parse rendered SysML v2 with selab-rust-lsp and check that the integration survives rendering.

For each <run>.sysml next to <run>.json: parser error count, and the share of the run's resolved
allocations (component, requirement_id) that appear in the parsed model as a satisfy usage whose
owner is the component part and whose type is the requirement definition.
Reuses text2model/src/t2m_eval/sysml_graph.py (read-only import; ACCESS-016).
Usage: python validate_sysml.py <run.json> [...]
"""
import json, pathlib, re, sys
ROOT = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "text2model" / "src"))
from t2m_eval.sysml_graph import SysmlGraphClient, lsp_available


def q(s): return re.sub(r"\s+", " ", s or "").strip().replace("'", "")


def check(lsp, run_path):
    run = json.load(open(run_path, encoding="utf-8"))
    text = open(str(run_path)[:-5] + ".sysml", encoding="utf-8").read()
    g = lsp.analyze(text)
    sat = {(e["target"].split("::")[-1], e["source"].split("::")[-1]) for e in g.edges if e.get("kind") == "satisfy"}
    want = {(q(a["component"]), q(a["requirement_id"])) for a in run["allocations"] if a.get("requirement_id")}
    kept = len(want & sat)
    return dict(run=pathlib.Path(run_path).name, parse_errors=len(g.errors), nodes=len(g.nodes),
                resolved_allocations=len(want), kept_in_model=kept,
                kept_share=round(kept / max(1, len(want)), 4), first_error=(g.errors[0].get("message") if g.errors else ""))


if __name__ == "__main__":
    assert lsp_available(), "selab-rust-lsp binary not found"
    with SysmlGraphClient() as lsp:
        for p in sys.argv[1:]:
            print(json.dumps(check(lsp, p), ensure_ascii=False))
