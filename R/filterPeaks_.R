filterPeaks_ <- function(peaks, params) {
  if (is.null(peaks) | isFALSE(params)) { return(peaks) }
  return(filterPeaks(peaks, minFrequency=params$filterPeaksMinFrequency))
}
