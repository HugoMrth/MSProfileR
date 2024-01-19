trimSpectra <- function(spectra, params) {
  if (is.null(spectra) || isFALSE(params)) { return (spectra) }
  return(trim(spectra, range=params$range*1000))
}
