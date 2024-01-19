updateConformityParams <- function(session, input, params, values) {
  values$conformityParams <- params
  if (isFALSE(params)) { return() }
  updateCheckboxInput(session,
                      'excludeEmptySpectra',
                      value=params$excludeEmptySpectra)
  updateCheckboxInput(session,
                      'excludeIrregularSpectra',
                      value=params$excludeIrregularSpectra)
}
