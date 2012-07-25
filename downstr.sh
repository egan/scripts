#!/bin/bash

##
# downstr.sh	-- return down string
#
# usage		-- downstr.sh [GLOB]
#
# written.sh	-- 13 March, 2011 by Egan McComb
#
# revised	--
##

usage()
{
	echo "Usage: $(basename $0) [GLOB]" >&2
}

chkargs()
{
	if (( ! $# ))
	then
		dir=.
	elif (( $# > 1 ))
	then
		echo "Error: Too many arguments" >&2
		usage
		exit $ERR_NARGS
	else
		dir=$(locate -n 1 -r $PWD.\*/$1$)
	fi
}

##----MAIN----##
chkargs "$@"

if [[ -z "$dir" ]] || [[ ! -d "$dir" ]]
then
	echo "Error: No match found for '$1'" >&2
	exit $ERR_VARGS
else
	echo "$dir"
fi

exit 0
