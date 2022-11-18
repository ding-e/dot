#!/bin/bash

# siji font
#xset +fp /home/dinge/.local/share/fonts
#xset fp rehash
#xset +fp /home/dinge/.local/share/fonts/tamzen-font/bdf
#xset fp rehash

# -----------------------------------------------------------------------
# # HDMI-0 : 外接显示器
# # eDP    : 内置显示器
# # --left-of : 外接显示在内置的左边
# # xrandr --output HDMI-0 --mode 1920x1080 --left-of eDP --primary
# # xrandr --output eDP --right-of HDMI-0 --mode 1920x1080 --primary
# xrandr --output HDMI-0 --mode 1920x1080 --right-of eDP --primary
# xrandr --output eDP --left-of HDMI-0 --mode 1920x1080 --primary

#xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#xrandr --addmode DP1 "1920x1080_60.00"

xrandr --output Virtual-1 --mode 1680x1050
#xrandr --output Virtual-1 --mode 1280x800

# -----------------------------------------------------------------------
# xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# xrandr --addmode DP1 1920x1080_60.00

# hdmi_0=$(xrandr | awk '{if ($1 == "DP1") print $2 }')
# is_keynav=$(ps ax|grep -v grep|grep keynav)
# if [ "$hdmi_0" == "connected" ]; then
#   xrandr --output DP1 --mode 1920x1080_60.00 --left-of eDP1 --primary
#   xrandr --output eDP1 --right-of DP1 --mode 1366x768 --primary

#   if [ "$is_keynav" == "" ]; then
#     eval "keynav &"
#   else
#     killall keynav
#     eval "keynav &"
#   fi
# else
#   if [ "$is_keynav" != "" ]; then
#     killall keynav
#   fi
# fi

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

# feh 设置墙纸
# feh --bg-fill /dinge/picture/wallpapers/view
# feh --bg-fill /dinge/picture/black-bg.png
# feh --bg-fill /dinge/picture/xp-bg.jpg
# feh --bg-fill /dinge/picture/green-bg.png
# firejail --net=none feh --bg-fill /home/dinge/core/picture/black-bg.png
# firejail --net=none feh --bg-fill /home/dinge/core/picture/green-bg.png
firejail --net=none feh --bg-fill /home/dinge/core/picture/xp-bg.jpg

#nitrogen --restore; 

# 启动picom
# compton
# picom -bCG --shadow-opacity=OPACITY
picom -bCG --shadow-opacity=0.0 --fade-in-step=1.0 --fade-out-step=1.0 --fade-delta=1 --menu-opacity=1.0

# 启动 fcitx
fcitx &
# firejail --net=none 2>/dev/null fcitx &
#firejail --net=none fcitx &

# feh 随机切换墙纸
#bash /home/dinge/core/scripts/dwm-scripts/wp-autochange.sh &

# dwm status
#xsetroot -name " [ USER ${USER}  DATE $(date +%Y.%m.%d\ %H:%M:%S) ]"
xsetroot -name " [ USER ${USER} + DATE $(date +%Y.%m.%d\ %H:%M:%S) ]"
#xsetroot -name " [USER ${USER} + DATE $(date +%Y.%m.%d\ %H:%M:%S)]"

# 无论当前current-status-type.txt文件的状态类型number是否为1, 开启dwm后都设置为1
$(echo 1 > $(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))/dwm-status/current-status-type.txt)
# 启动状态栏信息
bash /home/dinge/core/scripts/dwm-scripts/dwm-status/dwm-status.sh &
#bash /dinge/scripts/dwm-scripts/dwm-status/dwm-status.sh &

# =================== compton START
# 加上--config ~/.config/compton/compton.conf 切换窗口compton有模糊效果
#compton -b
#picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b

#== 配置说明：https://github.com/chjj/compton/blob/master/man/compton.1.asciidoc
#==         ：https://wiki.archlinux.org/index.php/Picom_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E4%B8%93%E4%B8%BA%E6%9F%90%E4%BA%9B%E7%AA%97%E5%8F%A3%E7%A6%81%E7%94%A8%E9%98%B4%E5%BD%B1%E6%95%88%E6%9E%9C 

#== -b: 后台运行，
#== -C: 禁用面板和 Docks 的阴影效果
#== -G: 禁用应用程序窗口和拖放对象的阴影效果
#== --shadow-opacity=OPACITY: 阴影的不透明度。（0.0-1.0，默认为0.75）
#compton -bCG --shadow-opacity=OPACITY
# =================== compton END

#sleep 1;

vmware-user-suid-wrapper &

/usr/lib/aarch64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1 &

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
#xautolock -time 10 -locker /dinge/scripts/dwm-scripts/slock-lockscreen.sh &

# 电源管理器
#xfce4-power-manager &

# 网络gui
# nm-applet &
# firejail --net=none nm-applet &

# 音量gui
# volumeicon &
firejail --net=none volumeicon &

#electron-ssr &

# 切换键盘布局（主要是mod键位）
#bash /home/dinge/core/scripts/dwm-scripts/dwm-xmodmap.sh &
#bash /dinge/scripts/dwm-scripts/dwm-xmodmap.sh &

#sleep 10;

# 开机自动打开 所需软件 - 现在集成到dwm 使用快捷键打开
#bash /dinge/scripts/dwm-scripts/dinge-autostart.sh &
