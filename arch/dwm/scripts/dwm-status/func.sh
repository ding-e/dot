#!/bin/bash

# 图标 - 不同分类下的分割 （比如：wifi速度和时间之间的分割符）
S_ICON_1=" - "

# 图标 - 相同分类下的分割 （比如：wifi速度分类下的上行下行分割符）
S_ICON_2=" + "

S_ICON_3="["
S_ICON_4="]"

# xsetroot 最前/后面是否添加空格
S_LEFT_SPACE=" "
S_RIGHT_SPACE=""

#WIFI_DEVICE="wlp3s0"
#WIFI_DEVICE="enp0s5"
WIFI_DEVICE="ens160"
# --------------------

# ========================================================
# function start

# 「小数」转换大小格式（文件大小/wifi速度等）
# $1: 传入字节，转kb，mb，gb，tb
# $2: 保留多少位小数 (傳入0, 則爲整數)
size_format() {
  size=$1
  rank=0
  unit="B"

  if [[ $size == 0 ]]; then
    rank=1
  else
    if [[ $2 == 0 ]]; then
      while [ $size -ge 1024 ]; do
        size=$(expr $size / 1024)
        rank=$(expr $rank + 1)
      done
    else
      bijiao=$(awk -v size=$size 'BEGIN{printf "%0.0f", (size >= 1024)}')
      while [ $bijiao -gt 0 ]; do
        size=$(awk -v size=$size -v f="%0.$2f" 'BEGIN{printf f, (size / 1024)}')
        bijiao=$(awk -v size=$size 'BEGIN{printf "%0.0f", (size >= 1024)}')
        rank=$(expr $rank + 1)
      done
    fi
  fi

  if [[ $rank == "1" ]]; then
    unit="KB"
  elif [[ $rank == "0" ]]; then
    unit="B"
  elif [[ $rank == "2" ]]; then
    unit="MB"
  elif [[ $rank == "3" ]]; then
    unit="GB"
  elif [[ $rank == "4" ]]; then
    unit="TB"
  else
    unit="BIG.TB"
  fi
  echo -e "${size}${unit}"
}

# 获取当前无线名称
get_wifi_name() {
  # 无线
  wifi=$(iwgetid -r)
  if [ "$wifi" == "" ]; then
    wifi="none"
  fi
  echo -e "${wifi}"
}

# 根據磁盘名字 - 获取磁盘的已用/空閒/已用百分比大小
# $1: 路徑(掛載點)
# $2: used / avail / percentage - 已用 / 空閒 / 已用百分比
get_disk_info() {
  disk_name=$1
  type=$2
  size=""

  if [[ "$type" == "used" ]]; then
    size=$(df -h | awk -v name=$disk_name '{ if ($6 == name) print $3 }')
    size="${size}B"
  elif [[ "$type" == "avail" ]]; then
    size=$(df -h | awk -v name=$disk_name '{ if ($6 == name) print $4 }')
    size="${size}B"
  elif [[ "$type" == "percentage" ]]; then
    size=$(df -h | awk -v name=$disk_name '{ if ($6 == name) print $5 }')
  fi
  echo -e "${size}"
}

# 獲取音量百分比
get_volume_info() {
  # 音量
  volume=$(amixer -M get Master | egrep 'Front Left' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')
  if [ "$(amixer -M get Master | egrep 'Front Left' | egrep -o 'off')" = "off" ]; then
    volume="M $volume"
  fi
  echo -e "${volume}%"
}

# 获取日期/时间
# get_datetime 1 -> 月.日
# get_datetime 2 -> 年.月.日
# get_datetime 3 -> 時:分
get_datetime() {
  if [ $1 == 1 ]; then
    date=$(date +%m.%d)
  elif [ $1 == 2 ]; then
    date=$(date +%Y.%m.%d)
  else
    date=$(date +%H:%M)
  fi
  echo -e "${date}"
}

# function end
# ========================================================

# wifi 上传/下载速度
print_wifi_speed() {
  up_time1=$(ifconfig ${WIFI_DEVICE} | grep "TX packets" | awk '{print $5}')
  down_time1=$(ifconfig ${WIFI_DEVICE} | grep "RX packets" | awk '{print $5}')

  sleep 1
  # clear

  up_time2=$(ifconfig ${WIFI_DEVICE} | grep "TX packets" | awk '{print $5}')
  down_time2=$(ifconfig ${WIFI_DEVICE} | grep "RX packets" | awk '{print $5}')

  up_time=$(expr $up_time2 - $up_time1)
  down_time=$(expr $down_time2 - $down_time1)

  echo -e "${S_ICON_3}SPE D $(size_format $down_time 0)/s${S_ICON_2}U $(size_format $up_time 0)/s${S_ICON_4}"
}

# 总物理内存
print_mem() {
  # 总内存 (byte) 默认kb
  memtotal=$(free | awk 'NR==2{print}' | awk '{print $2 * 1024}')
  # 剩余内存 (byte) 默认kb
  memavailable=$(free | awk 'NR==2{print}' | awk '{print $7 * 1024}')
  # 计算 已用内存 (byte) 默认kb
  memused=$(($memtotal - $memavailable))
  # 计算已用内存 百分比
  memusedP=$(awk -v memused=$memused -v memtotal=$memtotal 'BEGIN{printf "%0.0f", ((memused / memtotal) * 100)}')

  used=$(size_format $memused 1)
  avail=$(size_format $memavailable 1)
  echo -e "${S_ICON_3}MEM A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${memusedP}%${S_ICON_4}"
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
  echo -e "${S_ICON_3}W $(get_wifi_name)${S_ICON_2}T $(get_datetime 1) $(get_datetime 3)${S_ICON_4}"
}

# ======================================================

# 年月日 & 时间
print_datetime() {
  echo -e "${S_ICON_3}DATE $(get_datetime 2) $(get_datetime 3)${S_ICON_4}"
}

# 时间
print_time() {
  echo -e "${S_ICON_3}TIME $(get_datetime 3)${S_ICON_4}"
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
  # 音量
  volume=$(get_volume_info)
  # 笔记本屏幕亮度
  light=$(xbacklight -get)

  echo -e "${S_ICON_3}VOL ${volume}${S_ICON_2}LIG ${light}%${S_ICON_4}"
}

# 音量 和 当前时间
print_volume_datetime() {
  # 音量
  volume=$(get_volume_info)
  echo -e "${S_ICON_3}VOL ${volume}${S_ICON_2}DATE $(get_datetime 1) $(get_datetime 3)${S_ICON_4}"
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



