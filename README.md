# tmine

## Project package for BCB410 Applied Bioinformatics

This project revolves around a Tf-Idf (Term Frequency, Inverse Document Frequency) package for abstracts of scientific papers taken from PubMed.  This package provides data structures and functions to ease and simplify data transformations surrounding Tf-Idf processes, and provides direct transformations onto PubMed documents.  This package is designed for extensive console programming and experimentation.

Install with ```devtools::install_github("jlee118/tmine")```

The 'example' folder houses a workflow script with explanations on what the various functions do.  Please note that prior to the usage of most of the functions, the basic 'get_pubmed_abstract()' function must be called first to populate a dataframe with text data of abstracts searched from PubMed.

The Shiny application is housed in the "shiny" folder, and contains a visualization of the TF-IDF word plots for a group of papers searched on PubMed.  The visualization is customizable and switchable between various papers.  
