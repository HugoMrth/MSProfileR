extractConformityParams <- function(input, values) {
  values$conformityParams <- list(
    excludeEmptySpectra=input$excludeEmptySpectra,
    excludeIrregularSpectra=input$excludeIrregularSpectra
  )
  updateConformity(values)
}
