#!/bin/sh

xsetroot -cursor_name left_ptr &
xrandr \
       --output DP-0 --mode 2560x1440 --rate 180 --pos 0x0 --primary \
       --output HDMI-0  --mode 1920x1080 --rate 60 --pos 2560x360 &
