library(testthat)
library(ChIPAnalyzer)

test_that("Error occurs when empty data frame passed in", {
  expect_error(plotMethylPercentage(data.frame()))
})
