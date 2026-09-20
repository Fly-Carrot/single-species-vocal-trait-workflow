#!/usr/bin/env python3
"""Split one PCM WAV file into fixed-length clips and write a manifest."""

from __future__ import annotations

import argparse
import csv
import math
import wave
from pathlib import Path


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True, help="Source PCM WAV")
    parser.add_argument("--output", type=Path, required=True, help="Output folder")
    parser.add_argument("--seconds", type=float, default=10.0, help="Clip length in seconds")
    args = parser.parse_args()

    if args.seconds <= 0:
        raise SystemExit("--seconds must be greater than zero")

    args.output.mkdir(parents=True, exist_ok=True)
    rows: list[dict[str, object]] = []

    with wave.open(str(args.input), "rb") as source:
        params = source.getparams()
        frames_per_clip = max(1, round(args.seconds * params.framerate))
        clip_count = math.ceil(params.nframes / frames_per_clip)

        for index in range(clip_count):
            start_frame = index * frames_per_clip
            source.setpos(start_frame)
            audio = source.readframes(min(frames_per_clip, params.nframes - start_frame))
            frame_count = len(audio) // (params.sampwidth * params.nchannels)
            clip_path = args.output / f"{args.input.stem}_clip_{index + 1:03d}.wav"

            with wave.open(str(clip_path), "wb") as target:
                target.setparams(params)
                target.writeframes(audio)

            rows.append(
                {
                    "source_file": args.input.as_posix(),
                    "clip_id": index + 1,
                    "start_s": round(start_frame / params.framerate, 6),
                    "end_s": round((start_frame + frame_count) / params.framerate, 6),
                    "duration_s": round(frame_count / params.framerate, 6),
                    "clip_file": clip_path.as_posix(),
                }
            )

    manifest_path = args.output / "clip_manifest.csv"
    with manifest_path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)

    print(f"Wrote {len(rows)} clip(s) and {manifest_path}")


if __name__ == "__main__":
    main()
