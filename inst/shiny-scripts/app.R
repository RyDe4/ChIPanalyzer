library(shiny)
options(shiny.maxRequestSize=100*1024^2)

ui <- fluidPage(
  tabsetPanel(
    tabPanel(title = "Plot G4 Distribution",
      fluidRow(
        column(6,
        fileInput(inputId = "peaks",
                  label = "Choose ChIP-seq Peaks BED File"),
        numericInput(inputId = "seqLen",
                     label = "Length of sequence searched
                     around Centre of Peaks",
                     value = 275),
        selectInput(inputId = "assembly", label = "Select Genome
                    Assembly", choices = list("hg19", "hg38",
                                            "mm9", "mm10")),
        radioButtons(inputId = "maxOnly",
                     label = "Use only max scoring G4 for each peak?",
                     choiceNames = c("Yes", "No"),
                     choiceValues = c(TRUE, FALSE)),
        actionButton("runQuad",
                     label = "Generate G4 Position Plot")),
      column(6,
             plotOutput(outputId = "quadPlot"))
      )
    ),
    tabPanel(title = "Plot Methylation Percentage",
      fluidRow(
        column(6,
          fileInput(inputId = "methylData",
                label = "Choose Methylation Data BED File"),
          fileInput(inputId = "methylPeaks",
          label = "Choose ChIP-seq Peaks BED File"),
        actionButton("runMethylOverlap",
                label = "Generate G4 Position Plot")
        ),
        column(6, plotOutput(outputId = "methylPlot")
        )
      )
    )
  )
)


server <- function(input, output) {
  #function containing all steps to get G4 coverage Percentages for plotting
  getPerc <- function (bedPath, seqWidth, assemblyVersion, maxOnly) {
    incProgress(0.1, detail = "Finding Quadruplexes")
    reports <- findQuads(bedPath = bedPath,
                         seqWidth = seqWidth,
                         assemblyVersion = assemblyVersion)
    incProgress(0.7, detail = "Formatting Postitions")
    qMatrix <- getQuadMatrix(quadReports = reports, maxOnly = maxOnly)
    incProgress(0.9, detail = "Calculating Percentages")
    quadCoveragePercentage <- getQuadCoveragePercentage(quadMatrix = qMatrix)
    return(quadCoveragePercentage)
  }

  #Start calculating
  quadCoveragePercentage <- eventReactive(input$runQuad, {
    withProgress(message = "Generating Plot...", value = 0, {
    getPerc(input$peaks$datapath, input$seqLen, input$assembly, input$maxOnly)
    })
  })

  #render the quadruplex plot
  output$quadPlot <- renderPlot({
      plotQuadPosition(quadCoveragePercentage(), "")
  })

  #calculate overlap between methylation data and peaks when button is pressed
  overlap <- eventReactive(input$runMethylOverlap, {
    withProgress(message = "Finding peak sites with Methylation Data...",
                 value = 0, {
      getMethylOverlap(input$methylPeaks$datapath, input$methylData$datapath)
    })
  })

  #render the methylation plot
  output$methylPlot <- renderPlot({
      plotMethylPercentage(overlap())
  })
}

shiny::shinyApp(server = server, ui = ui)
