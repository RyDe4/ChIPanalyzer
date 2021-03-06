#create a data frame from a BED9 file representing methylation
#data from UCSC
createMethylBedFrame <- function(bedPath) {
  bindSites <- read.table(bedPath,
                          sep = "\t",
                          header = FALSE)
  colnames(bindSites) <- c("chrom", "start", "end", "name",
                           "s1", "strand", "s2,", "s3", "s4",
                           "s5", "coverage")
  return(bindSites)
}

#'Get methylation data overlapping with ChIP-SEQ peaks
#'
#'Given paths to a BED file with ChIP-SEQ peaks and a BED file
#'with methylation data, return a dataframe containing methylation
#'data for sites within ChIP-SEQ peaks.
#'
#'@param chipPath the path to a BED6 or greater file containing processed
#' ChIP-seq peaks. If data is not stranded, a period should be specified
#' in the strand column.
#'@param methylPath the path to a BED9 file with methylation data similar
#' to those available on the UCSC website, where the ninth column
#' specifies the percentage of reads that were methylated:
#' http://hgdownload.cse.ucsc.edu/goldenPath/hg19/encodeDCC/wgEncodeHaibMethylRrbs/
#'
#'@return a dataframe where the first column specifies
#' a chromosome, the second column specifies an end position
#' on the genome, the sixth column represents a strand or . if
#' this is not specified, and the last (ninth) column specifies
#' the percentage of reads that were methylated.
#'
#'@examples
#' path1 <- system.file("extdata", "MAZ_high_score.bed", package = "ChIPAnalyzer")
#' path2 <- system.file("extdata", "HcfUMethylData.bed", package = "ChIPAnalyzer")
#' overlap <- getMethylOverlap(path1, path2)
#'
#'@references
#' H. Pagès, M. Lawrence and P. Aboyoun (2020). S4Vectors:
#' Foundation of vector-like and list-like containers in
#' Bioconductor. R package version 0.24.4.
#'
#' Lawrence M, Huber W, Pag\`es H, Aboyoun P, Carlson M, et al.
#' (2013) Software for Computing and Annotating Genomic Ranges.
#' PLoS Comput Biol 9(8): e1003118.
#' doi:10.1371/journal.pcbi.1003118
#'
#'@export
#'@import S4Vectors
#'@import GenomicRanges
#'@import IRanges
getMethylOverlap <- function (chipPath, methylPath) {
  chipFrame <- createChipBedFrame(chipPath)
  #create a GenomicRanges object representing the peaks
  chipRange <- GenomicRanges::makeGRangesFromDataFrame(chipFrame,
                                        keep.extra.columns = FALSE)
  methylFrame <- createMethylBedFrame(methylPath)
  #create a GenomicRanges object represented sites with methylation data
  methylRange <- GenomicRanges::makeGRangesFromDataFrame(methylFrame,
                                        keep.extra.columns = FALSE)
  #get the overlap in the two GenomicRanges object
  overlap <- IRanges::findOverlapPairs(chipRange, methylRange)

  #subset the methylation dataframe to only include overlaps
  methylOverlaps <- methylFrame[which(as.vector(methylFrame$chrom) %in%
                           as.vector(GenomicRanges::seqnames(S4Vectors::second(overlap)))
                         & as.vector(methylFrame$start) %in%
                           as.vector(GenomicRanges::start(GenomicRanges::ranges(S4Vectors::second(overlap))))), ]
  return(methylOverlaps)
}


