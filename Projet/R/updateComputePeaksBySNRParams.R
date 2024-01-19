updateComputePeaksBySNRParams <- function(session, input, params, values) {
  values$computePeaksBySNRParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'noiseEstimatorMethod',
                     selected=params$noiseEstimatorMethod)
  updateNumericInput(session,'peakDetectionhalfWindowSize',
                     value=params$peakDetectionhalfWindowSize)
}
