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

ERR_NARGS=3
ERR_VARGS=5

usage()
{
	echo "Usage: $(basename $0) [N|REGEX]" >&2
}

chkargs()
{
	if [ -z "$1" ]
	then
		DIR=../
	elif [ $# -gt 1 ]
	then
		echo "Error: Too many arguments" >&2
		usage
		exit $ERR_NARGS
	elif $(grep -q [^[:digit:]] <<< $1)
	then
		DIR=${PWD%/$1/*}/$1
	else
		x=0
		while [ $x -lt ${1:-1} ]
		do
			DIR=${DIR}../
			x=$(($x+1))
		done
	fi
}

##----MAIN----##
chkargs "$@"

if [ ! -e "$DIR" ]
then
	echo "Error: No match found for '$1'" >&2
	exit $ERR_VARGS
else
	echo "$DIR"
fi

exit 0
