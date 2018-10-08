#test_get_most_similar.R

context("get_most_similar")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# Use pre-saved dataframe made from 'get_pubmed_abstracts'

abstract_with_tfidf <- append_tfidf(arabidopsis_data)
vec1 <- abstract_with_tfidf$tf_idf[1][[1]]

# ==== END SETUP AND PREPARE ===================================================

test_that("Check to see that the first cosine is not 1.0, that means the documents own result is still in the dataframe", {
  result_df <- get_most_similar(vec1, abstract_with_tfidf)
  expect_true(result_df[1,2] != 1.0)
})

test_that("Check to see if the cosine value is valid", {
  result_df <- get_most_similar(vec1, abstract_with_tfidf)
  expect_true(-1.0 <= result_df[1,2] & result_df[1,2] <= 1.0)
})

test_that("Check the cosine values are correct ( not a huge difference from manual/alternative summing method)", {
  result_df <- get_most_similar(vec1, abstract_with_tfidf)
  expect_true(result_df[1,2] - 0.03474605  < 0.000000000000000001)
})





# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
