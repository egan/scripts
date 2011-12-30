#!/bin/bash

##
# upstr -- return up string
#
# usage -- upstr [N|REGEX]
#
# written -- 13 March, 2011 by Egan McComb
#
# revised --
##

err_nargs=3
err_vargs=5

usage()
{
	echo "Usage: $(basename $0) [N|REGEX]" >&2
}

chkargs()
{
	if [ -z "$1" ]
	then
		dir=../
	elif [ $# -gt 1 ]
	then
		echo "Error: Too many arguments" >&2
		usage
		exit $err_nargs
	elif $(grep -q [^[:digit:]] <<< $1)
	then
		dir=${PWD%/$1/*}/$1
	else
		x=0
		while [ $x -lt ${1:-1} ]
		do
			dir=${DIR}../
			x=$(($x+1))
		done
	fi
}

##----MAIN----##
chkargs "$@"

if [ ! -e "$dir" ]
then
	echo "Error: No match found for '$1'" >&2
	exit $err_vargs
else
	echo "$dir"
fi

exit 0
