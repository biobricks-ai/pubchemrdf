# PubChemRDF

<a href="https://github.com/biobricks-ai/PubChemRDF/actions"><img src="https://github.com/biobricks-ai/PubChemRDF/actions/workflows/bricktools-check.yaml/badge.svg?branch=main"/></a>

## Description

RDF constitutes a family of World Wide Web Consortium (W3C) specifications for data interchange on the Web. RDF breaks down knowledge into machine-readable discrete pieces, called “triples.” Each “triple” is organized as a trio of ‘subject-predicate-object’. For example, in the phrase “atorvastatin may treat hypercholesterolemia,” the subject is “atorvastatin”, the predicate is “may treat”, and the object is “hypercholesterolemia.” RDF uses a Uniform Resource Identifier (URI) to name each part of the “subject-predicate-object” triple. A URI looks just like a typical web URL. RDF is a core part of semantic web standards. As an extension of the existing World Wide Web, the semantic web attempts to make it easier for users to find, share, and combine information. Semantic web leverages the following technologies: extensible markup language (XML), which provides syntax for RDF; web ontology language (OWL), which extends the ability of RDF to encode information; resource description framework (RDF), which expresses knowledge; and RDF query language (SPARQL), which enables query and manipulation of RDF content.

PubChem users have frequently expressed interest in having a downloadable database. Using PubChemRDF, one can download the desired RDF formatted data files from the PubChem FTP site, import them into a triplestore, and query using a SPARQL query interface. Together these tools enable the schema-less database access and query. There are a number of open-source and commercial triplestores such as the Apache Jena TDB and OpenLink Virtuoso (a list can be found here: http://en.wikipedia.org/wiki/Triplestore). Other than triplestores, PubChemRDF data can also be loaded into RDF-aware graph databases such as Neo4j, and the graph traversal algorithms can be used to query the RDF graphs. And last but not least, the ontological representation of the PubChem knowledge base allows logical inference, such as forward/backward chaining. The RDF data on the PubChem FTP site is arranged in such a way that you only need to download the type of information in which you are interested, thus allowing you to avoid downloading parts of PubChem data you will not use. For example, if you are just interested in computed chemical properties, you only need to download PubChemRDF data in the compound descriptor directory. In addition to bulk download, PubChemRDF also provides programmatic data access through RESTful interface.

PubChem RDF Documentation
https://pubchemdocs.ncbi.nlm.nih.gov/rdf


## Usage
```{R}
biobricks::install_brick("pubchemrdf")
biobricks::brick_pull("pubchemrdf")
pubchem <- brick_load_arrow("pubchemrdf")
```
