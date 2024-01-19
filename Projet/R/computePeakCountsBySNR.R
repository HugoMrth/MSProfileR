computePeakCountsBySNR <- function(spectra, params) {
  if (is.null(spectra) | isFALSE(params)) { return(NULL) }
  results <- NULL
  results <- data.frame(row.names = names(spectra))
  for(SNR in 2:7) {
    peaks <- detectPeaks(spectra,
                         method = params$noiseEstimatorMethod,
                         halfWindowSize = params$peakDetectionHalfWindowSize,
                         SNR = SNR)
    peakCounts <- lapply(X = peaks, function(spectrum) { length(spectrum@mass) })
    peakCounts <- t(as.data.frame(peakCounts))
    results[paste('SNR', SNR, sep=' ')] = peakCounts
  }
  return(results)
}
