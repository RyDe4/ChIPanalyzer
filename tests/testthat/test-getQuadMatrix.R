library(testthat)
library(ChIPAnalyzer)

test_that("returned matrix has correct dimensions", {
  testReports <- findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seqWidth = 200,
    assembly = "hg19")
  expect_equal(dim(getQuadMatrix(testReports, 200)), c(20, 200))
})
