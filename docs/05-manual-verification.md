# 5. Manual Verification

## Goal

Turn model candidates into a set of vocal segments that can be measured consistently.

Every retained recording in the case study was checked by listening and spectrogram inspection before vocal-trait extraction.

## Decision Sequence

1. Play the candidate and inspect the spectrogram.
2. Confirm the focal species.
3. Check that the vocal unit is complete.
4. Record overlap, clipping, weak signal, or other quality issues.
5. Assign `accept`, `exclude`, or `review`.
6. Save a short reason code for every excluded item.

Use [the validation template](../data/templates/manual-validation-template.csv) for practice.

## Suggested Reason Codes

| Code | Meaning |
| --- | --- |
| `wrong_species` | candidate belongs to another species |
| `overlap` | another signal prevents reliable measurement |
| `truncated` | vocal unit crosses the clip boundary |
| `weak_signal` | signal cannot be measured consistently |
| `clipping` | waveform is saturated |
| `review` | a second opinion is needed |

## Student Exercise

Two students should review the same small set independently. Compare their decisions, discuss disagreements, and update the written rule when a case is ambiguous.

Continue with the [illustrated Audition lesson](09-audition-audio-preparation.md) for preparing a validated vocal clip.
