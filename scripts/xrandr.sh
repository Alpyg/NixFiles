#!/bin/sh

xsetroot -cursor_name left_ptr &
xrandr --output DP-0 --mode 2560x1440 --rate 180 --pos 1080x480 --rotate normal --primary \
       --output HDMI-0 --mode 1920x1080 --rate 60 --pos 0x0 --rotate left \
       --output DP-3 --mode 1920x1080 --rate 75 --pos 3640x840 --rotate normal &
