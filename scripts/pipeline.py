"""Requirement–architecture integration pipeline: method M and baselines B0, B1, B2.

Task (same for all arms): from a long system document, produce every allocation of a
requirement to an architecture component, with the requirement resolved to the place
where it is DEFINED (its defining identifier and verbatim text), or marked unresolved.

Output schema (all arms):
  {"allocations": [{"component", "cited_id", "cited_title",
                    "requirement_id"|null, "requirement_text"|null}]}

Arms
  B0  whole document in one call.
  B1  independent chunk extraction (no memory) + simple merge by exact identifier.
  B2  chunk extraction of allocation entries + BM25 retrieval of source chunks per
      component + one resolution call per component over the retrieved chunks.
  M   chunk extraction into a provenance-keeping fact store (requirement definitions,
      allocation entries) + candidate generation (exact id, exact title, lexical top-k)
      + evidence re-reading (verifier sees the allocation entry and each candidate's
      stored definition) + commit or leave unresolved.
B1, B2 and M share the same chunk-extraction calls (same prompt, same rep), so they
differ only after extraction.

Usage: python pipeline.py <doc.txt> <arm> <model> <rep> <out_dir> [chunk_tokens]
"""
import json, math, os, pathlib, re, sys, time
from collections import Counter
sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import llm
import tiktoken

ENC = tiktoken.get_encoding("o200k_base")
def ntok(s): return len(ENC.encode(s))
LIG = {"ﬁ": "fi", "ﬂ": "fl", "ﬀ": "ff", "ﬃ": "ffi", "ﬄ": "ffl"}
def norm(s):
    s = s or ""
    for k, v in LIG.items(): s = s.replace(k, v)
    return re.sub(r"\s+", " ", s).strip()
def key(s): return re.sub(r"[^a-z0-9]", "", norm(s).lower())

TASK = """You are building a SysML v2 system model from a system requirements document.
The modeling target is the ALLOCATION of requirements to architecture components, with each
requirement resolved to the place where it is DEFINED in the document (its defining identifier and
its verbatim requirement sentence, keeping every condition, number and unit).
Rules: use only the document text; do not invent allocations; an identifier cited in an allocation
list may differ from the identifier under which the requirement is defined - link them only when the
document gives evidence that they are the same requirement; if no definition can be established,
set requirement_id and requirement_text to null."""

SCHEMA = """Return JSON only:
{"allocations": [{"component": "<architecture component name as written>",
  "cited_id": "<requirement identifier exactly as cited in the allocation statement>",
  "cited_title": "<short title as cited>",
  "requirement_id": "<identifier under which the requirement is defined, or null>",
  "requirement_text": "<verbatim defining requirement sentence, or null>"}]}"""


HEAD = re.compile(r"^(#{1,6}\s+\S.*|\d{1,2}(?:\.\d{1,2}){0,3}\s+[A-Z][^.]{0,70})$")


def heading_level(ln):
    if ln.startswith("#"): return len(ln) - len(ln.lstrip("#"))
    return ln.split()[0].count(".") + 1


def chunks(doc, size, breadcrumbs=True):
    """Line-preserving chunks of <= size o200k tokens. With breadcrumbs, each chunk is prefixed by the
    path of section headings in force at its first line (deterministic structural context)."""
    lines, out, cur, n, path, start_path = doc.split("\n"), [], [], 0, [], []
    for ln in lines:
        t = ntok(ln) + 1
        if cur and n + t > size:
            out.append((list(start_path), "\n".join(cur))); cur, n = [], 0
        if not cur: start_path = list(path)
        cur.append(ln); n += t
        s = ln.strip()
        if HEAD.match(s) and ". . ." not in s:
            lv = heading_level(s)
            path = [p for p in path if heading_level(p) < lv] + [s]
    if cur: out.append((list(start_path), "\n".join(cur)))
    if not breadcrumbs: return [c for _, c in out]
    return [("SECTION CONTEXT (headings in force where this excerpt starts): " + " > ".join(p) + "\n\n" if p else "") + c for p, c in out]


EXTRACT = """You read ONE excerpt of a system requirements document. Extract only what is stated in this excerpt.
1. requirement_definitions: requirements defined here, each with the identifier under which it is defined
   (e.g. given in a footnote or label attached to the sentence), a short title, and the verbatim requirement
   sentence (keep conditions, numbers and units).
2. allocation_entries: statements that allocate or assign requirements to an architecture component
   (e.g. a list of "Allocated Requirements" under a component heading); give the component name, and each
   cited requirement identifier and title exactly as cited.
Return JSON only:
{"requirement_definitions": [{"id": "...", "title": "...", "text": "..."}],
 "allocation_entries": [{"component": "...", "cited_id": "...", "cited_title": "..."}]}
If the excerpt continues a component heading from a previous excerpt, use the heading name visible nearest
above the entries; if none is visible write "UNKNOWN".

EXCERPT:
"""


def extract_chunks(doc, model, rep, size, log):
    store = dict(defs=[], allocs=[])
    cs = chunks(doc, size)
    last_comp = None
    for i, c in enumerate(cs):
        data, rec = llm.call(model, EXTRACT + c, tag=f"extract-{size}", rep=rep, max_tokens=16000)
        log.append(rec)
        if not data: continue
        for d in data.get("requirement_definitions", []) or []:
            store["defs"].append(dict(id=norm(d.get("id")), title=norm(d.get("title")), text=norm(d.get("text")), chunk=i))
        for a in data.get("allocation_entries", []) or []:
            comp = norm(a.get("component"))
            if comp.upper() == "UNKNOWN" and last_comp: comp = last_comp
            last_comp = comp or last_comp
            store["allocs"].append(dict(component=comp, cited_id=norm(a.get("cited_id")), cited_title=norm(a.get("cited_title")), chunk=i))
    return store, cs


def dedup_allocs(allocs):
    seen, out = set(), []
    for a in allocs:
        k = (key(a["component"]), a["cited_id"])
        if k in seen: continue
        seen.add(k); out.append(a)
    return out


def arm_b0(doc, model, rep, log, **_):
    data, rec = llm.call(model, TASK + "\n\n" + SCHEMA + "\n\nDOCUMENT:\n" + doc, tag="b0", rep=rep, max_tokens=64000)
    log.append(rec)
    return (data or {}).get("allocations", [])


def arm_b1(doc, model, rep, log, size, **_):
    store, _ = extract_chunks(doc, model, rep, size, log)
    by_id = {}
    for d in store["defs"]: by_id.setdefault(d["id"], d)
    out = []
    for a in dedup_allocs(store["allocs"]):
        d = by_id.get(a["cited_id"])
        out.append(dict(component=a["component"], cited_id=a["cited_id"], cited_title=a["cited_title"],
                        requirement_id=d["id"] if d else None, requirement_text=d["text"] if d else None))
    return out


class BM25:
    def __init__(self, docs, k1=1.5, b=0.75):
        self.toks = [re.findall(r"[a-z0-9]+", norm(d).lower()) for d in docs]
        self.N = len(docs); self.avg = sum(map(len, self.toks)) / max(1, self.N)
        df = Counter(t for ts in self.toks for t in set(ts))
        self.idf = {t: math.log(1 + (self.N - n + 0.5) / (n + 0.5)) for t, n in df.items()}
        self.tf = [Counter(ts) for ts in self.toks]; self.k1, self.b = k1, b
    def top(self, query, k):
        q = re.findall(r"[a-z0-9]+", norm(query).lower())
        sc = []
        for i, tf in enumerate(self.tf):
            L = len(self.toks[i]); s = 0.0
            for t in q:
                if t in tf: s += self.idf[t] * tf[t] * (self.k1 + 1) / (tf[t] + self.k1 * (1 - self.b + self.b * L / self.avg))
            sc.append((s, i))
        return [i for s, i in sorted(sc, reverse=True)[:k] if s > 0]


def arm_b2(doc, model, rep, log, size, k=4, **_):
    store, cs = extract_chunks(doc, model, rep, size, log)
    bm = BM25(cs)
    groups = {}
    for a in dedup_allocs(store["allocs"]): groups.setdefault(a["component"], []).append(a)
    out = []
    for comp, al in groups.items():
        q = " ".join(f"{a['cited_id']} {a['cited_title']}" for a in al)
        # the chunk(s) holding the allocation entries plus the top-k retrieved chunks
        idx = set(bm.top(q, k)) | {a["chunk"] for a in al}
        ctx = "\n\n---\n\n".join(cs[i] for i in sorted(idx))
        entries = json.dumps([{"component": comp, "cited_id": a["cited_id"], "cited_title": a["cited_title"]} for a in al], ensure_ascii=False)
        prompt = (TASK + "\n\nResolve ONLY the following allocation entries using the retrieved excerpts.\nENTRIES:\n" + entries +
                  "\n\n" + SCHEMA + "\n\nRETRIEVED EXCERPTS:\n" + ctx)
        data, rec = llm.call(model, prompt, tag=f"b2-{size}-{k}", rep=rep, max_tokens=16000)
        log.append(rec)
        got = {(x.get("cited_id")): x for x in (data or {}).get("allocations", []) or []}
        for a in al:
            x = got.get(a["cited_id"], {})
            out.append(dict(component=comp, cited_id=a["cited_id"], cited_title=a["cited_title"],
                            requirement_id=x.get("requirement_id"), requirement_text=x.get("requirement_text")))
    return out


VERIFY = """Decide, from the evidence below only, which candidate requirement definition (if any) is the SAME requirement
that the allocation entry cites. Identifiers may differ between the allocation list and the definition; accept a
candidate only if the evidence (title, wording, identifier structure) shows it is the same requirement. If two or
more candidates fit equally, or none fits, answer null.
Return JSON only: {"decisions": [{"cited_id": "...", "chosen_candidate": "<candidate id or null>", "reason": "<short>"}]}

ALLOCATION ENTRIES (component and cited requirement):
"""


def arm_m(doc, model, rep, log, size, k=3, **_):
    store, cs = extract_chunks(doc, model, rep, size, log)
    defs = {}
    for d in store["defs"]:
        if d["id"] and d["id"] not in defs: defs[d["id"]] = d
    ids = list(defs)
    by_title = {}
    for i in ids: by_title.setdefault(key(defs[i]["title"]), []).append(i)
    bm = BM25([f"{defs[i]['title']} {defs[i]['text']}" for i in ids])
    groups = {}
    for a in dedup_allocs(store["allocs"]): groups.setdefault(a["component"], []).append(a)
    out = []
    for comp, al in groups.items():
        pending, cands_all = [], {}
        for a in al:
            exact = a["cited_id"] in defs
            same_title = key(a["cited_title"]) and by_title.get(key(a["cited_title"]), [])
            if exact and key(defs[a["cited_id"]]["title"]) == key(a["cited_title"]):
                d = defs[a["cited_id"]]   # identifier and title agree: commit without re-reading
                out.append(dict(component=comp, cited_id=a["cited_id"], cited_title=a["cited_title"], requirement_id=d["id"], requirement_text=d["text"], basis="id+title"))
                continue
            cands = ([a["cited_id"]] if exact else []) + list(same_title or []) + [ids[j] for j in bm.top(a["cited_title"], k)]
            cands = list(dict.fromkeys(cands))[: k + 2]
            if not cands:
                out.append(dict(component=comp, cited_id=a["cited_id"], cited_title=a["cited_title"], requirement_id=None, requirement_text=None, basis="no candidate"))
                continue
            pending.append(a); cands_all[a["cited_id"]] = cands
        if not pending: continue
        ev = []
        for a in pending:
            ev.append(f"- component: {comp}; cited_id: {a['cited_id']}; cited_title: {a['cited_title']}\n  candidates:\n" +
                      "\n".join(f"    * id {c}: title \"{defs[c]['title']}\"; text \"{defs[c]['text'][:600]}\"" for c in cands_all[a["cited_id"]]))
        data, rec = llm.call(model, VERIFY + "\n".join(ev), tag=f"m-verify-{size}-{k}", rep=rep, max_tokens=8000)
        log.append(rec)
        dec = {x.get("cited_id"): x.get("chosen_candidate") for x in (data or {}).get("decisions", []) or []}
        for a in pending:
            c = dec.get(a["cited_id"])
            ok = c in cands_all[a["cited_id"]]
            out.append(dict(component=comp, cited_id=a["cited_id"], cited_title=a["cited_title"],
                            requirement_id=c if ok else None, requirement_text=defs[c]["text"] if ok else None,
                            basis="verified" if ok else "unresolved"))
    return out


ARMS = dict(B0=arm_b0, B1=arm_b1, B2=arm_b2, M=arm_m)


def render_sysml(allocs, name="System"):
    def ident(s): return "'" + norm(s).replace("'", "") + "'"
    reqs, comps, lines = {}, {}, [f"package {ident(name)} {{"]
    for a in allocs:
        comps.setdefault(a["component"], [])
        rid = a.get("requirement_id")
        if rid:
            reqs.setdefault(rid, a.get("requirement_text") or "")
            comps[a["component"]].append(rid)
    for rid, text in reqs.items():
        doc = norm(text).replace("*/", "* /")
        lines.append(f"  requirement def {ident(rid)} {{ doc /* {doc} */ }}")
    for c, rids in comps.items():
        lines.append(f"  part def {ident(c + ' Def')};")
        lines.append(f"  part {ident(c)} : {ident(c + ' Def')};")
        for rid in dict.fromkeys(rids):
            lines.append(f"  satisfy {ident(rid)} by {ident(c)};")
    lines.append("}")
    return "\n".join(lines)


if __name__ == "__main__":
    doc_path, arm, model, rep, out_dir = sys.argv[1:6]
    size = int(sys.argv[6]) if len(sys.argv) > 6 else 1500
    llm.load_env()
    doc = open(doc_path, encoding="utf-8").read()
    log, t0 = [], time.time()
    allocs = ARMS[arm](doc, model, int(rep), log, size=size)
    os.makedirs(out_dir, exist_ok=True)
    base = os.path.join(out_dir, f"{arm}.{model}.r{rep}")
    usage = dict(calls=len(log), errors=sum(1 for r in log if "error" in r),
                 input_tokens=sum(r["usage"].get("input_tokens", 0) for r in log),
                 output_tokens=sum(r["usage"].get("output_tokens", 0) for r in log),
                 truncated=sum(1 for r in log if r.get("usage", {}).get("truncated")),
                 provider_wall_seconds=round(sum(r.get("wall_seconds", 0) for r in log), 1), run_wall_seconds=round(time.time() - t0, 1),
                 from_cache=sum(1 for r in log if r.get("from_cache")))
    json.dump(dict(arm=arm, model=model, rep=int(rep), chunk_tokens=size, doc=doc_path, usage=usage, allocations=allocs),
              open(base + ".json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    open(base + ".sysml", "w", encoding="utf-8").write(render_sysml(allocs))
    print(arm, model, rep, len(allocs), "allocations", json.dumps(usage))
