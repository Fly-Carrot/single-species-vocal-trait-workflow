#!/usr/bin/env python3
"""Build a compact manifest for WAV files."""

from __future__ import annotations

import argparse
import csv
import hashlib
import wave
from pathlib import Path


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def inspect_wav(path: Path, root: Path) -> dict[str, object]:
    with wave.open(str(path), "rb") as wav:
        frames = wav.getnframes()
        sample_rate = wav.getframerate()
        return {
            "file": path.relative_to(root).as_posix(),
            "duration_s": round(frames / sample_rate, 6),
            "channels": wav.getnchannels(),
            "sample_rate_hz": sample_rate,
            "sample_width_bytes": wav.getsampwidth(),
            "frames": frames,
            "file_size_bytes": path.stat().st_size,
            "sha256": sha256(path),
        }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True, help="Folder containing WAV files")
    parser.add_argument("--output", type=Path, required=True, help="Output CSV path")
    args = parser.parse_args()

    root = args.input.resolve()
    files = sorted(root.rglob("*.wav"))
    if not files:
        raise SystemExit(f"No WAV files found under {root}")

    rows = [inspect_wav(path, root) for path in files]
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)

    print(f"Wrote {len(rows)} WAV record(s) to {args.output}")


if __name__ == "__main__":
    main()
