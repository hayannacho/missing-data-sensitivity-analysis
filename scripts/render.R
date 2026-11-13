# Run from the repository root. The Rmd resolves data relative to analysis/.
if (!file.exists("data/synthetic_demo.csv")) stop("Run python3 scripts/generate_demo.py first")
if (!rmarkdown::pandoc_available()) stop("Pandoc is required (included with RStudio)")
dir.create("output", showWarnings = FALSE)
rmarkdown::render("analysis/study.Rmd", output_dir = normalizePath("output"),
                  envir = new.env(parent = globalenv()))
writeLines(capture.output(sessionInfo()), "output/session-info.txt")
