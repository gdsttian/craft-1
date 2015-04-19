#!/bin/bash

# Run parameter selection for separated standoff data.

set -e
set -u

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

INPUTDIR="$CRAFTROOT/train-and-devel-standoff-separated"

OUTPUTDIR="$CRAFTROOT/parameter-selection-results"

NOHUPDIR="nohup"

RANDOMSEED="0c31e182-0d8a-40d8-94da-b2e1aa41ec8f"

EVALUATOR="$HOME/git_checkout/semsuite/semsuite eval -a -x 10 -r $RANDOMSEED"

rm -rf "$OUTPUTDIR"
mkdir "$OUTPUTDIR"

mkdir -p "$NOHUPDIR"

for d in "$INPUTDIR"/*; do
    t=`basename $d`
    o="$OUTPUTDIR/${t}-results.txt"
    n="$NOHUPDIR/nohup.out.$t.parameters"
    nohup $EVALUATOR \
	-c2 '(2**{5..-10..-1})' \
	-b 'B-*:{-5..5..0.5}' \
	"$d" > "$o" 2>"$n" &
done
