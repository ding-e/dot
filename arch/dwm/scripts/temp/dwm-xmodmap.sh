#!/bin/bash

sleep 3;

#xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
#xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group
xmodmap /home/dinge/.xmodmap &
#xmodmap ~/.xmodmap &
