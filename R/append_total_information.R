#' Calculate Total Tf-Idf Scores for All Documents
#'
#' \code{append_total_information} Adds up total tf-idf scores among all abstracts.
#'
#' \code{append_total_information} Given a dataframe returned from the \code{get_pubmed_abstracts} function that already has tf-idf scores calculated from \code{append_tfidf}, append a column to the DataFrame of the total tf-idf scores.
#' @param abstracts_dataframe A DataFrame returned from the \code{get_pubmed_abstracts} function.  Must already have tf-idf scores calculated from \code{append_tfidf}
#' @return A DataFrame.
#' @seealso \code{get_pubmed_abstracts} \code{\link{append_tfidf}}
#' @export
#' @examples
#' abstracts_df_with_total <- append_top_words(abstracts_df_with_tfidf)
#'

append_total_information <- function(abstracts_dataframe) {
  for (i in 1:length(abstracts_dataframe$tf_idf)) {
    abstracts_dataframe$tf_idf_total[i] <- sum(abstracts_dataframe$tf_idf[i][[1]])
  }
  return(abstracts_dataframe)
}


