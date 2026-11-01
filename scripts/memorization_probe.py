"""Memorization probe (ACCESS-007): ask the model, with no documents, to reproduce
official model artifacts of a candidate project. Saves raw responses; scoring is
done separately against the official files. Usage: python memorization_probe.py <model>"""
import json, sys, os, datetime, pathlib
from openai import OpenAI

MODEL = sys.argv[1] if len(sys.argv) > 1 else "gpt-6.1-sol"
OUT = pathlib.Path(__file__).resolve().parents[1] / "experiments" / "outputs" / "memorization-probe-v0"
OUT.mkdir(parents=True, exist_ok=True)

PROBES = {
  "fprime_cmddispatcher_ports": "Without consulting any document, list every port declared in the FPP model of the NASA F Prime component Svc::CommandDispatcher (file Svc/CmdDispatcher/CmdDispatcher.fpp). For each port give: name, FPP port type (e.g. Fw.Cmd), direction (input/output), and kind (async/sync/guarded) if any. Answer as a JSON list. If you do not know, say so explicitly rather than guessing.",
  "fprime_cdhcore_instances": "Without consulting any document, list the component instances defined in the NASA F Prime subtopology Svc/Subtopologies/CdhCore/CdhCore.fpp with their component types, and list the requirement IDs (SVC-CDHCORE-xxx) in its SDD and which instance satisfies each. Answer as JSON. If you do not know, say so explicitly rather than guessing.",
  "openpca_control_panel": "Without consulting any document, list the AADL component declarations (devices, threads, processes) in the package PCA_Control_Panel of the Kansas State University Open PCA Pump AADL model, and the Open PCA requirement IDs (of the form R5.5.0(n)) that are cited as comments in that package. Answer as JSON. If you do not know, say so explicitly rather than guessing.",
  "subset026_3_13_2": "Without consulting any document, quote verbatim the text of UNISIG SUBSET-026 v3.3.0 clauses 3.13.2.2.1 through 3.13.2.2.5 (Chapter 3, speed and distance monitoring). If you cannot quote them verbatim, say so explicitly rather than paraphrasing.",
}

client = OpenAI()
stamp = datetime.datetime.now(datetime.timezone.utc).isoformat()
log = []
for key, prompt in PROBES.items():
    r = client.chat.completions.create(model=MODEL, messages=[{"role": "user", "content": prompt}])
    txt = r.choices[0].message.content
    rec = {"probe": key, "model": MODEL, "model_version": r.model, "timestamp": stamp,
           "prompt": prompt, "response": txt,
           "usage": r.usage.model_dump() if r.usage else None}
    (OUT / f"{key}.{MODEL}.json").write_text(json.dumps(rec, ensure_ascii=False, indent=2), encoding="utf-8")
    log.append({"probe": key, "chars": len(txt or ""), "usage": rec["usage"]})
    print(key, len(txt or ""), "chars")
(OUT / f"run.{MODEL}.{stamp[:10]}.json").write_text(json.dumps(log, indent=2), encoding="utf-8")
