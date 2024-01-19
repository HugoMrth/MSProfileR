preprocessingUI <- function(id) {
  ns <- NS(id)
  tagList(
    # Trimming module
    box(title="Trimming", width = 12, solidHeader = TRUE, status = "primary",
        numericRangeInput(
          inputId = ns("spectraTrimmingRange"),
          label = tags$span("Range (m/z):",
                            tags$i(
                              class = "glyphicon glyphicon-info-sign",
                              style = "margin-left:10px;color:#0072B2;",
                              title = "Trim: Selection of the beginnings and ends of MS spectra range; Conformity test: automatic exclusion of empty, irregular and non-conform length of spectra"
                            )),
          value = c(2, 20)
        ),
        uiOutput(ns("trimActionButtons")),
        plotOutput(ns("massBoundsPlot"), height="120px", width="100%"),
        uiOutput(ns("downloadMassBoundsPlotButton"))
    ),
    # Conformity test module
    box(title="Conformity tests", width = 12, solidHeader = TRUE, status = "primary",
        DT::dataTableOutput(ns("conformityTests")),
        br(),
        checkboxInput(ns('excludeEmptySpectra'), label='Exclude empty spectra', value=TRUE),
        checkboxInput(ns('excludeIrregularSpectra'), label='Exclude irregular spectra', value=TRUE),
        uiOutput(ns("conformityTestActionButtons"))
    ),
    # cleaning module
    box(title="Cleaning", width = 12, solidHeader = TRUE, status = "primary",
        # Intensity transformation step
        radioButtons(ns("transformIntensityMethod"),label = tags$span("Method used to transform intensity:",
                                                                      tags$i(
                                                                        class = "glyphicon glyphicon-info-sign",
                                                                        style = "margin-left:10px;color:#0072B2;",
                                                                        title = "Variance stabilization : improve the graphical visualization of spectra by reducing the flattening effect exerted by the high-intensity peaks on the low-intensity peaks. Select one of the methods below"
                                                                      )), inline = TRUE,
                     choices = list("Sqrt" = "sqrt", "Log" = "log" ,"Log2" = "log2", "Log10" = "log10"),
                     selected = "sqrt"),

        # Smooth intensity step
        radioButtons(ns("smoothIntensityMethod"),
                     label = tags$span("Method used to smooth intensity:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title ="Reveal data partially obscured by noise : improve the precision of peak m/z values and peak detection. Select one of the methods below"
                                       )),

                     inline = TRUE,
                     choices = list("Savitsky-Golay" = "SavitzkyGolay", "Moving average" = "MovingAverage"),
                     selected = "SavitzkyGolay"),
        numericInput(ns("halfWindowSize"), "Half window size:", 10, min = 1, max = 100),
        # baseline correction step
        radioButtons(ns("removeBaselineMethod"),
                     label = tags$span("Method used to remove baseline:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title ="Correction of background noise altering the base level of mass spectra. Select one of the methods below"
                                       )),
                     inline = TRUE,
                     choices = list("SNIP" = "SNIP", "TopHat" = "TopHat", "Convex hull" = "ConvexHull", "Median" = "median"),
                     selected = "SNIP"),
        numericInput(ns("removeBaselineIterations"), "Number of iterations (only for SNIP):", 100, min = 1, max = 100),
        # Normalisation step
        radioButtons(ns("calibrateIntensityMethod"),
                     label = tags$span("Method used to normalize intensity:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title ="Normalization to achieve comparisons of intensities from each m/z values value between spectra. Select one of the methods below"
                                       )),

                     inline = TRUE,
                     choices = list("TIC" = "TIC", "PQN" = "PQN", "Median" = "median"),
                     selected = "TIC"),
        uiOutput(ns("cleanActionButtons")),
        br(),
        br(),
        uiOutput(ns("spectrumSelector")),
        plotOutput(ns("spectraSamplePlot")),
        uiOutput(ns("downloadspectraSamplePlotButton")),
    ),
    # the screening module (quality control)
    box(title="Quality Control", width = 12, solidHeader = TRUE, status = "primary",
        radioButtons(ns("scaleEstimator"),
                     label = tags$span( "Scale estimator:",
                                        tags$i(
                                          class = "glyphicon glyphicon-info-sign",
                                          style = "margin-left:10px;color:#0072B2;",
                                          title ="Detection of outliers spectra with a programmatic quality score : visualisation of Atypical spectra upper the threshold. The quality control is carried out with one of the five methods bellow. Outside the threshold indicated in red. Select one of the methods below"
                                        )),
                     inline = TRUE,
                     choices = list("Q" = "Q", "Median Absolute Deviation (MAD)" = "MAD"),
                     selected = "Q"),
        radioButtons(ns("atypicalIdentificationMethod"), label = "Method used for the identification of atypical spectra:", inline = TRUE,
                     choices = list("RC" = "RC", "Hampel" = "Hampel" , "ESD" = "ESD", "Boxplot" = "boxplot", "Adj.boxplot"= "adj.boxplot"),
                     selected = "RC"),
        numericInput(ns("threshold"), "Threshold:", 3, min = 0.1, max = 10, step=0.1),
        checkboxInput(ns("includeLowerSpectra"), "Include spectra below the lower threshold", value=TRUE),
        uiOutput(ns("screenActionButtons")),
        br(), br(),
        tags$b(textOutput(ns("typicalSpectraCount"))),
        plotOutput(ns("screeningPlot")),
        uiOutput(ns("downloadScreeningPlotButton"))
    ),
    # Possibility to select and kept the outliers or/and to remove typical spectra from the spectra list
    box(title="Selection", width = 12, solidHeader = TRUE, status = "primary",
        fluidRow(
          column(5, selectInput(ns('atypicalSpectraSelect'),
                                label = tags$span('Atypical spectra: (automatically removed)',
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "margin-left:10px;color:#0072B2;",
                                                    title = " Possibility to recover the excluded spectra"
                                                  )),

                                choices = list(),
                                size = 10, selectize = FALSE)),
          column(2, br(), br(), br(), br(), actionButton(ns("moveSpectraButton"), label='>>>')),
          column(5, selectInput(ns('selectedSpectraSelect'),
                                label = tags$span('Selected spectra:',
                                                  tags$i(
                                                    class = "glyphicon glyphicon-info-sign",
                                                    style = "margin-left:10px;color:#0072B2;",
                                                    title = " Possibility to exclude the selected typical spectra"
                                                  )),
                                choices = list(),
                                size = 10, selectize = FALSE))
        ),
        plotOutput(ns("selectedSpectrumPlot")),
        textOutput(ns("addedSpectra")),
        textOutput(ns("removedSpectra")),
        br(),
        # add the download button here
        downloadButton(ns("downloadPlot"), "Download Selected")

    ),



    ###

    # Spectra averaging
    box(title="Averaging", width = 12, solidHeader = TRUE, status = "primary",
        radioButtons(ns("averageMassSpectraMethod"),
                     label = tags$span("Averaging method:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title = "Averaging of MS spectra replicates: one representative spectra per sample of the replicates is the future analysis. Select one of the methods below"
                                       )),

                     inline = TRUE,
                     choices = list("Mean" = "mean", "Median" = "median" ,"Sum" = "sum"),
                     selected = "mean"),

        uiOutput(ns("mergeActionButtons")),
        br(), br(),
        tags$b(textOutput(ns("mergedSpectraCount"))),
        br(), br(),
        DT::dataTableOutput(ns("mergedSpectraMetadata"))
    )
  )
}
