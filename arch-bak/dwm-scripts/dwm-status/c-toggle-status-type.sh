#!/bin/bash

# 根据当前文件获取绝对路径
WORKSPACE=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))

# 导入状态的函数库
source ${WORKSPACE}/func.sh

# 获取当前的状态类型number
# 1: $(print_wifi_speed)
#    $(print_mem)
#    $(print_wifi_date_time)
#
# 2: $(print_wifi_speed)
#    $(print_root_disk)
#    $(print_battery_temperature)
file=${WORKSPACE}/current-status-type.txt

# 当前的状态的类型number
currStatusType=$(cat ${file})

if [ $currStatusType == 2 ]; then
    # 如果当前状态number为2，则修改为1
    $(echo 1 > ${file})

    # 马上修改dwm状态
    #xsetroot -name " $(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_wifi_date_time)";
    xsetroot -name "$(print_status_type_1)"
else
    # 如果当前状态number为1，则修改为2
    $(echo 2 > ${file})

    # 马上修改dwm状态
    #xsetroot -name " $(print_wifi_speed)${S_ICON_1}$(print_root_disk)${S_ICON_1}$(print_battery_temperature)${S_ICON_1}$(print_volume_light)";
    xsetroot -name "$(print_status_type_2)"
fi
