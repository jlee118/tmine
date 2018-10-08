#' Plot Bar Graph of Tf-Idf Scores for an Abstract
#'
#' \code{plot_word_score} Produces a bar graph of the words with the highest tf-idf scores.
#'
#' \code{plot_word_score} Given a vector of tf-idf weights, and the title of the document the vector belongs to, produces a bar plot of the words with the highest tf-idf weights.
#' @param tf-idf_vector A numeric vector of tf-idf weights that has the same number of columns as those in the abstracts DataFrame.
#' @param title Title of the document that hte tf-idf vector belongs to.
#' @param topn Number of top words to plot, default 25.
#' @seealso \code{get_pubmed_abstracts} \code{\link{append_tfidf}}
#' @export
#' @examples
#' plot_word_score(tfidf_vector,"Review of Current Machine Learning Approaches in Plant Biology",35)
#'


# Inspiration from https://rstudio-pubs-static.s3.amazonaws.com/4305_8df3611f69fa48c2ba6bbca9a8367895.html
plot_word_score<- function (tfidf_vector,topn=25) {
  top_words <- sort(tfidf_vector,decreasing=TRUE)[1:topn]
  df <- as.data.frame(top_words)
  df$words <- rownames(df)
  title <- paste("Tf-Idf Scores of Top",toString(topn), sep =" ")
  title <- paste(title, "words", sep = " ")

  #Chose to flip the bar graph to fit as many words on the plot as possible
  ggplot2::ggplot(df, ggplot2::aes(x = reorder(words,top_words), y = top_words)) + ggplot2::geom_bar(stat="identity") + ggplot2::coord_flip() + ggplot2::xlab("Words") + ggplot2::ylab("Score")+ggplot2::ggtitle(title)

}

