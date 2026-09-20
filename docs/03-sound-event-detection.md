# 3. Sound-Event Detection

## Goal

Describe the soundscape around each focal-species vocalization.

The case-study detector combines ATST features with a CRNN classifier. It assigns nine event labels:

| Source group | Event labels |
| --- | --- |
| Anthrophony | traffic, speech, music, knocking, horn |
| Biophony | bird, insect, frog |
| Geophony | rain |

## Functional Predictors

The event labels are also grouped by dominant acoustic pattern.

| Group | Labels |
| --- | --- |
| low-to-mid frequency | traffic, speech, music |
| mid-to-high frequency | bird, insect |
| broadband | knocking, horn, frog, rain |
| constant | traffic, insect, rain |
| pulsed | knocking, horn, frog |
| structured | speech, music, bird |

For each minute, the workflow calculates how much time is occupied by the labels in each group.

## Expected Event Table

```text
recording_id, clip_id, event_label, onset_s, offset_s, confidence
```

Each `onset_s` must be smaller than `offset_s`. Event names must match the label dictionary. The minute key must be unique after aggregation.

## Course Exercise

Open the spectrogram in the previous lesson. Mark one likely bird event and one background sound. Compare your labels with another student.

The runnable nine-class checkpoint and its inference command are planned for a later release. The lesson already defines the required input, labels, output fields, and quality checks.
