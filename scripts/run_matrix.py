"""Run arms x models x reps with one worker per (model, rep); arms run sequentially inside a worker
so that B1, B2 and M reuse the same chunk-extraction calls of that (model, rep).
Usage: python run_matrix.py <doc> <out_dir> <models,comma> <reps> [arms=B0,B1,B2,M] [chunk_tokens=1500]
Logs: <out_dir>/logs/<model>.r<rep>.log
"""
import os, subprocess, sys
from concurrent.futures import ThreadPoolExecutor

doc, out = sys.argv[1], sys.argv[2]
models = sys.argv[3].split(",")
reps = int(sys.argv[4])
arms = (sys.argv[5] if len(sys.argv) > 5 else "B0,B1,B2,M").split(",")
size = sys.argv[6] if len(sys.argv) > 6 else "1500"
here = os.path.dirname(os.path.abspath(__file__))
os.makedirs(os.path.join(out, "logs"), exist_ok=True)


def worker(mr):
    m, r = mr
    log = open(os.path.join(out, "logs", f"{m}.r{r}.log"), "a", encoding="utf-8")
    for arm in arms:
        p = subprocess.run([sys.executable, "-X", "utf8", os.path.join(here, "pipeline.py"), doc, arm, m, str(r), out, size],
                           stdout=log, stderr=log)
        log.write(f"## {arm} exit {p.returncode}\n"); log.flush()
    return m, r


with ThreadPoolExecutor(max_workers=len(models) * reps) as ex:
    for m, r in ex.map(worker, [(m, r) for m in models for r in range(reps)]):
        print("done", m, r, flush=True)
