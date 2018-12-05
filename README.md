# tmine

## Project package for BCB410 Applied Bioinformatics

This project revolves around a Tf-Idf (Term Frequency, Inverse Document Frequency) package for abstracts of scientific papers taken from PubMed.  This package provides data structures and functions to ease and simplify data transformations surrounding Tf-Idf processes, and provides direct transformations onto PubMed documents.  

This package is designed for extensive console programming and experimentation with scientific papers.  The goal of this package is to provide a broad overview and visualization of text data prior to any extensive model building.  

Install with ```devtools::install_github("jlee118/tmine")```

Please note that prior to the usage of most of the functions, the basic 'get_pubmed_abstract()' function must be called first to populate a dataframe with text data of abstracts searched from PubMed.

The Shiny application is housed in the "shiny" folder, and contains a visualization of the TF-IDF word plots for a group of papers searched on PubMed.  The visualization is customizable and switchable between various papers.

## Dependencies
```
    easyPubMed,
    pubmed.mineR,
    plyr,
    tm,
    ggplot2,
    visualTest,
    proto,
    DT,
    shiny
```
## Basic Workflow

```

# This is an example script of what a normal workflow with this package
# Tf-Idf Uses: Please Read!
# The tf-idf model is designed for quick text mining on a SMALL (default set to 20) subset of documents.  This model doesn't reflect grammar structure, attention, or any sophisticated features found on higher end neural network language models.
# This model also works better on a more focused group of documents, for example a search on a specific research subarea.  Searches like "plant biology" or "cancer" have far too many different papers, research areas, and therefore words
# associated with them, this will cause large amounts of sparsity in the model, making it useless.
# What the model is good for is quick identification of "key" or "important terms", and to some extent, "important documents",  on a small group of documents containing short text (hence why abstracts are chosen).
# This model is routinely used in text-based searches in different avenues, and is often good at providing a general overview on text data, or refining search results
# This package aims to eliminate the large amount of data transoformations usually required to perform small tasks.  This one data structure can provide easier exploration and scripting uses while providing general visualisations with ease.




# Pick a query term.  Searching for generic terms is quite straightforward, however searching for additional fields including author names, publish dates, journals, would require one to research on PubMed's query formulation for advanced searches.
# Here is a link for advanced search syntax https://www.ncbi.nlm.nih.gov/pubmed/advanced
# For now, we start with simple searches, this will take a few seconds

abstracts_df <- get_pubmed_abstracts("cancer stem cells")
names(abstracts_df)
# [1] "pmid"     "doi"      "title"    "abstract" "year"     "month"    "day"      "jabbrv"   "journal"  "address"  "email"    "fullname"

# Here is a sample abstract
abstracts_df$abstract[1]

# [1] "Long non-coding RNAs (lncRNAs) have been identified to exert crucial roles in tumorigenesis and can serve as novel biomarkers for cancer therapy including lung cancer. Cisplatin is a first-line chemotherapeutic agent in non-small cell lung cancer (NSCLC), but the therapeutic effect is unsatisfactory, partly due to drug resistance. Emerging evidence showed that chemo-resistance is associated with acquisition of cancer stem cell (CSC)-like properties. Cisplatin resistance remains a major obstacle in the treatment of lung cancer, and its mechanism is still not fully elucidated. Meanwhile, CSCs have been involved in tumor metastasis, tumor recurrence and chemotherapy resistance. So far, the mechanism of nuclear enriched abundant transcript 1 (NEAT1) in modulating CSCs in lung cancer remains barely known. Therefore, we aimed to explore the correlation between NEAT1 and cancer stem cells in lung cancer. In our current study, we observed that CSC-like traits were much more enriched in cisplatin-resistant A549/CDDP cells. In addition, NEAT1 was obviously up-regulated in A549/CDDP cells compared with parental A549 cells. Knockdown of NEAT1 decreased the CSC-like properties of A549/CDDP cells through inhibiting tumor cell sphere volume, repressing CSC-like biomarkers levels and restraining CD44 positive cell ratios. Oppositely, overexpression of NEAT1 enhanced the stemness respectively. Moreover, it has been reported that Wnt pathway is implicated in many vital cellular functions including cancer stem cells. Here, it was exhibited that Wnt signal pathway was inactivated by knockdown of NEAT1 whereas activated by NEAT1 overexpression in A549/CDDP cells. Taken these together, it was indicated that NEAT1 could exert a novel biological role in NSCLC chemo-resistance."
# Now we add tf-idf weights.  The package was designed to minimize data transformations to allow for adding vectors.  We will continue to add features to this data structure to ease the text exploration process
abstracts_with_tfidf <- append_tfidf(abstracts_df)

#Here is what the beginning one tf-idf vector looks like
abstracts_with_tfidf$tf_idf[1][[1]][1:10]

# a549  a549 cells    abundant acquisition   activated    addition       agent       aimed  associated      barely
# 5.5451774   2.3025851   2.3025851   2.3025851   1.6094379   1.3862944   1.6094379   2.3025851   0.2231436   2.3025851

# There are many words, around 1000 or more
# Once the tf-idf vectors are loaded, one can do other types of analysis.  Functions for obtaining most similar documents, finding most informative words, finding documents with most information are available as functions in this package.
# If we isolate a vectorm we can plot it as well:

vec1 <- abstracts_with_tfidf$tf_idf[1][[1]]
title <- abstracts_with_tfidf$title[1]
plot_word_score(vec1, title)

# Lastly, depending on the dataset searched, a PCA reduction may reveal some interesting results on how related documents are for one another.  Every dot is colour coded differently and represents a different document within the dataframe.
reduce_and_plot(abstracts_with_tfidf)
```
