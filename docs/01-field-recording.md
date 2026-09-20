# 1. Field Recording

## Goal

Collect comparable recordings across sites and time.

## Case-Study Design

- Recorder: AudioMoth
- Network: 21 sites
- Recording schedule: 1 minute every 10 minutes, 24 hours per day
- Monitoring window: 20 April to 8 July 2024
- Recorder height: about 1.5 m

Each recording must retain a site code, device identity, date, start time, and duration.

## Field Checklist

1. Set the recorder clock and time zone.
2. Record the device ID and site code.
3. Save the AudioMoth configuration export.
4. Note deployment and recovery times.
5. Check battery level and storage.
6. Photograph the recorder position.

## Minimum Metadata

| Field | Example |
| --- | --- |
| `site_code` | `BJS` |
| `device_id` | project device code |
| `start_datetime` | ISO 8601 time |
| `duration_s` | `60` |
| `latitude` / `longitude` | controlled project record |
| `config_file` | saved AudioMoth export |

The teaching repository uses the field design shown in the overview figure. Device-specific settings can be added as a course handout when the configuration export is ready for release.

## Student Task

Draft a metadata row for one recorder deployment. Check that another person could identify the recorder, site, date, and schedule from that row alone.
