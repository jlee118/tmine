#' Tf-Idf scores for PubMed Abstracts
#'
#' \code{append_tfidf} Calculates Tf-Idf scores for text from PubMed abstracts.
#'
#' \code{append_tfidf} Given a dataframe returned from the \code{get_pubmed_abstracts} function,
#' calculate a vector of tf-idf scores for each abstract, and appends it to the dataframe.
#
#' @param abstracts_dataframe A DataFrame returned from the \code{get_pubmed_abstracts} function.
#' Must already have tf-idf scores calculated from \code{append_tfidf}
#'
#' @return A DataFrame.
#' @seealso \code{\link{get_pubmed_abstracts}}
#' @export
#' @examples
#' abstracts_with_tfidf <- append_tfidf(abstracts_df)
#'
append_tfidf <- function(abstracts_dataframe){

  docs <- abstracts_dataframe$abstract[1:length(abstracts_dataframe$abstract)]
  # The four lines of code below are taken from http://ethen8181.github.io/machine-learning/clustering_old/tf_idf/tf_idf.html
  doc_corpus <- tm::Corpus( tm::VectorSource(docs) )
  control_list <- list(removePunctuation = TRUE, stopwords = TRUE, tolower = TRUE)
  tdm <- tm::TermDocumentMatrix(doc_corpus, control = control_list)
  tf <- as.matrix(tdm)

  # Calculate the Inverse Document Frequency, add 1 in the denominator to prevent having 0 as denominator
  idf <- log(ncol(tf) / (1 + rowSums(tf[, 1:ncol(tf)])))
  tf_idf <- tf * idf

  # Append tf-idf vectors to a list, add that list as a column into the DataFrame.
  # Purpose of this was to keep organization within a dataframe ( not just have a ton of additional tf-idf columns)
  for ( i in 1:ncol(tf)) {
    one_list <- list()
    one_list[[1]] <- tf_idf[, i]
    abstracts_dataframe$tf_idf[i] <- one_list
  }
  return(abstracts_dataframe)
}

#[END]
