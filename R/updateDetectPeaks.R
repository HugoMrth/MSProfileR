updateDetectPeaks <- function(values) {
  enableOrDisableParams(c('SNR'), values$detectPeaksParams)
  enableOrDisableParams(c('noiseEstimatorMethod', 'peakDetectionHalfWindowSize'),
                        !(isFALSE(values$detectPeaksParams) && isFALSE(values$computePeaksBySNRParams)))
  values$peaks <- detectPeaks_(values$peakDetectionSpectra, values$detectPeaksParams)
  removeComputeReferencePeaksParams(values)
  removeBinPeaksParams(values)
}
