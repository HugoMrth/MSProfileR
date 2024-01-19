updateComputeReferencePeaksParams <- function(session, input, params, values) {
  values$computeReferencePeaksParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'referencePeaksMethod',
                     selected=params$referencePeaksMethod)
  updateNumericInput(session,'minFrequency',
                     value=params$minFrequency)
  updateNumericInput(session,'referencePeaksTolerance',
                     value=params$referencePeaksTolerance)
}
