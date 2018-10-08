#test_append_top_words.R

context("append_top_words")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# Use pre-saved dataframe made from 'get_pubmed_abstracts'

abstract_with_tfidf <- append_tfidf(arabidopsis_data)


# ==== END SETUP AND PREPARE ===================================================

test_that("Check that tf-idf column exists",  {
  expect_true("tf_idf" %in% names(abstract_with_tfidf))
})

test_that("Check that the correct column has been added", {
  abstract_with_top <-append_top_words(abstract_with_tfidf)
  expect_true("topwords" %in% names(abstract_with_top))
})

test_that("Check that actual words have been added ", {
  abstract_with_top <-append_top_words(abstract_with_tfidf)
  expect_equal(class(abstract_with_top$topwords[1][[1]][[1]]), class("word"))
})

test_that("Test that the top word in the list is actually the top word", {
  abstract_with_top <-append_top_words(abstract_with_tfidf)
  expect_true("ovule" %in% abstract_with_top$topwords[1][[1]])
})

# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
