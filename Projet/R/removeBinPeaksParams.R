removeBinPeaksParams <- function(values) {
  values$binPeaksParams <- FALSE
  updateBinPeaks(values)
}
