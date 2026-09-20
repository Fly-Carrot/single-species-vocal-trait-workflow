# Shared setup for the teaching analysis.

find_repo_root <- function() {
  candidates <- c(getwd(), normalizePath(file.path(getwd(), ".."), mustWork = FALSE))
  for (candidate in unique(candidates)) {
    if (file.exists(file.path(candidate, "README.md")) &&
        file.exists(file.path(candidate, "analysis"))) {
      return(normalizePath(candidate, mustWork = TRUE))
    }
  }
  stop("Cannot locate the repository root. Run the script from the repository root or analysis/ directory.")
}

repo_root <- find_repo_root()
raw_data_dir <- file.path(repo_root, "analysis", "data", "raw")
supplementary_data_dir <- file.path(repo_root, "analysis", "data", "supplementary")
model_output_dir <- file.path(repo_root, "analysis", "model_outputs")

read_analysis_csv <- function(filename) {
  path <- file.path(raw_data_dir, filename)
  if (!file.exists(path)) {
    stop("Missing data file: ", path, "\nRun: python3 analysis/download_public_data.py")
  }
  dat <- read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
  names(dat) <- trimws(names(dat))
  dat <- dat[, !(names(dat) == "" | names(dat) == "X" |
                   grepl("^Unnamed: 0$|^\\.\\.\\.", names(dat))), drop = FALSE]
  dat
}

zscore <- function(x) as.numeric(scale(x))

zscore_columns <- function(dat, vars) {
  present <- intersect(vars, names(dat))
  dat[present] <- lapply(dat[present], zscore)
  dat
}

require_package <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop("Package required but not installed: ", pkg, call. = FALSE)
  }
}

source_setup <- function() invisible(TRUE)
run_models <- identical(tolower(Sys.getenv("RUN_MODELS", "false")), "true")

minute_responses <- c(
  "total_n_calls", "mean_interval", "mean_peakfreq", "mean_bandw",
  "mean_centroid", "min_freq", "max_freq"
)

gam_responses <- c("mean_calls", "mean_peakfreq", "mean_centroid", "mean_bandw")

spectral_predictors <- c(
  "low_freq_strength", "mid_high_freq_strength", "low_mid_high_freq_strength"
)

temporal_predictors <- c(
  "constant_strength", "pulse_strength", "structural_strength"
)

message("Repository root: ", repo_root)
message("RUN_MODELS=", run_models)
