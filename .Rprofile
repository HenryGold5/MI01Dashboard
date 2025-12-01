# .Rprofile for MI01 Dashboard
# This file ensures proper package loading for Posit Connect Cloud

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Ensure required packages are available
required_packages <- c(
  "shiny",
  "bslib",
  "dplyr",
  "tmap",
  "sf",
  "cartogram",
  "gt",
  "gtExtras",
  "stringr",
  "ggplot2",
  "scales",
  "tidyr",
  "readxl",
  "quarto"
)

# Function to check and install missing packages
.check_packages <- function() {
  missing <- required_packages[!required_packages %in% installed.packages()[, "Package"]]
  if (length(missing) > 0) {
    message("Installing missing packages: ", paste(missing, collapse = ", "))
    install.packages(missing, dependencies = TRUE)
  }
}

# Only check packages if not on Posit Connect (Connect handles this)
if (!nzchar(Sys.getenv("RSTUDIO_CONNECT_SERVER"))) {
  .check_packages()
}

# Cleanup
rm(.check_packages, required_packages)
