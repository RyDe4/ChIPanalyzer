library(testthat)
library(ChIPAnalyzer)

#this test requires the full methylation dataset which is too
#big to be pushed to github
test_that("getMethylOverlap does not return an impossibly large number
          of overlaps", {
  expect_equal(nrow(ChIPAnalyzer::getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                    methylPath = "HEK293MethylData.bed")) <= 20000,
               TRUE)
})

#this test requires the full methylation dataset which is too
#big to be pushed to github
test_that("test that getMethylOverlap doesn't return an
          empty dataframe when it has access to the full
          methylation dataset", {
            expect_equal(nrow(ChIPAnalyzer::getMethylOverlap(chipPath = "MAZ_very_small_test.bed",
                                                             methylPath = "HEK293MethylData.bed")) <= 20000,
                         TRUE)
})
