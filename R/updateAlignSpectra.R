updateAlignSpectra <- function(values) {
  enableOrDisableParams(c('alignmentWarpingMethod'), values$alignSpectraParams)
  values$alignedSpectra <- alignSpectra_(values$peakDetectionSpectra,
                                         values$peaks,
                                         values$referencePeaks,
                                         values$alignSpectraParams)
  removeComputeIntensityMatrixParams(values)
}
