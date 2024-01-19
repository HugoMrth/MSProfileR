updateComputeReferencePeaks <- function(values) {
  enableOrDisableParams(c('referencePeaksMethod',
                          'minFrequency',
                          'referencePeaksTolerance'), values$computeReferencePeaksParams)
  values$referencePeaks <- computeReferencePeaks(values$peaks, values$computeReferencePeaksParams)
  removeAlignSpectraParams(values)
}
