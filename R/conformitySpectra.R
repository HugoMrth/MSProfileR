conformitySpectra <- function(spectra, params) {
  if (is.null(spectra) || isFALSE(params)) { return (spectra) }
  if (params$excludeEmptySpectra && length(spectra) > 0) {
    spectra <- spectra[!sapply(spectra, isEmpty)]
    spectra <- spectra[sapply(spectra, isRegular)]
  }
  if (length(spectra) == 0) {
    return (NULL)
  }
  return (spectra)
}
