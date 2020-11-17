library(testthat)
library(ChIPAnalyzer)

test_that("getQuadCoveragePercentage returns correct percentages", {
  expect_equal(getQuadCoveragePercentage(
    matrix(c(0, 1, 0, 1, 1, 1, 0, 0, 0), ncol = 3)), c((1/3)*100,
                                                          100.00000,
                                                          0.00000))
})
