#!/bin/bash

# xrandr --output HDMI-0 --off
# xrandr --output HDMI1 --off

# HDMI1, DP1
hdmi_0=$(xrandr | awk '{if ($1 == "DP1") print $2 }')
if [ "$hdmi_0" == "disconnected" ]; then
  xrandr --output DP1 --off
  xrandr --output eDP1 --mode 1366x768 --primary
else
  xrandr --output eDP1 --off
  #xrandr --output HDMI1 --off
  xrandr --output DP1 --mode 1920x1080_60.00 --primary
fi
