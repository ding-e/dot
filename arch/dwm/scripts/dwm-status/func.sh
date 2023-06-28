#!/bin/bash

CURR_DIR=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))
source ${CURR_DIR}/utils.sh

# wifi 上/下行速度
print_wifi_speed() {
  echo -e $(dwm_wifi_speed.sh)
}

# 总物理内存
print_mem() {
  echo -e $(dwm_mem.sh)
}

# ======================================================

# 磁盘使用情况
# / 磁盘
print_root_disk() {
  disk_name="/"
  used=$(get_disk_info $disk_name "used")
  avail=$(get_disk_info $disk_name "avail")
  percentage=$(get_disk_info $disk_name "percentage")
  echo -e "${S_ICON_3}ROOT A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${percentage}${S_ICON_4}"
}

# home 磁盘
print_home_disk() {
  disk_name="/home"
  used=$(get_disk_info $disk_name "used")
  avail=$(get_disk_info $disk_name "avail")
  percentage=$(get_disk_info $disk_name "percentage")
  echo -e "${S_ICON_3}HOME A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${percentage}${S_ICON_4}"
}

# dinge 磁盘
print_dinge_disk() {
  disk_name="/dinge"
  used=$(get_disk_info $disk_name "used")
  avail=$(get_disk_info $disk_name "avail")
  percentage=$(get_disk_info $disk_name "percentage")
  echo -e "${S_ICON_3}DINGE A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${percentage}${S_ICON_4}"
}

# ======================================================

# 无线
print_wifi() {
  echo -e "${S_ICON_3}WIFI $(get_wifi_name)${S_ICON_4}"
}

# wifi & 月日 & 時間
print_wifi_datetime() {
  echo -e "${S_ICON_3}W $(get_wifi_name)${S_ICON_2}T $(get_datetime 1) $(get_datetime 0)${S_ICON_4}"
}

# ======================================================

# 年月日 & 时间
print_datetime() {
  echo -e "${S_ICON_3}DATE $(get_datetime 2) $(get_datetime 0)${S_ICON_4}"
}

# 时间
print_time() {
  echo -e "${S_ICON_3}TIME $(get_datetime 0)${S_ICON_4}"
}

# ======================================================

# 电池 和 cpu温度
print_battery_temperature() {
  # 电源
  # C: 正在充电，D: 用移动电池
  battery="C $(acpi | egrep 'Battery 0' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')%"
  dis=$(acpi | egrep 'Battery 0' | egrep -o 'Discharging')
  if [ "$dis" == "Discharging" ]; then
    battery="D $(acpi | egrep 'Battery 0' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')%"
  fi
  #battery="$(acpi | egrep 'Battery 0' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')%"

  # 温度
  temperature=$(cat /sys/class/thermal/thermal_zone0/temp | egrep -o '^[0-9][0-9]')

  echo -e "${S_ICON_3}BAT ${battery}${S_ICON_2}THE ${temperature}°C${S_ICON_4}"
}

# 音量 和 笔记本屏幕亮度
print_volume_light() {
  volume=$(get_volume_info)
  light=$(xbacklight -get)
  echo -e "${S_ICON_3}VOL ${volume}${S_ICON_2}LIG ${light}%${S_ICON_4}"
}

# 音量 和 当前时间
print_volume_datetime() {
  volume=$(get_volume_info)
  echo -e "${S_ICON_3}VOL ${volume}${S_ICON_2}DATE $(get_datetime 1) $(get_datetime 0)${S_ICON_4}"
}

# ======================================================

# 检测软件更新情况（未更新个数，已安装软件个数）
print_packages_up_info() {
  upd=$(checkupdates | wc -l)
  ind=$(pacman -Q | wc -l)
  if [[ $upd -ge 1 ]]; then
    echo -e "${S_ICON_3}${upd} updates${S_ICON_2}${ind} installed${S_ICON_4}"
  else
    echo -e ""
  fi
}

# ======================================================

print_status_type_1() {
  # intel / amd cpu
  # $(print_wifi_datetime)

  # 虛擬機
  # $(print_volume_datetime)
  echo -e "${S_LEFT_SPACE}$(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_time)${S_RIGHT_SPACE}"
}

print_status_type_2() {
  # intel / amd cpu
  # $(print_wifi_speed) $(print_root_disk) $(print_battery_temperature) $(print_volume_light)

  # 虛擬機
  echo -e "${S_LEFT_SPACE}$(print_root_disk)${S_ICON_1}$(print_volume_datetime)${S_RIGHT_SPACE}"
}



