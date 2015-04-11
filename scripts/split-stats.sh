#!/bin/bash

# Print statistics for a split.

set -e
set -u

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

# Directory to find split in
SPLITDIR="$CRAFTROOT/test-split"

# Split dataset part names
n1=`ls $SPLITDIR | head -n 1`
n2=`ls $SPLITDIR | tail -n 1`

# Document counts
c1=`ls "$SPLITDIR/$n1" | wc -l`
c2=`ls "$SPLITDIR/$n2" | wc -l`

echo $n1 $c1 $n2 $c2

for n in $n1 $n2; do
    if [[ "$n" = "$n1" ]]; then
	r="1.*$c2/($c1+$c2)"
    else
	r="1.*$c1/($c1+$c2)"
    fi
    total=`cat "$SPLITDIR/$n"/* | awk '{ t+=$1 } END { print t }'`
    echo $n adjusted total `echo "$total * $r" | bc`
    cat "$SPLITDIR/$n"/* | perl -e '
        while(<>) { die "ERROR" unless(/^\s*(\d+)\s+(\S+)\s*$/); $t{$2}+=$1 }
        END { foreach $k (sort keys %t) { $r=$t{$k}*'"$r"'; print "$k $r\n" } }'
    echo
done
