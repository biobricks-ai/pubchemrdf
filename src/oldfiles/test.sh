#!/usr/bin/env bash

localpath=$(pwd)
rawpath="$localpath/raw"
rapper test.ttl -q -w -i 'turtle' -o 'ntriples' > $rawpath/testfile.rdf
# rapper $rawpath/compound/general/pc_compound2component.ttl -i 'turtle' -o 'ntriples' -O file://$rawpath/testfile.rdf