updateComputeIntensityMatrix <- function(values) {
  enableOrDisableParams(c('fillMissingValues'), values$computeIntensityMatrixParams)
  values$intensityMatrix <- computeIntensityMatrix(values$filteredPeaks,
                                                   values$alignedSpectra,
                                                   values$computeIntensityMatrixParams)
}
