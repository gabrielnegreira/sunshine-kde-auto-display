#!/usr/bin/env bash
# This script will activate the dummy display without deactivating the main display. 
# It is meant to allow the client to work as a second display (extended).
set -euo pipefail

MAIN_OUT="DP-4"
DUMMY_OUT="DP-2"

W="${SUNSHINE_CLIENT_WIDTH:-1920}"
H="${SUNSHINE_CLIENT_HEIGHT:-1080}"
FPS="${SUNSHINE_CLIENT_FPS:-60}"

# Enable dummy (keep main enabled)
kscreen-doctor "output.${DUMMY_OUT}.enable"

# Try match client mode
kscreen-doctor "output.${DUMMY_OUT}.mode.${W}x${H}@${FPS}" 2>/dev/null || \
kscreen-doctor "output.${DUMMY_OUT}.mode.${W}x${H}@60" 2>/dev/null || true

# Keep main as primary (so your local desktop stays “normal”)
kscreen-doctor "output.${MAIN_OUT}.primary"
