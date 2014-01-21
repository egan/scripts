#!/bin/bash

##
# volumed.sh -- print changes in volume to stdout
#
# usage      -- volumed.sh
#
# notes      -- requires inotify-tools and volume
#            -- designed for use from xmobar
#
# written    -- 14 June, 2010 by Egan McComb
#
# revised    --
##

sdevice="/dev/snd/controlC0"

while $(ps s $PPID | grep -q xmobar)
do
	volume
	inotifywait $sdevice -e ACCESS -e CLOSE_WRITE &> /dev/null
done

exit 0
