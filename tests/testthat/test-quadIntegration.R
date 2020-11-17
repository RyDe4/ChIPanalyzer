library(testthat)
library(ChIPAnalyzer)

test_that("Test that the pathway examining G-quad positions works", {
  testReports <- findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seq = 200,
    assembly = "hg19")
  testMatrix <- getQuadMatrix(testReports)
  testPercentages <- getQuadCoveragePercentage(testMatrix)
  expect_equal(plotQuadPosition(testPercentages, "test plot"), TRUE)
})
