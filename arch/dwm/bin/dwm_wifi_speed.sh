#!/bin/bash

# wifi 上/下行速度

CURR_DIR=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))
source ${CURR_DIR}/../scripts/dwm-status/utils.sh

up_tmp1=$(ifconfig ${WIFI_DEVICE} | grep "TX packets" | awk '{print $5}')
down_tmp1=$(ifconfig ${WIFI_DEVICE} | grep "RX packets" | awk '{print $5}')

sleep 1
# clear

up_tmp2=$(ifconfig ${WIFI_DEVICE} | grep "TX packets" | awk '{print $5}')
down_tmp2=$(ifconfig ${WIFI_DEVICE} | grep "RX packets" | awk '{print $5}')

up=$(expr $up_tmp2 - $up_tmp1)
down=$(expr $down_tmp2 - $down_tmp1)

echo -e " ${S_ICON_3}SPE D $(size_format $down 0)/s${S_ICON_2}U $(size_format $up 0)/s${S_ICON_4}"
