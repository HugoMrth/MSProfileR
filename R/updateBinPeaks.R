updateBinPeaks <- function(values) {
  enableOrDisableParams(c('binPeaksMethod', 'binPeaksTolerance'), values$binPeaksParams)
  values$binnedPeaks <- binPeaks_(values$peaks, values$binPeaksParams)
  removeFilterPeaksParams(values)
}
