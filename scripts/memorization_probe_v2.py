"""Memorization probe v2 (ACCESS-007/009): forced-answer variant, two vendors.

Differences from v0: the prompt forbids abstention and demands a best-effort
answer, so recall is an upper bound on what the model can reproduce from memory.
Scoring against the official files is done by score_memorization.py.

Usage: python memorization_probe_v2.py            # both models
       python memorization_probe_v2.py gpt-6.1-sol
Keys are read from the environment (OPENAI_API_KEY, ANTHROPIC_API_KEY); the
caller loads them. Values are never printed.
"""
import datetime, json, os, pathlib, sys, urllib.request

OUT = pathlib.Path(__file__).resolve().parents[1] / "experiments" / "outputs" / "memorization-probe-v2"
OUT.mkdir(parents=True, exist_ok=True)

FORCE = ("You must answer from memory with your best guess even if unsure. Do not refuse, "
         "do not say you don't know, do not add caveats. Output only the requested JSON.")
PROBES = {
  "fprime_cmddispatcher_ports": FORCE + " List every port declared in the FPP model of NASA F Prime component Svc::CommandDispatcher (Svc/CmdDispatcher/CmdDispatcher.fpp). JSON list of objects {name, type, direction, kind}.",
  "fprime_cdhcore_instances": FORCE + " List the component instances (name and component type) defined in NASA F Prime Svc/Subtopologies/CdhCore/CdhCore.fpp, and the SVC-CDHCORE-xxx requirement IDs with the instance that satisfies each. JSON {instances:[{name,type}], requirements:[{id,satisfied_by}]}.",
  "fprime_health_ports": FORCE + " List every port declared in NASA F Prime Svc/Health/Health.fpp (general ports only, not command/event/telemetry special ports). JSON list of {name, type, direction, kind}.",
  "openpca_control_panel": FORCE + " List the AADL component declarations (name and category: device/thread/process/system) in package PCA_Control_Panel of the Kansas State University Open PCA Pump AADL model, and the requirement IDs of the form R5.5.0(n) cited as comments there. JSON {components:[{name,category}], requirement_ids:[...]}.",
  "openpca_allocation_control_panel": FORCE + " In the Open PCA Pump System Requirements 1.0.0 (KSU SAnToS TR 2018-4-1), section 10.5.1 Control Panel lists 'Allocated Requirements'. Reproduce that list as JSON [{id, title}].",
  "subset026_3_13_2": FORCE + " Quote the text of UNISIG SUBSET-026 v3.3.0 clauses 3.13.2.2.1 through 3.13.2.2.5. JSON [{clause, text}].",
}

def call_openai(model, prompt):
    from openai import OpenAI
    r = OpenAI().chat.completions.create(model=model, messages=[{"role": "user", "content": prompt}])
    return r.choices[0].message.content, r.model, r.usage.model_dump() if r.usage else None

def call_anthropic(model, prompt):
    body = json.dumps({"model": model, "max_tokens": 4000, "messages": [{"role": "user", "content": prompt}]}).encode()
    req = urllib.request.Request("https://api.anthropic.com/v1/messages", data=body, headers={
        "x-api-key": os.environ["ANTHROPIC_API_KEY"], "anthropic-version": "2023-06-01", "content-type": "application/json"})
    with urllib.request.urlopen(req, timeout=300) as resp:
        d = json.loads(resp.read())
    txt = "".join(b.get("text", "") for b in d.get("content", []))
    return txt, d.get("model"), d.get("usage")

MODELS = {"gpt-6.1-sol": call_openai, "claude-opus-5-5": call_anthropic}
targets = [sys.argv[1]] if len(sys.argv) > 1 else list(MODELS)
stamp = datetime.datetime.now(datetime.timezone.utc).isoformat()
for model in targets:
    for key, prompt in PROBES.items():
        try:
            txt, ver, usage = MODELS[model](model, prompt)
            rec = {"probe": key, "model": model, "model_version": ver, "timestamp": stamp, "prompt": prompt, "response": txt, "usage": usage}
        except Exception as e:  # keep the failure as evidence
            rec = {"probe": key, "model": model, "timestamp": stamp, "prompt": prompt, "error": repr(e)[:500]}
        (OUT / f"{key}.{model}.json").write_text(json.dumps(rec, ensure_ascii=False, indent=2), encoding="utf-8")
        print(model, key, "ERROR" if "error" in rec else f"{len(rec['response'] or '')} chars")
