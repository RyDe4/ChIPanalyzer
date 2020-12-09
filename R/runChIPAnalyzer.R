#'Run the Shiny App for ChIPAnalyzer
#'
#'This function launches the Shiny GUI for ChIPAnalyzer
#'
#'@references
#' Grolemund, G. (2015). Learn Shiny - Video Tutorials. \href{https://shiny.rstudio.com/tutorial/}{Link}
#'
#'@export
runChIPAnalyzer <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "ChIPAnalyzer")
  shiny::runApp(appDir, display.mode = "normal")
  return()
}
