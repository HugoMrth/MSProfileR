runProcessing <- function(values) {
  updatePeakDetectionSpectra(values)
  updateComputePeaksBySNR(values)
  updateDetectPeaks(values)
  updateComputeReferencePeaks(values)
  updateAlignSpectra(values)
  updateBinPeaks(values)
  updateFilterPeaks(values)
  updateComputeIntensityMatrix(values)
}
