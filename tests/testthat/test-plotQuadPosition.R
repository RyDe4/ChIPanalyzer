library(testthat)
library(ChIPAnalyzer)

test_that("test that ploting valid vector
          doesn't cause error", {
  expect_equal(typeof(plotQuadPosition(c(10, 20, 30, 20, 10),
                                       "test title")), "list")
})

test_that("test that attempting to plot empty dataframe
          causes error", {
  expect_error(plotQuadPosition(c(), "test quad plot"))
})
