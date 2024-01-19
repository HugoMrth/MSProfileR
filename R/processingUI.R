processingUI <- function(id) {
  ns <- NS(id)
  tagList(
    # Peak detection
    box(title="Peak detection", width = 12, solidHeader = TRUE, status = "primary",
        radioButtons(ns("noiseEstimatorMethod"),
                     label = tags$span("Noise estimator method:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title = "A local maximum is detected as a peak whether its intensity is greater than the noise level"
                                       )),

                     inline = TRUE,
                     choices = list("MAD" = "MAD", "Super smoother" = "SuperSmoother"),
                     selected = "MAD"),
        numericInput(ns("peakDetectionHalfWindowSize"), "Half window size:", 20, min = 1, max = 100),
        uiOutput(ns("computePeaksBySNRActionButtons")),
        plotOutput(ns("peakCountsBySNRPlot")),
        uiOutput(ns("downloadPeakCountsBySNRPlotButton")),
        br(),
        sliderTextInput(
          inputId = ns("SNR"),
          label = "Choose SNR Value:",
          choices = seq(from = 2, to = 7, by = 1),
          grid = TRUE),
        textOutput(ns("SNRStatistics")),
        br(), br(),
        uiOutput(ns("detectPeaksActionButtons")),
        br(), br(),
        uiOutput(ns("spectrumWithPeaksSelector")),
        textOutput(ns("detectPeaksCount")),
        plotOutput(ns("spectrumWithPeaksPlot")),
        uiOutput(ns("downloadSpectrumWithPeaksPlotButton"))
    ),
    # Spectrum alignment
    box(title="Spectrum alignment", width = 12, solidHeader = TRUE, status = "primary",
        radioButtons(ns("referencePeaksMethod"),
                     label = tags$span("Method for reference peaks:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title = "Creation of reference MassPeaks objec from a list of MassPeaks object & align MassPeaks object with the selected references"
                                       )),
                     inline = TRUE,
                     choices = list("Strict" = "strict", "Relaxed" = "relaxed"),
                     selected = "strict"),
        numericInput(ns("minFrequency"), "Minimum frenquency of reference peaks:", 0.9, min = 0.1, max = 1.0, step=0.1),
        numericInput(ns("referencePeaksTolerance"), "Tolerance for reference peaks:", 0.002, min = 0.0001, max = 0.5, step=0.0001),
        uiOutput(ns("computeReferencePeaksActionButtons")),
        br(),
        textOutput(ns("referencePeaksCount")),
        plotOutput(ns("referencePeaksPlot")),
        uiOutput(ns("downloadReferencePeaksPlotButton")),
        br(),
        radioButtons(ns("alignmentWarpingMethod"), label = "Warping method for alignment:", inline = TRUE,
                     choices = list("Lowess" = "lowess", "Linear" = "linear", "Quadratic" = "quadratic", "Cubic" = "cubic"),
                     selected = "lowess"),
        uiOutput(ns("alignSpectraActionButtons")),
        plotOutput(ns("alignedSpectraPlot")),
        uiOutput(ns("downloadAlignedSpectraPlotButton"))
    ),
    # Binning peaks
    box(title="Peak binning", width = 12, solidHeader = TRUE, status = "primary",
        radioButtons(ns("binPeaksMethod"),
                     label = tags$span("Method for binning:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title = "Looking for similar peaks across MassPeaks objects and equalizes their mass"
                                       )),
                     inline = TRUE,
                     choices = list("strict" = "strict", "relaxed" = "relaxed"),
                     selected = "strict"),
        numericInput(ns("binPeaksTolerance"), "Tolerance for binning:", 0.002, min = 0.0001, max = 0.5, step=0.0001),
        uiOutput(ns("binPeaksActionButtons")),
        br(),
        textOutput(ns("binnedPeaksCount")),
        plotOutput(ns("binnedPeaksPlot")),
        uiOutput(ns("downloadBinnedPeaksPlotButton"))
    ),
    # Filtering peaks
    box(title="Peak filtering", width = 12, solidHeader = TRUE, status = "primary",
        numericInput(ns("filterPeaksMinFrequency"),
                     label = tags$span("Minimum frenquency:",
                                       tags$i(
                                         class = "glyphicon glyphicon-info-sign",
                                         style = "margin-left:10px;color:#0072B2;",
                                         title =  "Removing of infrequently occuring peaks in a list of MassPeaks objects"
                                       )),


                     0.2, min = 0.1, max = 1.0, step=0.1),
        uiOutput(ns("filterPeaksActionButtons")),
        br(),
        textOutput(ns("filteredPeaksCount")),
        plotOutput(ns("filteredPeaksPlot")),
        uiOutput(ns("downloadFilteredPeaksPlotButton"))
    ),
    # Classification of specimen by hierarchical clustering
    box(title="Clustering", width = 12, solidHeader = TRUE, status = "primary",
        checkboxInput(ns("fillMissingValues"),

                      label = tags$span("Fill missing intensities using the aligned spectra",
                                        tags$i(
                                          class = "glyphicon glyphicon-info-sign",
                                          style = "margin-left:10px;color:#0072B2;",
                                          title =  "Converting a list of MassPeaks objects into a graphical matrix"
                                        )), value=TRUE),
        uiOutput(ns("computeIntensityMatrixActionButtons")),
        plotOutput(ns("intensityMatrixPlot")),
        uiOutput(ns("downloadIntensityMatrixPlotButtons"))
    )
  )
}
