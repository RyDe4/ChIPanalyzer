library(testthat)
library(ChIPAnalyzer)

test_that("getMethylOverlap does not return an impossibly large number
          of overlaps", {
  expect_equal(nrow(ChIPAnalyzer::getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                    methylPath = "HEK293MethylData.bed")) <= 20000,
               TRUE)
})
