#!/bin/bash

##
# userbool.sh	-- parse boolean user input
#
# usage		-- userbool INPUT
#
# notes		-- designed for use in other scripts
#
# todo		-- add safeguards
#
# written	-- 29 December, 2011 by Egan McComb
#
# revised	--
##

##----MAIN----##
if [[ $1 = "Y" ]] || [[ $1 = "y" ]]
then
	exit 0
else
	exit 1
fi
