#!/bin/bash

#/usr/bin/prlcc &
#/usr/bin/ptiagent --info &

xrandr --output Virtual-1 --mode 2560x1600
# xrandr --output Virtual-1 --mode 1920x1200
#xrandr --output Virtual-1 --mode 1680x1050
#xrandr --output Virtual-1 --mode 1440x900

# feh 设置墙纸
# firejail --net=none feh --bg-fill /home/dinge/core/picture/xp-bg.jpg
# feh --bg-fill /home/dinge/.dwm/wallpapers/xp.jpg
feh --bg-fill /home/dinge/.dwm/wallpapers/c.jpg

# dwm status
dwmblocks &
xsetroot -name " [ USER ${USER} + DATE $(date +%Y.%m.%d\ %H:%M:%S) ]"

# 无论当前current-status-type.txt文件的状态类型number是否为1, 开启dwm后都设置为1
#$(echo 1 > $(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))/dwm-status/current-status-type.txt)
# 启动状态栏信息
#bash /home/dinge/.dwm/scripts/dwm-status/dwm-status.sh &

# 启动picom
#picom -bCG --shadow-opacity=OPACITY
picom -bCG --shadow-opacity=0.0 --fade-in-step=1.0 --fade-out-step=1.0 --fade-delta=1 --menu-opacity=1.0

# 音量gui
volumeicon &
# firejail --net=none volumeicon &

# 启动 fcitx
fcitx5 &
#firejail --net=none fcitx &

# -----------------------------------------------------------------------
# 禁用触摸板
# xinput list - 查看所有输入设备
# 15 16 19
#xinput disable 15
# touchpadID=$(xinput | grep "ETPS/2 Elantech Touchpad" | awk '{print $6}' | grep "id=" | tr -cd "[0-9]")
# if [[ $touchpadID != "" ]]; then
#   xinput disable ${touchpadID}
# fi

# 蓝牙
# blueman-applet &
# blueberry-tray &

#nitrogen --restore; 

# feh 随机切换墙纸
#bash /home/dinge/core/scripts/dwm-scripts/wp-autochange.sh &

# 切换键盘布局（主要是mod键位）
# bash /home/dinge/core/scripts/dwm-scripts/dwm-xmodmap.sh &

sleep 1;
vmware-user-suid-wrapper &

#/usr/lib/aarch64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1 &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# manjaro-hello &
# pamac-tray &
# clipit &
# sbxkb &
# start_conky_maia &
# start_conky_green &
# ff-theme-util &
# fix_xcursor &

# bluerlock / xslock 锁屏 - 时间： 10分钟
#xautolock -time 10 -locker blurlock &
#xautolock -time 10 -locker slock &
#xautolock -time 10 -locker /home/dinge/core/scripts/dwm-scripts/slock-lockscreen.sh &

# 电源管理器
#xfce4-power-manager &

# 网络gui
# nm-applet &
# firejail --net=none nm-applet &

#sleep 10;

# 开机自动打开 所需软件 - 现在集成到dwm 使用快捷键打开
#bash /dinge/scripts/dwm-scripts/dinge-autostart.sh &

# -----------------------------------------------------------------------
# HDMI-0 : 外接显示器
# eDP    : 内置显示器
# --left-of : 外接显示在内置的左边
# # xrandr --output HDMI-0 --mode 1920x1080 --left-of eDP --primary
# # xrandr --output eDP --right-of HDMI-0 --mode 1920x1080 --primary
# xrandr --output HDMI-0 --mode 1920x1080 --right-of eDP --primary
# xrandr --output eDP --left-of HDMI-0 --mode 1920x1080 --primary

#xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#xrandr --addmode DP1 "1920x1080_60.00"

