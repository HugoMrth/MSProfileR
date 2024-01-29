updateTrimParams <- function(session, input, params, values) {
  values$trimParams <- params
  if (isFALSE(params)) { return() }
  updateNumericRangeInput(session,
                          'spectraTrimmingRange',
                          value=params$range)
}
