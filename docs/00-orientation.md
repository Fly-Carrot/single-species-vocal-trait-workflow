# 0. Orientation

## The Ecological Question

Urban recordings contain birds, insects, frogs, rain, traffic, speech, music, horns, and other short events. This workflow asks how the vocal traits of one focal bird vary across that soundscape and across different vegetation settings.

The Common Tailorbird case uses two analysis scales:

- **minute level:** short-term associations between the current soundscape and vocal traits;
- **site-period level:** associations between average vocal traits and vegetation or landscape structure.

The two scales run in parallel. A BLMM result does not feed into a GAM.

## Follow One Observation

```text
1-min WAV
  -> six 10-s clips
  -> sound-event labels
  -> focal-species candidates
  -> manually validated vocal segments
  -> seven segment-level traits
  -> one minute-level row
  -> one BLMM analysis row
```

For the habitat branch, minute rows are averaged within three similar-length sampling-period blocks to create site-period rows for GAMs.

## Four Questions to Ask at Every Step

1. What is the input unit?
2. What decision changes the data?
3. What is the output unit?
4. Can the output be linked back to its source recording?

## Case-Study Counts

| Data layer | Count | Unit |
| --- | ---: | --- |
| PAM network | 21 | site |
| focal subset | 20 | site |
| validated material | 9,142 | vocal segment |
| BLMM data | 2,776 | site-minute |
| GAM data | 59 | site-period |
| BLMM specifications | 14 | model |
| GAMs | 4 | model |

## Continue

Start with [field recording](01-field-recording.md), or jump to the [analysis scripts](../analysis/README.md) when you already have analysis-ready tables.
