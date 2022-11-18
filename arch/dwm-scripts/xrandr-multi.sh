#!/bin/bash

# HDMI1 : 外接显示器
# eDP1    : 内置显示器
# --left-of : 外接显示在内置的左边

# HDMI1, DP1
hdmi_0=$(xrandr | awk '{if ($1 == "DP1") print $2 }')
is_keynav=$(ps ax|grep -v grep|grep keynav)
if [ "$hdmi_0" == "disconnected" ]; then
  xrandr --output DP1 --off
  xrandr --output eDP1 --mode 1366x768 --primary

  if [ "$is_keynav" != "" ]; then
    killall keynav
  fi
else
  xrandr --output DP1 --mode 1920x1080_60.00 --left-of eDP1 --primary
  xrandr --output eDP1 --right-of DP1 --mode 1366x768 --primary

  #xrandr --output DP1 --mode 1920x1080_60.00 --left-of eDP1 --primary
  #xrandr --output eDP1 --right-of DP1 --mode 1366x768 --primary

  if [ "$is_keynav" == "" ]; then
    eval "keynav &"
  else
    killall keynav
    eval "keynav &"
  fi
fi
