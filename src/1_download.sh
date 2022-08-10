#!/usr/bin/env bash

# Download files

localpath=$(pwd)
echo "Local path: $localpath"

downloadpath="$localpath/download"
echo "Download path: $downloadpath"
mkdir -p "$downloadpath"
cd $downloadpath;
ftpbase="ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF"
wget -r -A ttl.gz -nH --cut-dirs=3 -nc -P compound $ftpbase/compound/general
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/substance
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/descriptor
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/synonym
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/inchikey
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/bioassay
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/measuregroup
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/endpoint
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/protein
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/pathway
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/conserveddomain
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/gene
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/source
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/concept
wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/reference
echo "Download done."
