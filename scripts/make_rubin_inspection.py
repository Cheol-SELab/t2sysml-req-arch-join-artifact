"""Rubin GT inspection sheet (protocol annotation-v1 s6): all not_established + >=10% random supported.

Usage: make_rubin_inspection.py <rubin-gt-v1.1.json> <LSE-61.txt> <LDM-148.txt> <out.csv>
Page numbers are PDF page indices (1-based) counted from form feeds in the pdftotext output.
Judgement columns are left blank for the reviewer.
"""
import csv, json, math, random, re, sys, unicodedata

gt_path, lse_path, ldm_path, out_path = sys.argv[1:5]
gt = json.load(open(gt_path, encoding="utf8"))
lse = open(lse_path, encoding="utf8").read()
ldm = unicodedata.normalize("NFKC", open(ldm_path, encoding="utf8").read())  # ligatures (fl, ffl) in pdftotext output


def page(text, pos):
    return text.count("\f", 0, pos) + 1


def lse_page(rid):
    m = re.search(r"ID: " + re.escape(rid) + r"\b", lse)
    return page(lse, m.start()) if m else ""


# LDM-148 section 15.2 (second occurrence of the heading; the first is the table of contents)
heads = [m.start() for m in re.finditer(r"^15\.2 Component to Requirement Traceability", ldm, re.M)]
s152 = heads[-1]


def ldm_page(comp):
    m = re.search(r"^" + re.escape(comp) + r"\s*$", ldm[s152:], re.M)
    return page(ldm, s152 + m.start()) if m else ""


claims = gt["claims"]
ne = [c for c in claims if c["status"] != "supported"]
sup = [c for c in claims if c["status"] == "supported"]
k = math.ceil(0.10 * len(sup))
sample = sorted(random.Random(20261031).sample(sup, k), key=lambda c: c["gt_id"])

cols = ["item", "set", "gt_id", "component", "requirement_id", "title_in_LDM148", "title_in_LSE61",
        "specification_LSE61", "script_status", "script_reason", "LSE61_pdf_page", "LDM148_15.2_pdf_page",
        "reviewer_judgement", "reviewer_note"]
with open(out_path, "w", encoding="utf-8-sig", newline="") as f:
    w = csv.writer(f)
    w.writerow(cols)
    for i, (tag, c) in enumerate([("NE", c) for c in ne] + [("S", c) for c in sample], 1):
        rid = c["original_id"]
        w.writerow([f"{tag}{i:03d}" if tag == "NE" else f"S{i - len(ne):03d}", tag, c["gt_id"], c["component"], rid,
                    c["cited_title"], c["body_title"], c["body_text"], c["status"], c["reason"],
                    lse_page(rid), ldm_page(c["component"]), "", ""])
print(f"not_established {len(ne)}, supported sample {k}/{len(sup)} -> {out_path}")
