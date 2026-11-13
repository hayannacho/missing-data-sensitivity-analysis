# Missing-data sensitivity analysis — synthetic demo

> **SYNTHETIC DATA DEMO — NOT REAL ADNI DATA.** Every demonstration row is generated from equations. This repository contains no actual participant data, original ADNI results, or reproduction of the original clinical study.

**An R workflow for comparing complete-case regression, multiple imputation, and alternative handling of zero-valued measurements.**

Prepared for the portfolio of **Hayoung Anna Cho** (credited as **Anna Cho** in the original report). This project comes from a Georgia Tech PSYC 8803 course analysis dated December 7, 2025. The original study used ADNI data; this public package runs on generated synthetic data only.

## My work and the analytical question

My original analysis examined how missing-data decisions affect an estimated association between a CSF peptide and tau PET, adjusting for age, sex, and measurement interval. The source R Markdown report names Anna Cho as its author and contains the following analytical workflow:

- Restore missing-value codes while distinguishing missing tau from zero-valued WMH.
- Summarize missingness and model associations with tau availability.
- Screen 69 peptide variables and fit an exploratory complete-case regression.
- Use `mice` for multiple imputation and pool regression estimates using Rubin's rules.
- Compare estimates when zero WMH measurements are retained versus excluded.

This attribution is based on the named report and its analysis, not a verified line-by-line authorship history. The archive does not establish the division of any upstream data preparation work. See [contributions](docs/CONTRIBUTIONS.md).

## What this repository demonstrates

The notebook follows the original analysis structure while making the public example independent of participant records. Synthetic features are named `PEP001`–`PEP069`; their selected feature and estimates are not the original study's results.

Publication preparation adds explicit feature selection, BH-adjusted screening p-values, type-appropriate imputation methods, a complete-case comparison restricted to the MI population, and diagnostic traces. These additions were prepared with AI assistance and are distinguished from the original work in [provenance](docs/PROVENANCE.md).

## Run the synthetic example

Requirements: Python 3 (standard library only), R, and Pandoc (available with RStudio). From the repository root:

```sh
python3 scripts/generate_demo.py
Rscript scripts/install_dependencies.R
Rscript scripts/render.R
```

Open `output/study.html`. Generated data and rendered output are ignored by Git. The notebook defaults to 20 imputations and 10 iterations; inspect convergence diagnostics rather than assuming these settings are sufficient. Optional Bayesian regression is disabled and requires a separate brms/Stan installation.

**Validation status:** the Python tests and full R/HTML pipeline passed on synthetic data in Ubuntu 24.04 ARM64 with R 4.3.3 and mice 3.16.0. Both scenarios completed 20 imputations × 10 iterations without mice logged events. Runtime success does not validate real-data assumptions or establish convergence for other datasets. See [validation](docs/VALIDATION.md).

**Course context:** this is a portfolio adaptation, not the original submitted report or an instructor-endorsed release. The reviewed course documents contain no explicit GitHub permission or prohibition; separate instructor permission has not been obtained. See [publication review](docs/PUBLICATION_REVIEW.md).

```sh
python3 -m unittest discover -s tests -v
Rscript tests/validate_analysis.R
```

## Interpretation

- Missingness patterns alone do not test MCAR; observed associations do not establish MAR or exclude MNAR.
- Screening and fitting on the same sample make the selected-feature estimates exploratory. BH adjustment does not solve post-selection inference for the later MI model.
- Restricting to observed WMH and excluding zero WMH change the population. This is a measurement-handling sensitivity analysis, not a general MNAR analysis.
- Synthetic results demonstrate software behavior, not clinical findings or reproduction of the original ADNI results.

## Files and data boundaries

| Path | Purpose |
| --- | --- |
| `analysis/study.Rmd` | Curated version of the original analysis, configured for synthetic input |
| `scripts/` | Synthetic generator, R dependency installation and rendering |
| `tests/` | Generator reproducibility and scenario coverage |
| `docs/` | Contribution evidence, provenance, data dictionary and validation |

No participant records, original CSVs, original rendered reports, individual-level figures, lecture materials, assignment prompt, or Git history are included. [Data handling](docs/DATA_HANDLING.md) explains the boundary. [AI usage](AI_USAGE.md) describes this preparation; AI use in the original analysis is not established by the available evidence.

No new software license is assigned in this preparation; see [NOTICE.md](NOTICE.md).

## Isolated R validation

With Docker installed, generate the synthetic CSV first, then run:

```sh
docker build -t missing-data-r .
docker run --rm -v "$PWD:/work" -w /work missing-data-r
```

The Dockerfile uses the same base-image digest and package installation commands as the verified container. Ubuntu repository packages may receive updates; `docs/tested-package-versions.tsv` records the tested versions rather than enforcing a complete dependency lock.
