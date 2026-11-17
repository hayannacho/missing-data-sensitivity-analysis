# Render the real synthetic analysis, then plot estimates and their 95% intervals.
# Run from the repository root after scripts/generate_demo.py.
source("tests/validate_analysis.R")
dir.create("output/portfolio", recursive = TRUE, showWarnings = FALSE)
cc <- function(fit, label) {
  ci <- confint(fit, parm = e$peptide_var)
  data.frame(method = label, estimate = unname(coef(fit)[e$peptide_var]),
             lower = ci[1, 1], upper = ci[1, 2], rows = nobs(fit))
}
mi <- e$sens_wmh
comparison <- rbind(
  cc(e$fit_cc, "Complete cases / all eligible"),
  cc(e$fit_cc_matched, "Complete cases / MI population"),
  data.frame(method = c("MI / WMH zeros retained", "MI / WMH zeros excluded"),
             estimate = mi$estimate, lower = mi[["2.5 %"]], upper = mi[["97.5 %"]],
             rows = c(nrow(e$df_mi), nrow(e$df_mi_B))))
stopifnot(nrow(comparison) == 4, all(is.finite(as.matrix(comparison[, 2:5]))),
          all(comparison$lower < comparison$estimate), all(comparison$upper > comparison$estimate))
write.csv(comparison, "output/portfolio/coefficient-comparison.csv", row.names = FALSE)
populations <- data.frame(population = c("Generated", "WMH observed", "WMH positive"),
                          rows = c(nrow(e$df), nrow(e$df_mi), nrow(e$df_mi_B)))
write.csv(populations, "output/portfolio/analysis-populations.csv", row.names = FALSE)
png("output/portfolio/sensitivity-results.png", width = 1800, height = 900, res = 160)
layout(matrix(c(1, 2), nrow = 1), widths = c(3.4, 1.5))
par(oma = c(3, 0, 5, 0), mar = c(5, 15, 2, 1), family = "sans", las = 1)
colors <- c("#64748b", "#64748b", "#0f766e", "#6d28d9")
plot(comparison$estimate, 4:1, xlim = c(0, max(comparison$upper)*1.08), ylim = c(.5, 4.5),
     pch = 19, cex = 1.3, col = colors, yaxt = "n", ylab = "", bty = "n",
     xlab = "Synthetic PEP001 coefficient (95% interval)")
abline(v = 0, col = "#cbd5e1", lty = 2)
segments(comparison$lower, 4:1, comparison$upper, 4:1, col = colors, lwd = 3)
axis(2, at = 4:1, labels = paste0(comparison$method, "\n(n = ", comparison$rows, ")"), tick = FALSE, cex.axis = .85)
text(comparison$estimate, (4:1)+.24, labels = sprintf("%.4f", comparison$estimate), cex = .9, col = colors)
par(mar = c(5, 3, 2, 2))
bp <- barplot(populations$rows, names.arg = c("All", "WMH\nobserved", "WMH\npositive"),
              ylim = c(0, 450), col = c("#cbd5e1", "#0f766e", "#6d28d9"), border = NA,
              ylab = "Rows", las = 1, cex.names = .8)
text(bp, populations$rows+20, labels = populations$rows, cex = .95)
title("Analysis populations", cex.main = .95)
mtext("Missing-data decisions, visible in one comparison", outer = TRUE, side = 3, line = 2.6, adj = .03, cex = 1.45, font = 2)
mtext("400 generated observations | 69 features screened | 20 imputations x 10 iterations per MI scenario", outer = TRUE, side = 3, line = .8, adj = .03, cex = .85)
mtext("Synthetic data only. Screening and fitting share a sample; intervals are exploratory, not clinical evidence.", outer = TRUE, side = 1, line = 1.4, cex = .8)
dev.off()
cat("PASS: four estimates/intervals exported directly from fitted objects; no hardcoded results.\n")
