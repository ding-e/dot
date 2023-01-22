#!/bin/bash

# 根据当前文件获取绝对路径
WORKSPACE=$(dirname $(readlink -f "$0") || (cd "$(dirname "$0")";pwd))

# 导入状态的函数库
source ${WORKSPACE}/func.sh

# status bar 顯示類型
file=${WORKSPACE}/current-status-type.txt

# 当前的状态的类型number
currStatusType=$(cat ${file})

if [ $currStatusType == 2 ]; then
  # 如果当前状态number为2，则修改为1
  $(echo 1 > ${file})

  # 马上修改dwm状态
  xsetroot -name "$(print_status_type_1)"
else
  # 如果当前状态number为1，则修改为2
  $(echo 2 > ${file})

  # 马上修改dwm状态
  xsetroot -name "$(print_status_type_2)"
fi
