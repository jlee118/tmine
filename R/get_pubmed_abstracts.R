#' Abstracts and Document Information from PubMed
#'
#' \code{get_pubmed_abstracts} Returns information on abstracts of documents retrieved from PubMed
#'
#' \code{get_pubmed_abstracts} Takes a query string and returns a dataframe containing the text
#' of the abstract and other information on documents returned from PubMed.
#'
#' @param query_string A string to be searched on PubMed
#' @param retmax Maximum number of results returned
#' @return A DataFrame.
#' @seealso \code{\link{article_to_df}}
#' @export
#' @examples
#' query_string <- gene expression cancer"
#' abstracts_df <- get_pubmed_abstracts(query_string)
#' abstracts_df$abstract[1] <- "Membrane type-1 matrix metalloproteinase (MT1-MMP) possesses....


get_pubmed_abstracts <- function(query_string,retmax=20) {
  # Get PMID's from a string query, search PMID's in PubMed
  # Retrieving documents from PubMed may take a few seconds
  pmids <- easyPubMed::get_pubmed_ids(query_string)
  my_abstracts_xml <- easyPubMed::fetch_pubmed_data(pmids, retmax=retmax)
  my_PM_list <- easyPubMed::articles_to_list(my_abstracts_xml)
  datalist=list()

  # Per document, there are multiple row entries in the dataframe created due to
  # multiple authors.  Concatenate to long string of authors, take first row of dataframe
  for (i in 1:length(my_PM_list)) {
    df <- easyPubMed::article_to_df(my_PM_list[i], max_chars = 10000)
    df$fullname <- paste(df$lastname, df$firstname, sep=" , ")
    df$fullname[1] <- paste(unlist(df$fullname[1:length(df$fullname)]), collapse="|")
    datalist[[i]] <- df[1:1,]
  }

  # Concatenate list of dataframes into one
  final_df <- plyr::ldply(datalist,data.frame)
  final_df$firstname <- NULL
  final_df$lastname <- NULL
  final_df$ID <- rownames(final_df)
  return(final_df)
}

#[END]
