#!/bin/bash

result=$(ps ax|grep -v grep|grep trayer)
if [ "$result" == "" ]; then
  # dwm status top
  #eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 20 --height 20 --distance 2 --margin 2 --padding 5 --iconspacing 5 --SetDockType false --tint 0x2E3440 &"

  # dwm status bottom 
#  eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 20 --height 20 --distance 19 --margin 2 --padding 5 --iconspacing 5 --SetDockType false --tint 0x2E3440 &"

  #eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype pixel --width 112 --height 16 --distance 2 --margin 2 --padding 5 --iconspacing 5 --SetDockType false --tint 0x2E3440 &"

  #eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 112 --height 16 --distance 2 --margin 2 --padding 5 --iconspacing 5 --SetDockType false --tint 0x2E3440 &"
  #eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 112 --height 16 --distance 19 --margin 2 --padding 5 --iconspacing 5 --SetDockType false --tint 0x2E3440 &"

  # --- Nord ---
  #eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 112 --height 16 --distance 2 --margin 2 --padding 5 --iconspacing 5 --SetDockType false --tint 0x2E3440 &"

  # --- Win95 ---
  #eval  "trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 112 --height 16 --distance 2 --margin 2 --padding 5 --iconspacing 8 --SetDockType false --tint 0x000000 &"
  #eval  "firejail --net=none trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 112 --height 16 --distance 2 --margin 2 --padding 5 --iconspacing 8 --SetDockType false --tint 0x000000 &"

  eval  "firejail --net=none trayer --transparent true --alpha 0 --expand false --edge bottom --align right --widthtype request --width 112 --height 16 --distance 18 --margin 2 --padding 5 --iconspacing 8 --SetDockType false --tint 0x000000 &"

else
  killall trayer
fi

# -h 打印帮助消息并退出
# -v 打印版本并退出
#	--edge 					要使用<left | right | top | bottom>的屏幕边缘
#	--align					对齐<left | center | right>
#	--margin				边距长度（以像素为单位）
#	--distance			出纸器的窗口和屏幕边缘之间的空间
#	--distancefrom	指定要计算距离的边，请参见上文。

#	--widthtype			如何计算面板宽度：
#    	request			遵循小部件的尺寸请求。可以动态缩小或增长
#			pixel				占用固定的像素数，然后'width'变量保存一个数字
#			percent			是边缘的“宽度”百分比
#	--width					面板的宽度（不适用于--widthtype = request）

#	--heighttype		如何调整面板高度：
#			pixel				占用固定像素数，然后是“ height”变量  拥有一个号码
#	--height				面板的高度，以像素为单位

#	--SetDockTpe		将面板窗口类型标识为停靠<true | false>
#	--SetPartialStrut		保留面板的空间，使其不会被 最大化的窗口<true | false>

#	--transparent		使用透明度<true | false>
#	--tint					用于“着色”背景墙纸的颜色 
#	--alpha					透明度的百分比<0-256>

#	--expand				指定出纸器是否可以容纳额外的空间  是否<true | false>
#	--padding				托盘程序窗口框架和停靠的图标之间的额外空间
#	--monitor				定义要在其上显示拖拉工具的Mointor， 零数到监视器数减去一， 或字符串“ primary”。
#	--iconspacing		托盘图标之间的间隔，以像素为单位。
