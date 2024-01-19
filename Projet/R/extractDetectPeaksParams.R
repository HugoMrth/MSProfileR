extractDetectPeaksParams <- function(input, values) {
  values$detectPeaksParams <- list(
    noiseEstimatorMethod=input$noiseEstimatorMethod,
    peakDetectionHalfWindowSize=input$peakDetectionHalfWindowSize,
    SNR=input$SNR
  )
  updateDetectPeaks(values)
}
