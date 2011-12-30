#!/bin/bash

##
# upstr.sh	-- return up string
#
# usage		-- upstr.sh [N|UPDIR]
#
# written	-- 13 March, 2011 by Egan McComb
#
# revised	--
##

usage()
{
	echo "Usage: $(basename $0) [N|UPDIR]" >&2
}

chkargs()
{
	if (( ! $# ))
	then
		dir=../
	elif (( $# > 1 ))
	then
		echo "Error: Too many arguments" >&2
		usage
		exit $ERR_NARGS
	elif $(grep -q [^[:digit:]] <<< "$1")
	then
		dir="${PWD%/$1/*}/$1"
	else
		x=0
		while (( $x < ${1:-1} ))
		do
			dir="${dir}../"
			((x++))
		done
	fi
}

##----MAIN----##
chkargs "$@"

if [[ ! -d "$dir" ]]
then
	echo "Error: No match found for '$1'" >&2
	exit $ERR_VARGS
else
	echo "$dir"
fi

exit 0
