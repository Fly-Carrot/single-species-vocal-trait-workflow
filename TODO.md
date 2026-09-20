# Teaching Workflow Roadmap

The repository already covers the overall study design, example audio, data checks, minute-level BLMMs, habitat GAMs, and confidence-sensitivity results. The next release will complete the practical path from a raw recording to a measured vocal-trait table.

## Recommended Order

1. Build the approved teaching-audio set.
2. Document audio review and preparation in Adobe Audition.
3. Document vocal-trait measurement and export in Avisoft-SASLab Pro.
4. Join the measured output to the existing R workflow.
5. Add model inference packages and a complete student exercise.

## Priority Tasks

| Priority | Module | Work to add | Material needed | Deliverable | Completion check | Status |
|---|---|---|---|---|---|---|
| P0 | Teaching audio | Select four short cases: clear focal song, traffic overlap, mixed species, and weak signal. Preserve source IDs and add use permission. | Approval for selected project clips | Four WAV files, case notes, and an answer key | Every clip has a source ID, teaching purpose, expected decision, and permission record | In progress |
| P0 | Audition: audio review | Show how to open a source recording, inspect waveform and spectrogram, locate focal vocalizations, and record the review decision. | Screenshots or a short screen recording from the project workflow | `docs/09-audition-audio-preparation.md` with annotated screenshots | A student can locate the same focal event and record the same keep/reject decision | Planned |
| P0 | Audition: preparation | Show project folder naming, non-destructive editing, channel selection, trimming, documented noise treatment, and WAV export for measurement. | Actual export settings and any saved Audition preset; denoising parameters if used | Reproducible preparation recipe plus before/after examples | Export keeps the focal signal intact, avoids clipping, preserves source linkage, and records every processing step | Waiting for settings |
| P0 | Avisoft: measurement setup | Show clip import, spectrogram display, axes, analysis window, and project measurement settings. | Avisoft version, saved preset or screenshots of each setting | `docs/10-avisoft-vocal-trait-measurement.md`, preset record, and one reference project | The teaching clip opens with the documented time and frequency display | Waiting for settings |
| P0 | Avisoft: vocal units | Show how syllables are identified, how boundaries are placed, and how ambiguous or overlapping signals are handled. | One clear case and three difficult cases with confirmed decisions | Annotated examples and a manual-check checklist | Two users assign the same keep/reject decision and comparable syllable boundaries | Planned |
| P0 | Avisoft: seven traits | Measure syllable count, inter-syllable interval, minimum, maximum, peak and centroid frequencies, and bandwidth; state units and aggregation rules. | One project reference export and the final column mapping | Trait dictionary, worked example, and export template | All seven fields reproduce the reference values within a declared rounding tolerance | Waiting for reference export |
| P0 | Data handoff | Link each measured segment to source clip, site, timestamp, sampling-period block, and minute ID; aggregate segment records to minute-level observations. | A small segment-level export with valid identifiers | R import and aggregation lesson | The worked example produces the expected segment count and minute-level row | Planned |
| P1 | Quality control | Add a second-pass review on a subset and record disagreements, corrections, missing values, and exclusions. | Agreed review fraction and decision rules | QC form and completed example | Every changed value has a reason and reviewer record | To decide |
| P1 | Sound-event inference | Add the nine-class model command, labels, configuration, and expected output. | Runnable SED checkpoint and configuration | Small inference lesson | A supplied clip produces the expected event table | Waiting for model files |
| P1 | Species screening | Add the custom BirdNET v2.4 command, labels, confidence field, and expected output. | Runnable custom BirdNET package | Small screening lesson | A supplied clip produces the expected focal-species candidate record | Waiting for model files |
| P1 | End-to-end case | Connect raw WAV, Audition review, Avisoft measurement, minute aggregation, BLMM input, and GAM input in one example. | Completed P0 modules | One guided case with intermediate outputs | A student can trace every final value back to the source recording | Planned |
| P2 | Course exercises | Add short tasks, answer sheets, and a scored practice set. | Approved teaching clips and reference decisions | Student and instructor versions | Answers cover common mistakes and explain each decision | Planned |
| P2 | Reproducible release | Add automated checks, software versions, checksums, citation information, and a tagged release. | Stable lessons and model files | Versioned repository release | Fresh setup passes data, script, and expected-output checks | Planned |

## Audition Lesson Outline

1. Create the working folders and preserve the untouched source WAV.
2. Open the recording and confirm file metadata.
3. Inspect the waveform and spectrogram at the focal timestamp.
4. Listen for species identity, overlap, clipping, and signal quality.
5. Mark the retained vocal section and record the review decision.
6. Apply only the documented project processing settings.
7. Export the measurement-ready WAV with a traceable filename.
8. Compare the source and exported files before moving to Avisoft.

The lesson will use the project settings shown in the approved screenshots. No generic noise-reduction value will be presented as a project parameter.

## Avisoft Lesson Outline

1. Import the validated WAV and load the project measurement settings.
2. Confirm the spectrogram time and frequency display.
3. Identify syllables and correct their boundaries manually where needed.
4. Reject clips that fail the agreed quality rules.
5. Measure the seven vocal traits with their original units.
6. Export one row per validated vocal segment with stable identifiers.
7. Review a subset and resolve measurement differences.
8. Aggregate the validated segment table to the minute level in R.

## Materials to Request

- Audition screenshots or a short screen recording from import to WAV export.
- The actual Audition export settings and any saved preset.
- Avisoft version, spectrogram settings, measurement preset, and batch-export settings.
- One small Avisoft reference output with confirmed values for all seven traits.
- Permission to publish four short project audio cases.
- Runnable sound-event and custom BirdNET model packages for the later inference lessons.

## Already Available

- One project-provided Common Tailorbird sample.
- Waveform, spectrogram, and segmentation figures.
- A reusable manual-validation table.
- Public minute-level and site-period datasets.
- Fourteen BLMM specifications and four habitat GAMs.
- Public confidence-sensitivity summaries.
