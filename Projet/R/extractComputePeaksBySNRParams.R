extractComputePeaksBySNRParams <- function(input, values) {
  values$computePeaksBySNRParams <- list(
    noiseEstimatorMethod=input$noiseEstimatorMethod,
    peakDetectionHalfWindowSize=input$peakDetectionHalfWindowSize
  )
  updateComputePeaksBySNR(values)
}
