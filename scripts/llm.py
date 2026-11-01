"""Minimal cached LLM client for the [access] experiments (OpenAI + Anthropic).

Every call is cached on disk by sha256(model, rep, tag, prompt); the cache file holds
the raw response text and provider usage, so runs are reproducible offline.
Keys are read from the environment; load_env() reads text2model/src/t2m_pipeline/.env
without printing values.
"""
import hashlib, io, json, os, pathlib, re, time, urllib.request

ROOT = pathlib.Path(__file__).resolve().parents[1]
CACHE = ROOT / "experiments" / "cache"
CACHE.mkdir(parents=True, exist_ok=True)


def load_env():
    p = ROOT.parent / "text2model" / "src" / "t2m_pipeline" / ".env"
    for line in io.open(p, encoding="utf-8"):
        line = line.strip()
        if line and not line.startswith("#") and "=" in line:
            k, v = line.split("=", 1)
            v = v.strip().strip('"').strip("'")
            if v: os.environ[k.strip()] = v


def _openai(model, prompt, max_tokens):
    from openai import OpenAI
    kw = dict(model=model, messages=[{"role": "user", "content": prompt}], response_format={"type": "json_object"},
              max_completion_tokens=max_tokens)
    if "sol" in model or "gpt-6" in model: kw["reasoning_effort"] = "medium"
    r = OpenAI(timeout=1800).chat.completions.create(**kw)
    u = r.usage
    return r.choices[0].message.content, r.model, dict(input_tokens=u.prompt_tokens, output_tokens=u.completion_tokens,
                                                        cached_input_tokens=getattr(getattr(u, "prompt_tokens_details", None), "cached_tokens", 0) or 0)


def _anthropic(model, prompt, max_tokens):
    body = json.dumps({"model": model, "max_tokens": max_tokens, "stream": True,
                       "messages": [{"role": "user", "content": prompt}]}).encode()
    req = urllib.request.Request("https://api.anthropic.com/v1/messages", data=body, headers={
        "x-api-key": os.environ["ANTHROPIC_API_KEY"], "anthropic-version": "2023-06-01", "content-type": "application/json"})
    text, usage, ver = [], {}, model
    with urllib.request.urlopen(req, timeout=1800) as resp:
        for raw in resp:
            line = raw.decode("utf-8").strip()
            if not line.startswith("data:"): continue
            ev = json.loads(line[5:])
            t = ev.get("type")
            if t == "message_start":
                ver = ev["message"].get("model", model); usage.update(ev["message"].get("usage", {}))
            elif t == "content_block_delta" and ev["delta"].get("type") == "text_delta":
                text.append(ev["delta"]["text"])
            elif t == "message_delta":
                usage.update(ev.get("usage", {}))
                if ev.get("delta", {}).get("stop_reason") == "max_tokens": usage["truncated"] = True
            elif t == "error":
                raise RuntimeError(json.dumps(ev)[:500])
    return "".join(text), ver, dict(input_tokens=usage.get("input_tokens", 0), output_tokens=usage.get("output_tokens", 0),
                                    cached_input_tokens=usage.get("cache_read_input_tokens", 0), truncated=usage.get("truncated", False))


def parse_json(text):
    s = text.strip()
    m = re.search(r"```(?:json)?\s*(.*?)```", s, re.S)
    if m: s = m.group(1)
    i = s.find("{")
    j = s.rfind("}")
    return json.loads(s[i:j + 1])


def call(model, prompt, tag, rep=0, max_tokens=32000, retries=3):
    """Return (parsed_json, record). record has usage, wall_seconds, cached flag."""
    key = hashlib.sha256(json.dumps([model, rep, tag, prompt]).encode()).hexdigest()
    f = CACHE / f"{key}.json"
    if f.exists():
        rec = json.loads(f.read_text(encoding="utf-8"))
        rec["from_cache"] = True
        try: return parse_json(rec["response"]), rec
        except Exception: pass
    err = None
    for attempt in range(retries):
        t0 = time.time()
        try:
            fn = _anthropic if model.startswith("claude") else _openai
            text, ver, usage = fn(model, prompt, max_tokens)
            rec = dict(model=model, model_version=ver, rep=rep, tag=tag, prompt_sha256=hashlib.sha256(prompt.encode()).hexdigest(),
                       response=text, usage=usage, wall_seconds=round(time.time() - t0, 2), attempt=attempt)
            data = parse_json(text)
            f.write_text(json.dumps(rec, ensure_ascii=False), encoding="utf-8")
            rec["from_cache"] = False
            return data, rec
        except Exception as e:
            err = e
            time.sleep(5 * (attempt + 1))
    rec = dict(model=model, rep=rep, tag=tag, error=repr(err)[:800], usage=dict(input_tokens=0, output_tokens=0))
    return None, rec
