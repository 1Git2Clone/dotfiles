#!/usr/bin/env python3
import subprocess
import argparse
import sys
from pathlib import Path
from typing import List


def get_video_duration(input_path: Path) -> float:
    """Uses ffprobe to get the exact duration of the video in seconds."""
    cmd: List[str] = [
        "ffprobe",
        "-v",
        "error",
        "-show_entries",
        "format=duration",
        "-of",
        "default=noprint_wrappers=1:nokey=1",
        str(input_path),
    ]
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return float(result.stdout.strip())
    except (subprocess.CalledProcessError, ValueError) as e:
        print(f"Error: Could not determine duration for {input_path}: {e}")
        sys.exit(1)


def compress_video(input_path: Path, output_path: Path, max_size_mb: float) -> None:
    if not input_path.exists():
        print(f"Error: Input file '{input_path}' not found.")
        return

    # Check if compression is even necessary
    current_size_mb: float = input_path.stat().st_size / (1024 * 1024)
    if current_size_mb <= max_size_mb:
        print(
            f"File is already {current_size_mb:.2f}MB (under {max_size_mb}MB target). Skipping."
        )
        return

    # 1. Setup constants and safety buffer
    # 0.94 margin to account for muxing overhead (headers/metadata)
    margin: float = 0.94
    target_size_bits: float = max_size_mb * 8 * 1024 * 1024 * margin
    duration: float = get_video_duration(input_path)

    # 2. Calculate Bitrates
    audio_bitrate_bps: int = 128 * 1024
    total_bitrate_bps: float = target_size_bits / duration
    video_bitrate_bps: int = int(total_bitrate_bps - audio_bitrate_bps)

    # Sanity check: prevent negative or "glitchy" low bitrates
    if video_bitrate_bps < 64000:
        print(f"!! Warning: Target {max_size_mb}MB is very small for {duration:.1f}s.")
        video_bitrate_bps = 64000

    print("--- Encoding Profile ---")
    print(f"Target:   {max_size_mb} MB")
    print(f"Bitrate:  {video_bitrate_bps // 1000} kbps")
    print("------------------------")

    null_device: str = "NUL" if sys.platform == "win32" else "/dev/null"

    # Base FFmpeg parameters
    base_params: List[str] = [
        "ffmpeg",
        "-y",
        "-i",
        str(input_path),
        "-c:v",
        "libx264",
        "-b:v",
        str(video_bitrate_bps),
        "-preset",
        "medium",
    ]

    pass1: List[str] = base_params + ["-pass", "1", "-an", "-f", "mp4", null_device]
    pass2: List[str] = base_params + [
        "-pass",
        "2",
        "-c:a",
        "aac",
        "-b:a",
        "128k",
        str(output_path),
    ]

    try:
        print("Pass 1/2: Analyzing...")
        subprocess.run(pass1, check=True, stderr=subprocess.DEVNULL)

        print("Pass 2/2: Encoding...")
        subprocess.run(pass2, check=True, stderr=subprocess.DEVNULL)

        final_size_mb: float = output_path.stat().st_size / (1024 * 1024)
        print(f"\nDone! Final size: {final_size_mb:.2f} MB")

    except subprocess.CalledProcessError as e:
        print(f"\nFFmpeg failed: {e}")
    finally:
        # Cleanup logs
        for log_file in Path(".").glob("ffmpeg2pass-0.log*"):
            log_file.unlink(missing_ok=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Force video under a specific MB limit."
    )
    parser.add_argument("input", type=Path, help="Source video file")
    parser.add_argument("output", type=Path, help="Output video file")
    parser.add_argument("size", type=float, help="Target size in MB")

    args = parser.parse_args()
    compress_video(args.input, args.output, args.size)
