#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Make sure this is before the 'exec' command or it won't be sourced.
#[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# ---------------------------------------------------

# ubuntu dwm ==========================
# 使用startx命令从文字界面启动
# 将系统改为默认进入文字界面
# sudo vim /etc/default/grub
#    将GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
#    改为GRUB_CMDLINE_LINUX_DEFAULT="text"
# 更新grub配置                  : sudo update-grub
# 将启动等级改为多用户等级         : sudo systemctl set-default multi-user.target
# 如果想改回启动图形界面           : sudo systemctl set-default graphical.target
# 在文字界面打开gdm3的用户登录界面  : sudo systemctl start gdm.service
# -----------------------------------------------------------------------

## Parallels Tools
## 动态显示分辨率
#/usr/bin/prlcc &
## 同步剪贴板
#/usr/bin/prlcp &
##/usr/bin/ptiagent --info &

exec dwm 2> /dev/null

# exec startxfce4
# exec cinnamon-session

# exec i3 -V >> ~/.config/i3/log/log-$(date +'%Y%m%d-%H%M%S') 2>&1
# exec awesome

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
