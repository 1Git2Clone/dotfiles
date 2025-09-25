#!/usr/bin/env python3

import argparse
import subprocess
import os
import math


def get_file_size_mb(path):
    return os.path.getsize(path) / (1024 * 1024)


def encode_crf(input_path, output_path, crf):
    """Encode video with a given CRF value."""
    subprocess.run(
        [
            "ffmpeg",
            "-y",
            "-i",
            input_path,
            "-c:v",
            "libx264",
            "-crf",
            str(crf),
            "-preset",
            "medium",
            "-c:a",
            "aac",
            "-b:a",
            "128k",
            output_path,
        ],
        check=True,
    )


def compress_predictive(
    video_path, max_size_mb, output_path=None, target_ratio=0.8, probe_crf=23
):
    if output_path is None:
        base, ext = os.path.splitext(video_path)
        output_path = f"{base}_compressed{ext}"

    # Step 1: Encode probe at probe_crf
    probe_output = f"{output_path}.probe.mp4"
    encode_crf(video_path, probe_output, probe_crf)
    probe_size = get_file_size_mb(probe_output)
    os.remove(probe_output)

    # Step 2: Calculate target CRF
    target_size = max_size_mb * target_ratio
    probe_size = max(probe_size, 0.1)

    target_crf = probe_crf + 6 * math.log2(probe_size / target_size)
    target_crf = max(18, min(38, target_crf))

    # Step 3: Encode final output
    encode_crf(video_path, output_path, target_crf)

    return output_path


def main():
    parser = argparse.ArgumentParser(
        description="Compress a video to ~90-95% of max size using predictive CRF."
    )
    parser.add_argument("input", help="Input video file path")
    parser.add_argument("size", type=float, help="Target maximum size in MB")
    parser.add_argument("-o", "--output", help="Output video path (optional)")
    parser.add_argument(
        "--ratio",
        type=float,
        default=0.8,
        help="Target ratio of max size (default 0.85)",
    )
    args = parser.parse_args()

    output_file = compress_predictive(args.input, args.size, args.output, args.ratio)
    print(f"Compressed video saved to: {output_file}")


if __name__ == "__main__":
    main()
