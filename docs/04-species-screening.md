# 4. Species Screening

## Goal

Find likely Common Tailorbird vocalizations within bird-event clips.

The study used a custom BirdNET v2.4 classifier trained for 272 local bird species. Candidate *O. sutorius* records with confidence above 0.5 entered the manual review and vocal-trait workflow.

## Keep These Fields

```text
source_file
start_s
end_s
scientific_name
common_name
confidence
model_version
```

The confidence score records the model's ranking. Species identity is confirmed in the next step.

## Review Questions

1. Does the candidate contain a complete vocal unit?
2. Is the target signal visible in the spectrogram?
3. Does another species overlap the candidate?
4. Is the signal strong enough for trait measurement?

## Teaching Route

Students can learn the file format and review logic with the included example. The custom classifier package and exact command will be added with the project model files.
