binPeaks_ <- function(peaks, params) {
  if (is.null(peaks) | isFALSE(params)) return(peaks)
  return(binPeaks(peaks,
                  method=params$binPeaksMethod,
                  tolerance=params$binPeaksTolerance))
}
