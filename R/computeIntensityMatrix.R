computeIntensityMatrix <- function(peaks, spectra, params) {
  if (is.null(peaks) | is.null(spectra) | isFALSE(params)) { return(NULL) }
  return (
    if (params$fillMissingValues) { intensityMatrix(peaks, spectra) }
    else { intensityMatrix(peaks) }
  )
}
