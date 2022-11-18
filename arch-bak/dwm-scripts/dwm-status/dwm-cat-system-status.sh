#!/bin/bash   
# -- 注意：因为ubuntu默认使用bash，
# -- 如果使用sh声明的话，将会无法使用source加载脚本
# -- 具体参考：https://www.cnblogs.com/luego/p/11684311.html
##!/bin/sh

# 根据当前文件获取绝对路径
WORKSPACE=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))

# 导入状态的函数库
source ${WORKSPACE}/func.sh

S_ICON_3="[ "
S_ICON_4=" ]"
# --------------------

# echo " $(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_wifi_date_time) "

# 发送一条系统通知
notify-send "TIME    $(print_datetime)
MEMORY  $(print_mem)
------------------------
ROOT    $(print_root_disk)
------------------------
VOLUME  $(print_volume_light)
BETTERY $(print_battery_temperature)
------------------------
WIFI    $(print_wifi)
"


#DINGE   $(print_dinge_disk)

#$(date "+%Y-%m-%d %H:%M")
notify-send "$(LANG=en cal)"
