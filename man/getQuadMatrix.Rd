% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/QuadCalc.R
\name{getQuadMatrix}
\alias{getQuadMatrix}
\title{Get A Matrix Representing the positions of G-quadruplexes in Multiple Sequences}
\usage{
getQuadMatrix(quadReports, maxOnly = TRUE)
}
\arguments{
\item{quadReports}{a list of reports (type PQSviews) generated by pqsfinder in
the function findQuads. The length of the sequences reported on must be the same
and equal to seqWidth}

\item{maxOnly}{if TRUE, only the maximum scoring G-quadruplexes for each sequence are used.}
}
\value{
a matrix with dimensions length(quadReports) X seqWidth
}
\description{
Create a matrix with a number of rows equivalent to the number of reports in
quadReports, and a number of columns equal to seqWidth, where each entry is 1 iff
there is a quadruplex at that position in the sequence for the report for that row,
and a 0 otherwise.
}
\examples{
path <- system.file("extdata", "MAZ_very_small_test.bed", package = "ChIPAnalyzer")
reports <- findQuads(bedPath = path, seqWidth = 200, assemblyVersion = "hg19")
quadMatrix <- getQuadMatrix(quadReports = reports, maxOnly = TRUE)

}
\references{
Hon J, Martinek T, Zendulka J, Lexa M. (2017) pqsfinder: an
exhaustive and imperfection-tolerant search tool for
potential quadruplex-forming sequences in R. Bioinformatics.
33(21), 3373-3379.
https://doi.org/10.1093/bioinformatics/btx413
}
