# Validation record

Validated 2026-11-13 on an isolated Ubuntu 24.04.5 ARM64 Docker container, R 4.3.3, mice 3.16.0, rmarkdown 2.25, Pandoc 3.1.3. Host system R was not installed or changed.

## Executed

- Python generator: 400 artificial observations, 69 synthetic peptide features; no real input data read.
- Python unittest: 2 tests passed (reproducibility, labels, missingness/zero scenarios and usable complete cases).
- `Rscript scripts/render.R`: all enabled notebook chunks completed and HTML generated.
- `Rscript tests/validate_analysis.R`: full notebook rendered again; all assertions passed.
- Main and WMH-positive scenarios: 20 imputations and 10 iterations each, with no `mice` logged events. Completed data had no remaining missing values. Pooled estimates were finite, categorical imputation used logistic regression, and the predictor diagonal was zero.
- Synthetic MI populations: 368 with observed WMH; 330 with positive WMH. The screen selected synthetic PEP001. These are demo outputs, not ADNI results.
- Generated HTML contained no rendered warning/error messages detected by text inspection. Main imputation trace plots were visually inspected; no sustained obvious drift was observed. This is limited diagnostic review, not proof of convergence.

See `synthetic-validation-results.txt`, `tested-session-info.txt`, and `tested-package-versions.tsv` for recorded outputs and versions. The package version inventory is not an installation lockfile. The Dockerfile uses the verified base digest and installation procedure; its build command itself was not separately rerun after writing the file.

## Scope and limits

The optional Bayesian block is disabled and was not run. Original ADNI results were not reproduced. No real participant records were loaded. Package installation via the native CRAN helper was not tested; the container used Ubuntu binary packages. Successful synthetic execution does not establish correct assumptions for clinical data or course permission to publish.

The public ZIP excludes generated CSV/HTML, course PDFs, original data, original report outputs and caches. Local generated outputs remain available for review under ignored `data/` and `output/` directories. The manifest records the original Rmd hash.
