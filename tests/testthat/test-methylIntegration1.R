library(testthat)
library(ChIPAnalyzer)

#this test requires the full methylation dataset which is too big
#to push to github
test_that("The methylation Pie chart pipeline works", {
  testOverlap <- ChIPAnalyzer::getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                 methylPath = "HcfUMethylData.bed")
  expect_equal(plotMethylPercentage(testOverlap), TRUE)
})
