#' Top Words for PubMed Abstracts
#'
#' \code{append_tfidf} Finds words with the top tf-idf scores for each abstract entry in the dataframe.
#'
#' \code{append_tfidf} Given a dataframe returned from the \code{get_pubmed_abstracts} function that already has tf-idf scores calculated from \code{append_tfidf}, append a column to the DataFrame of the words with the top tf-idf scores
#' @param abstracts_dataframe A DataFrame returned from the \code{get_pubmed_abstracts} function.  Must already have tf-idf scores calculated from \code{append_tfidf}
#' @return A DataFrame.
#' @seealso \code{get_pubmed_abstracts} \code{\link{append_tfidf}}
#' @export
#' @examples
#' abstracts_with_topwordsf <- append_top_words(abstracts_df_with_tfidf)
#'


append_top_words <- function(abstracts_dataframe, num_words=30) {
  # Sort tf-idf scores decreasing, take top 'num_words' words
  for (i in 1:length(abstracts_dataframe$tf_idf)){
    sorted <- sort(abstracts_dataframe$tf_idf[i][[1]], decreasing = TRUE)
    topwords <- list()
    topwords[[1]] <- names(sorted[1:num_words])
    abstracts_dataframe$topwords <- topwords

  }
  return(abstracts_dataframe)
}
