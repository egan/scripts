#!/bin/bash

##
# xmobar-nettoggle.sh -- toggle network interface in xmobar config
#
# usage -- xmobar-nettoggle.sh
#
# written -- 19 December, 2011 by Egan McComb
#
# revised --
##

xmobarrc="$HOME/.xmobarrc"

if $(grep -q "eth0" < $xmobarrc)
then
	sed -e "s/eth0/wlan0/g" < $xmobarrc | sponge $xmobarrc
else
	sed -e "s/wlan0/eth0/g" < $xmobarrc | sponge $xmobarrc
fi

pkill -x xmobar
exec xmobar &> /dev/null &

exit 0
