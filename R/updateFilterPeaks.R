updateFilterPeaks <- function(values) {
  enableOrDisableParams(c('filterPeaksMinFrequency'), values$filterPeaksParams)
  values$filteredPeaks <- filterPeaks_(values$binnedPeaks, values$filterPeaksParams)
  removeComputeIntensityMatrixParams(values)
}
