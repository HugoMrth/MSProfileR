removeComputePeaksBySNRParams <- function(values) {
  values$computePeaksBySNRParams <- FALSE
  updateComputePeaksBySNR(values)
}
