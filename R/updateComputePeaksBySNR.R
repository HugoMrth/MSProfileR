updateComputePeaksBySNR <- function(values) {
  enableOrDisableParams(c('noiseEstimatorMethod',
                          'peakDetectionHalfWindowSize'), values$computePeaksBySNRParams)
  values$peakCountsBySNR <- computePeakCountsBySNR(values$peakDetectionSpectra, values$computePeaksBySNRParams)
}
