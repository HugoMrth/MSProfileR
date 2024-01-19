updateConformity <- function(values) {
  enableOrDisableParams(c('excludeEmptySpectra', 'excludeIrregularSpectra'), values$conformityParams)
  values$conformitySpectra <- conformitySpectra(values$trimmedSpectra, values$conformityParams)
  removeCleanParams(values)
}
