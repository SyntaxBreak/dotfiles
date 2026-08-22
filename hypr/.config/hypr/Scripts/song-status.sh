#!/usr/bin/env bash

status=$(playerctl status 2>/dev/null)
if [ "$status" == "Playing" ]; then
    indicator_icon=$(printf "\uF00B")
elif [ "$status" == "Paused" ]; then
    indicator_icon=$(printf "\uEFD8")
else
    echo "$(printf "\uF00B") touching grass - nothing [ꝏ/ꝏ]"
    exit 1
fi

title=$(playerctl metadata --format "{{xesam:title}}")
artist=$(playerctl metadata --format "{{xesam:artist}}")

pos_sec=$(playerctl position 2>/dev/null | cut -d'.' -f1)
len_sec=$(playerctl metadata --format "{{mpris:length}}")

if [ -n "$len_sec" ]; then
    len_sec=$((len_sec / 1000000))
else
    len_sec=0
fi

format_time() {
    local total=$1
    local mins=$((total / 60))
    local secs=$((total % 60))
    printf "%02d:%02d" "$mins" "$secs"
}

pos_fmt=$(format_time "${pos_sec:-0}")
len_fmt=$(format_time "$len_sec")

echo "${indicator_icon} ${artist} - ${title} [${pos_fmt}/${len_fmt}]"