#!/bin/bash

##
# downstr.sh -- return down string
#
# usage      -- downstr.sh [SEARCH]
#               SEARCH is a string of regexes
#               specifying parts of the desired path
#
# written.sh -- 13 March, 2011 by Egan McComb
#
# revised    --
##

usage()
{
	echo "Usage: $(basename $0) [GLOB]" >&2
	echo -e "\t-SEARCH is a string of regexes" >&2
	echo -e "\t specifying parts of the desired path" >&2
}

chkargs()
{
	if (( ! $# ))
	then
		dir=.
	else

		dir=$(locate -n 1 -r $PWD.\*/$1$)
	fi
}

mkglob()
{
	glob="$PWD"
	for token in "$@"
	do
		glob="$glob.*/$token"
	done
	glob="$glob$"
}

##----MAIN----##
chkargs "$@"
mkglob "$@"

dir=$(locate -n 1 -r $glob)

if [[ -z "$dir" ]] || [[ ! -d "$dir" ]]
then
	echo "Error: No match found for '$@'" >&2
	exit $ERR_VARGS
else
	echo "$dir"
fi

exit 0
