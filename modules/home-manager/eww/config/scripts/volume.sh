#!/bin/sh

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 + 0}')

if [ "$1" = "up" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1
elif [ "$1" = "down" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
else
    echo $(awk "BEGIN {print $volume * 100}")
fi
