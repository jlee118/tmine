#' Scatter Plot of Tf-Idf
#'
#' \code{plot_word_score} Produces a scatter plot for all documents with Tf-Idf vectors.
#'
#' \code{plot_word_score}Given a dataframe from the \code{get_pubmed_abstracts} function with tf-idf weights from the \code{append_tfidf} function, produce a scatterplot using a PCA reduced coordinate of all abstracts present in the DataFrame.
#' @param abstracts_dataframe DataFrame produced from \code{get_pubmed_abstracts}.  Must have tf-idf vectors already from \code{append_tfidf}.
#' @seealso \code{get_pubmed_abstracts} \code{\link{append_tfidf}}
#' @export
#' @examples
#' reduce_and_plot(abstracts_df_with_tfidf)
#'


reduce_and_plot <- function(abstracts_dataframe) {
  list_vec <-list()
  # Grab all tf-idf vectors from all abstracts
  for (i in 1:length(abstracts_dataframe$tf_idf)) {
    list_vec[[i]] <- abstracts_dataframe$tf_idf[i][[1]]
  }
  # Concatenate into matrix
  data <- as.matrix(do.call(rbind,list_vec))

  #Apply PCA to the transpose of the matrix shape, transpose provides correct output dimension
  data.pca <- prcomp(t(data), center =TRUE, scale=TRUE)
  plot_data <- as.data.frame(data.pca$rotation[,1:2])
  plot_data$name <- rownames(plot_data)

  #Colour code every point, the legend represents the index number of where that document corresponding to the point lies in the dataframe
  ggplot2::ggplot(plot_data, ggplot2::aes(x=PC1,y=PC2)) + ggplot2::geom_point(ggplot2::aes(colour = factor(name)))
}
