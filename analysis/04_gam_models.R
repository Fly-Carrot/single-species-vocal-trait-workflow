# Define and optionally fit the four site-period habitat GAMs.

setup_path <- if (file.exists("analysis/00_setup.R")) "analysis/00_setup.R" else "00_setup.R"
source(setup_path)

dat <- read_analysis_csv("08_gam_analysis_dataset.csv")
dat$period <- factor(dat$period)
dat$site_code <- factor(dat$site_code)

numeric_predictors <- c(
  "height_range", "dist1", "dist2", "LAI_understory", "local_clustering",
  "MPS_edge", "ISR", "mean_crown_ratio", "PLAND_gs"
)
dat <- zscore_columns(dat, numeric_predictors)

gam_formulas <- list(
  mean_calls = mean_calls ~ period +
    s(height_range) + s(dist2) + s(LAI_understory) + s(dist1) + s(MPS_edge),
  mean_peakfreq = mean_peakfreq ~ period +
    s(dist2) + s(dist1) + s(LAI_understory) + s(local_clustering) + s(MPS_edge),
  mean_centroid = mean_centroid ~ period +
    s(local_clustering) + s(dist1) + s(ISR) + s(MPS_edge) + s(mean_crown_ratio),
  mean_bandw = mean_bandw ~ period +
    s(dist1) + s(MPS_edge) + s(height_range) + s(dist2) + s(PLAND_gs)
)

gam_families <- list(
  mean_calls = stats::gaussian(),
  mean_peakfreq = stats::gaussian(),
  mean_centroid = stats::gaussian(),
  mean_bandw = Gamma(link = "log")
)

model_grid <- data.frame(
  response = names(gam_formulas),
  formula = vapply(gam_formulas, function(x) paste(deparse(x), collapse = " "), character(1)),
  family = c("Gaussian", "Gaussian", "Gaussian", "Gamma(log)"),
  stringsAsFactors = FALSE
)

stopifnot(nrow(model_grid) == 4, !anyDuplicated(model_grid$response))
print(model_grid, row.names = FALSE)

if (run_models) {
  require_package("mgcv")
  dir.create(model_output_dir, recursive = TRUE, showWarnings = FALSE)

  fits <- lapply(names(gam_formulas), function(response) {
    mgcv::gam(
      formula = gam_formulas[[response]],
      data = dat,
      family = gam_families[[response]],
      method = "REML",
      select = TRUE
    )
  })
  names(fits) <- names(gam_formulas)
  saveRDS(fits, file.path(model_output_dir, "gam_model_fits.rds"))

  summaries <- do.call(rbind, lapply(names(fits), function(response) {
    smooth <- as.data.frame(summary(fits[[response]])$s.table)
    smooth$predictor <- rownames(smooth)
    smooth$response <- response
    smooth
  }))
  write.csv(summaries, file.path(model_output_dir, "gam_smooth_summary.csv"), row.names = FALSE)
} else {
  cat("Model grid checked. Set RUN_MODELS=true to fit the GAMs.\n")
}
