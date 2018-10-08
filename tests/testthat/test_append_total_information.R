#append_total_information.R

context("append_total_information")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# Use pre-saved dataframe made from 'get_pubmed_abstracts'

abstract_with_tfidf <- append_tfidf(arabidopsis_data)
# ==== END SETUP AND PREPARE ===================================================



test_that("Check that there is the same number of vectors as abstracts", {
  abstracts_with_total <- append_total_information(abstract_with_tfidf)
  expect_equal(length(abstracts_with_total$tf_idf_total), length(abstract_with_tfidf$abstract))
})

test_that("Check the tf-idf are summed properly compared to a manual method", {
  abstracts_with_total <- append_total_information(abstract_with_tfidf)
  expect_true(abstracts_with_total$tf_idf_total[1] - 191.9612 < 0.000000000000000001)
})





# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
