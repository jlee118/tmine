#test_get_pubmed_abstracts.R

context("get_pubmed_abstracts")

# ==== BEGIN SETUP AND PREPARE =================================================
#
query_string <- "cancer stem cell"
abstracts_df <- get_pubmed_abstracts(query_string)
abstracts_df2 <- get_pubmed_abstracts(query_string, 30)
#
# ==== END SETUP AND PREPARE ===================================================

test_that("20 documents are returned by default without specification",  {
  expect_equal(length(abstracts_df$title), 20)
})

test_that("30 documents are returned by default with specification",  {
  expect_equal(length(abstracts_df2$title), 30)
})

test_that("correct number of columns in dataframe",  {
  expect_equal(length(colnames(abstracts_df)), 13)
})

test_that("the abstract text is of character data type" , {
  expect_equal(class(abstracts_df$abstract),class("this is a character type"))
})



# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persitent construct that the test has created, except for
# stuff in tempdir().
rm(query_string)
rm(abstracts_df)
rm(abstracts_df2)
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
