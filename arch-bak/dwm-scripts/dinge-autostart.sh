#!/bin/bash


:'
这是多行注释
'

/dinge/scripts/dwm-scripts/tray-toggle.sh &

#qv2ray &
#firejail qv2ray &

#thunar &
firejail --net=none thunar &

#google-chrome-stable &
firejail chromium &

#firefox &
#firejail --net=none godot-50-v3.2.2 &

#godot-50-v3.2.2-mono &
#firejail --net=none code &

