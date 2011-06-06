#!/bin/bash

##
# volumed.sh -- print volume changes to stdout
#
# usage -- designed for use with xmobar
#
# notes -- depends on inotify-tools and volume script
#
# written -- 14 June, 2010 by Egan McComb
#
# revised --
##

SDEVICE="/dev/snd/controlC0"

while [[ $(ps s $PPID | grep xmobar) ]]
do
	volume
	inotifywait $SDEVICE -e ACCESS -e CLOSE_WRITE > /dev/null 2> /dev/null
done
