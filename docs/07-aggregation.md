# 7. Data Aggregation

## Goal

Move from validated segments to the two analysis scales.

## Segment to Minute

The minute key is:

```text
site_code + date + hour + minute
```

Within each minute:

- sum syllable counts;
- calculate syllable-weighted means for interval, peak frequency, centroid frequency, and bandwidth;
- take the minimum of minimum frequency;
- take the maximum of maximum frequency;
- count how many validated segments contributed to the row.

This step turns 9,142 validated segments into 2,776 minute-level observations from 20 sites.

## Minute to Site-Period

The monitoring window was divided into three similar-length sampling blocks:

| Block | Dates | Days |
| --- | --- | ---: |
| T1 | 20 April–16 May 2024 | 27 |
| T2 | 17 May–11 June 2024 | 26 |
| T3 | 12 June–8 July 2024 | 27 |

Minute summaries were averaged within each site and block. The result contains 59 site-period observations.

## Checks Before Any Model

1. Confirm that the minute key is unique.
2. Count rows before and after every join.
3. Check that all frequencies use the same unit.
4. Check that weights are positive.
5. Record why any expected site-period row is absent.

Run `Rscript analysis/01_data_check.R` to inspect the public analysis tables.
