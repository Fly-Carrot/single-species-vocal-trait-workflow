# 8. Models and Sensitivity

## Minute-Level BLMMs

The BLMM branch relates seven vocal responses to short-term soundscape conditions. Each response has one spectral-group model and one temporal-group model, giving 14 specifications.

```text
response ~ three soundscape predictors
         + s(time_decimal)
         + (1 | site_code)
```

The site random intercept accounts for repeated observations within the same site. Time of day is fitted as a smooth term.

Run:

```bash
Rscript analysis/03_blmm_models.R
```

The default mode prints and checks the 14 formulas. Full fitting starts only when `RUN_MODELS=true`.

## Site-Period GAMs

The GAM branch relates four average vocal responses to vegetation, landscape, road-distance, and urban-context predictors. Penalized smooths allow gradual nonlinear associations.

Run:

```bash
Rscript analysis/04_gam_models.R
```

## Spatiotemporal Tests

The workflow uses PERMANOVA for the multivariate trait set, Kruskal-Wallis tests for individual traits, epsilon-squared effect sizes, and BH-adjusted pairwise Wilcoxon tests.

```bash
RUN_MODELS=true Rscript analysis/02_spatiotemporal_tests.R
```

## Confidence Sensitivity

The retained, validated data were rebuilt at confidence cut-offs of 0.6, 0.7, and 0.8. The same BLMM and GAM structures were then compared across thresholds.

```bash
Rscript analysis/05_sensitivity_summary.R
```

Compare:

- effect direction;
- interval overlap;
- convergence diagnostics;
- GAM smooth shape;
- sample size retained at each cut-off.

## Reporting Rule

Model estimates should be read together with diagnostics and data scale. Smooth transitions describe fitted changes along a predictor gradient. Their ecological meaning comes from the full response curve and the observed data range.
