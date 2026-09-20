# Spatiotemporal tests for the seven minute-level vocal traits.

setup_path <- if (file.exists("analysis/00_setup.R")) "analysis/00_setup.R" else "00_setup.R"
source(setup_path)

dat <- read_analysis_csv("01_minute_level_vocal_traits.csv")
complete <- complete.cases(dat[, c(minute_responses, "site_code", "period")])
test_dat <- dat[complete, , drop = FALSE]
response_matrix <- test_dat[, minute_responses, drop = FALSE]

cat("Rows used:", nrow(test_dat), "\n")

if (run_models) {
  require_package("vegan")
  permanova <- vegan::adonis2(
    response_matrix ~ site_code * period,
    data = test_dat,
    method = "euclidean",
    permutations = 999
  )
  print(permanova)
} else {
  cat("PERMANOVA is available with RUN_MODELS=true.\n")
  cat("Formula: vocal traits ~ site_code * period; Euclidean distance; 999 permutations.\n")
}

epsilon_squared <- function(test, n, k) {
  max(0, (unname(test$statistic) - k + 1) / (n - k))
}

kw_rows <- lapply(minute_responses, function(response) {
  site_test <- kruskal.test(test_dat[[response]] ~ test_dat$site_code)
  period_test <- kruskal.test(test_dat[[response]] ~ test_dat$period)
  data.frame(
    trait = response,
    site_H = unname(site_test$statistic),
    site_p = site_test$p.value,
    site_epsilon2 = epsilon_squared(site_test, nrow(test_dat), length(unique(test_dat$site_code))),
    period_H = unname(period_test$statistic),
    period_p = period_test$p.value,
    period_epsilon2 = epsilon_squared(period_test, nrow(test_dat), length(unique(test_dat$period)))
  )
})

kw_summary <- do.call(rbind, kw_rows)
print(kw_summary, row.names = FALSE)

dir.create(model_output_dir, recursive = TRUE, showWarnings = FALSE)
write.csv(kw_summary, file.path(model_output_dir, "kruskal_wallis_summary.csv"), row.names = FALSE)

pairwise_rows <- lapply(minute_responses, function(response) {
  result <- pairwise.wilcox.test(test_dat[[response]], test_dat$period, p.adjust.method = "BH")
  mat <- as.data.frame(as.table(result$p.value), stringsAsFactors = FALSE)
  mat <- mat[!is.na(mat$Freq), , drop = FALSE]
  names(mat) <- c("group_1", "group_2", "p_adjusted")
  mat$trait <- response
  mat[, c("trait", "group_1", "group_2", "p_adjusted")]
})

pairwise_summary <- do.call(rbind, pairwise_rows)
write.csv(pairwise_summary, file.path(model_output_dir, "period_pairwise_wilcoxon.csv"), row.names = FALSE)
cat("Saved summary tables to analysis/model_outputs/.\n")
