#!/bin/sh

xsetroot -cursor_name left_ptr &
xrandr \
       --output DP-0 --mode 2560x1440 --rate 180 --pos 1920x0 --primary \
       --output HDMI-0  --mode 1920x1080 --rate 60 --pos 0x360 \
       --output DP-3 --mode 1920x1080 --rate 75 --pos 4480x360 &
