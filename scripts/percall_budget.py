"""Per-call input budget of a finished run, replayed from the response cache only (no API call). Descriptive.
The arm is re-executed with llm.call patched to serve cached records only; every call's provider-reported input
tokens are collected. A cache miss is reported (and the replay then diverges from the original run).
Usage: python percall_budget.py <doc> <pipeline.py|pipeline_v2.py> <arm> <model> <rep> [chunk=1500]
Prints one JSON line: arm, model, rep, calls, cache_misses, max_input, p95_input, total_input.
"""
import hashlib, importlib, json, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import llm

doc_p, mod, arm, model, rep = sys.argv[1:6]
size = int(sys.argv[6]) if len(sys.argv) > 6 else 1500
P = importlib.import_module(mod.replace(".py", ""))
seen, miss = [], [0]


def cached_call(model_, prompt, tag, rep=0, max_tokens=32000, retries=3):
    key = hashlib.sha256(json.dumps([model_, rep, tag, prompt]).encode()).hexdigest()
    f = llm.CACHE / f"{key}.json"
    if not f.exists():
        miss[0] += 1
        return None, dict(model=model_, rep=rep, tag=tag, error="cache miss", usage=dict(input_tokens=0, output_tokens=0))
    rec = json.loads(f.read_text(encoding="utf-8")); rec["from_cache"] = True
    seen.append(rec.get("usage", {}).get("input_tokens", 0))
    try: return llm.parse_json(rec["response"]), rec
    except Exception: return None, rec


llm.call = cached_call
P.llm.call = cached_call
doc = open(doc_p, encoding="utf-8").read()
fn = {"B0": P.arm_b0, "B1": P.arm_b1, "B2": P.arm_b2, "M": P.arm_m}.get(arm) if mod.startswith("pipeline.") else P.ARMS[arm]
fn(doc, model, int(rep), [], size=size)
s = sorted(seen)
print(json.dumps(dict(arm=arm, model=model, rep=int(rep), calls=len(s), cache_misses=miss[0], max_input=s[-1] if s else 0,
                      p95_input=s[int(0.95 * (len(s) - 1))] if s else 0, total_input=sum(s))))
