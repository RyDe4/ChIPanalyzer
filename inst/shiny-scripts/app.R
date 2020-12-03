library(shiny)

ui <- fluidPage(
  fileInput(inputId = "peaks",
            label = "Choose ChIP-seq Peaks BED File"),
  numericInput(inputId = "seqLen",
               label = "Length of sequence searched
               around Centre of Peaks",
               value = 100),
  selectInput(inputId = "assembly", label = "Select Genome
              Assembly", choices = list("hg19", "hg38",
                                        "mm9", "mm10")),
  plotOutput(outputId = "quadPlot")
)

server <- function(input, output) {
  output$quadPlot <- renderPlot({
    if (!is.null(input$peaks)) {
      reports <- findQuads(bedPath = input$peaks$datapath,
                          seqWidth = input$seqLen,
                          assemblyVersion = input$assembly)
      qMatrix <- getQuadMatrix(quadReports = reports)
      quadCoveragePercentage <- getQuadCoveragePercentage(quadMatrix = qMatrix)
      plotQuadPosition(quadCoveragePercentage, "")
    }
  })
}

shinyApp(server = server, ui = ui)
