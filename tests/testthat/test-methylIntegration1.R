library(testthat)
library(ChIPAnalyzer)

test_that("The methylation Pie chart pipeline works", {
  testOverlap <- ChIPAnalyzer::getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                 methylPath = "HEK293MethylData.bed")
  expect_equal(plotMethylPercentage(testOverlap), TRUE)
})
