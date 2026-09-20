# Inspect confidence-bias and retained-data sensitivity summaries.

setup_path <- if (file.exists("analysis/00_setup.R")) "analysis/00_setup.R" else "00_setup.R"
source(setup_path)
require_package("readxl")

s2 <- file.path(supplementary_data_dir, "Supplementary_Data_S2.xlsx")
s4 <- file.path(supplementary_data_dir, "Supplementary_Data_S4.xlsx")
if (!file.exists(s2) || !file.exists(s4)) {
  stop("Missing supplementary workbooks. Run: python3 analysis/download_public_data.py")
}

cat("Supplementary Data S2 sheets:\n")
print(readxl::excel_sheets(s2))
cat("\nSupplementary Data S4 sheets:\n")
print(readxl::excel_sheets(s4))

soundscape <- readxl::read_excel(s2, sheet = "S2c_main_soundscape")
blmm_stability <- readxl::read_excel(s4, sheet = "BLMM_sign_stability")
gam_summary <- readxl::read_excel(s4, sheet = "GAM_summary_05_to_08")

cat("\nBelow-threshold soundscape comparison:\n")
print(utils::head(soundscape, 10))
cat("\nBLMM sign stability:\n")
print(utils::head(blmm_stability, 20))
cat("\nGAM sensitivity summary:\n")
print(utils::head(gam_summary, 20))
