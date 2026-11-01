"""Method v2 (POST-HOC, ACCESS-020/021): split-evidence fact store with identifier-correspondence learning.

Derived from the error analysis of M v1 on the test document; reported as post-hoc. pipeline.py (v1) is
imported unchanged. New shared extraction (v2) records three fact kinds per excerpt:
  items        : requirement sentences with section number and item label, WITHOUT requiring an identifier
  declarations : identifier declarations (footnotes / labels such as "requirement R7.3.0(1): battery backup")
  allocations  : allocation entries (component, cited id, cited title)
Store consolidation (deterministic, no model call):
  join  declaration -> item  when the declaration title occurs in the item text, preferring the same or
        nearest excerpt; an item may also carry an identifier stated in its own excerpt.
  learn the document-wide identifier correspondence T from allocation entries whose cited title equals
        exactly one declared title: T = the most frequent per-component numeric delta between cited and
        declared identifier (requires >= 5 pairs and >= 60 % support; otherwise T is undefined).
  resolve each allocation entry:
        a) T(cited) declared and title equal                 -> commit  (basis corr+title)
        b) cited declared verbatim and title equal           -> commit  (basis id+title)
        c) T(cited) declared, title differs                  -> evidence re-reading on that one candidate
        d) title-equal declaration inconsistent with T, or nothing -> unresolved
     If T is undefined: v1 behaviour (candidates + verifier) over the joined store.
Arms: B1v2 / B2v2 (v1 merge / retrieval over v2 extraction), M2 (full), M2-noT (no correspondence learning).
Usage: python pipeline_v2.py <doc> <arm> <model> <rep> <out_dir> [chunk_tokens]
"""
import json, os, re, sys, time
from collections import Counter
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import llm
import pipeline as P

EXTRACT2 = """You read ONE excerpt of a system requirements document. Extract only what is stated in this excerpt.
1. requirement_items: every requirement sentence (e.g. a numbered item "(15) The Control Panel shall ...").
   Give the section number it belongs to (from the nearest heading or the SECTION CONTEXT line), the item label
   as written (e.g. "(15)"), the verbatim sentence (keep conditions, numbers and units), and an identifier ONLY
   if the identifier is written next to the sentence itself; otherwise null.
2. identifier_declarations: lines that declare a requirement identifier together with a short title, such as
   footnotes "requirement R7.3.0(1): battery backup". Give the identifier and the title exactly as written.
3. allocation_entries: statements that allocate or assign requirements to an architecture component (e.g. a list
   of "Allocated Requirements" under a component heading): component name, cited identifier and cited title exactly
   as written. If the component heading is not visible, use the last heading in the SECTION CONTEXT line.
Return JSON only:
{"requirement_items": [{"section": "...", "label": "...", "text": "...", "id": null}],
 "identifier_declarations": [{"id": "...", "title": "..."}],
 "allocation_entries": [{"component": "...", "cited_id": "...", "cited_title": "..."}]}

EXCERPT:
"""

NUM = re.compile(r"\d+")


def extract_v2(doc, model, rep, size, log):
    cs = P.chunks(doc, size)
    st = dict(items=[], decls=[], allocs=[])
    for i, c in enumerate(cs):
        data, rec = llm.call(model, EXTRACT2 + c, tag=f"extract2-{size}", rep=rep, max_tokens=16000)
        log.append(rec)
        if not data: continue
        for it in data.get("requirement_items", []) or []:
            st["items"].append(dict(section=P.norm(it.get("section")), label=P.norm(it.get("label")), text=P.norm(it.get("text")),
                                    id=P.norm(it.get("id")) if it.get("id") else "", chunk=i))
        for d in data.get("identifier_declarations", []) or []:
            if d.get("id"): st["decls"].append(dict(id=P.norm(d["id"]), title=P.norm(d.get("title")), chunk=i))
        for a in data.get("allocation_entries", []) or []:
            st["allocs"].append(dict(component=P.norm(a.get("component")), cited_id=P.norm(a.get("cited_id")),
                                     cited_title=P.norm(a.get("cited_title")), chunk=i))
    return st, cs


def join_store(st):
    """Return defs: id -> {id, title, text, chunk, basis}. Declarations are joined to items by title containment."""
    defs = {}
    items = st["items"]
    for d in st["decls"]:
        if d["id"] in defs: continue
        tk = P.key(d["title"])
        best = None
        for it in items:
            if it["id"] and P.key(it["id"]) == P.key(d["id"]):
                best = (0, it); break
            if tk and tk in P.key(it["text"]):
                dist = abs(it["chunk"] - d["chunk"])
                if dist <= 1 and (best is None or dist < best[0]): best = (dist, it)
        defs[d["id"]] = dict(id=d["id"], title=d["title"], text=best[1]["text"] if best else "", chunk=d["chunk"],
                             basis="decl+item" if best else "decl only")
    for it in items:   # items that state their own identifier but have no declaration
        if it["id"] and it["id"] not in defs:
            defs[it["id"]] = dict(id=it["id"], title="", text=it["text"], chunk=it["chunk"], basis="item id")
    return defs


def delta(a, b):
    na, nb = NUM.findall(a or ""), NUM.findall(b or "")
    if len(na) != len(nb) or not na: return None
    pre_a, pre_b = NUM.sub("#", a), NUM.sub("#", b)
    if pre_a != pre_b: return None
    return tuple(int(y) - int(x) for x, y in zip(na, nb))


def apply_delta(a, t):
    na = NUM.findall(a or "")
    if t is None or len(na) != len(t): return None
    it = iter(str(int(x) + d) for x, d in zip(na, t))
    return NUM.sub(lambda m: next(it), a)


def learn_correspondence(allocs, defs):
    by_title = {}
    for i, d in defs.items():
        if d["title"]: by_title.setdefault(P.key(d["title"]), []).append(i)
    deltas = []
    for a in allocs:
        c = by_title.get(P.key(a["cited_title"]), [])
        if len(c) == 1:
            t = delta(a["cited_id"], c[0])
            if t is not None: deltas.append(t)
    if len(deltas) < 5: return None, dict(pairs=len(deltas))
    t, n = Counter(deltas).most_common(1)[0]
    info = dict(pairs=len(deltas), dominant=list(t), support=round(n / len(deltas), 3))
    return (t if n / len(deltas) >= 0.6 else None), info


VERIFY2 = """Decide, from the evidence below only, whether each allocation entry cites the SAME requirement as its candidate
definition. The candidate was proposed because its identifier corresponds to the cited identifier under the identifier
correspondence observed throughout this document. Accept only if the wording supports that it is the same requirement.
Return JSON only: {"decisions": [{"cited_id": "...", "same": true|false, "reason": "<short>"}]}

ENTRIES:
"""


def resolve(allocs, defs, model, rep, log, size, use_T=True, k=3):
    T, info = learn_correspondence(allocs, defs) if use_T else (None, dict(disabled=True))
    out, pending = [], []
    for a in P.dedup_allocs(allocs):
        tk = P.key(a["cited_title"])
        cand_T = apply_delta(a["cited_id"], T) if T is not None else None
        rec = dict(component=a["component"], cited_id=a["cited_id"], cited_title=a["cited_title"], requirement_id=None, requirement_text=None)
        if cand_T and cand_T in defs and P.key(defs[cand_T]["title"]) == tk:
            rec.update(requirement_id=cand_T, requirement_text=defs[cand_T]["text"] or None, basis="corr+title")
        elif a["cited_id"] in defs and P.key(defs[a["cited_id"]]["title"]) == tk:
            rec.update(requirement_id=a["cited_id"], requirement_text=defs[a["cited_id"]]["text"] or None, basis="id+title")
        elif cand_T and cand_T in defs:
            pending.append((rec, cand_T)); continue
        elif T is None:
            pending.append((rec, None)); continue
        else:
            rec["basis"] = "unresolved: no identifier-consistent candidate"
        out.append(rec)
    # evidence re-reading for single correspondence candidates (grouped per component)
    single = [(r, c) for r, c in pending if c]
    groups = {}
    for r, c in single: groups.setdefault(r["component"], []).append((r, c))
    for comp, lst in groups.items():
        ev = "\n".join(f"- component {comp}; cited_id {r['cited_id']}; cited_title \"{r['cited_title']}\"; candidate {c}: title \"{defs[c]['title']}\"; text \"{defs[c]['text'][:600]}\"" for r, c in lst)
        data, lr = llm.call(model, VERIFY2 + ev, tag=f"m2-verify-{size}", rep=rep, max_tokens=8000)
        log.append(lr)
        dec = {x.get("cited_id"): bool(x.get("same")) for x in (data or {}).get("decisions", []) or []}
        for r, c in lst:
            if dec.get(r["cited_id"]): r.update(requirement_id=c, requirement_text=defs[c]["text"] or None, basis="corr+verified")
            else: r["basis"] = "unresolved: verifier rejected"
            out.append(r)
    # no correspondence learned: v1-style candidate verification over the joined store
    rest = [r for r, c in pending if not c]
    if rest:
        ids = list(defs)
        by_title = {}
        for i in ids: by_title.setdefault(P.key(defs[i]["title"]), []).append(i)
        bm = P.BM25([f"{defs[i]['title']} {defs[i]['text']}" for i in ids]) if ids else None
        groups = {}
        for r in rest: groups.setdefault(r["component"], []).append(r)
        for comp, lst in groups.items():
            ev, cands = [], {}
            for r in lst:
                cc = ([r["cited_id"]] if r["cited_id"] in defs else []) + by_title.get(P.key(r["cited_title"]), []) + ([ids[j] for j in bm.top(r["cited_title"], k)] if bm else [])
                cands[r["cited_id"]] = list(dict.fromkeys(cc))[: k + 2]
                ev.append(f"- component: {comp}; cited_id: {r['cited_id']}; cited_title: {r['cited_title']}\n  candidates:\n" +
                          "\n".join(f"    * id {c}: title \"{defs[c]['title']}\"; text \"{defs[c]['text'][:600]}\"" for c in cands[r["cited_id"]]))
            data, lr = llm.call(model, P.VERIFY + "\n".join(ev), tag=f"m2-v1verify-{size}", rep=rep, max_tokens=8000)
            log.append(lr)
            dec = {x.get("cited_id"): x.get("chosen_candidate") for x in (data or {}).get("decisions", []) or []}
            for r in lst:
                c = dec.get(r["cited_id"])
                if c in cands[r["cited_id"]]: r.update(requirement_id=c, requirement_text=defs[c]["text"] or None, basis="verified")
                else: r["basis"] = "unresolved"
                out.append(r)
    return out, info


def arm_m2(doc, model, rep, log, size, use_T=True, **_):
    st, _ = extract_v2(doc, model, rep, size, log)
    defs = join_store(st)
    out, info = resolve(st["allocs"], defs, model, rep, log, size, use_T=use_T)
    return out, dict(correspondence=info, store=dict(items=len(st["items"]), decls=len(st["decls"]), defs=len(defs),
                                                    defs_with_text=sum(1 for d in defs.values() if d["text"]), allocs=len(st["allocs"])))


def arm_b1v2(doc, model, rep, log, size, **_):
    st, _ = extract_v2(doc, model, rep, size, log)
    defs = join_store(st)
    out = []
    for a in P.dedup_allocs(st["allocs"]):
        d = defs.get(a["cited_id"])
        out.append(dict(component=a["component"], cited_id=a["cited_id"], cited_title=a["cited_title"],
                        requirement_id=d["id"] if d else None, requirement_text=(d["text"] or None) if d else None))
    return out, {}


def arm_b2v2(doc, model, rep, log, size, k=4, **_):
    st, cs = extract_v2(doc, model, rep, size, log)
    bm = P.BM25(cs)
    groups = {}
    for a in P.dedup_allocs(st["allocs"]): groups.setdefault(a["component"], []).append(a)
    out = []
    for comp, al in groups.items():
        q = " ".join(f"{a['cited_id']} {a['cited_title']}" for a in al)
        idx = set(bm.top(q, k)) | {a["chunk"] for a in al}
        ctx = "\n\n---\n\n".join(cs[i] for i in sorted(idx))
        entries = json.dumps([{"component": comp, "cited_id": a["cited_id"], "cited_title": a["cited_title"]} for a in al], ensure_ascii=False)
        prompt = (P.TASK + "\n\nResolve ONLY the following allocation entries using the retrieved excerpts.\nENTRIES:\n" + entries +
                  "\n\n" + P.SCHEMA + "\n\nRETRIEVED EXCERPTS:\n" + ctx)
        data, rec = llm.call(model, prompt, tag=f"b2v2-{size}-{k}", rep=rep, max_tokens=16000)
        log.append(rec)
        got = {x.get("cited_id"): x for x in (data or {}).get("allocations", []) or []}
        for a in al:
            x = got.get(a["cited_id"], {})
            out.append(dict(component=comp, cited_id=a["cited_id"], cited_title=a["cited_title"],
                            requirement_id=x.get("requirement_id"), requirement_text=x.get("requirement_text")))
    return out, {}


ARMS = {"M2": arm_m2, "M2-noT": lambda *a, **k: arm_m2(*a, use_T=False, **k), "B1v2": arm_b1v2, "B2v2": arm_b2v2}


TEXT_REREAD = """Below are requirement identifier declarations (e.g. footnotes) and the document excerpts in which they appear.
For each declaration, copy VERBATIM the requirement sentence that the declaration annotates (the sentence carrying the
footnote marker or label), keeping every condition, number and unit. If the excerpts do not contain it, return null.
Return JSON only: {"texts": [{"id": "...", "text": "<verbatim sentence or null>"}]}

DECLARATIONS:
"""


def reread_texts(defs, cs, model, rep, log, size):
    """POST-HOC v2.1 (ACCESS-023): fill missing definition texts by re-reading the declaration's excerpt and the one before."""
    missing = [d for d in defs.values() if not d["text"] and d["basis"] != "item id"]
    groups = {}
    for d in missing: groups.setdefault(d["chunk"], []).append(d)
    for ch, lst in sorted(groups.items()):
        ctx = "\n\n---\n\n".join(cs[i] for i in (ch - 1, ch) if 0 <= i < len(cs))
        prompt = TEXT_REREAD + "\n".join(f"- {d['id']}: {d['title']}" for d in lst) + "\n\nEXCERPTS:\n" + ctx
        data, rec = llm.call(model, prompt, tag=f"m2r-text-{size}", rep=rep, max_tokens=8000)
        log.append(rec)
        got = {x.get("id"): x.get("text") for x in (data or {}).get("texts", []) or []}
        for d in lst:
            t = got.get(d["id"])
            if t: d["text"], d["basis"] = P.norm(t), "decl+reread"


def arm_m2r(doc, model, rep, log, size, **_):
    st, cs = extract_v2(doc, model, rep, size, log)
    defs = join_store(st)
    reread_texts(defs, cs, model, rep, log, size)
    out, info = resolve(st["allocs"], defs, model, rep, log, size, use_T=True)
    return out, dict(correspondence=info, store=dict(defs=len(defs), defs_with_text=sum(1 for d in defs.values() if d["text"])))


ARMS["M2R"] = arm_m2r

if __name__ == "__main__":
    doc_path, arm, model, rep, out_dir = sys.argv[1:6]
    size = int(sys.argv[6]) if len(sys.argv) > 6 else 1500
    llm.load_env()
    doc = open(doc_path, encoding="utf-8").read()
    log, t0 = [], time.time()
    allocs, diag = ARMS[arm](doc, model, int(rep), log, size=size)
    os.makedirs(out_dir, exist_ok=True)
    base = os.path.join(out_dir, f"{arm}.{model}.r{rep}")
    usage = dict(calls=len(log), errors=sum(1 for r in log if "error" in r),
                 input_tokens=sum(r["usage"].get("input_tokens", 0) for r in log),
                 output_tokens=sum(r["usage"].get("output_tokens", 0) for r in log),
                 truncated=sum(1 for r in log if r.get("usage", {}).get("truncated")),
                 provider_wall_seconds=round(sum(r.get("wall_seconds", 0) for r in log), 1), run_wall_seconds=round(time.time() - t0, 1),
                 from_cache=sum(1 for r in log if r.get("from_cache")))
    json.dump(dict(arm=arm, model=model, rep=int(rep), chunk_tokens=size, doc=doc_path, usage=usage, diagnostics=diag, allocations=allocs),
              open(base + ".json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    open(base + ".sysml", "w", encoding="utf-8").write(P.render_sysml(allocs))
    print(arm, model, rep, len(allocs), "allocations", json.dumps(usage), json.dumps(diag))
