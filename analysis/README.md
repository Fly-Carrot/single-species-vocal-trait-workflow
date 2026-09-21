# Analysis Lessons

These scripts use the public, analysis-ready tables from [Fly-Carrot/JAPPL-2026-01502-Supplementary](https://github.com/Fly-Carrot/JAPPL-2026-01502-Supplementary).

## 1. Download the Data

Run from the repository root:

```bash
python3 analysis/download_public_data.py
```

The script downloads three CSV files used by the models and four supplementary workbooks.

## 2. Check the Data

```bash
Rscript analysis/01_data_check.R
```

Expected counts:

- 2,776 minute-level vocal observations;
- 20 focal sites;
- 59 site-period observations;
- three sampling-period blocks.

## 3. Run the Lessons

```bash
Rscript analysis/02_spatiotemporal_tests.R
Rscript analysis/03_blmm_models.R
Rscript analysis/04_gam_models.R
Rscript analysis/05_sensitivity_summary.R
```

The BLMM and GAM scripts print and check their model grids by default. This keeps the first run quick.

To fit the models:

```bash
RUN_MODELS=true Rscript analysis/03_blmm_models.R
RUN_MODELS=true Rscript analysis/04_gam_models.R
```

BLMM fitting requires `brms` and a working Stan backend. GAM fitting requires `mgcv`. Spatiotemporal PERMANOVA requires `vegan`. Sensitivity workbooks require `readxl`.

## Script Map

| Script | Purpose |
| --- | --- |
| `01_data_check.R` | verify counts, sites, periods, and required columns |
| `02_spatiotemporal_tests.R` | PERMANOVA, Kruskal-Wallis, effect size, and pairwise tests |
| `03_blmm_models.R` | define and optionally fit 14 minute-level BLMMs |
| `04_gam_models.R` | define and optionally fit four habitat GAMs |
| `05_sensitivity_summary.R` | inspect confidence-bias and retained-data sensitivity tables |

Model outputs are written to `analysis/model_outputs/`, which is ignored by Git.
