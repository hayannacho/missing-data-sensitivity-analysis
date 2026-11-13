# Execute the full default notebook, then check analysis invariants.
analysis_env <- new.env(parent = globalenv())
dir.create("output", showWarnings = FALSE)
rmarkdown::render("analysis/study.Rmd", output_dir = normalizePath("output"),
                  envir = analysis_env, quiet = TRUE)
e <- analysis_env
stopifnot(e$imp$m == 20L, e$imp_B$m == 20L,
          e$imp$iteration == 10L, e$imp_B$iteration == 10L,
          length(e$peptide_vars) == 69L,
          nrow(e$screen_table) == 69L,
          all(is.finite(e$mi_summary$estimate)),
          all(is.finite(e$sens_wmh$estimate)),
          all(e$screen_table$p.adjusted.BH >= e$screen_table$p.value),
          nrow(e$df_mi_B) < nrow(e$df_mi),
          all(e$df_mi_B$WMH_volume_mm3 > 0),
          !anyNA(mice::complete(e$imp, 1)),
          !anyNA(mice::complete(e$imp_B, 1)),
          e$spec$method['PTGENDER'] == 'logreg',
          all(diag(e$spec$predictor) == 0))
for (obj in list(e$imp, e$imp_B)) {
  stopifnot(is.null(obj$loggedEvents))
}
summary_lines <- c(
  "PASS: full synthetic notebook and analysis invariants",
  paste("Rows:", nrow(e$df), "MI population:", nrow(e$df_mi), "WMH-positive population:", nrow(e$df_mi_B)),
  paste("Selected synthetic feature:", e$peptide_var),
  "Both scenarios: 20 imputations, 10 iterations, no mice logged events",
  capture.output(e$compare_est), capture.output(e$sens_wmh)
)
writeLines(summary_lines, "output/validation-results.txt")
writeLines(capture.output(sessionInfo()), "output/session-info.txt")
pkgs <- installed.packages()
write.table(pkgs[, c("Package", "Version")], "output/package-versions.tsv",
            sep = "\t", row.names = FALSE, quote = FALSE)
cat(paste(summary_lines, collapse = "\n"), "\n")
