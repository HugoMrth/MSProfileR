updateBinPeaksParams <- function(session, input, params, values) {
  values$binPeaksParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'binPeaksMethod',
                     selected=params$binPeaksMethod)
  updateNumericInput(session,'binPeaksTolerance',
                     value=params$binPeaksTolerance)
}
