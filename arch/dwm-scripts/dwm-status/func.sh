
# 图标 - 不同分类下的分割 （比如：wifi速度和时间之间的分割符）
#S_ICON_1=
S_ICON_1=" - "

# 图标 - 相同分类下的分割 （比如：wifi速度分类下的上行下行分割符）
#S_ICON_2=
S_ICON_2=" + "

S_ICON_3="["
S_ICON_4="]"

# xsetroot 最前/后面是否添加空格
S_LEFT_SPACE=" "
S_RIGHT_SPACE=""

#WIFI_DEVICE="wlp2s0"
#WIFI_DEVICE="wlp3s0"
WIFI_DEVICE="ens160"
# --------------------

###########################################
## 函数 start

# 「整数」转换大小格式（文件大小/wifi速度等）
# $1: 传入字节，转kb，mb，gb，tb
to_size_format() {
  size=$1
  rank=0
  unit="B"

  if [[ $size == 0 ]]; then 
    rank=1
  else
    while [ $size -ge 1024 ]; do
      size=$(expr $size / 1024)
      # size=$(awk 'BEGIN{printf "%0.1f",$size / 1024}')
      rank=$(expr $rank + 1)
    done
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

# 「小数」转换大小格式（文件大小/wifi速度等）
# $1: 传入字节，转kb，mb，gb，tb
# $2: 保留多少位小数
to_size_format2() {
  size=$1
  rank=0
  unit="B"
  bijiao=$(awk -v size=$size 'BEGIN{printf "%0.0f", (size >= 1024)}')

  if [[ $size == 0 ]]; then 
    rank=1
  else
    # while [ $size -ge 1024 ]; do
    while [ $bijiao -gt 0 ]; do
      # size=$(expr $size / 1024)
      size=$(awk -v size=$size -v f="%0.$2f" 'BEGIN{printf f, (size / 1024)}')
      bijiao=$(awk -v size=$size 'BEGIN{printf "%0.0f", (size >= 1024)}')
      rank=$(expr $rank + 1)
    done
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

# 更具磁盘名字获取磁盘的已用数量
get_disk_used() {
    disk_name=$1
    echo -e $(df -h | awk '{ if ($6 == "${disk_name}") print $3 }')
}

# 更具磁盘名字获取磁盘的已用百分比
get_disk_percentage() {
    disk_name=$1
    echo -e $(df -h | awk '{ if ($6 == "${disk_name}") print $4 }')
}

# 更具磁盘名字获取磁盘的空闲数量
get_disk_avail() {
    disk_name=$1
    echo -e $(df -h | awk '{ if ($6 == "${disk_name}") print $4 }')
}

# 获取日期
# get_date 1 -> 月.日
# get_date 2 -> 年.月.日
get_date() {
    if [ $1 == 1 ]; then
        date=$(date +%m.%d)
    else
        date=$(date +%Y.%m.%d)
    fi

    echo -e "${date}"
}

# 获取时间
get_time() {
    echo -e "$(date +%H:%M)"
}

## 函数 end
###########################################

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

  echo -e "${S_ICON_3}SPE D $(to_size_format $down_time)/s${S_ICON_2}U $(to_size_format $up_time)/s${S_ICON_4}"
  # echo -e "[ SPE D $(to_size_format2 $down_time 1)/s ${S_ICON_2} U $(to_size_format2 $up_time 1)/s ]"
}

# 总物理内存
print_mem() {
  ## 总内存 (byte) 默认kb
  #memtotal=$(free | awk 'NR==2{print}' | awk '{print $2 * 1024}')
  ## 已用内存 (byte) 默认kb
  #memused=$(free | awk 'NR==2{print}' | awk '{print $3 * 1024}')
  ## 计算 剩余内存 (byte) 默认kb
  #memfree=$(($memtotal - $memused))
  ## 计算已用内存 百分比
  #memusedP=$(awk -v memused=$memused -v memtotal=$memtotal 'BEGIN{printf "%0.0f", ((memused / memtotal) * 100)}')
  #echo -e "${S_ICON_3}MEM A $(to_size_format2 $memfree 1)${S_ICON_2}U $(to_size_format2 $memused 1)${S_ICON_2}U.P ${memusedP}%${S_ICON_4}"

  # ==========================

  # 总内存 (byte) 默认kb
  memtotal=$(free | awk 'NR==2{print}' | awk '{print $2 * 1024}')
  # 剩余内存 (byte) 默认kb
  memavailable=$(free | awk 'NR==2{print}' | awk '{print $7 * 1024}')
  # 计算 已用内存 (byte) 默认kb
  memused=$(($memtotal - $memavailable))
  # 计算已用内存 百分比
  memusedP=$(awk -v memused=$memused -v memtotal=$memtotal 'BEGIN{printf "%0.0f", ((memused / memtotal) * 100)}')
  echo -e "${S_ICON_3}MEM A $(to_size_format2 $memavailable 1)${S_ICON_2}U $(to_size_format2 $memused 1)${S_ICON_2}U.P ${memusedP}%${S_ICON_4}"

  # ==========================

  #memtotal=$(cat /proc/meminfo | awk 'NR==1{print}' | awk '{print $2 * 1024}')
  #memfreeTemp=$(cat /proc/meminfo | awk 'NR==2{print}' | awk '{print $2 * 1024}')
  #membuffers=$(cat /proc/meminfo | awk 'NR==4{print}' | awk '{print $2 * 1024}')
  #memcached=$(cat /proc/meminfo | awk 'NR==5{print}' | awk '{print $2 * 1024}')
  #memused=$(($memtotal - $memfreeTemp - $membuffers - $memcached))
  #memusedP=$(awk -v memused=$memused -v memtotal=$memtotal 'BEGIN{printf "%0.0f", ((memused / memtotal) * 100)}')
  #memfree=$(($membuffers + $memcached + $memfreeTemp))
  #echo -e "${S_ICON_3}MEM A $(to_size_format2 $memfree 1)${S_ICON_2}U $(to_size_format2 $memused 1)${S_ICON_2}U.P ${memusedP}%${S_ICON_4}"

  # =========================

  #memtotal=$(awk -v total=$(printf "%.0f\n" $(top -b -n 1 | grep "MiB Mem" | awk '{print $4}')) 'BEGIN{printf "%0.0f", (total * 1024 * 1024)}')
  #memfreeTemp=$(awk -v free=$(printf "%.0f\n" $(top -b -n 1 | grep "MiB Mem" | awk '{print $6}')) 'BEGIN{printf "%0.0f", (free * 1024 * 1024)}')
  #memused=$(awk -v used=$(printf "%.0f\n" $(top -b -n 1 | grep "MiB Mem" | awk '{print $8}')) 'BEGIN{printf "%0.0f", (used * 1024 * 1024)}')
  #membuffcache=$(awk -v buffcache=$(printf "%.0f\n" $(top -b -n 1 | grep "MiB Mem" | awk '{print $10}')) 'BEGIN{printf "%0.0f", (buffcache * 1024 * 1024)}')

  #memfree=$(($membuffcache + $memfreeTemp))
  #memusedP=$(awk -v memused=$memused -v memtotal=$memtotal 'BEGIN{printf "%0.0f", ((memused / memtotal) * 100)}')

  #echo -e "${S_ICON_3}MEM A $(to_size_format2 $memfree 1)${S_ICON_2}U $(to_size_format2 $memused 1)${S_ICON_2}U.P ${memusedP}%${S_ICON_4}"

}


# wifi & 时间
print_wifi_datetime() {
  echo -e "${S_ICON_3}W $(get_wifi_name)${S_ICON_2}T $(get_date 1) $(get_time)${S_ICON_4}"
}

# 无线
print_wifi() {
  echo -e "${S_ICON_3}WIFI $(get_wifi_name)${S_ICON_4}"
}

# 时间
print_datetime() {
  echo -e "${S_ICON_3}DATE $(get_date 2) $(get_time)${S_ICON_4}"
}

# 磁盘使用情况
# / 磁盘
print_root_disk() {
  # 已用
  used=$(df -h | awk '{ if ($6 == "/") print $3 }')
  # 空闲
  avail=$(df -h | awk '{ if ($6 == "/") print $4 }')
  # 已用百分比
  percentage=$(df -h | awk '{ if ($6 == "/") print $5 }')

  echo -e "${S_ICON_3}ROOT A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${percentage}${S_ICON_4}"
}

# home 磁盘
print_home_disk() {
  # 已用
  used=$(df -h | awk '{ if ($6 == "/home") print $3 }')
  # 空闲
  avail=$(df -h | awk '{ if ($6 == "/home") print $4 }')
  # 已用百分比
  percentage=$(df -h | awk '{ if ($6 == "/home") print $5 }')

  echo -e "${S_ICON_3}HOME A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${percentage}${S_ICON_4}"
}

# dinge 磁盘
print_dinge_disk() {
  # 已用
  used=$(df -h | awk '{ if ($6 == "/dinge") print $3 }')
  # 空闲
  avail=$(df -h | awk '{ if ($6 == "/dinge") print $4 }')
  # 已用百分比
  percentage=$(df -h | awk '{ if ($6 == "/dinge") print $5 }')

  echo -e "${S_ICON_3}DINGE A ${avail}${S_ICON_2}U ${used}${S_ICON_2}U.P ${percentage}${S_ICON_4}"
}

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
  volume=$(amixer -M get Master | egrep 'Front Left' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')
  if  [ "$(amixer -M get Master | egrep 'Front Left' | egrep -o 'off')" = "off" ]; then
    volume="M $volume"
  fi

  # 笔记本屏幕亮度
  light=$(xbacklight -get)

  echo -e "${S_ICON_3}VOL ${volume}%${S_ICON_2}LIG ${light}%${S_ICON_4}"
}

# 音量 macos m1 vmware arm ubuntu 和 当前时间
print_volume_datetime() {
  # 音量
  volume=$(amixer -M get Master | egrep 'Mono: Playback' | egrep -o '[0-9]+%' | egrep -o '[0-9]+')
  if  [ "$(amixer -M get Master | egrep 'Mono: Playback' | egrep -o 'off')" = "off" ]; then
    volume="M $volume"
  fi

  echo -e "${S_ICON_3}VOL ${volume}%${S_ICON_2}DATE $(get_date 1) $(get_time)${S_ICON_4}"
}
# ======================================================

# 歌曲
print_song() {
  # SONG=$(./spotify.py)
  #if [[ "$SONG" == *"—"* ]]; then
  #  echo -e " ${SONG} {$S_ICON_1}"
  #else
  #  echo -e ""
  #fi

  echo -e ""
}

# 检测软件更新情况（未更新个数，已安装软件个数）
print_packages_up_info() {
  upd=`checkupdates | wc -l`
  ind=`pacman -Q | wc -l`
  if [[ $upd -ge 1 ]]; then
    echo -e "${S_ICON_3}${upd} updates${S_ICON_2}${ind} installed${S_ICON_4}"
  else
    echo -e ""
  fi
}


# ======================================================

print_status_type_1() {
    # intel / amd cpu 
    #echo -e "${S_LEFT_SPACE}$(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_wifi_datetime)${S_RIGHT_SPACE}"

    # vmware m1 arm
    echo -e "${S_LEFT_SPACE}$(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_volume_datetime)${S_RIGHT_SPACE}"
}

print_status_type_2() {
    # intel / amd cpu 
    #echo -e "${S_LEFT_SPACE}$(print_wifi_speed)${S_ICON_1}$(print_root_disk)${S_ICON_1}$(print_battery_temperature)${S_ICON_1}$(print_volume_light)${S_RIGHT_SPACE}"

    # vmware m1 arm
    echo -e "${S_LEFT_SPACE}$(print_wifi_speed)${S_ICON_1}$(print_mem)${S_ICON_1}$(print_root_disk)${S_ICON_1}$(print_volume_datetime)${S_RIGHT_SPACE}"
}









