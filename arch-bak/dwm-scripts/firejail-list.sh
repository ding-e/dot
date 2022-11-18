#!/bin/bash

# 记录老的分隔符
IFS_old=$IFS
# 以换行符作为分隔符
IFS=$'\n'

firejaillist=$(firejail --list)

temp="FIREJAIL LIST
----------------"
linenum=0
lennum=0
for line in $firejaillist
do
    # 获取每一行总字符数
    len=$(echo ${line} | wc -m)
    # 计算总字符数
    lennum=$[$lennum+$len]
    # 计算行数
    linenum=$[$linenum+1]
done
# 计算字符平均值 - 用于每一行的最大字符个数
maxnum=$[$lennum/$linenum]
# 如果小于80个字符，则默认最大字符个数为80
if [ $maxnum -lt 80 ]; then
    maxnum=80
fi

# ------------

for line in $firejaillist
do
    # 当过当前行是trayer，则删除trayer后面的字符
    if [ "$(echo $line | egrep 'trayer')" != '' ]; then
        trayermaxlen=$[$(echo "$line" | awk '{printf("%d\n", match($0, "trayer"))}')+5]
        line=${line:0:$trayermaxlen}
    fi

    # 获取每一行总字符数
    len=$(echo ${line} | wc -m)

    # 限制每一行的字符个数
    if [ $len -gt $maxnum ]; then
        line=${line:0:$maxnum}"..."
    fi

    # 合并每一行
    if [ "$temp" != "" ]; then
        temp=$temp"
"$line
    else
        temp=$line
    fi
done

# ------------

# 分隔符改回去 不影响下次使用
IFS=$IFS_old

#notify-send "$(firejail --list)"
#echo -e $temp
notify-send "${temp}"

