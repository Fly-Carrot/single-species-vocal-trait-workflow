#!/usr/bin/env python3
"""Create the waveform, spectrogram, and segmentation figures used in the lessons."""

from __future__ import annotations

import wave
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


ROOT = Path(__file__).resolve().parents[1]
AUDIO = ROOT / "data" / "demo" / "common-tailorbird-denoised.wav"
ASSETS = ROOT / "assets"

NAVY = "#133149"
TEAL = "#087E8B"
GOLD = "#D18B00"
RED = "#C2473A"
GRID = "#D7E0E5"


def read_pcm16(path: Path) -> tuple[int, np.ndarray]:
    with wave.open(str(path), "rb") as wav:
        if wav.getsampwidth() != 2:
            raise ValueError("The demo figure script currently expects 16-bit PCM WAV audio.")
        sample_rate = wav.getframerate()
        channels = wav.getnchannels()
        samples = np.frombuffer(wav.readframes(wav.getnframes()), dtype="<i2").astype(float)
    if channels > 1:
        samples = samples.reshape(-1, channels).mean(axis=1)
    peak = np.max(np.abs(samples)) or 1.0
    return sample_rate, samples / peak


def clean_axes(ax: plt.Axes) -> None:
    ax.spines[["top", "right"]].set_visible(False)
    ax.grid(color=GRID, linewidth=0.6, alpha=0.8)
    ax.tick_params(colors=NAVY)


def main() -> None:
    ASSETS.mkdir(parents=True, exist_ok=True)
    sample_rate, audio = read_pcm16(AUDIO)
    time = np.arange(audio.size) / sample_rate
    duration = time[-1]

    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 11})

    fig, ax = plt.subplots(figsize=(10, 2.8), constrained_layout=True)
    ax.plot(time, audio, color=TEAL, linewidth=0.55)
    ax.set(xlabel="Time (s)", ylabel="Relative amplitude", xlim=(0, duration), ylim=(-1.05, 1.05))
    ax.set_title("Example Common Tailorbird recording", color=NAVY, fontweight="bold")
    clean_axes(ax)
    fig.savefig(ASSETS / "demo-waveform.png", dpi=180, facecolor="white")
    plt.close(fig)

    fig, ax = plt.subplots(figsize=(10, 4.0), constrained_layout=True)
    ax.specgram(audio, NFFT=1024, Fs=sample_rate, noverlap=768, cmap="magma", scale="dB")
    ax.set(xlabel="Time (s)", ylabel="Frequency (kHz)", xlim=(0, duration), ylim=(0, 10000))
    ax.set_yticks(np.arange(0, 10001, 2000), labels=[str(x) for x in range(0, 11, 2)])
    ax.set_title("Spectrogram of the same recording", color=NAVY, fontweight="bold")
    fig.savefig(ASSETS / "demo-spectrogram.png", dpi=180, facecolor="white")
    plt.close(fig)

    fig, ax = plt.subplots(figsize=(10, 3.2), constrained_layout=True)
    ax.plot(time, audio, color=NAVY, linewidth=0.45)
    bounds = np.arange(0, duration + 2, 2)
    colors = [TEAL, GOLD, RED, "#4C7A4B", "#6A5D9B"]
    for index, start in enumerate(bounds[:-1]):
        end = min(start + 2, duration)
        ax.axvspan(start, end, color=colors[index % len(colors)], alpha=0.12)
        ax.axvline(start, color=colors[index % len(colors)], linewidth=1.1)
        ax.text((start + end) / 2, 0.88, f"clip {index + 1}", ha="center", color=colors[index % len(colors)])
    ax.axvline(duration, color=NAVY, linewidth=1.1)
    ax.set(xlabel="Time (s)", ylabel="Relative amplitude", xlim=(0, duration), ylim=(-1.05, 1.05))
    ax.set_title("Fixed-length clips keep their position in the source WAV", color=NAVY, fontweight="bold")
    clean_axes(ax)
    fig.savefig(ASSETS / "demo-segmentation.png", dpi=180, facecolor="white")
    plt.close(fig)

    print("Created three demo figures in assets/")


if __name__ == "__main__":
    main()
