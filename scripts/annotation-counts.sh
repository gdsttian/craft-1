#!/bin/bash

# Print the number of annotations per category for a given document.

set -e
set -u

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

# Directory to place annotation counts in
OUTPUTDIR="$CRAFTROOT/annotation-counts"

CRAFTXML="$CRAFTROOT/knowtator-xml"

echo "Writing counts to $OUTPUTDIR"
rm -rf "$OUTPUTDIR"
mkdir "$OUTPUTDIR"

for f in `ls $CRAFTXML/chebi`; do
    o=`basename ${f%.txt.knowtator.xml}`
    # CRAFT categories, excluding "sections-and-typography"
    for c in chebi cl entrezgene go_bpmf go_cc ncbitaxon pr so; do
	egrep '<annotation>' "$CRAFTXML/$c/$f" | \
	    perl -pe 's/<annotation>\s*$/'$c'\n/' | \
	    sort | uniq -c
    done | sort -rn > "$OUTPUTDIR/$o.txt"
done
