removeComputeIntensityMatrixParams <- function(values) {
  values$computeIntensityMatrixParams <- FALSE
  updateComputeIntensityMatrix(values)
}
