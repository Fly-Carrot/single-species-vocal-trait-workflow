# Check the public analysis tables and their analytical universes.

setup_path <- if (file.exists("analysis/00_setup.R")) "analysis/00_setup.R" else "00_setup.R"
source(setup_path)

vocal_minute <- read_analysis_csv("01_minute_level_vocal_traits.csv")
blmm_data <- read_analysis_csv("07_blmm_analysis_dataset.csv")
gam_data <- read_analysis_csv("08_gam_analysis_dataset.csv")

inventory <- data.frame(
  table = c("minute vocal traits", "BLMM input", "GAM input"),
  rows = c(nrow(vocal_minute), nrow(blmm_data), nrow(gam_data)),
  columns = c(ncol(vocal_minute), ncol(blmm_data), ncol(gam_data))
)
print(inventory, row.names = FALSE)

cat("\nAnalytical universes:\n")
cat("- minute observations:", nrow(vocal_minute), "\n")
cat("- focal sites:", length(unique(vocal_minute$site_code)), "\n")
cat("- site-period observations:", nrow(gam_data), "\n")
cat("- focal sites in GAM data:", length(unique(gam_data$site_code)), "\n")
cat("- sampling blocks:", paste(sort(unique(gam_data$period)), collapse = ", "), "\n")

required_blmm <- c(minute_responses, spectral_predictors, temporal_predictors, "site_code", "time_decimal")
required_gam <- c(gam_responses, "period", "LAI_understory", "mean_crown_ratio",
                  "local_clustering", "MPS_edge", "PLAND_gs", "dist1", "dist2")

missing_blmm <- setdiff(required_blmm, names(blmm_data))
missing_gam <- setdiff(required_gam, names(gam_data))

if (length(missing_blmm)) stop("Missing BLMM variables: ", paste(missing_blmm, collapse = ", "))
if (length(missing_gam)) stop("Missing GAM variables: ", paste(missing_gam, collapse = ", "))

stopifnot(
  nrow(vocal_minute) == 2776,
  length(unique(vocal_minute$site_code)) == 20,
  nrow(gam_data) == 59,
  length(unique(gam_data$site_code)) == 20
)

cat("\nCounts and required variables match the teaching contract.\n")
