
#'Plot the abundance of Predicted G-quadruplexes
#'Relative to a Central Postiion
#'
#'Using a vector returned by getQuadCoveragePercentage(),
#'plot the percentage of peaks that have G-quadruplexes across
#'positions in sequences around the ChIP-SEQ peaks
#'
#'@param featurePercentages a numeric vector containing percentages such as
#' a vector returned by getQuadCoveragePercentage()
#'@param title a string specifying the title of the plot
#'
#'@return This function does not return anything
#'
#'@example
#' reports <- findQuads(bedPath = "BRD4_reduced.bed", seqWidth = 75, assemblyVersion = "hg19")
#' qMatrix <- getQuadMatrix(quadReports = reports, seqWidth = 75)
#' quadCoveragePercentage <- getQuadCoveragePercentage(quadMatrix = qMatrix)
#' plotQuadPosition(quadCoveragePosition, "BRD4 G-Quad Abundance")
plotQuadPosition <- function (featurePercentages, title) {
  leftBound <- -1*floor(length(featurePercentages)/2) + 1
  rightBound <- ceiling(length(featurePercentages)/2)
  plot(c(leftBound, rightBound),
       c(0, 100), type = "n",
       xlab = "Position",
       ylab = "Percentage")
  lines(leftBound:rightBound,
        type = "l",
        featurePercentages,
        col = "blue")
  abline(v = 0)
  title(title)
}

plotMethylPercentage <- function(methylOverlapData) {
  avgPercentMethyl <- mean(methylOverlapData$coverage)
  pieLabels <-c(paste(round(avgPercentMethyl, 4), "%"),
                paste(round(100 - avgPercentMethyl, 4), "%"))
  sections <- c(avgPercentMethyl, 100 - avgPercentMethyl)
  pie(sections, pieLabels,
      col = c("green", "blue"),
      cex = 0.7)
  title("Avg Percent Reads Methylated", cex = 0.5)
  legend("topright", c("Methylated", "Not Methylated"),
         cex = 0.53, fill= c("green", "blue"))
}

plotMultipleMethylPercentage <- function(methylCoverageList, lineNames, title, xlabel) {
  avgPercentages <-lapply(methylCoverageList, mean)
  avgPercentages <- unlist(avgPercentages)
  names(avgPercentages) <- lineNames
  barplot(avgPercentages,
          ylim = c(0, max(avgPercentages) + 1),
          xlab = xlabel,
          ylab = "Average Coverage Percentage",
          main = title)
}
