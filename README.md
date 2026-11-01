# Requirement–architecture join toward SysML v2: data and code

Data, code and model outputs for the manuscript

> *Requirement–Architecture Integration toward SysML v2 under a Bounded Per-Call Budget: Reviewer-Free Ground Truth on Natural Documents and Identifier Disagreement*
> C. Y. Park, S. Matsumoto, J. Choi, J. Jang, J. Cho, J. Lee (under preparation for IEEE Access)

The manuscript text is not part of this repository. Every number in it is recomputed from the files here, or from
files you rebuild from public sources with the scripts here. No API key is needed: all model responses are in
`experiments/cache/`.

## What is here

| Path | Content |
| --- | --- |
| `scripts/` | Ground-truth builders, the pipelines (`pipeline.py`: B0, B1, B2, M v1; `pipeline_v2.py`: M2, M2R), scoring and analysis, the per-call budget replay, and this repository's builder `build_release.py` |
| `protocol/` | Annotation protocol v0, v1 and the v1.1 amendment; the pre-specified plans for Rubin, Rubin-X, context scaling and M3; frozen hashes (`*.sha256`) |
| `data/frozen/openpca-gt-v1.json` | Open PCA ground truth: 160 supported allocations, 8 not-established entries |
| `data/frozen/rubin/*-id-remap.json` | Seeded identifier permutations used for Rubin and Rubin-X |
| `data/frozen/*.sha256`, `data/frozen/context-scaling/padded-meta.json` | Hashes of frozen code and inputs |
| `data/sources/openpca/raw/requirements.txt` | Text of the Open PCA requirements document (CC BY-SA 3.0, see `DATA-NOTICE.md`) |
| `data/dev/` | F Prime development document and ground truth (Apache-2.0 excerpts) |
| `data/source-registry.csv` | Every screened source: URL, version, SHA-256, licence status, screening decision |
| `data/reviews/` | Author and reviewer inspection records, including the Rubin inspection sheet without its specification-text column |
| `experiments/outputs/` | Every run output (`*.json`), rendered SysML v2 (`*.sysml`), run logs, alignment outputs, memorization probes and analysis files |
| `experiments/cache/` | Raw provider responses (6,118 files), keyed by SHA-256 of (model, run, tag, prompt); prompts are rebuilt from the inputs |
| `decisions/log.csv` | The study's decision log (ACCESS-001 to ACCESS-064) |
| `reports/` | Data-screening reports and the consolidated results report |
| `MANIFEST.sha256` | SHA-256 of every file in this repository |
| `EXCLUDED.sha256` | SHA-256 of the files used in the study but not redistributed |

Models: `gpt-6.1-sol` and `claude-opus-5-5`, three runs per arm and model.

## What is not here, and how to rebuild it

The Rubin documents (LDM-148 v8.1, LSE-61 v6.2, and the trace export), the TMT Observatory Architecture Document and
the Open PCA AADL archive are public but carry no redistribution licence. They are not included, and neither are files
that reproduce their text: the Rubin and Rubin-X inputs and ground truth, and the context-scaling inputs.
`EXCLUDED.sha256` lists all of them with their hashes. To rebuild them:

1. Download the sources. The URLs and SHA-256 values are in `data/source-registry.csv`:
   - <https://ldm-148.lsst.io/v/v8.1/LDM-148.pdf>
   - <https://lse-61.lsst.io/v/v6.2/LSE-61.pdf>
   - `DM Requirements Traceability ID Order.csv` from <https://github.com/lsst/LDM-148>, saved as `trace-v8.1.csv`
   - the FAA REMH (DOT/FAA/AR-08/32)
   - the TMT OAD CCR34
2. Extract the text. The hashes were produced on Windows; scripts that write text files use the platform line ending, so on
   other systems compare after normalising CRLF to LF. The extractors below reproduce the hashes in `EXCLUDED.sha256` with Xpdf `pdftotext` 4.00 and `pypdf` 6.12.2 on Windows:

   ```
   pdftotext -enc UTF-8 LSE-61.pdf  data/sources/rubin/raw/LSE-61-v6.2.txt
   pdftotext -enc UTF-8 LDM-148.pdf data/sources/rubin/raw/LDM-148-v8.1.txt
   pdftotext -layout -eol dos OAD-CCR34.pdf data/sources/tmt/raw/oad.txt
   python -c "import pypdf;open('data/sources/alisa/raw/remh.txt','w',encoding='utf-8').write(''.join(p.extract_text() for p in pypdf.PdfReader('FAA-DoT-Requirements-AR-08-32.pdf').pages))"
   ```

3. Build the inputs and ground truth from the `scripts/` directory:

   ```
   S=../data/sources/rubin/raw
   python build_gt_rubin.py $S/LSE-61-v6.2.txt $S/LDM-148-v8.1.txt $S/trace-v8.1.csv ../data/frozen/rubin v1.2
   python build_gt_rubin.py $S/LSE-61-v6.2.txt $S/LDM-148-v8.1.txt $S/trace-v8.1.csv ../data/frozen/rubin v1.2 split
   python build_padded.py ../data/frozen/context-scaling
   ```

   - The `v1.2` option gives the ground truth reported in the manuscript.
   - The `v1.1` option and no option rebuild the earlier versions byte for byte.
   - The memory-arm input is the LDM-148 part of `rubin-remapped.txt`:

     ```
     python -c "b=open('../data/frozen/rubin/rubin-remapped.txt','rb').read();open('../data/frozen/rubin/rubin-ldm-only.txt','wb').write(b[b.find(b'===== DOCUMENT: LDM-148'):])"
     ```

## Recompute the results

Run from the repository root:

```
# Open PCA
python scripts/analyze_all.py data/frozen/openpca-gt-v1.json out-openpca.json experiments/outputs/main-v1 experiments/outputs/main-v2 --pairs M2R:B0,M2:B0,M:B0,M2R:M,M2R:B2v2,M2R:M2-noT,M2R:M2,M:B2,M2R:B2
# Rubin and Rubin-X (after rebuilding the ground truth)
python scripts/analyze_all.py data/frozen/rubin/rubin-gt-v1.2.json out-rubin.json experiments/outputs/rubin-v1 --pairs M:B2,M2R:B2,M2R:B0,M:B0,M:B1,M2R:M,M3:B0,M3:M2R
python scripts/analyze_all.py data/frozen/rubin/rubin-x-gt-v1.2.json out-rubinx.json experiments/outputs/rubin-x --pairs M:B1,M:B2,M:B0,M2R:B1,M2R:M
python scripts/join_cost_rubinx.py data/frozen/rubin/rubin-gt-v1.2.json experiments/outputs/rubin-v1 data/frozen/rubin/rubin-x-gt-v1.2.json experiments/outputs/rubin-x out-x3.json
```

Compare the outputs with the following files in `experiments/outputs/`:

| Condition | Reference file |
| --- | --- |
| Open PCA | `analysis-all.json` |
| Rubin | `rubin-analysis-gt12.json` |
| Rubin-X | `rubin-x-analysis-gt12.json` |
| Rubin-X join cost | `rubin-x-joincost-gt12.json` |

Bootstrap intervals use seed 20261031 and 10,000 resamples; the resampling stream is shared across pairs, so the
`--pairs` order above reproduces the reference files exactly.

Re-running a pipeline (`scripts/pipeline.py <doc> <arm> <model> <rep> <out_dir>`) replays every call from the cache when
the input document is byte-identical to the frozen one. `scripts/percall_budget.py` reports per-call input from the
cache alone. SysML v2 parsing (`validate_sysml.py`) needs the authors' language-server client, which is not included.

## Licence

- **Code:** the code in `scripts/` is MIT-licensed (`LICENSE`).
- **Data:** data files carry the licences of their sources. See `DATA-NOTICE.md`.
