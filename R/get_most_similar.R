#' Most Similar Documents
#'
#' \code{get_most_similar} Finds the documents with the highest cosine-similarity score among their tf-idf vectors.
#'
#' \code{append_tfidf} Given a dataframe returned from the \code{get_pubmed_abstracts} function that already has tf-idf scores calculated from \code{append_tfidf}, and a vector of tf-idf scores that have the same number of columns, return the indices of the documents that have the highest cosine-similarity scores in descending order.
#' @param abstracts_dataframe A DataFrame returned from the \code{get_pubmed_abstracts} function.  Must already have tf-idf scores calculated from \code{append_tfidf}.
#' @param tf-idf_vector A numeric vector of tf-idf weights that has the same number of columns as those in the abstracts DataFrame.
#' @return A DataFrame.
#' @seealso \code{get_pubmed_abstracts} \code{\link{append_tfidf}}
#' @export
#' @examples
#' indices <-get_most_similar(abstracts_df_with_tfidf,tfidf_vector)
#'

get_most_similar <- function(tfidf_vector,abstracts_dataframe) {
  cosines=c()
  for (i in 1:length(abstracts_dataframe$tf_idf)) {
    current_vec <- abstracts_dataframe$tf_idf[i][[1]]
    cos <- crossprod(tfidf_vector,current_vec)/sqrt(crossprod(tfidf_vector)*crossprod(current_vec))
    cosines[i] <- cos
  }
  indices <- order(cosines,decreasing=TRUE)
  sorted_cosines <- sort(cosines,decreasing=TRUE)
  df <- as.data.frame(indices)
  df$cosines<- cosines
  return(df[2:length(indices), c(1,2)])
}

