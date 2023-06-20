#!/bin/bash

CURR_DIR=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))
source ${CURR_DIR}/../scripts/dwm-status/utils.sh

echo -e "${S_ICON_3}TIME $(get_datetime 0)${S_ICON_4}"
