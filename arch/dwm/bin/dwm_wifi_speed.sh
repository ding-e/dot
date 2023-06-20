#!/bin/bash

# wifi 上/下行速度

CURR_DIR=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))
source ${CURR_DIR}/../scripts/dwm-status/utils.sh

up_time1=$(ifconfig ${WIFI_DEVICE} | grep "TX packets" | awk '{print $5}')
down_time1=$(ifconfig ${WIFI_DEVICE} | grep "RX packets" | awk '{print $5}')

sleep 1
# clear

up_time2=$(ifconfig ${WIFI_DEVICE} | grep "TX packets" | awk '{print $5}')
down_time2=$(ifconfig ${WIFI_DEVICE} | grep "RX packets" | awk '{print $5}')

up_time=$(expr $up_time2 - $up_time1)
down_time=$(expr $down_time2 - $down_time1)

echo -e " ${S_ICON_3}SPE D $(size_format $down_time 0)/s${S_ICON_2}U $(size_format $up_time 0)/s${S_ICON_4}"
