from rdfpandas.graph import to_dataframe
from rdflib import Graph
import pandas as pd
import os
import csv

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
    print("File: " + FileParquet)
    print("Parsing ...")
    g.parse(location=FileRaw, format="ttl")

    print("Saving parquet ...\n")
    df = to_dataframe(g)
    df.to_parquet(FileParquet)
   
    # print("Serialiazing ...")
    # g.serialize(destination="./temp/serialfile.txt", format="ntriples", encoding="utf-8")
    # print("Reading CSV ...")
    # df = pd.read_csv("./temp/serialfile.txt", names=['subject', 'predicate', 'object'], delimiter=' ', engine='python')
    # print("Saving parquet ...\n")
    # df.to_parquet(FileParquet)
    
    if count == 2:
        break

print(f"Parquet files saved: {count}")

