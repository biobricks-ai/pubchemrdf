#!/usr/bin/env bash

localpath=$(pwd)
echo "Local path: $localpath"

if java --version; then
  echo "Command succeeded: java installed"
else
  sudo apt install default-jre
fi

if $HOME/rdfpro/rdfpro -v; then
  echo "Command succeeded: rdfpro installed"
else
  cd $HOME;
  wget https://knowledgestore.fbk.eu/files/rdfpro/0.6/rdfpro-dist-0.6-bin.tar.gz;
  tar xzvf rdfpro-dist-0.6-bin.tar.gz;
fi

if rapper -v; then
  echo "Command succeeded: rapper/rapter installed"
else
  sudo apt install raptor2-utils
fi

if aws --version; then
    echo "Command succeeded: awscli installed"
else
  sudo apt install unzip;
  wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip";
  unzip -o awscliv2.zip;
  sudo ./aws/install;
  sudo apt-get update;
  sudo apt-get install awscli;
fi

if R --version; then
  echo "Command succeeded: R installed"
else
  sudo apt install r-base-core
fi

if dvc --version; then
  echo "Command succeeded: dvc installed"
else
  sudo apt update;
  sudo apt install snapd;
  sudo snap install dvc --classic;
fi


# Download files
downloadpath="$localpath/download"
echo "Download path: $downloadpath"
mkdir -p "$downloadpath"
cd $downloadpath;
ftpbase="ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF"
wget -r -A ttl.gz -nH --cut-dirs=3 -nc -P compound $ftpbase/compound/general
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/substance
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/descriptor
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/synonym
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/inchikey
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/bioassay
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/measuregroup
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/endpoint
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/protein
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/pathway
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/conserveddomain
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/gene
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/source
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/concept
# wget -r -A ttl.gz -nH --cut-dirs=2 -nc $ftpbase/reference
echo "Download done."

# Unzip files
temppath="$localpath/temp"
mkdir -p $temppath
echo "Temporal path: $temppath"

datapath="$localpath/data"
mkdir -p $datapath
echo "Data path: $datapath"

cd $downloadpath
find . -type d > $temppath/dirs.txt
find . -type f -name '*.ttl.gz' | cut -c 2- | cut -f 1 -d '.' | sort > $temppath/files.txt
# tail -n +40 $temppath/files.txt > $temppath/files.txt

cd $datapath
xargs mkdir -p < $temppath/dirs.txt
cd $localpath

head -n 40 $temppath/files.txt | xargs -P20 -n1 bash -c '
gunzip -c '$downloadpath'$1.ttl.gz > '$datapath'$1.ttl; 
rapper -i turtle -o nquads '$datapath'$1.ttl > '$datapath'$1.nquads;
rm '$datapath'$1.ttl;
python src/nquads2parquet.py '$datapath'$1.nquads;
rm '$datapath'$1.nquads;
rm '$datapath'$1.csv;
' {}
# for filename in `cat $temppath/downloadedfiles.txt`; do
#   ttlname=${filename%.*}
#   ttlname=${ttlname:2}

#   if test -f "$ttlpath/$ttlname"; then
#     echo "File $ttlpath/$ttlname already unzipped."
#   else
#     echo "Unziping file: $filename"
#     gunzip -c $downloadpath/$filename > $ttlpath/$ttlname;
#     echo "Unziping file: $filename"
#     #rapper rapper -i turtle -o nquads $rawname > ./temp/pc_compound2component.nquads
#   fi
# done

# Get data ready to parse and serialize in parquet by Py
# datapath="$localpath/data"
# echo "Data path: $datapath"
# mkdir -p $datapath
# cd $datapath
# xargs mkdir -p < $temppath/dirs.txt
# cd $rawpath
# find . -type f -name '*.ttl' | sort > $temppath/unzipedfiles.txt
