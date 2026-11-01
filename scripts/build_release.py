"""Build the public artifact folder for the [access] study (ACCESS-064).

Usage: python build_release.py <dest_dir>

Policy (author decision 2026-10-31): source documents without a redistribution licence (Rubin LDM-148/LSE-61,
TMT OAD, Open PCA AADL archive) are not redistributed, nor are inputs or ground-truth files that reproduce their
text (Rubin/Rubin-X remapped inputs and GT, context-scaling padded inputs). They are listed in EXCLUDED.sha256 with
their hashes and are rebuilt by the included scripts from the public sources. Scripts, protocols, decision log,
reports, Open PCA ground truth (CC BY-SA 3.0 excerpts), F Prime development data (Apache-2.0 excerpts), model outputs,
the response cache and analyses are included. The manuscript is not included.
"""
import csv, hashlib, io, os, shutil, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
dest = Path(sys.argv[1]).resolve()
assert not dest.exists() or not any(dest.iterdir()), f"{dest} must be empty"
dest.mkdir(parents=True, exist_ok=True)

INCLUDE_DIRS = ["scripts", "protocol", "decisions", "reports", "data/dev", "experiments/outputs", "experiments/cache"]
INCLUDE_FILES = ["data/sources/openpca/raw/requirements.txt", "data/source-registry.csv", "data/case-registry.csv", "experiments/run-registry.csv",
                 "data/frozen/openpca-gt-v1.json", "data/frozen/context-scaling/padded-meta.json",
                 "data/frozen/rubin/rubin-id-remap.json", "data/frozen/rubin/rubin-x-id-remap.json"]
INCLUDE_GLOBS = ["data/frozen/*.sha256", "data/reviews/*.md"]
EXCLUDED = ["data/frozen/rubin/rubin-remapped.txt", "data/frozen/rubin/rubin-x-remapped.txt",
            "data/frozen/rubin/rubin-ldm-only.txt", "data/frozen/rubin/rubin-gt-v1.json",
            "data/frozen/rubin/rubin-gt-v1.1.json", "data/frozen/rubin/rubin-gt-v1.2.json",
            "data/frozen/rubin/rubin-x-gt-v1.json", "data/frozen/rubin/rubin-x-gt-v1.2.json",
            "data/frozen/context-scaling/openpca-L1.txt", "data/frozen/context-scaling/openpca-L2.txt",
            "data/reviews/2026-10-31-rubin-inspection-sheet-v1.csv",
            "data/sources/rubin/raw/LSE-61-v6.2.txt", "data/sources/rubin/raw/LDM-148-v8.1.txt",
            "data/sources/rubin/raw/trace-v8.1.csv", "data/sources/alisa/raw/remh.txt", "data/sources/tmt/raw/oad.txt"]
SKIP_PARTS = {"__pycache__"}


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def copy(rel):
    src, dst = ROOT / rel, dest / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)


rels = []
for d in INCLUDE_DIRS:
    for p in sorted((ROOT / d).rglob("*")):
        if p.is_file() and not SKIP_PARTS & set(p.parts):
            rels.append(p.relative_to(ROOT).as_posix())
rels += INCLUDE_FILES
for g in INCLUDE_GLOBS:
    rels += [p.relative_to(ROOT).as_posix() for p in sorted(ROOT.glob(g))]
rels = sorted(set(rels) - set(EXCLUDED))
for r in rels:
    copy(r)
for p in sorted((ROOT / "release-template").iterdir()):  # README, LICENSE, data notice
    shutil.copy2(p, dest / p.name); rels.append(p.name)

# inspection sheet without the LSE-61 specification text column
sheet = "data/reviews/2026-10-31-rubin-inspection-sheet-v1.csv"
rows = list(csv.DictReader(open(ROOT / sheet, encoding="utf-8-sig")))
cols = [c for c in rows[0] if c != "specification_LSE61"]
buf = io.StringIO(); w = csv.DictWriter(buf, cols, extrasaction="ignore"); w.writeheader(); w.writerows(rows)
out = sheet.replace(".csv", "-public.csv")
(dest / out).write_text(buf.getvalue(), encoding="utf-8")
rels.append(out)

with open(dest / "EXCLUDED.sha256", "w", encoding="utf-8") as f:
    f.write("# Files used in the study but not redistributed (no redistribution licence for their source text).\n"
            "# Rebuild them with the scripts listed in README.md and compare with these hashes.\n")
    for r in EXCLUDED:
        f.write(f"{sha(ROOT / r)}  {r}\n")
with open(dest / "MANIFEST.sha256", "w", encoding="utf-8") as f:
    for r in sorted(rels):
        f.write(f"{sha(dest / r)}  {r}\n")
print(f"files {len(rels)} -> {dest}")
