#!/bin/bash

##
# touchpad -- toggle touchpad, to be called by wm
#
# usage -- touchpad
#
# written -- 18 June, 2011 by Egan McComb
#
# revised --
##

if [ $(synclient -l | grep TouchpadOff | awk -F '= ' '{ print $2 }') -eq 0 ]
then
    synclient TouchpadOff=1
else
    synclient TouchpadOff=0
fi
