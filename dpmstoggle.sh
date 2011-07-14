#!/bin/bash

##
# dpmstoggle.sh -- toggle dpms and X screen blanking
#
# usage -- dpmstoggle.sh
#
# written -- 13 July, 2011 by Egan McComb
#
# revised --
##

LOCKFILE=/tmp/dpms.lock

if [ ! -e $LOCKFILE ]
then
	xset -dpms
	xset s off
	touch $LOCKFILE
else
	xset +dpms
	xset s on
	rm $LOCKFILE
fi

exit 0
