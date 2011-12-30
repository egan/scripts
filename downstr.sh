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

err_nargs=3
err_vargs=5

usage()
{
	echo "Usage: $(basename $0) [REGEX]" >&2
}

chkargs()
{
	if [ -z "$1" ]
	then
		dir=.
	elif [ $# -gt 1 ]
	then
		echo "Error: Too many arguments" >&2
		usage
		exit $err_nargs
	else
		dir=$(locate -n 1 -r $PWD.*/"$1"$)
	fi
}

##----MAIN----##
chkargs "$@"

if [ -z "$dir" ]
then
	echo "Error: No match found for '$1'" >&2
	exit $err_vargs
else
	echo "$dir"
fi

exit 0
