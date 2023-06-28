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

# 「小数」转换大小格式（文件大小/wifi速度等）
# $1: 传入字节，转kb，mb，gb，tb
# $2: 保留多少位小数 (傳入0, 則爲整數)
size_format() {
  size=$1
  i=0
  unit=("B" "KB" "MB" "GB" "TB" "BIG.TB")

  if [[ $size == 0 ]]; then
    i=1
  else
    # while [ $size -ge 1024 ]; do
    #   size=$(expr $size / 1024)
    #   i=$(expr $i + 1)
    # done
    go=$(awk -v size=$size 'BEGIN{printf "%0.0f", (size >= 1024)}')
    while [ $go == 1 ]; do
      size=$(awk -v size=$size -v f="%0.$2f" 'BEGIN{printf f, (size / 1024)}')
      go=$(awk -v size=$size 'BEGIN{printf "%0.0f", (size >= 1024)}')
      i=$(expr $i + 1)
    done
    if [[ $i -gt 4 ]]; then
      i=5
    fi
  fi

  echo -e "${size}${unit[i]}"
}

# 获取当前无线名称
get_wifi_name() {
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
  volume=$(amixer -M get Master | egrep 'Front Left' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')
  if [ "$(amixer -M get Master | egrep 'Front Left' | egrep -o 'off')" = "off" ]; then
    volume="M $volume"
  fi
  echo -e "${volume}%"
}

# 获取日期/时间
# get_datetime 0 -> 時:分
# get_datetime 1 -> 月.日
# get_datetime 2 -> 年.月.日
get_datetime() {
  date=($(date +%H:%M) $(date +%m.%d) $(date +%Y.%m.%d))
  i=$1
  if [[ $1 -gt 2 ]]; then
    i=0
  fi
  echo -e "${date[i]}"
}