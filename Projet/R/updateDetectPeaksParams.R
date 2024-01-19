updateDetectPeaksParams <- function(session, input, params, values) {
  values$detectPeaksParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'noiseEstimatorMethod',
                     selected=params$noiseEstimatorMethod)
  updateNumericInput(session,'peakDetectionhalfWindowSize',
                     value=params$peakDetectionhalfWindowSize)
  updateSliderTextInput(session, 'SNR', selected=params$SNR)
}
