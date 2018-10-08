#test_reduce_and_plot.R

context("reduce_and_plot")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# Use pre-saved dataframe made from 'get_pubmed_abstracts'

abstract_with_tfidf <- append_tfidf(arabidopsis_data)

# code for testing visualization taken from here https://stackoverflow.com/questions/30246789/how-to-test-graphical-output-of-functions

# ==== END SETUP AND PREPARE ===================================================
# tips on testing ggplots are from here https://stackoverflow.com/questions/31038709/how-to-write-a-test-for-a-ggplot-plot/31041168
test_that("Y label of the plot are correct", {
  p <- reduce_and_plot(abstract_with_tfidf)
  expect_identical(p$labels$y, "PC2")

})

test_that("X Label of the plot is correct", {
  p <- reduce_and_plot(abstract_with_tfidf)
  expect_identical(p$labels$x, "PC1")
})

test_that("Check data is two dimensions",{
  p <- reduce_and_plot(abstract_with_tfidf)
  expect_identical(dim(p$data)[2] - 1, 2)
})

test_that("Check amount of dots represented are same as number of documents available",{
  p <- reduce_and_plot(abstract_with_tfidf)
  expect_identical(dim(p$data)[1],  length(abstract_with_tfidf$title))
})



# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
