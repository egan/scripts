#!/bin/bash

##
# downstr -- return down string
#
# usage -- downstr [REGEX]
#
# written -- 13 March, 2011 by Egan McComb
#
# revised --
##

ERR_NARGS=3
ERR_VARGS=5

usage()
{
	echo "Usage: $(basename $0) [REGEX]" >&2
}

chkargs()
{
	if [ -z "$1" ]
	then
		DIR=.
	elif [ $# -gt 1 ]
	then
		echo "Error: Too many arguments" >&2
		usage
		exit $ERR_NARGS
	else
		DIR=$(locate -n 1 -r $PWD.*/"$1"$)
	fi
}

##----MAIN----##
chkargs "$@"

if [ -z "$DIR" ]
then
	echo "Error: No match found for '$1'" >&2
	exit $ERR_VARGS
else
	echo "$DIR"
fi

exit 0
