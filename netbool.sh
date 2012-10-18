#!/bin/bash

##
# netbool.sh	-- check for proper Internet connectivity
#
# usage		-- netbool.sh
#
# notes		-- designed for use in other scripts
#
# todo		-- more elegant way to do this?
#
# written	-- 29 December, 2011 by Egan McComb
#
# revised	--
##

if ping -c 1 $(ip route | awk '/default/ { print $3 }') &> /dev/null
then
	exit 0
else
	exit 1
fi
