removeAlignSpectraParams <- function(values) {
  values$alignSpectraParams <- FALSE
  updateAlignSpectra(values)
}
