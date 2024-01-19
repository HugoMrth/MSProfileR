extractFilterPeaksParams <- function(input, values) {
  values$filterPeaksParams <- list(
    filterPeaksMinFrequency=input$filterPeaksMinFrequency
  )
  updateFilterPeaks(values)
}
