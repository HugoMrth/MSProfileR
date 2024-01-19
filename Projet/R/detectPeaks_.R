detectPeaks_ <- function(spectra, params) {
  if (is.null(spectra) | isFALSE(params)) { return(NULL) }
  return(detectPeaks(spectra,
                     method=params$noiseEstimatorMethod,
                     halfWindowSize = params$peakDetectionHalfWindowSize,
                     SNR = params$SNR))
}
