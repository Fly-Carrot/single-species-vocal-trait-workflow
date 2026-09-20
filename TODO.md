# Roadmap

This first release supports the learning path, audio preparation demo, and public statistical workflow. The next additions will extend the same structure.

## Teaching Audio Set

- [x] Include one project-provided Common Tailorbird sample.
- [x] Generate a waveform, spectrogram, and segmentation view from that sample.
- [ ] Add a small approved set with four teaching cases: clear song, traffic overlap, mixed species, and low-quality signal.
- [ ] Add a short answer key for each case.

**Material needed:** permission to publish the selected project clips. Candidate clips can be chosen from the existing focal-species audio archive and matched to minute-level sound-event records.

## Model Inference

- [ ] Add the nine-class sound-event inference command and a small expected output.
- [ ] Add the custom BirdNET v2.4 inference command and label file.
- [ ] Record model versions and checksums.

**Material needed:** the runnable SED checkpoint/configuration and the custom BirdNET model package used by the project.

## Manual Verification and Vocal Traits

- [x] Add a reusable manual-validation table.
- [x] Explain the seven traits and the 9,142-to-2,776 aggregation.
- [ ] Add step-by-step Avisoft screenshots.
- [ ] Add the project measurement preset and one reference export.
- [ ] Add a scored student practice set.

**Material needed:** Avisoft screenshots or a short screen recording, the saved settings/preset, and approval to publish a small reference output.

## Statistical Workflow

- [x] Download the public minute-level and site-period tables.
- [x] Check row counts, sites, periods, and required variables.
- [x] Define the 14 BLMM specifications and four GAMs.
- [x] Read the public confidence-sensitivity summaries.
- [ ] Add a quick-fit dataset for laptops with limited memory.
- [ ] Add automated expected-output checks.

## Course Delivery

- [x] Map the workshop teaching sequence to the repository lessons.
- [ ] Add short exercises and answer sheets.
- [ ] Publish a Quarto course site after the core lessons are stable.
- [ ] Create a versioned release linked to the associated article.
