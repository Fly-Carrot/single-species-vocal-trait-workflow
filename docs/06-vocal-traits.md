# 6. Vocal-Trait Measurement

## Goal

Measure repeatable time and frequency properties from each validated vocal segment.

The case study used Avisoft-SASLab Pro and extracted seven traits.

| Trait | Plain-language meaning |
| --- | --- |
| syllable count | number of detected syllables |
| inter-syllable interval | average time between syllables |
| minimum frequency | lowest measured frequency |
| maximum frequency | highest measured frequency |
| peak frequency | frequency with the strongest energy |
| centroid frequency | energy-weighted centre of the spectrum |
| bandwidth | difference between upper and lower frequency bounds |

## Measurement Sequence

1. Open a validated clip.
2. Set the spectrogram view for the focal signal.
3. Inspect and clean the signal where needed.
4. Detect or mark the syllable boundaries.
5. Review every boundary.
6. Export the seven measurements with the source ID.

The workshop deck provides the teaching sequence for this module: clip selection, denoising, import into Avisoft, syllable detection, boundary review, and table export.

## Output Key

Every row should retain:

```text
source_file, candidate_id, segment_id, validation_decision, confidence
```

The project produced 9,142 validated segment-level records before minute aggregation.

## Planned Visual Lesson

The next release will add Avisoft screenshots, the project preset, and one reference export. These materials will make the GUI steps repeatable for a classroom exercise.
