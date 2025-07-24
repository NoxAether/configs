#!/usr/bin/env sh

get_nvidia_gpu_usage() {
    if command -v nvidia-smi &>/dev/null; then
        usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        [ -z "$usage" ] && echo "N/A" || echo "$usage"
    else
        echo "N/A"
    fi
}

# Get NVIDIA GPU usage
nvidia_usage=$(get_nvidia_gpu_usage)

# Format output
echo "%{F#ff2a6d}GPU%{F-} %{F#05d9ff}${nvidia_usage}%%{F-}"
