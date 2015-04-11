#!/bin/bash

# Separate random 1/3 as held-out test set.

set -e
set -u

# support OSX with coreutils (no -R option to sort)
gsort=`which gsort`
if [[ ! -z $gsort ]]; then
    sort=$gsort
else
    sort=sort
fi

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

# Directory to find stratified split in
INPUTDIR="$CRAFTROOT/annotation-counts-split"

# Directory to place test / other split in
OUTPUTDIR="$CRAFTROOT/test-split"

TMPDIR=`mktemp -d extract-XXX`

function cleanup {
    rm -rf "$TMPDIR"
}
trap cleanup EXIT

# Temp copy of input data
cp -r "$INPUTDIR"/* $TMPDIR

rm -rf "$OUTPUTDIR"
mkdir -p "$OUTPUTDIR"/{train-and-devel,test}

for d in "$TMPDIR"/*; do
    # split ~33% into test, rest into train-and-devel in sequences of
    # random assignments to (train-and-devel, test, train-and-devel).
    while [[ ! -z `ls "$d"` ]]; do
	for i in `seq 3`; do
	    pick=`ls "$d" | $sort -R | head -n 1`
	    if [[ -z "$pick" ]]; then
		break
	    fi
	    if [[ $i = 2 ]]; then
		out="$OUTPUTDIR"/test
	    else
		out="$OUTPUTDIR"/train-and-devel
	    fi
	    mv "$d/$pick" "$out"
	done
    done    
done
