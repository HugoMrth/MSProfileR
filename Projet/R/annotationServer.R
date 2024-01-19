annotationServer <- function(id, values) {
  moduleServer(
    id,
    function(input, output, session) {
      output$downloadAnnotationFileButton <- renderUI({
        if (is.null(values$spectra)) { return() }
        ns <- session$ns
        downloadButton(ns('downloadAnnotationFile'), "Download an empty annotation table")
      })

      output$downloadAnnotationFile <- downloadHandler(
        filename = "annotation.xlsx",
        content = function(file) {
          writeAnnotationFile(file, values)
        }
      )

      output$removeAnnotationsButton <- renderUI({
        if (is.null(values$rawAnnotations)) { return() }
        ns <- session$ns
        actionButton(ns('removeAnnotations'), 'Remove annotations')
      })

      observeEvent(input$removeAnnotations, {
        if (input$removeAnnotations==0) { return() }
        values$rawAnnotations = NULL
        processAnnotations(values)
      })

      observeEvent(input$uploadAnnotationFile, {
        file <- input$uploadAnnotationFile
        ext <- tools::file_ext(file$datapath)
        req(file)
        validate(need(ext == "csv" || ext == "xls" || ext == "xlsx", "Please upload a csv/xls/xlsx file"))
        readAnnotationFile(file$datapath, values)
        processAnnotations(values)
      })

      output$raw_annotations <- DT::renderDataTable(values$rawAnnotations)

      output$annotationError <- renderUI({
        if (is.null(values$annotationError)) { return() }
        ns <- session$ns
        p(values$annotationError)
      })

      output$annotationStatistics <- DT::renderDataTable(values$annotationStatistics)

    }
  )
}
