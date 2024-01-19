processingServer <- function(id, values) {
  initializeProcessingParams(values)

  moduleServer(
    id,
    function(input, output, session) {

      # Parameters

      observeEvent(values$updateProcessing, {
        if (isFALSE(values$updateProcessing)) { return() }
        updateProcessingParameters(session, input, values)
        values$updateProcessing <- FALSE
      })

      observeEvent(values$clearProcessing, {
        if (isFALSE(values$clearProcessing)) { return() }
        updatePeakDetectionSpectra(values)
        values$clearProcessing <- FALSE
      })

      # ComputePeaksBySNR

      observeEvent(input$resetComputePeaksBySNRButton, {
        if (input$resetComputePeaksBySNRButton==0) { return() }
        removeComputePeaksBySNRParams(values)
      })

      observeEvent(input$computePeaksBySNRButton, {
        if (input$computePeaksBySNRButton==0) { return() }
        extractComputePeaksBySNRParams(input, values)
      })

      output$computePeaksBySNRActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$peakDetectionSpectra)) { return() }
        createActionButton(isFALSE(values$computePeaksBySNRParams),
                           ns("computePeaksBySNRButton"), "Compute number of peaks by Signal-to-Noise-Ratio (SNR)",
                           ns("resetComputePeaksBySNRButton"), "Reset")
      })

      output$peakCountsBySNRPlot <- renderPlot({
        if (!is.null(values$peakCountsBySNR)) {
          boxplot(values$peakCountsBySNR, xlab = "Signal-to-Noise Ratio (SNR)", ylab = "Number of Peaks")
        }
      })

      output$SNRStatistics <- renderText({
        if (is.null(values$peakCountsBySNR)) { return ("") }
        peakCounts <- values$peakCountsBySNR[[paste('SNR', input$SNR, sep=' ')]]
        peakCountMean <- mean(peakCounts)
        peakCountSd <- sd(peakCounts)
        return (paste('Average number of peaks for SNR ', input$SNR, ': ', round(peakCountMean, 2), ' (sd: ', round(peakCountSd, 2), ')', sep=''))
      })

      output$downloadPeakCountsBySNRPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$peakCountsBySNR)) { return() }
        downloadButton(ns('downloadPeakCountsBySNRPlot'), 'Download figure')
      })

      output$downloadPeakCountsBySNRPlot <- downloadHandler(
        filename = 'peak_counts_by_SNR.svg',
        content = function(file) { writePeaksCountsBySNRPlot(file, values) }
      )

      # DetectPeaks

      observeEvent(input$resetDetectPeaksButton, {
        if (input$resetDetectPeaksButton==0) { return() }
        removeDetectPeaksParams(values)
      })

      observeEvent(input$detectPeaksButton, {
        if (input$detectPeaksButton==0) { return() }
        extractDetectPeaksParams(input, values)
      })

      output$detectPeaksActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$peakDetectionSpectra)) { return() }
        createActionButton(isFALSE(values$detectPeaksParams),
                           ns("detectPeaksButton"), "Detect peaks",
                           ns("resetDetectPeaksButton"), "Reset")
      })

      output$spectrumWithPeaksSelector <- renderUI({
        spectra <- values$peakDetectionSpectra
        if (is.null(spectra)) { return () }
        ns <- session$ns
        numericInput(ns("spectrumWithPeaksIndex"), "Spectrum index:",
                     value = 1, min = 1, max = length(spectra), step = 1)
      })

      output$detectPeaksCount <- renderText({
        index <- input$spectrumWithPeaksIndex
        spectra <- values$peakDetectionSpectra
        peaks <- values$peaks
        if (is.null(index) || is.null(spectra) || is.null(peaks)
            || index <= 0 || index > length(spectra)) { return("") }
        return (paste("Number of detected peaks: ", length(peaks[[index]]@mass), sep = ""))
      })

      output$spectrumWithPeaksPlot <- renderPlot({
        index <- input$spectrumWithPeaksIndex
        spectra <- values$peakDetectionSpectra
        peaks <- values$peaks
        if (is.null(index) || is.null(spectra) || is.null(peaks)
            || index <= 0 || index > length(spectra)) { return() }
        plotSpectrumWithPeaks(spectra[[index]], peaks[[index]])
      })

      output$downloadSpectrumWithPeaksPlotButton <- renderUI({
        ns <- session$ns
        index <- input$spectrumWithPeaksIndex
        spectra <- values$peakDetectionSpectra
        peaks <- values$peaks
        if (is.null(index) || is.null(spectra) || is.null(peaks)
            || index <= 0 || index > length(spectra)) { return() }
        downloadButton(ns('downloadSpectrumWithPeaksPlot'), 'Download figure')
      })

      output$downloadSpectrumWithPeaksPlot <- downloadHandler(
        filename = 'spectrum_with_peaks.svg',
        content = function(file) {
          svg(file=file, width = 8, height = 4)
          index <- input$spectrumWithPeaksIndex
          spectra <- values$peakDetectionSpectra
          peaks <- values$peaks
          plotSpectrumWithPeaks(spectra[[index]], peaks[[index]])
          dev.off()
        }
      )

      # ComputeReferencePeaks

      observeEvent(input$resetComputeReferencePeaksButton, {
        if (input$resetComputeReferencePeaksButton==0) { return() }
        removeComputeReferencePeaksParams(values)
      })

      observeEvent(input$computeReferencePeaksButton, {
        if (input$computeReferencePeaksButton==0) { return() }
        extractComputeReferencePeaksParams(input, values)
      })

      output$computeReferencePeaksActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$peaks)) { return() }
        createActionButton(isFALSE(values$computeReferencePeaksParams),
                           ns("computeReferencePeaksButton"), "Compute reference peaks",
                           ns("resetComputeReferencePeaksButton"), "Reset")
      })

      output$referencePeaksCount <- renderText({
        if (is.null(values$referencePeaks)) { return ('') }
        paste('Number of reference peaks: ', length(values$referencePeaks))
      })

      output$referencePeaksPlot <- renderPlot({
        if (!is.null(values$referencePeaks)) { plot(values$referencePeaks) }
      })

      output$downloadReferencePeaksPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$referencePeaks)) { return () }
        downloadButton(ns('downloadReferencePeaksPlot'), 'Download figure')
      })

      output$downloadReferencePeaksPlot <- downloadHandler(
        filename = 'reference_peaks.svg',
        content = function(file) { writeReferencePeaksPlot(file, values) }
      )

      # AlignSpectra

      observeEvent(input$resetAlignSpectraButton, {
        if (input$resetAlignSpectraButton==0) { return() }
        removeAlignSpectraParams(values)
      })

      observeEvent(input$alignSpectraButton, {
        if (input$alignSpectraButton==0) { return() }
        extractAlignSpectraParams(input, values)
      })

      output$alignSpectraActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$referencePeaks) || is.null(values$peaks) || is.null(values$peakDetectionSpectra)) { return() }
        if (length(values$referencePeaks)==0) { return() }
        createActionButton(isFALSE(values$alignSpectraParams),
                           ns("alignSpectraButton"), "Align Spectra",
                           ns("resetAlignSpectraButton"), "Reset")
      })

      output$alignedSpectraPlot <- renderPlot({ computeSpectraPheatmap(values$alignedSpectra) })

      output$downloadAlignedSpectraPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$alignedSpectra)) { return () }
        downloadButton(ns('downloadAlignedSpectraPlot'), 'Download figure')
      })

      output$downloadAlignedSpectraPlot <- downloadHandler(
        filename = 'spectra_aligned.svg',
        content = function(file) { writeAlignedSpectraPlot(file, values) }
      )

      # BinPeaks

      observeEvent(input$resetBinPeaksButton, {
        if (input$resetBinPeaksButton==0) { return() }
        removeBinPeaksParams(values)
      })

      observeEvent(input$binPeaksButton, {
        if (input$binPeaksButton==0) { return() }
        extractBinPeaksParams(input, values)
      })

      output$binPeaksActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$peaks)) { return() }
        createActionButton(isFALSE(values$binPeaksParams),
                           ns("binPeaksButton"), "Bin peaks",
                           ns("resetBinPeaksButton"), "Reset")
      })

      output$binnedPeaksCount <- renderText({
        paste('Number of peaks (number of m/z values): ', computePeakCount(values$binnedPeaks))
      })

      output$binnedPeaksPlot <- renderPlot({ computeSpectraPheatmap(values$binnedPeaks) })

      output$downloadBinnedPeaksPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$binnedPeaks)) { return () }
        downloadButton(ns('downloadBinnedPeaksPlot'), 'Download figure')
      })

      output$downloadBinnedPeaksPlot <- downloadHandler(
        filename = 'peaks_binned.svg',
        content = function(file) { writeBinnedPeaksPlot(file, values) }
      )

      # FilterPeaks

      observeEvent(input$resetFilterPeaksButton, {
        if (input$resetFilterPeaksButton==0) { return() }
        removeFilterPeaksParams(values)
      })

      observeEvent(input$filterPeaksButton, {
        if (input$filterPeaksButton==0) { return() }
        extractFilterPeaksParams(input, values)
      })

      output$filterPeaksActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$binnedPeaks)) { return() }
        createActionButton(isFALSE(values$filterPeaksParams),
                           ns("filterPeaksButton"), "Filter peaks",
                           ns("resetFilterPeaksButton"), "Reset")
      })

      output$filteredPeaksCount <- renderText({
        paste('Number of peaks: ', computePeakCount(values$filteredPeaks))
      })

      output$filteredPeaksPlot <- renderPlot({ computeSpectraPheatmap(values$filteredPeaks) })

      output$downloadFilteredPeaksPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$filteredPeaks)) { return () }
        downloadButton(ns('downloadFilteredPeaksPlot'), 'Download figure')
      })

      output$downloadFilteredPeaksPlot <- downloadHandler(
        filename = 'peaks_filtered.svg',
        content = function(file) { writeFilteredPeaksPlot(file, values) }
      )

      # computeIntensityMatrix

      observeEvent(input$resetComputeIntensityMatrixButton, {
        if (input$resetComputeIntensityMatrixButton==0) { return() }
        removeComputeIntensityMatrixParams(values)
      })

      observeEvent(input$computeIntensityMatrixButton, {
        if (input$computeIntensityMatrixButton==0) { return() }
        extractComputeIntensityMatrixParams(input, values)
      })

      output$computeIntensityMatrixActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$filteredPeaks) | is.null(values$alignedSpectra)) { return() }
        createActionButton(isFALSE(values$computeIntensityMatrixParams),
                           ns("computeIntensityMatrixButton"), "Compute intensity matrix",
                           ns("resetComputeIntensityMatrixButton"), "Reset")
      })

      output$intensityMatrixPlot <- renderPlot({
        computeIntensityMatrixPheatmap(values$intensityMatrix, values$alignedSpectra, TRUE)
      })

      output$downloadIntensityMatrixPlotButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$intensityMatrix)) { return () }
        tagList(
          downloadButton(ns('downloadIntensityMatrixPlot32'), 'Download matrix (32x16)'),
          downloadButton(ns('downloadIntensityMatrixPlot16'), 'Download matrix (16x8)'),
          downloadButton(ns('downloadIntensityMatrixPlot8'), 'Download matrix (8x4)'),
          downloadButton(ns('downloadDendrogram'), 'Download dendrogram')
        )
      })

      output$downloadIntensityMatrixPlot32 <- downloadHandler(
        filename = 'intensity_matrix_32x16.svg',
        content = function(file) { writeIntensityMatrixPlot(file, values, 32, 16, TRUE) }
      )

      output$downloadIntensityMatrixPlot16 <- downloadHandler(
        filename = 'intensity_matrix_16x8.svg',
        content = function(file) { writeIntensityMatrixPlot(file, values, 16, 8, TRUE) }
      )

      output$downloadIntensityMatrixPlot8 <- downloadHandler(
        filename = 'intensity_matrix_8x4.svg',
        content = function(file) { writeIntensityMatrixPlot(file, values, 8, 4, FALSE) }
      )

      output$downloadDendrogram <- downloadHandler(
        filename = 'dendrogram.svg',
        content = function(file) { writeDendrogramPlot(file, values) }
      )
    }
  )
}
