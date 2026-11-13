packages <- c("rmarkdown", "knitr", "readr", "dplyr", "ggplot2", "mice", "broom", "purrr")
missing <- setdiff(packages, rownames(installed.packages()))
if (length(missing)) install.packages(missing, repos = "https://cloud.r-project.org")
