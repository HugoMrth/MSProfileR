dataLoadingServer <- function(id, values) {
  moduleServer(
    id,
    function(input, output, session) {

      volumes <- getVolumes()
      shinyDirChoose(input, 'directory', roots = volumes())

      directory <- reactive({
        directory <- parseDirPath(volumes(), input$directory)
        if (length(directory) == 0) NULL else directory[[1]]
      })

      message <- reactive({
        directory_ <- directory()
        spectra <- values$spectra
        if (is.null(directory_) || is.null(spectra)) { return('No spectra loaded...') }
        return(paste(length(values$spectra),
                     ' spectra loaded (', directory_,')', sep=''))
      })

      observeEvent(directory(), {
        directory_ <- directory()
        if (is.null(directory_)) { return() }
        if (is.null(input$directoryLevel)) { return() }
        values$spectra <- NULL
        values$spectra <- loadSpectra(directory_, input$directoryLevel)
        processAnnotations(values)
      })

      output$infoBox <- renderInfoBox({
        infoBox("Spectra", message(), icon = icon('upload'),
                color = 'purple', fill = TRUE)
      })

      output$metadata <- DT::renderDataTable(extractSpectraMetadata(values$spectra)[,c('sampleName','replicateName','acquisitionDate')])

      observeEvent(input$uploadParameters, {
        file <- input$uploadParameters
        ext <- tools::file_ext(file$datapath)
        req(file)
        validate(need(ext == "json", "Please upload a json file"))
        values$updateParameters <- fromJSON(file=file$datapath)
        values$updatePreprocessing <- TRUE
      })


    }
  )
}
