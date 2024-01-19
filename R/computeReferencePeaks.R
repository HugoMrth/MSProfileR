computeReferencePeaks <- function(peaks,
                                  params) {
  if (is.null(peaks) | isFALSE(params)) { return(NULL) }
  return(referencePeaks(peaks,
                        method=params$referencePeaksMethod,
                        minFrequency = params$minFrequency,
                        tolerance = params$referencePeaksTolerance))
}
