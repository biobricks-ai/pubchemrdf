import pandas as pd
import sys
import csv
import os

FileName = sys.argv[1]
FileNameCSV = os.path.splitext(FileName)[0] + ".csv"
FileNameParquet = os.path.splitext(FileName)[0] + ".parquet"

print(f"nquads2parquet: Creating CSV file {FileNameCSV}")
File = open(FileName, 'r')
Data = File.read()
File.close()

Data = Data.replace("> <", ">\t<")
Data = Data.replace("> \"", ">\t\"")
Data = Data.replace(" .", "")
Data = Data.replace("\"@en", "\"")
Data = Data.replace("\\\"", "_")

CSVFile = open(FileNameCSV, "wt")
CSVFile.write(Data)
CSVFile.close()

print(f"nquads2parquet: Creating parquet file {FileNameParquet}")
df = pd.read_csv(FileNameCSV, names=['subject', 'predicate', 'object'], 
    delimiter='\t', engine='python', quoting=csv.QUOTE_ALL)
df.to_parquet(FileNameParquet)