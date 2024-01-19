preprocessingServer <- function(id, values) {
  initializePreprocessingParams(values)

  moduleServer(
    id,
    function(input, output, session) {

      # Parameters

      observeEvent(values$updatePreprocessing, {
        if (isFALSE(values$updatePreprocessing)) { return() }
        updatePreprocessingParameters(session, input, values)
        values$updatePreprocessing <- FALSE
        values$updateProcessing <- TRUE
      })

      observeEvent(values$spectra, {
        removeTrimParams(values)
      })

      # Trim

      observeEvent(input$resetTrimButton, {
        if (input$resetTrimButton==0) { return() }
        removeTrimParams(values)
      })

      observeEvent(input$trimButton, {
        if (input$trimButton==0) { return() }
        extractTrimParams(input, values)
      })

      output$trimActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$spectra)) { return() }
        createActionButton(isFALSE(values$trimParams),
                           ns("trimButton"), "Trim",
                           ns("resetTrimButton"), "Reset")
      })

      output$massBoundsPlot <- renderPlot({ computeMassBoundsPlot(values$trimmedSpectra) })

      output$downloadMassBoundsPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$trimmedSpectra)) { return() }
        downloadButton(ns('downloadMassBoundsPlot'), 'Download figure')
      })

      output$downloadMassBoundsPlot <- downloadHandler(
        filename = 'mass_bounds.svg',
        content = function(file) { writeMassBoundsPlot(file, values) }
      )

      # Conformity test

      output$conformityTests <- renderDataTable({
        if (is.null(values$trimmedSpectra)) { return() }
        results <- conformityTests(values$trimmedSpectra)
        datatable({results}, options = list(dom = 't'), selection = list(mode = "none")) %>% formatStyle(
          "Results",
          target = "row",
          backgroundColor = styleEqual(c(0, "No"), c("#33cc33", "#33cc33"))
        )
      })

      output$conformityTestActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$trimmedSpectra)) { return() }
        createActionButton(isFALSE(values$conformityParams),
                           ns("conformityButton"), "Exclude spectra",
                           ns("resetConformityButton"), "Reset")
      })

      observeEvent(input$conformityButton, {
        if (input$conformityButton==0) { return() }
        extractConformityParams(input, values)
      })

      observeEvent(input$resetConformityButton, {
        if (input$resetConformityButton==0) { return() }
        removeConformityParams(values)
      })

      # Clean

      observeEvent(input$resetCleanButton, {
        if (input$resetCleanButton==0) { return() }
        removeCleanParams(values)
      })

      observeEvent(input$cleanButton, {
        if (input$cleanButton==0) { return() }
        extractCleanParams(input, values)
      })

      output$cleanActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$trimmedSpectra)) { return() }
        createActionButton(isFALSE(values$cleanParams),
                           ns("cleanButton"), "Clean",
                           ns("resetCleanButton"), "Reset")
      })

      output$spectrumSelector <- renderUI({
        spectra <- values$cleanedSpectra
        if (is.null(spectra)) { return () }
        ns <- session$ns
        numericInput(ns("spectrumIndex"), "Spectrum index:", value = 1, min = 1, max = length(spectra), step = 1)
      })

      output$spectraSamplePlot <- renderPlot({
        index <- input$spectrumIndex
        spectra <- values$cleanedSpectra
        if (is.null(index) || is.null(spectra) || index <= 0 || index > length(spectra)) { return() }
        plot(spectra[[index]])
      })

      output$downloadspectraSamplePlotButton <- renderUI({
        ns <- session$ns
        index <- input$spectrumIndex
        spectra <- values$cleanedSpectra
        if (is.null(index) || is.null(spectra) || index <= 0 || index > length(spectra)) { return() }
        downloadButton(ns('downloadSpectraSamplePlot'), 'Download figure')
      })

      output$downloadSpectraSamplePlot <- downloadHandler(
        filename = 'spectrum_after_cleaning.svg',
        content = function(file) {
          index <- input$spectrumIndex
          spectra <- values$cleanedSpectra
          svg(file=file, width = 8, height = 4)
          plot(spectra[[index]])
          dev.off()
        }
      )

      # Screen

      observeEvent(input$resetScreenButton, {
        if (input$resetScreenButton==0) { return() }
        removeScreenParams(values)
      })

      observeEvent(input$screenButton, {
        if (input$screenButton==0) { return() }
        extractScreenParams(input, values)
      })

      output$screenActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$cleanedSpectra)) { return() }
        createActionButton(isFALSE(values$screenParams),
                           ns("screenButton"), "Screen",
                           ns("resetScreenButton"), "Reset")
      })

      output$typicalSpectraCount <- renderText({
        typicalSpectra <- values$typicalSpectra
        cleanedSpectra <- values$cleanedSpectra
        if (is.null(cleanedSpectra) || is.null(typicalSpectra)) {
          return ('Number of typical spectra: no spectra loaded.')
        }
        return(paste('Number of typical spectra: ',
                     length(typicalSpectra), '/',
                     length(cleanedSpectra),
                     sep=''))
      })

      output$screeningPlot <- renderPlot(values$screeningPlot)

      output$downloadScreeningPlotButton <- renderUI({
        ns <- session$ns
        if (is.null(values$screeningPlot)) { return() }
        downloadButton(ns('downloadScreeningPlot'), 'Download figure')
      })

      output$downloadScreeningPlot <- downloadHandler(
        filename = 'screening.svg',
        content = function(file) { writeScreeningPlot(file, values) }
      )

      # Select # to beeeeeee changed
      output$downloadPlot <- downloadHandler(
        filename = "selected_plot.svg",
        content = function(file) {
          writeSelectedPlot(file, values)
        }
      )
      # Select
      observeEvent(c(values$atypicalSpectraAfterSelection, values$selectedSpectra), {
        updateSelectInput(session,
                          'atypicalSpectraSelect',
                          choices = computeListForSelection(
                            values$atypicalSpectraAfterSelection,
                            values$screeningEstTable,
                            FALSE))
        updateSelectInput(session,
                          'selectedSpectraSelect',
                          choices = computeListForSelection(
                            values$selectedSpectra,
                            values$screeningEstTable,
                            TRUE))
        disable('moveSpectraButton')
      })

      observeEvent(input$atypicalSpectraSelect, {
        if (is.null(input$atypicalSpectraSelect)) { return() }
        values$selectedSpectrum <- input$atypicalSpectraSelect
        values$selectedSpectrumState <- 'atypical'
        updateActionButton(session, 'moveSpectraButton', label='>>>')
        enable('moveSpectraButton')
      })

      observeEvent(input$selectedSpectraSelect, {
        if (is.null(input$selectedSpectraSelect)) { return() }
        values$selectedSpectrum <- input$selectedSpectraSelect
        values$selectedSpectrumState <- 'selected'
        updateActionButton(session, 'moveSpectraButton', label='<<<')
        enable('moveSpectraButton')
      })

      output$selectedSpectrumPlot <- renderPlot({
        if (is.null(values$selectedSpectrum)) { return () }
        if (values$selectedSpectrumState == 'atypical') {
          plot(values$atypicalSpectraAfterSelection[[values$selectedSpectrum]])
        } else {
          plot(values$selectedSpectra[[values$selectedSpectrum]])
        }
      })

      observeEvent(input$moveSpectraButton, {
        if (is.null(values$selectedSpectra)) { return() }
        if (values$selectedSpectrumState == 'atypical') {
          values$selectedSpectra[[values$selectedSpectrum]] <- values$atypicalSpectraAfterSelection[[values$selectedSpectrum]]
          values$atypicalSpectraAfterSelection[[values$selectedSpectrum]] <- NULL
        } else {
          values$atypicalSpectraAfterSelection[[values$selectedSpectrum]] <- values$selectedSpectra[[values$selectedSpectrum]]
          values$selectedSpectra[[values$selectedSpectrum]] <- NULL
        }
        values$selectedSpectrum <- NULL
        values$selectedSpectrumState < NULL
        removeMergeParams(values)
      })

      output$addedSpectra <- renderText({
        ids <- computeAddedSpectraIds(values$atypicalSpectra, values$atypicalSpectraAfterSelection)
        str <- if (length(ids) == 0) "no spectra added" else paste(ids, collapse=', ')
        return(paste('Restore outlier spectra to continue analysis:', str))
      })

      output$removedSpectra <- renderText({
        ids <- computeRemovedSpectraIds(values$atypicalSpectra, values$atypicalSpectraAfterSelection)
        str <- if (length(ids) == 0) "no spectra removed" else paste(ids, collapse=', ')
        return(paste('Remove typical spectra from the analysis:', str))
      })

      # Merge

      observeEvent(input$resetMergeButton, {
        if (input$resetMergeButton==0) { return() }
        removeMergeParams(values)
      })

      observeEvent(input$mergeButton, {
        if (input$mergeButton==0) { return() }
        extractMergeParams(input, values)
      })

      output$mergeActionButtons <- renderUI({
        ns <- session$ns
        if (is.null(values$selectedSpectra)) { return() }
        createActionButton(isFALSE(values$mergeParams),
                           ns("mergeButton"), "Merge",
                           ns("resetMergeButton"), "Reset")
      })

      output$mergedSpectraCount <- renderText({
        mergedSpectra <- values$mergedSpectra
        return (
          if (is.null(mergedSpectra)) 'Number of spectra after averaging: no spectra loaded.'
          else paste('Number of spectra after merging: ', length(mergedSpectra), sep='')
        )
      })

      output$mergedSpectraMetadata <- DT::renderDataTable(extractSpectraMetadata(values$mergedSpectra)[,c('sampleName','replicateName','acquisitionDate')])
    })

}
