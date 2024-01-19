executeProcessing <- function(values) {
  values$peakDetectionSpectra <- values$mergedSpectra
  values$peakCountsBySNR <- computePeakCountsBySNR(values$peakDetectionSpectra, values$computePeaksBySNRParams)
  values$peaks <- detectPeaks_(values$peakDetectionSpectra, values$detectPeaksParams)
  values$referencePeaks <- computeReferencePeaks(values$peaks, values$computeReferencePeaksParams)
  values$alignedSpectra <- alignSpectra_(values$peakDetectionSpectra,
                                         values$peaks,
                                         values$referencePeaks,
                                         values$alignSpectraParams)
  values$binnedPeaks <- binPeaks_(values$peaks, values$binPeaksParams)
  values$filteredPeaks <- filterPeaks_(values$binnedPeaks, values$filterPeaksParams)
  values$intensityMatrix <- computeIntensityMatrix(values$filteredPeaks,
                                                   values$alignedSpectra,
                                                   values$computeIntensityMatrixParams)
  return(values)
}
