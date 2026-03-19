#!/usr/bin/env bash
#This script is meant to be called when sunshine ends a streaming, restoring the default settings.
set -euo pipefail

MAIN_OUT="DP-4"
DUMMY_OUT="DP-2"

# Restore main
kscreen-doctor "output.${MAIN_OUT}.enable" "output.${DUMMY_OUT}.disable"
kscreen-doctor "output.${MAIN_OUT}.primary"
