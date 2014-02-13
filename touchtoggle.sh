#!/bin/bash

##
# touchtoggle.sh -- toggle touchpad and cursor
#
# usage          -- touchtoggle.sh
#
# notes          -- designed for use from window manager
#
# written        -- 12 February, 2014 by Egan McComb
#
# revised        --
##

# Toggle unclutter.
pgrep unclutter > /dev/null && pkill unclutter || unclutter -noevents -idle 0 &
# Toggle touchpad.
$(synclient -l | grep -q 'Off *= 0') && synclient TouchpadOff=1 || synclient TouchpadOff=0

exit 0
