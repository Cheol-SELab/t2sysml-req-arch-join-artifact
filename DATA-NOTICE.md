# Data notice

- **Open PCA Pump requirements:** © Kansas State University SAnToS Laboratory, CC BY-SA 3.0.
  - Source: *Open Patient-Controlled Analgesia Infusion Pump System Requirements, Version 1.0.0* (SAnToS TR 2018-4-1, 2018), <http://pub.santoslab.org/open-pca-pump/artifacts/Open-PCA-Pump-Requirements.pdf>.
  - `data/sources/openpca/raw/requirements.txt` is a text extraction of it.
  - The defining sentences in `data/frozen/openpca-gt-v1.json`, `experiments/outputs/alignment-v0/` and the Open PCA run outputs are excerpts of it. These files are redistributed under CC BY-SA 3.0.
- **F Prime (NASA/JPL):** Apache-2.0, <https://github.com/nasa/fprime>.
  - `data/dev/` holds excerpts of its design documents and models.
- **Rubin Observatory LDM-148 and LSE-61, TMT OAD, Open PCA AADL archive:** not redistributed. See `README.md`.
  - The model outputs and cached responses in `experiments/` contain short passages that the models reproduced from these documents. They are included solely so that the reported scores can be recomputed.
  - The Rubin inspection sheet in `data/reviews/` omits the specification text.
- **Model outputs and cached responses:** produced by `gpt-6.1-sol` (OpenAI) and `claude-opus-5-5` (Anthropic) during the study.
