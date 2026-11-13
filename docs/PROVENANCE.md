# Provenance and publication changes

Source: `GATECH.zip` → `GATECH/Fall 2025/PSYC8803/final/Final_annotated_report.Rmd`. A SHA-256 digest of the original file is recorded in `source-manifest.json`. The original archive is unchanged.

The prepared notebook retains the original workflow and much of its R code. Changes:

1. Replace the personal absolute data path with a parameterized synthetic-only path and an explicit synthetic marker check. Remove participant previews and the cleaned-data export block.
2. Replace the 69-column positional peptide range with explicit artificial feature names; remove original selected-peptide and sample-size claims from the demo.
3. Correct MCAR/MAR descriptions and identify selection, population restriction and measurement-handling limitations.
4. Add BH adjustment to the screening table. This does not provide valid confirmatory post-selection inference in subsequent models.
5. Use PMM for incomplete numeric columns, logistic imputation for binary PTGENDER, and no imputation for complete columns. The original supplied `method="pmm"` globally. Clarify that incomplete auxiliary columns can be imputed.
6. Compare a complete-case model on the MI-restricted population in addition to the original broader complete-case model. Add imputation trace plots and logged events.
7. Parameterize imputation count and iterations, preserve seeds, disable the optional Bayesian block by default, and replace kableExtra styling with knitr tables.
8. Replace the naniar missingness graphic with a base-R missingness image, removing an unnecessary dependency.
9. Add a synthetic generator, Python checks, documentation, and Git exclusions. No original numerical results or figures are carried over.

These are publication-preparation changes, not evidence of what was submitted for the original course. R execution and HTML rendering were subsequently verified in an isolated Ubuntu 24.04 ARM64 container; see VALIDATION.md.
