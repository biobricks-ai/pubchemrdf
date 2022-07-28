#!/usr/bin/env bash

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

## User Input for location to download:
echo "Include user external download location: ex. /path/to/download/";
read user_path;
dir='ftp.ncbi.nlm.nih.gov'
output_path=$user_path;

cd $output_path;
mkdir -p $output_path
if [ "$(ls -A $output_path)" ]; then
   echo "$output_path is not Empty"
   ## Generate list of turtle files: Excluding compounds
   sudo find . -type f -name '*.ttl.gz' | grep -v '/RDF/compound/' > $HOME/file_conversion.txt
else
  sudo wget -m -r -N -p -S ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/
fi

## Combine RDF files located from same directory:
for i in `cat download/file_conversion.txt`; do
  gzip -d $i;
  #rapper $i;
  #rdfpro $i
done
