#!/usr/bin/env python3
"""Download the small public dataset used by the analysis lessons."""

from __future__ import annotations

import urllib.parse
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
BASE_URL = "https://raw.githubusercontent.com/Fly-Carrot/JAPPL-2026-01502-Supplementary/main/"

FILES = {
    "Raw data/01_minute_level_vocal_traits.csv": "analysis/data/raw/01_minute_level_vocal_traits.csv",
    "Raw data/07_blmm_analysis_dataset.csv": "analysis/data/raw/07_blmm_analysis_dataset.csv",
    "Raw data/08_gam_analysis_dataset.csv": "analysis/data/raw/08_gam_analysis_dataset.csv",
    "Supplementary Data/Supplementary_Data_S1.xlsx": "analysis/data/supplementary/Supplementary_Data_S1.xlsx",
    "Supplementary Data/Supplementary_Data_S2.xlsx": "analysis/data/supplementary/Supplementary_Data_S2.xlsx",
    "Supplementary Data/Supplementary_Data_S3.xlsx": "analysis/data/supplementary/Supplementary_Data_S3.xlsx",
    "Supplementary Data/Supplementary_Data_S4.xlsx": "analysis/data/supplementary/Supplementary_Data_S4.xlsx",
}


def main() -> None:
    for remote, local in FILES.items():
        target = ROOT / local
        target.parent.mkdir(parents=True, exist_ok=True)
        url = BASE_URL + urllib.parse.quote(remote)
        print(f"Downloading {remote}")
        urllib.request.urlretrieve(url, target)
    print(f"Downloaded {len(FILES)} files to analysis/data/")


if __name__ == "__main__":
    main()
