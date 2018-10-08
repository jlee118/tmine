#test_append_tfidf.R

context("append_tfidf")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# Use pre-saved dataframe made from 'get_pubmed_abstracts'
# ==== END SETUP AND PREPARE ===================================================

test_that("Check that an additional column has been added",  {
  abstracts_with_tfidf <- append_tfidf(arabidopsis_data)
  expect_equal(length(names(abstracts_with_tfidf)), length(names(arabidopsis_data)) + 1)
})

test_that("Check that there is the same number of vectors as abstracts", {
  abstracts_with_tfidf <- append_tfidf(arabidopsis_data)
  expect_equal(length(abstract_with_tfidf$tf_idf), length(abstract_with_tfidf$abstract))
})

test_that("Check that the dimensionality is equal for tf-idf vector", {
  abstracts_with_tfidf <- append_tfidf(arabidopsis_data)
  expect_equal(length(arabidopsis_data$tf_idf[1][[1]]), length(arabidopsis_data$tf_idf[2][[1]]))
})

test_that("Check the tf-idf vector is a numeric vector", {
  abstracts_with_tfidf <- append_tfidf(arabidopsis_data)
  expect_equal(class(abstract_with_tfidf$tf_idf[1][[1]]), class(c(1,2,3)))
})




# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
