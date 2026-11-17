# Validation record

## Portfolio result figure — 2026-11-17

The two Python generator tests and full R/HTML analysis were rerun successfully in the existing Ubuntu ARM64 validation image (R 4.3.3, mice 3.16.0). Both MI scenarios again completed 20 imputations × 10 iterations without logged events. `scripts/plot_results.R` sources the full analysis validation, obtains complete-case intervals from `confint`, and obtains MI intervals from pooled model summaries. No estimates are hardcoded in the plotting script.

Complete-case row counts are 226 (all eligible) and 207 (within the MI population). MI populations have 368 rows with zero WMH retained and 330 with zeros excluded, from 400 generated rows. All four estimates/intervals are exported to [CSV](demo/coefficient-comparison.csv); population counts are [separately exported](demo/analysis-populations.csv). The PNG was visually checked for all four methods, interval bounds, labels, and row counts.

The intervals use each fitted model's existing convention (OLS t intervals and pooled MI intervals); they are exploratory after same-sample feature selection. No original clinical records are involved. Analysis code is unchanged; this is a later output-visualization addition.

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

The optional Bayesian block is disabled and was not run. Original ADNI results were not reproduced. No real participant records were loaded. Package installation via the native CRAN helper was not tested; the container used Ubuntu binary packages. Successful synthetic execution does not establish correct assumptions for clinical data.

The public ZIP excludes generated CSV/HTML, course PDFs, original data, original report outputs and caches. Local generated outputs remain available for review under ignored `data/` and `output/` directories. The manifest records the original Rmd hash.
