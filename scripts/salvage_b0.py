"""B0-salvage (descriptive, pre-specified in protocol/rubin-plan-v1.txt): recover complete allocation objects from the
cached raw B0 response when the response is truncated and unparseable. No model call.
The B0 prompt is rebuilt exactly as pipeline.arm_b0 builds it, the cache record is located by its key, and every
complete JSON object inside the response that has a "component" field is parsed (brace matching, string-aware).
Usage: python salvage_b0.py <doc> <model> <rep> <out.json>
"""
import hashlib, json, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import llm
import pipeline as P


def objects(text):
    out, depth, start, ins, esc = [], 0, None, False, False
    for i, ch in enumerate(text):
        if ins:
            if esc: esc = False
            elif ch == "\\": esc = True
            elif ch == '"': ins = False
            continue
        if ch == '"': ins = True
        elif ch == "{":
            depth += 1
            if depth == 2: start = i
        elif ch == "}":
            if depth == 2 and start is not None:
                try:
                    o = json.loads(text[start:i + 1])
                    if isinstance(o, dict) and "component" in o: out.append(o)
                except Exception:
                    pass
                start = None
            depth -= 1
    return out


def main():
    doc_path, model, rep, outp = sys.argv[1:5]
    doc = open(doc_path, encoding="utf-8").read()
    prompt = P.TASK + "\n\n" + P.SCHEMA + "\n\nDOCUMENT:\n" + doc
    key = hashlib.sha256(json.dumps([model, int(rep), "b0", prompt]).encode()).hexdigest()
    rec = json.loads((llm.CACHE / f"{key}.json").read_text(encoding="utf-8"))
    allocs = objects(rec["response"])
    u = rec.get("usage", {})
    json.dump(dict(arm="B0-salvage", model=model, rep=int(rep), doc=doc_path,
                   usage=dict(calls=1, errors=0, input_tokens=u.get("input_tokens", 0), output_tokens=u.get("output_tokens", 0),
                              truncated=u.get("truncated", 0), provider_wall_seconds=rec.get("wall_seconds", 0)),
                   diagnostics=dict(salvaged=len(allocs), response_chars=len(rec["response"])), allocations=allocs),
              open(outp, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print("B0-salvage", model, rep, len(allocs), "objects")


if __name__ == "__main__":
    main()
