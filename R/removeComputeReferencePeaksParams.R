removeComputeReferencePeaksParams <- function(values) {
  values$computeReferencePeaksParams <- FALSE
  updateComputeReferencePeaks(values)
}
