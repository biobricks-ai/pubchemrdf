# from rdfpandas.graph import to_dataframe
from rdflib import Graph
import pandas as pd
import os
import csv
from os.path import exists

LocalPath = os.getcwd()
print("Local path: " + LocalPath)
DataPath = LocalPath + "/data"
print("Data path: " + DataPath)
RawPath = LocalPath + "/raw"
print("Raw path: " + RawPath)

File = open('./temp/unzipedfiles.txt', 'r')
Lines = File.readlines()

g = Graph()

count = 0
for FileName in Lines:
    count += 1
    FileRaw = RawPath + FileName[1:]
    FileParquet = FileName[1:]
    FileParquet = DataPath + FileParquet[:-5] + ".parquet"

    if exists(FileParquet) :
        print(f"File {count}: {FileParquet} already exists.")
        continue

    print(f"File {count}: {FileParquet}")
    print("Parsing ...")
    g.parse(location=FileRaw, format="ttl")
   
    print("Serialiazing ...")
    g.serialize(destination="./temp/serialfile.txt", format="ntriples", encoding="utf-8")
    SerialData = g.serialize(format="ntriples", encoding=None)

    # Some fields in ntriples have spaces and qoutes
    # This convert ntriples to tab separeted file 
    SerialData = SerialData.replace("> <", ">\t<")
    SerialData = SerialData.replace("> \"", ">\t\"")
    SerialData = SerialData.replace(" .", "")
    SerialData = SerialData.replace("\"@en", "\"")
    SerialData = SerialData.replace("\\\"", "_")
    SerialFile = open("./temp/serialfile.txt", "wt")
    SerialFile.write(SerialData)
    SerialFile.close()

    print("Reading CSV ...")
    df = pd.read_csv("./temp/serialfile.txt", names=['subject', 'predicate', 'object'], 
        delimiter='\t', engine='python', quoting=csv.QUOTE_ALL)
    print("Saving parquet ...\n")
    df.to_parquet(FileParquet)

print(f"Parquet files saved: {count}")



# print("Saving parquet ...\n")
# df = to_dataframe(g)
# df.to_parquet(FileParquet)
