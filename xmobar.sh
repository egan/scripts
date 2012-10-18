#!/bin/bash

for pid in $(pgrep xmobar)
do
	kill $pid > /dev/null &
done

/usr/bin/xmobar &
