FROM ubuntu:24.04@sha256:2198e4c65076e9cb0b3d695219df667c0e3b0072da64ca3c2648aca17dcecaf5
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    r-base-core r-cran-rmarkdown r-cran-knitr r-cran-readr r-cran-dplyr \
    r-cran-ggplot2 r-cran-mice r-cran-broom r-cran-purrr pandoc \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /work
CMD ["Rscript", "tests/validate_analysis.R"]
