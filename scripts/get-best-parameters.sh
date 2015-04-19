#!/bin/bash

# Get best parameters from parameter selection run outputs.

# Run after select-parameters.sh

set -e
set -u

# Matching criterion, one of --exact, --left, --right, --overlap
MATCHING_CRITERION="--right"

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

INPUTDIR="$CRAFTROOT/parameter-selection-results"

OUTPUT="$INPUTDIR/best-parameters.txt"

EVALUATOR="$HOME/git_checkout/semsuite/tools/parameters/best-parameters.py $MATCHING_CRITERION"

for f in "$INPUTDIR"/*-results.txt; do
    c=`basename "$f"`
    c=${c/-results.txt/}
    echo -n "$c"$'\t'
    $EVALUATOR $f
done | tee "$OUTPUT"
