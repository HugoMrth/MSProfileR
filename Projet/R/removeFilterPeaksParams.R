removeFilterPeaksParams <- function(values) {
  values$filterPeaksParams <- FALSE
  updateFilterPeaks(values)
}
