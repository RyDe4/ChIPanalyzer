library(testthat)
library(ChIPAnalyzer)

#correct sequence verified by examining sequence in IGV
test_that("correct sequences retreived from genome", {
  expect_equal(as.character(subject(findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seqWidth = 200,
    assembly = "hg19")[[1]])), "GGGGGAAGTGAGTGGATGTAGCTATTGGCAACCAGACAAGCAAAGCCAATTAAGGGGTGGAGAGCTTATGCAAAGAATGTGATGAATAAATTCTGGAACAAGAGTCCATGCCCTTTATTCATTTATAACAATTGAGGCAGTCAAGTGAGAAGCTGTAACATAGCATCAAATTATGATAGACCCAGATCACTATAACTGGA")
})
