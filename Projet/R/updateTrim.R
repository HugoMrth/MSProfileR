updateTrim <- function(values) {
  enableOrDisableParams(c('spectraTrimmingRange'), values$trimParams)
  values$trimmedSpectra <- trimSpectra(values$spectra, values$trimParams)
  removeConformityParams(values)
}
