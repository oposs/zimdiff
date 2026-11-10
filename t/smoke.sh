#!/bin/sh
# compile the script against the modules in thirdparty and check --version
set -e
${PERL:-perl} -c "$srcdir/bin/zimdiff"
"$srcdir/bin/zimdiff" --version | grep -q '^zimdiff '
