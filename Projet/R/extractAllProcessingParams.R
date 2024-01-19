extractAllProcessingParams <- function(params, values) {
  params$computePeaksBySNRParams <- values$computePeaksBySNRParams
  params$detectPeaksParams <- values$detectPeaksParams
  params$computeReferencePeaksParams <- values$computeReferencePeaksParams
  params$alignSpectraParams <- values$alignSpectraParams
  params$binPeaksParams <- values$binPeaksParams
  params$filterPeaksParams <- values$filterPeaksParams
  params$computeIntensityMatrixParams <- values$computeIntensityMatrixParams
  return(params)
}
