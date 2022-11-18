#!/bin/bash

# 根据当前文件获取绝对路径
WORKSPACE=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))

# 导入状态的函数库
source ${WORKSPACE}/func.sh

# xset b off
while true; do
    # 当前的状态的类型number
    # 1: $(print_wifi_speed)
    #    $(print_mem)
    #    $(print_wifi_date_time)
    #
    # 2: $(print_wifi_speed)
    #    $(print_root_disk)
    #    $(print_battery_temperature)
  currStatusType=$(cat ${WORKSPACE}/current-status-type.txt)
  if [ $currStatusType == 2 ]; then
      #xsetroot -name " $(print_wifi_speed)${S_ICON_1}$(print_root_disk)${S_ICON_1}$(print_battery_temperature)${S_ICON_1}$(print_volume_light)";
      xsetroot -name "$(print_status_type_2)"
  else
      #xsetroot -name " $(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_wifi_date_time)";
      xsetroot -name "$(print_status_type_1)"
  fi
  sleep 2;
done &
