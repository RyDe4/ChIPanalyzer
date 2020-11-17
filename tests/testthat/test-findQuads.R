library(testthat)
library(ChIPAnalyzer)

#correct sequence verified by examining sequence in IGV
test_that("correct sequences retreived from genome", {
  expect_equal(as.character(Biostrings::subject(findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seqWidth = 200,
    assembly = "hg19")[[1]])), "GGGGGAAGTGAGTGGATGTAGCTATTGGCAACCAGACAAGCAAAGCCAATTAAGGGGTGGAGAGCTTATGCAAAGAATGTGATGAATAAATTCTGGAACAAGAGTCCATGCCCTTTATTCATTTATAACAATTGAGGCAGTCAAGTGAGAAGCTGTAACATAGCATCAAATTATGATAGACCCAGATCACTATAACTGGA")
})

test_that("correct number of reports is generated", {
  expect_equal(length(findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seqWidth = 200,
    assembly = "hg19")), 20)
})

test_that("Error generated when invalid assembly is specified", {
  expect_error(findQuads(
    bedPath = "MAZ_very_small_test.bed",
    seqWidth = 200,
    assembly = "blah"))
})
