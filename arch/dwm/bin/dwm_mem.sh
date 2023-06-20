#!/bin/bash

# 内存信息

CURR_DIR=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))
source ${CURR_DIR}/../scripts/dwm-status/utils.sh

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
