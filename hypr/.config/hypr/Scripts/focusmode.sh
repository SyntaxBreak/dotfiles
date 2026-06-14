#!/usr/bin/env bash

STATE_FILE="/tmp/hypr-focus-mode"

# Your normal values
NORMAL_GAPS_IN=3
NORMAL_GAPS_OUT=8
NORMAL_ROUNDING=5
NORMAL_BORDER_SIZE=3

if [ -f "$STATE_FILE" ]; then
    # Restore normal mode

    hyprctl keyword general:gaps_in "$NORMAL_GAPS_IN"
    hyprctl keyword general:gaps_out "$NORMAL_GAPS_OUT"
    hyprctl keyword decoration:rounding "$NORMAL_ROUNDING"
    hyprctl keyword general:border_size "$NORMAL_BORDER_SIZE"

    pkill -USR2 waybar 2>/dev/null || waybar >/dev/null 2>&1 &

    rm "$STATE_FILE"
else
    # Enable focus mode

    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding 0
    hyprctl keyword general:border_size 0

    pkill -USR1 waybar

    touch "$STATE_FILE"
fi