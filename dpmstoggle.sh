#!/bin/bash

##
# dpmstoggle.sh -- toggle dpms and X screen blanking
#
# usage         -- dpmstoggle.sh
#
# notes         -- designed for use from window manager
#               -- determines dpms status using lockfile
#
# written       -- 13 July, 2011 by Egan McComb
#
# revised       --
##

lockfile="/tmp/dpms.lock"

if [[ ! -e "$lockfile" ]]
then
	xset s off -dpms
	touch "$lockfile"
else
	xset s on +dpms
	rm "$lockfile"
fi

exit 0
