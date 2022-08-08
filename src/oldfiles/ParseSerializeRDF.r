pacman::p_load(tidyverse, biobricks, arrow, future, magrittr)

# workers <- 20 # how many threads we will use
# future::plan(tweak(multicore, workers = workers))

write_parquet <- function(ttlfile) {
  sparql <- "SELECT * WHERE { ?subject ?predicate ?object . }"
  print("Parsing ...")
  rdf <- rdflib::rdf_parse(ttlfile, format = "turtle")
  print("Converting to dataframe ...")
  tbl <- rdflib::rdf_query(rdf, sparql, data.frame = TRUE)
  parquetfile <- gsub(".ttl", ".parquet", ttlfile)
  parquetfile <- gsub("raw", "data", parquetfile)
  print("Writing parquet ...")
  arrow::write_parquet(tbl, parquetfile)
}

files <- readr::read_lines("./temp/unzipedfiles.txt") %>% gsub("^\\.", "raw", .)

walk(files, function(file) {
  # future({
    write_parquet(file)
  # })
})
