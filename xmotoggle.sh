#!/bin/bash

##
# xmobar-nettoggle.sh	-- toggle active network interface in xmobar
#
# usage			-- xmobar-nettoggle.sh
#
# notes			-- designed for use from window manager
#
# written		-- 19 December, 2011 by Egan McComb
#
# revised		--
##

xmobarrc="$HOME/.xmobarrc"

if grep -q eth0 < $xmobarrc
then
	sed -i "s/eth0/wlan0/g" "$xmobarrc" || exit 1
else
	sed -i "s/wlan0/eth0/g" "$xmobarrc" || exit 1
fi

pkill -x xmobar
exec xmobar &> /dev/null &

exit 0
