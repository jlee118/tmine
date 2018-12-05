#test_plot_word_score.R

context("plot_word_score")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# Use pre-saved dataframe made from 'get_pubmed_abstracts'

abstract_with_tfidf <- append_tfidf(arabidopsis_data)
abstract_with_top <- append_top_words(abstract_with_tfidf)
title <- abstract_with_top$title[4]
vec1 <- abstract_with_top$tf_idf[4][[1]]


# code for testing visualization taken from here https://stackoverflow.com/questions/30246789/how-to-test-graphical-output-of-functions

# ==== END SETUP AND PREPARE ===================================================
# tips on testing ggplots are from here https://stackoverflow.com/questions/31038709/how-to-write-a-test-for-a-ggplot-plot/31041168
test_that("Y label of the plot are correct", {
  p <- plot_word_score(vec1,topn=25, title)
  expect_identical(p$labels$y, "Score")

})

test_that("X Label of the plot is correct", {
  p <- plot_word_score(vec1, topn=25, title)
  expect_identical(p$labels$x, "Words")
})

test_that("Top scoring on the bar is top scoring word calculated",{
  p <- plot_word_score(vec1, topn=25, title)
  expect_identical(p$data[1,2], "cellular")
})



# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
