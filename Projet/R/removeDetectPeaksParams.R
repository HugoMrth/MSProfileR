removeDetectPeaksParams <- function(values) {
  values$detectPeaksParams <- FALSE
  updateDetectPeaks(values)
}
