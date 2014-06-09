#!/bin/bash

##
# openrecentpdf.sh -- open latest pdf file in ~/var
#
# usage            -- openrecentpdf.sh
#
# notes            -- designed for use from window manager
#
# written          -- 8 June, 2014 by Egan McComb
#
# revised          --
##

exec zathura "$(find ~/var/*.{pdf,PDF} -maxdepth 1 -type f -printf '%T@ %p\n' 2> /dev/null | sort -n | tail -1 | cut -d ' ' -f 2-)" &> /dev/null
exit 0
