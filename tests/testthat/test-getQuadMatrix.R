library(testthat)

test_that("check that returned matrix has correct dimensions", {
  testReports <- findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seq = 200,
    assembly = "hg19")
  expect_equal(dim(getQuadMatrix(testReports)), c(20, 200))
})

test_that("check that an error occurs when the reports are for sequences of
          different length", {
  report1 <- pqsfinder::pqsfinder(Biostrings::DNAString("TGCCATAA"))
  report2 <- pqsfinder::pqsfinder(Biostrings::DNAString("ACGACT"))
  reportList <- list(report1, report2)
  expect_error(getQuadMatrix(reportList))
})

