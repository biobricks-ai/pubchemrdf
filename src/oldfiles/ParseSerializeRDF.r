infile <- system.file("extdata", "test.ttl", package = "redland")
rdf <- rdf_parse(infile)

sparql <-
" SELECT *
  WHERE {
    ?subject ?predicate ?object .
  }
"
df <- rdf_query(rdf, sparql, data.frame = TRUE)
