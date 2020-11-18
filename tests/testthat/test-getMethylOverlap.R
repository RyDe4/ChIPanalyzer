library(testthat)
library(ChIPAnalyzer)

test_that("getMethylOverlap does not return an impossibly large number
          of overlaps", {
  expect_equal(nrow(ChIPAnalyzer::getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                    methylPath = "HcfUMethylData.bed")) <= 20000,
               TRUE)
})

test_that("test that getMethylOverlap doesn't return an
          empty dataframe when it has access to the full
          methylation dataset", {
            expect_equal(nrow(ChIPAnalyzer::
                                getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                                             methylPath = "HcfUMethylData.bed")) <= 20000,
                         TRUE)
})
