updateFilterPeaksParams <- function(session, input, params, values) {
  values$filterPeaksParams <- params
  if (isFALSE(params)) { return() }
  updateNumericInput(session,'filterPeaksMinFrequency',
                     value=params$filterPeaksMinFrequency)
}
