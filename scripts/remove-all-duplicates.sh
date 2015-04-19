#!/bin/bash

# Remove duplicates from separated standoffs.

set -e
set -u

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

INPUTDIR="$CRAFTROOT/train-and-devel-standoff-separated"

OUTPUTDIR="$CRAFTROOT/train-and-devel-standoff-separated-deduplicated"

rm -rf "$OUTPUTDIR"
mkdir "$OUTPUTDIR"

for d in `find "$INPUTDIR"/* -type d`; do
    od="$OUTPUTDIR"/`basename "$d"`
    mkdir -p "$od"
    # copy over text files without change
    cp "$d"/*.txt "$od"
    # run remove-duplicates on annotation files
    for f in `find "$d" -type f -name '*.ann'`; do
	python "$SCRIPTDIR/remove-duplicates.py" "$f" > "$od"/`basename $f`
    done
done
