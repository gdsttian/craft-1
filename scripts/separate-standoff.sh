#!/bin/bash

# Split standoff annotations into different files by annotation type.

set -e
set -u

# http://stackoverflow.com/a/246128
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

CRAFTROOT="$SCRIPTDIR/.."

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 DIRECTORY"
    exit 1
fi
INPUTDIR=$1

if [[ ! -d "$INPUTDIR" ]]; then
    echo "Error: no a directory: $INPUTDIR"
    exit 1
fi

INPUTDIR=${INPUTDIR%/}
OUTPUTDIR="${INPUTDIR}-separated"

for t in SO GO_BP PR EntrezGene GO_CC CHEBI NCBITaxon CL GO_MF; do
    d="$OUTPUTDIR/$t"
    rm -rf "$d"
    mkdir -p "$d"
    cp "$INPUTDIR"/*.txt "$d"
    for f in "$INPUTDIR"/*.ann; do 
	egrep '^[^[:space:]]+[[:space:]]'$t' ' $f > "$d"/`basename $f` || true
    done
done
