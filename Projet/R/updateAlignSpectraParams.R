updateAlignSpectraParams <- function(session, input, params, values) {
  values$alignSpectraParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'alignmentWarpingMethod',
                     selected=params$alignmentWarpingMethod)
}
