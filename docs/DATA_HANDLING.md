# Data handling and demo dictionary

This repository contains no ADNI observations or derived participant records. It does not bundle the original report, plot outputs, source spreadsheets, or data access credentials. The demo generator reads no input data; it samples artificial values from equations with a fixed seed.

| Column | Synthetic meaning |
| --- | --- |
| `DATA_SOURCE` | Constant `SYNTHETIC_NOT_ADNI` marker |
| `TAU_SUVR` | Artificial response; blanks and zeros exercise missing-code restoration |
| `WMH_volume_mm3` | Artificial positive measurement, true zeros, and missing values |
| `AGE` | Artificial age between 55 and 90 before missingness |
| `PTGENDER` | Binary synthetic factor, following the original model's schema |
| `interval_months` | Artificial interval from 0 to 36 |
| `SUVR_GlobalSUVR` | Fully observed artificial auxiliary predictor |
| `PEP001`–`PEP069` | Artificial standardized peptide-like features; PEP001 enters the response equation |

These values are not calibrated to ADNI. TAU missingness depends on observed synthetic amyloid; other generated missing values are assigned randomly. This controlled demonstration cannot validate assumptions about real participants.

Generated `data/` and `output/` directories are ignored. The marker check prevents accidental use of an unlabelled file; it is not a de-identification mechanism. Never relabel real observations as synthetic. Real-data access and usage conditions must be handled separately through the relevant data provider; this package conveys no data permissions.
