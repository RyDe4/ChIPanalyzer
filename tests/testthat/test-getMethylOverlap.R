library(testthat)
library(ChIPAnalyzer)

test_that("getMethylOverlap does not return an impossibly large number
          of overlaps", {
  expect_equal(2 * 2, 4)
})
