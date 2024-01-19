updatePeakDetectionSpectra <- function(values) {
  values$peakDetectionSpectra <- values$mergedSpectra
  removeComputePeaksBySNRParams(values)
  removeDetectPeaksParams(values)
}
