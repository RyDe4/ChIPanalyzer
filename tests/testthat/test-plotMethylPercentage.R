library(testthat)

test_that("Error occurs when empty data frame passed in", {
  expect_error(typeof(plotMethylPercentage(data.frame())),
               "empty dataframe provided")
})

test_that("Test that function returns object of correct type", {
  overlap <- getMethylOverlap("MAZ_very_small_test.bed", "HcfUMethylData.bed")
  expect_equal(typeof(plotMethylPercentage(overlap)),
               "list")
})
