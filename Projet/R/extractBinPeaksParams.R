extractBinPeaksParams <- function(input, values) {
  values$binPeaksParams <- list(
    binPeaksMethod=input$binPeaksMethod,
    binPeaksTolerance=input$binPeaksTolerance
  )
  updateBinPeaks(values)
}
