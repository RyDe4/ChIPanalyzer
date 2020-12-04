library(shiny)
options(shiny.maxRequestSize=100*1024^2)

ui <- fluidPage(
  tabsetPanel(
    tabPanel(title = "Plot G4 Distribution",
      fileInput(inputId = "peaks",
                label = "Choose ChIP-seq Peaks BED File"),
      numericInput(inputId = "seqLen",
                   label = "Length of sequence searched
                   around Centre of Peaks",
                   value = 100),
      selectInput(inputId = "assembly", label = "Select Genome
                  Assembly", choices = list("hg19", "hg38",
                                            "mm9", "mm10")),
      actionButton("runQuad",
                   label = "Generate G4 Position Plot"),
      plotOutput(outputId = "quadPlot")
    ),
    tabPanel(title = "Plot Methylation Percentage",
      fileInput(inputId = "methylPeaks",
        label = "Choose ChIP-seq Peaks BED File"),
      fileInput(inputId = "methylData",
        label = "Choose Methylation Data BED File"),
      actionButton("runMethylOverlap",
               label = "Generate G4 Position Plot"),
      plotOutput(outputId = "methylPlot")
    )
  )
)


server <- function(input, output) {
  getPerc <- function (bedPath, seqWidth, assemblyVersion) {
    reports <- findQuads(bedPath = bedPath,
                         seqWidth = seqWidth,
                         assemblyVersion = assemblyVersion)
    qMatrix <- getQuadMatrix(quadReports = reports)
    quadCoveragePercentage <- getQuadCoveragePercentage(quadMatrix = qMatrix)
    return(quadCoveragePercentage)
  }

  quadCoveragePercentage <- eventReactive(input$runQuad, {
    getPerc(input$peaks$datapath, input$seqLen, input$assembly)
  })

  output$quadPlot <- renderPlot({
    plotQuadPosition(quadCoveragePercentage(), "")
  })

  overlap <- eventReactive(input$runMethylOverlap, {
    getMethylOverlap(input$methylPeaks$datapath, input$methylData$datapath)
  })

  output$methylPlot <- renderPlot({
    if (!is.null(overlap())) {
      plotMethylPercentage(overlap())
    }
  })
}

shinyApp(server = server, ui = ui)
