#!/usr/bin/env bash
#This script is meant to me called by Sunshine when a streaming starts.
#It requires a dummy display plug to work.
#It will then disable the main monitor, enable the dummy display and set its resolution and fps to match those of the client.
#Only works if the dummy display has those resolution and fps enabled on it.

set -euo pipefail

#to find out the display names use `kscreen-doctor -o`
MAIN_OUT="DP-4"  #name of the main display
DUMMY_OUT="DP-2" #name of the dummy display

W="${SUNSHINE_CLIENT_WIDTH:-1920}"
H="${SUNSHINE_CLIENT_HEIGHT:-1080}"
FPS="${SUNSHINE_CLIENT_FPS:-60}"

# Switch to dummy
kscreen-doctor "output.${DUMMY_OUT}.enable" "output.${MAIN_OUT}.disable"

# Try to match client mode (exact FPS, then @60)
kscreen-doctor "output.${DUMMY_OUT}.mode.${W}x${H}@${FPS}" 2>/dev/null || \
kscreen-doctor "output.${DUMMY_OUT}.mode.${W}x${H}@60" 2>/dev/null || true

# Make dummy primary
kscreen-doctor "output.${DUMMY_OUT}.primary"
