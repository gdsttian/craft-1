#!/bin/bash

# Split annotation count files into subdirs by the most frequent type.
# Helper for stratified sampling.

set -e
set -u

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

# Directory to find annotation counts in
INPUTDIR="$CRAFTROOT/annotation-counts"

# Directory to place split counts in
OUTPUTDIR="$CRAFTROOT/annotation-counts-split"

echo "Splitting to $OUTPUTDIR"
rm -rf "$OUTPUTDIR"
mkdir "$OUTPUTDIR"

for f in "$INPUTDIR"/*.txt; do
    majority=`sort -rn $f | head -n 1 | awk '{ print $2 }'`
    mkdir -p "$OUTPUTDIR/$majority"
    cp $f "$OUTPUTDIR/$majority"
done
