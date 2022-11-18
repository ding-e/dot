#!/bin/bash

# 先睡眠3分钟, 在.xinitrc里面设置了墙纸
sleep 3m

while true; do
  bash /home/dinge/core/scripts/dwm-scripts/wp-change.sh &
  sleep 3m
done
