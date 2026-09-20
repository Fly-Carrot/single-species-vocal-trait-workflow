# Define and optionally fit the 14 minute-level BLMMs.

setup_path <- if (file.exists("analysis/00_setup.R")) "analysis/00_setup.R" else "00_setup.R"
source(setup_path)

dat <- read_analysis_csv("07_blmm_analysis_dataset.csv")
dat$site_code <- factor(dat$site_code)
dat$period <- factor(dat$period)
dat <- zscore_columns(dat, c(spectral_predictors, temporal_predictors, "time_decimal"))

families <- list(
  total_n_calls = "negbinomial",
  mean_interval = "lognormal",
  mean_peakfreq = "gaussian",
  mean_bandw = "lognormal",
  mean_centroid = "gaussian",
  min_freq = "lognormal",
  max_freq = "gaussian"
)

build_formula <- function(response, predictors) {
  as.formula(paste(
    response,
    "~",
    paste(c(predictors, "s(time_decimal)", "(1 | site_code)"), collapse = " + ")
  ))
}

model_grid <- do.call(rbind, lapply(minute_responses, function(response) {
  data.frame(
    response = response,
    model_set = c("spectral", "temporal"),
    formula = c(
      paste(deparse(build_formula(response, spectral_predictors)), collapse = " "),
      paste(deparse(build_formula(response, temporal_predictors)), collapse = " ")
    ),
    family = families[[response]],
    stringsAsFactors = FALSE
  )
}))

stopifnot(
  nrow(model_grid) == 14,
  !anyDuplicated(model_grid[c("response", "model_set")])
)
print(model_grid, row.names = FALSE)

if (run_models) {
  require_package("brms")
  dir.create(model_output_dir, recursive = TRUE, showWarnings = FALSE)

  for (i in seq_len(nrow(model_grid))) {
    response <- model_grid$response[i]
    predictors <- if (model_grid$model_set[i] == "spectral") spectral_predictors else temporal_predictors
    family_i <- switch(
      model_grid$family[i],
      negbinomial = brms::negbinomial(),
      lognormal = brms::lognormal(),
      gaussian = brms::gaussian()
    )

    fit <- brms::brm(
      formula = build_formula(response, predictors),
      data = dat,
      family = family_i,
      chains = 4,
      iter = 2000,
      warmup = 1000,
      control = list(adapt_delta = 0.99, max_treedepth = 15),
      seed = 2026
    )

    saveRDS(
      fit,
      file.path(model_output_dir, paste0("blmm_", model_grid$model_set[i], "_", response, ".rds"))
    )
  }
} else {
  cat("Model grid checked. Set RUN_MODELS=true to fit the BLMMs.\n")
}
